---
title: "Hello, World!"
subtitle: "Or, how to secure a simple static blog."
date: 2017-11-05
draft: true
---

Hello, world! And welcome to my blog, where I will discuss computers, security, and the topic du
jour. This blog needs some content! So, I'll create some content about protecting the
content. _Mmmmmmeta._

<!--
TODO: rewrite intro
-->

## Threat model

Since I believe in doing things **thoroughly**, let me start by laying out my [threat
model][]. Perhaps I'll dedicate more posts to threat modeling in the future, but for now
I'll just try and answer the questions of "what am I trying to protect?", "what am I protecting
against" and "who am I protecting against?" (or in security parlance, what are my assets, the
threats to those assets and who are the threat actors?).

The assets I'll discuss in this post are the blog content, the web servers hosting that content, and
the domain name. If I was being *really* thorough (I'm not), I might also include the private
serving certificate, development machine, my login credentials, my git backups, netlify's build
machines, etc.

A security model I find helpful is the [C.I.A. triad][cia-triad]. Not the Central Intelligence
Agency, but rather Confidentiality, Integrity, and Availability. These are properties of a secure
system, and a good framework for thinking about the threats against the blog assets.

This blog is public, there is no secret content or user data, and no interfaces to external systems
(except those secret keys and login credentials I said I wouldn't talk about). So I won't worry too
much about confidentiality, although it will come up while discussing TLS
([a.k.a. SSL][aka-ssl]). Integrity is a big one though, as I want to ensure my posts make it to
readers as I intended. I like to think I'm warding off nation states trying to spread
disinformation, but in reality I'm probably just mitigating against vandalism from script
kiddies. But I'm getting ahead of myself: the last part is availability, and I don't want anyone to
take down my blog - you should be able to read it at ALL HOURS (e.g. while waiting for your bank to
stop being down for maintenance).

Finally, to answer who might want to attack this blog: script kiddies looking for some lolz, nation
states interested in weakening the integrity of the internet and world, or anyone with a personal
vendetta against me (of which I hope there are none!).

## Static content

The first requirement I had for my blog was that it had to be static content. This means that the
content is (for the most part) generated ahead of time, and simply served up as static files (HTML,
CSS, and javascript). Static sites tend to be fast, but more relevant to this post they have some
really nice security properties.

Limiting a website to static content greatly reduces the attack surface, eliminating whole
categories of attack like [XSS][] and [SQL injection][sqli]. Since the content is served from
directly from files, the only way for an attacker to alter the content being served is by either
modifying the underlying files or compromising the file server.

Additionally, because the files don't change (unless I go back and edit them) they can easily be
cached by a [content delivery network (CDN)][cdn]. While I don't expect too much traffic, I want to
make sure my blog doesn't fall over if this post ever makes the front page of [Hacker
News](https://news.ycombinator.com/) (gotta dream big). This same caching mechanism can also help
protect against [DDoS][], since requests are likely to hit the optimized and distributed CDN
caches.

### Implementaion

I opted to go with [Hugo][]. There are a lot of options out there, including [Jekyll][] (made
popular by [GitHub Pages][]), hand crafted artisanal HTML (don't do this), and a gazillion more
listed [here][static-sites]. I opted for Hugo mostly because I didn't need to setup a development
environment (it's a static binary), fairly light weight, and sufficiently mature.

## Serving

### TLS

Come on, it's 2017, do I really need to talk about this? You don't see me highlighting the decision
to use HTTP. Unfortunately, in 2017 serving web content over TLS is still very much an active
choice.

- what is it (TLS vs SSL vs HTTPS)
- why it matters: integrity, general internet robustness, confidentiality
- HSTS

### DNSSEC

- what is it
- why it matters

### Implementation

- netlify
  - TODO: discuss TLS via lets encrypt, CDN, etc.
- alternatives: static file hosting (e.g. GCS) + CDN (e.g. cloud flare)
- google dns

## Best Practices -- FIXME

- Content-Security-Policy
- mozilla observatory (https://observatory.mozilla.org/analyze/tim.allclair.org)



[threat model]: https://en.wikipedia.org/wiki/Threat_model
[cia-triad]: https://security.blogoverflow.com/2012/08/confidentiality-integrity-availability-the-three-components-of-the-cia-triad/
[cdn]: https://en.wikipedia.org/wiki/Content_delivery_network
[ddos]: https://en.wikipedia.org/wiki/Denial-of-service_attack#Distributed_DoS
[xss]: https://www.owasp.org/index.php/Cross-site_Scripting_(XSS)
[sqli]: https://www.owasp.org/index.php/SQL_Injection
[hugo]: https://gohugo.io/
[jekyll]: https://jekyllrb.com/
[github pages]: https://pages.github.com/
[static-sites]: https://www.staticgen.com/
[aka-ssl]: https://certsimple.com/blog/ssl-or-tls
