---
layout: post
title:  Building a Resume from Source
date:   2018-08-22 19:02:24
categories: python
---

After hearing one of my co-workers mention that he keeps his Resume in a personal
repository on Github, a light bulb went off in my head. What if I could demonstrate
my talent and creativity as a software engineer and at the same time produce a resume
that looked and felt professional? At the time I had been reading a lot about
[Literate Programming](), I was working with [Jupyter Notebooks]() and I was writing
a lot of personal and professional tooling in Python. So one weekend I decided to get
work...

## Markdown vs RST

Creating a plain-text resume that was just as easy to read as an HTML or PDF was
quite the experience. I wanted most everything in my git repo to be accessible 
to anyone, not matter how technical they may be.

Markdown would have been the obvious choice but I ended up choosing reStructuredText 
for a markup language instead of Markdown. Markdown's syntax is simple, but it feels 
more like a specification than anything. rST is built into the popular Docutils package
for Python, and feels like it has more of a standard implementation than Markdown.

The HTML produced but rST is also much more accessible and semantic in my 
opinion. If you check out the HTML in my [resume]() you will see most of the content
is contained with Description List elements. `dl`'s are perhaps the most underrated 
element in HTML.

## RST to HTML and PDF



Finally, I needed a way to easily test my resume, create versioned releases on Github and
deploy the newest version to my personal website. As I am writing this post, "testing"
my resume currently means spell checking it with [Aspell](). I am also considering implementing cross-browser and cross-device layout testing using the [Galen Framework]().

With every commit made to my git repo, a [Circle CI]() workflow is kicked off and my
resume is built and tested. When a tag is pushed, the workflow takes it a step further
and creates a [Github Release]() as well as uploads the HTML version of my resume to the
AWS S3 bucket I use for hosting my website.
