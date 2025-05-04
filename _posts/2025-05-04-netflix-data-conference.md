---
layout: post
title: Netflix Data Engineering Open Forum 2025
date: 2025-05-04 12:00:00
description: My experience at the Netflix Data Engineering Open Forum 2025.
tags: data engineering
categories: conferences
thumbnail:
---

### Introduction

Netflix is known for having some of the most advanced software systems in the world, built by top-tier engineering talent. Over the years, I’ve followed their work through the [Netflix TechBlog](https://netflixtechblog.com/tagged/architecture), especially their data engineering efforts. As a data engineer myself, I’ve always been curious to see how they build at scale. Last year, Netflix launched the inaugural Data Engineering Open Forum—a one-day conference featuring technical talks from their team and opportunities to network with industry professionals. I didn’t get a chance to attend last year, so I was determined to make it this time. This year’s conference was held on April 23 at their Los Gatos office. Huge thanks to Xinran Waibel, the driving force behind the event, and the rest of the organizing team for making it happen.

I’m not sure how last year’s turnout was, but this year many people confirmed that the attendance was much higher. Registration opened on April 1, and I think all the spots were filled by the end of the day. This is a clear sign of growing interest in the conference and data engineering. The organizers had more sessions this year so they setup parallel sessions and asked the attendees to choose which talk they wanted to attend. On the day of the conference, I don't think many of us remembered which session we had signed up for.

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/2025-05-04-netflix-data-conference/data_engineering_open_forum_2025_photo_1.jpg" title="data_engineering_open_forum_2025_photo_1" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Xinran Waibel kicking off the event with opening remarks. Credit: Data Engineering Open Forum 2025.
</div>

### Sessions

The day kicked off with opening remarks, a talk on RDG, and a closing panel—sessions that everyone attended together. The rest of the day was filled with parallel sessions, where we had to choose which ones to attend.

#### Opening Remarks and RDG

Xinran and Ian Yohai, VP of Commerce Data Science & Engineering, gave the welcome address. They shared an overview of the Netflix data ecosystem and highlighted some of the exciting areas the company is currently exploring.

Netflix architecture is based on microservices (service decomposition + data isolation) which resulted in separation of concerns, which ultimately lead to separation of data. The first session after the opening remarks was the **How Netflix built a Real-Time Distributed Graph (RDG) for Internet Scale** which was built to provide an intuitive data model for complex relationships to handle global data volume in near real time. The architecture consisted of - Kafka, Flink, Data Mesh (Not the architecture framework) - Internal platform for moving data between Neflix systems at scale, Key-Value data abstraction layer on top of Cassandra and gRPCs.

This was one of my most favorite sessions of the day. I am waiting for them to share the recordings and the decks so that I can dive deep into this one. They also mentioned they will be starting a blog series to explain more about the RDGs.

After that, I attended the following four sessions:

#### Apache Spark™ 4.0 for Data Engineering

This session spotlighted upcoming features in Spark 4.0, with a strong focus on PySpark. A couple of highlights stood out:

- **Spark Connect Client API**: Spark 4.0 introduces this new, language-agnostic framework that acts as a bridge between applications—notebooks, SDKs, or custom tools—and the Spark driver. It enables a true client-server model, where clients make requests using the DataFrame API, which are then sent to the Spark server via gRPC/protobuf. The results are returned to the client, making it possible to run Spark workloads even from edge devices.
- **Python-Scala parity**: Spark 4.0 now offers full feature parity between Python and Scala for DataFrame operations—great news for PySpark users who’ve often found certain capabilities missing in the Python APIs.

#### Lightning Talks

This session featured a series of short, 10-15 minute talks. I found the first one especially useful—it covered how to optimize ETL workflows using storage-partitioned joins. Unfortunately, this feature is currently only supported in Apache Iceberg, so I won't be able to use it at work. The next two talks focused on prioritizing impactful work and automating BI deployments. While, I did not find these sessions interesting, there were plenty of people who found it useful.

#### The Feedback Loop

This session turned out to be a surprise for most attendees. Many of us walked in expecting a talk on product feedback and how to incorporate it into systems—but it ended up being about something quite different: the soft skill of giving and receiving feedback. While I’m sure some people were a bit disappointed by the switch, I personally found it to be a pleasant surprise. It’s rare to see conferences prioritize soft skills, which are just as important as technical expertise. The session was not only refreshing but also interactive and fun—definitely a nice change of pace.

#### Data Junction

This was the second session I really enjoyed—and found incredibly useful. DataJunction (DJ) is an open-source metrics platform that lets users define metrics and their underlying data models using SQL. It acts as a semantic layer on top of a physical data warehouse, enabling consistent metric definitions across teams. By leveraging this metadata, DJ can enable efficient retrieval of metrics data across different dimensions and filters. DJ uses a graph-based system, where nodes represent various components such as warehouse tables, transformations, dimensions, and metrics. You can build data cubes (combinations of metrics and dimensions) and trace metric lineage, making it easy to understand how metrics are derived.

Having seen this issue at work where different groups defined the same metrics in inconsistent ways, this project immediately resonated with me. I’m planning to dig deeper into it on [GitHub](https://github.com/DataJunction/dj).

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/2025-05-04-netflix-data-conference/data_engineering_open_forum_2025_photo_3.jpg" title="data_engineering_open_forum_2025_photo_3" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    The Future of Data Engineering Panel. Credits: Data Engineering Open Forum 2025.
</div>

#### The Panel

The final session of the day was a panel discussion on **The Future of Data Engineering** featuring promiment engineers and leaders like
Inna Giguere (Director, Content and Studio Data Engineering at Netflix), Ryan Blue (Technical Staff at Databricks), Jerry Wang (Data Infrastructure Senior Leader at Airbnb). WWhile I’m waiting for the recording to revisit all the details, one theme that stood out was the emphasis on balancing technical curiosity with solid fundamentals. As the panelists reflected on their careers, they all highlighted how staying up-to-date with new technologies—while staying grounded in core concepts like data modeling—has been key to their growth.

I’m definitely looking forward to reviewing the session again and taking more detailed notes once the recording is out.

### Conclusion

Overall, Netflix did a fantastic job organizing the event. The talks were well-paced, with thoughtfully scheduled breaks that made the day feel balanced and energizing. Unlike many conferences that lean heavily into product pitches, this one stayed true to its purpose—uniting data engineers for a day filled with knowledge-sharing, learning, and networking. While the networking session at the end was great, there were plenty of other chances to meet people throughout the day—morning, lunch, and after the event. I connected with folks from Netflix and other companies, and we’ve stayed in touch on LinkedIn.

If I had one suggestion for improvement, it would be to include a short 1–2 line description for each talk in the agenda—just enough to help attendees choose sessions more effectively.

I’m looking forward to revisiting the following sessions that I missed once the recordings are available.

- Apache Gluten: Revolutionizing Data Processing Efficiency on Apache Spark
- Delivering Scalable Insights for a New Product Launch: Games at Netflix
- Making Lakehouse Table Formats & Catalogs work for your data using Apache XTable (Incubating)
- How Metronome Scaled their Real-Time Usage Based Billing Pipeline to Billions of Events Per Day

ll definitely be back next year!

P.S. Almost forgot to mention—at the end of the day, they were giving away free books! All we had to do was fill out a quick feedback survey. I chose Designing Data-Intensive Applications by Martin Kleppmann—been meaning to read it for a while!

<div class="row">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.liquid loading="eager" path="assets/img/2025-05-04-netflix-data-conference/DDIA.jpg" title="Designing Data Intensive Applications" class="img-fluid rounded z-depth-1" %}
    </div>
</div>
<div class="caption">
    Designing Data Intensive Applications by Martin Kleppmann
</div>

### References:

- https://2025dataengineeringopenforumat.splashthat.com
- https://netflixtechblog.com
- https://github.com/DataJunction/dj
