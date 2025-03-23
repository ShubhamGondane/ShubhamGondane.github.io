---
layout: post
title: Building with AI
date: 2025-03-22 06:00:00
description: How I Used Generative AI for My Latest Side Project
tags: ai
categories: coding
thumbnail: 
---

### Introduction
OCR (Optical Character Recognition) systems are game-changers for extracting text from scanned documents, images, and PDFs. But let’s be real—they’re far from perfect. From misread characters to formatting nightmares, OCR errors can creep in due to poor image quality, complex layouts, or even just bad handwriting. Manually fixing these mistakes? Tedious and time-consuming.

That’s exactly why I built an AI-powered OCR quality control system—with a little help from GitHub Copilot. In this article, I’ll walk you through how I used AI to automate the validation process, catch OCR errors, and make quality control faster and more reliable. Let’s dive in!

### Why OCR Needs Quality Control

#### Common OCR Errors and Challenges:
Character Misrecognition:
- OCR can misinterpret characters, especially in cases where the scanned document has poor image quality, unusual fonts, or handwriting.
- Example: The system might read "O" as "0" or "I" as "1".

Formatting and Layout Issues:
- Complex documents with tables, columns, and special formatting often get misaligned or incorrectly parsed.
- Example: A multi-column page might be read linearly instead of by columns, resulting in jumbled text.

Missing or Extra Characters:
- Some OCR engines struggle with faint, blurred, or heavily stylized text, leading to dropped or inserted characters.
- Example: "Quality Control" might be extracted as "Qual1ty Contr0l".

Table Structure Distortion:
- OCR may extract tabular data as plain text, losing row and column relationships.
- Example: A financial statement with tabular data might become an unreadable text block.

Inconsistent Formatting Across Pages:
- Large documents with varying page designs might lead to inconsistencies in text extraction.
- Example: Page 1 might extract correctly, but Page 2 might misplace headings or misread bullet points.

#### The Pain of Manual Quality Control:
Performing manual quality control on OCR output is tedious and time-consuming because:

- Human Review is Slow: Reviewing every extracted word, number, and table manually takes considerable effort.
- Error Spotting is Challenging: Subtle OCR mistakes, like small misreads in numerical data, can be hard to detect.
- Scalability is an Issue: Manually validating a few pages is possible, but checking thousands of documents is impractical.

### How I Used Generative AI to write the code.
Generative AI became my ultimate brainstorming partner, helping me explore different approaches to solving the OCR quality control challenge. My first instinct was to ask it to find commercially available OCR QC systems—but, to be honest, that didn’t yield great results. So, I switched gears and asked it to draft a high-level plan for building my own solution.

After a few rounds of iteration—tweaking, refining, and optimizing the approach—I had a solid plan in place. That’s when I took the next leap: asking AI to generate the Python code. And I have to admit, it did a surprisingly good job! It structured the modules, created the necessary functions, and laid out the core logic. Of course, it wasn’t perfect—there were inconsistencies in function definitions and calls, and some of the imports were outright wrong. But overall? A solid 80% of the code worked right out of the gate.

What really impressed me was how AI accelerated my development process. As I tested the system, new ideas kept popping into my head. Instead of manually writing every piece of code from scratch, I’d simply prompt the AI to generate new functionality—and it delivered. The speed and fluidity of this workflow made the entire experience incredibly efficient and, honestly, pretty fun!

### System Design & Implementation
The high level design and implementation is covered in detail here - [Automated OCR QC System](https://shubhamgondane.github.io/projects/ocr_qc/)



### Key Takeaways & Lessons Learned
One of the biggest wins? The massive reduction in boilerplate code! AI handled all the repetitive, tedious parts, letting me focus on the core logic. It also nudged me toward a cleaner, more modular design—and even helped generate documentation, saving me hours of effort.

That said, debugging was a bit of a rollercoaster. Sometimes, it took several iterations for the AI to truly grasp what was wrong. Given that it’s a probabilistic model and doesn’t “understand” code the way a human does, this was expected. But it also highlighted an even bigger challenge: writing good prompts.

I quickly realized that a vague or overly simple prompt often led to mediocre results. One particularly effective trick I found online was asking AI to generate 5-6 possible solutions that **might** work, then internally evaluate them to present the top 1-2 solutions that **should** work. This approach dramatically improved the quality of AI-generated code. If you're interested in leveling up your prompt game, there’s a goldmine of ideas in the [ChatGPTPromptGenius](https://www.reddit.com/r/ChatGPTPromptGenius/top/?t=all) subreddit.

Now, my next big goal? Diving deeper into prompt engineering. I want to craft smarter, more precise prompts that will help me build and iterate on side projects even faster. If AI can already speed up my workflow this much, I can only imagine how powerful it’ll be with the right prompts! :rocket: