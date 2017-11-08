---
title: "Hello, World!"
subtitle: "Or, how to secure a simple static blog."
date: 2017-11-05
draft: true
---

Hello, world! And welcome to my blog, where I will discuss computers, security, and the topic
du-jour. Now, let's kick things off with a discussion of some of the technical decisions that went
into the crafting of this blog.

## Threat model

Before discussing the security of this blog in any detail, it's important understand the [threat
model](https://en.wikipedia.org/wiki/Threat_model). Perhaps I'll dedicate more posts to threat
modeling in the future, but for now I'll just try and answer the questions of "what am I trying to
protect?", "what am I protecting against" and "who am I protecting against?" (or in security
parlance, what are my assets, the threats to those assets and who are the threat actors?).

The assets I'll discuss in this post are the blog content, the web servers hosting that content, and
the domain name. If I was being really thorough (I'm not), I might also include the private serving
certificate, development machine, my login credentials, my git backups, etc.

A security model I find helpful is the C.I.A. triad. Not the American intelligence agency -- it
stands for Confidentiality, Integrity, and Availability. These are the properties of a secure
system, and a good framework for thinking about the threats against the blog assets. 

FIXME: discuss confidentiality of consumer

This blog is public, there is no secret content or user data, and no interfaces to external
systems. The only assets I'm hosting are the public blog content itself.

That means I can completely
rule out attacks against confidentiality, leaving only integrity and availability from the [CIA
triad](http://security.blogoverflow.com/2012/08/confidentiality-integrity-availability-the-three-components-of-the-cia-triad/)
of security.

Attacks against integrity would look like changing the blog content. This could either be done to
spread disinformation (for instance by totalitarian government), or for simple
defacement (internet vandalism).

Attacks on the availability of my blog would mean disrupting the ability for my audience to get to
my content. Examples of this category of attack would be distributed denial of service and [DNS
hijacking](https://en.wikipedia.org/wiki/DNS_hijacking) (which could also compromise integrity).

Finally, to answer who might want to attack this blog: script kiddies looking for some lolz, nation
states interested in weakening the general security of the internet, or anyone with a personal
vendetta against me (of which I hope there are none!).

## Static content

The first requirement I had for my blog was that it had to be static content. This means that the
content is (for the most part) generated ahead of time, and simply served up as static files (HTML,
CSS, and javascript).

The 2 big advantages I see to static content are speed and security. Because the files don't change
(unless I go back and edit them) they can easily be cached by a [content delivery network
(CDN)](https://en.wikipedia.org/wiki/Content_delivery_network). While I don't expect too much
traffic, I want to make sure my blog doesn't fall over if a post every makes the front page of
[Hacker News](https://news.ycombinator.com/). This same caching mechanism can also help protect
against [DDoS](https://en.wikipedia.org/wiki/Denial-of-service_attack#Distributed_DoS).

On the security front, limiting a website to static content greatly reduces the attack surface,
eliminating categories of attack such as XSS and SQL injection. Since the content is only served
from files, the only way for an attacker to alter the content being served is by either modifying
the underlying files or compromising the file server, and since the general web interface is
read-only, the options for compromising either are severely limited.

### Hugo

TODO: discuss hugo, alternatives (jekyll, etc.)

## TLS

TODO

- what is it
- why it matters: integrity, general internet robustness, confidentiality

### netlify

TODO: discuss TLS via lets encrypt, CDN, etc.
alternatives: static file hosting (e.g. GCS) + CDN (e.g. cloud flare)

## DNS sec

TODO:
- what is it
- why it matters
s
