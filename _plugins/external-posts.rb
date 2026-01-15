require 'feedjira'
require 'httparty'
require 'jekyll'
require 'nokogiri'
require 'time'

module ExternalPosts
  class ExternalPostsGenerator < Jekyll::Generator
    safe true
    priority :high

    def generate(site)
      if site.config['external_sources'] != nil
        site.config['external_sources'].each do |src|
          puts "Fetching external posts from #{src['name']}:"
          if src['rss_url']
            fetch_from_rss(site, src)
          elsif src['posts']
            fetch_from_urls(site, src)
          end
        end
      end
    end

    def fetch_from_rss(site, src)
      xml = HTTParty.get(src['rss_url']).body
      return if xml.nil?
      if xml.include?('<!DOCTYPE html>')
        xml = File.read('./substack.rss')
      end
      feed = Feedjira.parse(xml)
      process_entries(site, src, feed.entries)
    end

    def process_entries(site, src, entries)
      entries.each do |e|
        puts "...fetching #{e.url}"
        create_document(site, src['name'], e.url, {
          title: e.title,
          content: e.content,
          summary: e.summary,
          published: e.published
        })
      end
    end

    def create_document(site, source_name, url, content)
      # check if title is composed only of whitespace or foreign characters
      if content[:title].gsub(/[^\w]/, '').strip.empty?
        # use the source name and last url segment as fallback
        slug = "#{source_name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}-#{url.split('/').last}"
      else
        # parse title from the post or use the source name and last url segment as fallback
        slug = content[:title].downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
        slug = "#{source_name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')}-#{url.split('/').last}" if slug.empty?
      end

      path = site.in_source_dir("_posts/#{slug}.md")
      doc = Jekyll::Document.new(
        path, { :site => site, :collection => site.collections['posts'] }
      )
      doc.data['external_source'] = source_name
      doc.data['title'] = content[:title]
      doc.data['feed_content'] = content[:content]
      doc.data['description'] = content[:summary]
      doc.data['date'] = content[:published]
      doc.data['redirect'] = url
      doc.content = content[:content]
      site.collections['posts'].docs << doc
    end

    def fetch_from_urls(site, src)
      src['posts'].each do |post|
        puts "...fetching #{post['url']}"
        content = fetch_content_from_url(post['url'])
        # allow optional overrides from the config (useful when the remote site
        # blocks scraping or returns an interstitial like Cloudflare "Just a moment...")
        content[:published] = parse_published_date(post['published_date']) if post['published_date']
        content[:title] = post['title'] if post['title']
        content[:summary] = post['summary'] if post['summary']
        
        # if title was overridden but content is empty/generic, try alternative content extraction
        if post['title'] && (content[:content].nil? || content[:content].empty? || content[:content] == 'Just a moment...')
          puts "...retrying content extraction for #{post['url']}"
          content = fetch_content_from_url_advanced(post['url'])
          content[:title] = post['title']
          content[:published] = parse_published_date(post['published_date']) if post['published_date']
          content[:summary] = post['summary'] if post['summary']
        end

        create_document(site, src['name'], post['url'], content)
      end
    end

    def parse_published_date(published_date)
      case published_date
      when String
        Time.parse(published_date).utc
      when Date
        published_date.to_time.utc
      else
        raise "Invalid date format for #{published_date}"
      end
    end

    def fetch_content_from_url(url)
      html = HTTParty.get(url).body
      parsed_html = Nokogiri::HTML(html)

      title = parsed_html.at('head title')&.text.strip || ''
      description = parsed_html.at('head meta[name="description"]')&.attr('content')
      description ||= parsed_html.at('head meta[name="og:description"]')&.attr('content')
      description ||= parsed_html.at('head meta[property="og:description"]')&.attr('content')

      body_content = parsed_html.search('p').map { |e| e.text }
      body_content = body_content.join() || ''

      {
        title: title,
        content: body_content,
        summary: description
        # Note: The published date is now added in the fetch_from_urls method.
      }
    end

    def fetch_content_from_url_advanced(url)
      # Try fetching with a different approach, target Substack article content specifically
      html = HTTParty.get(url, headers: { 'User-Agent' => 'Mozilla/5.0 (compatible; Jekyll/3.0)' }).body
      parsed_html = Nokogiri::HTML(html)

      title = parsed_html.at('head title')&.text.strip || ''
      description = parsed_html.at('head meta[property="og:description"]')&.attr('content')
      description ||= parsed_html.at('head meta[name="description"]')&.attr('content')

      # For Substack articles, try to find article body content
      body_content = ''
      # Look for Substack article container
      article = parsed_html.at('article')
      if article
        body_content = article.search('p').map { |e| e.text.strip }.select { |t| !t.empty? }.join(' ')
      else
        # Fallback to generic paragraph extraction
        body_content = parsed_html.search('p').map { |e| e.text.strip }.select { |t| !t.empty? }.join(' ')
      end

      {
        title: title,
        content: body_content || '',
        summary: description || ''
      }
    end

  end
end

