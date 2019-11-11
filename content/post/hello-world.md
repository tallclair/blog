---
title: "Hello, World!"
subtitle: "Or, how to secure a simple static blog."
date: 2018-07-15
draft: true
---

Hello, world! And welcome to my blog, where I will discuss computers, security, and the topic du
jour. To kick things off, I'm writing about the technical decisions that went into setting up and
securing this blog (how meta).

## Everything needs a threat model

Every successful security approach _requires_ a [threat
model][], whether that's a formalized written
down threat model, or just an informal conceptualized model. Trying to secure a system without a
threat model is a bit like trying to develop an application by fixing random bugs. I'll dedicate
more posts to threat modeling in the future, but for now I'll just try and answer the questions of
"what am I trying to protect?", "what am I protecting against" and "who am I protecting against?"
(or in security parlance, what are my assets, the threats to those assets and who are the threat
actors?).

First off, the **primary** asset I am protecting is the blog content. All other assets are
secondary, in that their only value is in protecting and serving the content itself. Those secondary
assets include the web host (Netlify), the domain name and DNS entries, the blog source (git), and
any credentials used for access those things. Protecting the credentials and source are out of scope
for this post.

For threats, a security model I find helpful is the [C.I.A. triad][cia-triad]. Not the Central
Intelligence Agency, but rather Confidentiality, Integrity, and Availability. These are properties
of a secure system, and a good framework for thinking about the threats against the assets. Since
the blog content is public, I won't worry too much about confidentiality, although it will come up
while discussing TLS. Integrity is an important one though, as I want to ensure my posts make it to
the readers as I intended. The last part is availability, which is also an important part of
protecting the content. As a sanity check, these threats correspond to the most common attacks
against non-interactive websites: defacement and denial of service.

Finally, to answer _who_ might want to attack this blog, I like to think I'm warding off nation
states trying to spread disinformation, but in reality my biggest threats probably come from
vandals, script kiddies, and spammers (injecting ads).

[threat model]: https://en.wikipedia.org/wiki/Threat_model
[cia-triad]: https://security.blogoverflow.com/2012/08/confidentiality-integrity-availability-the-three-components-of-the-cia-triad/

## Static content

The first requirement I had for my blog was that it had to be static content. This means that the
content is (for the most part) generated ahead of time, and simply served up as static files (HTML,
 CSS, and javascript). Static sites tend to be fast, but more relevant to this post they have some
really nice security properties.

Limiting a website to static content greatly reduces the attack surface, eliminating whole
categories of attack like [XSS][] and [SQL injection][sqli]. Since the content is served directly
from files, the only way for an attacker to alter the content being served is by either modifying
the underlying files or compromising the file server.

Additionally, because the files don't change (unless I go back and edit them) they can easily be
cached by a [content delivery network (CDN)][cdn]. While I don't expect too much traffic, I want to
make sure my blog doesn't fall over if this post ever makes the front page of [Hacker
News](https://news.ycombinator.com/) (gotta dream big). This same caching mechanism can also help
protect against [DDoS][], since requests are likely to hit the optimized and distributed CDN
caches.

[cdn]: https://en.wikipedia.org/wiki/Content_delivery_network
[xss]: https://www.owasp.org/index.php/Cross-site_Scripting_(XSS)
[ddos]: https://en.wikipedia.org/wiki/Denial-of-service_attack#Distributed_DoS
[sqli]: https://www.owasp.org/index.php/SQL_Injection


### Implementaion

I opted to go with [Hugo][]. There are a lot of options out there, including [Jekyll][] (made
popular by [GitHub Pages][]), hand crafted artisanal HTML (don't do this), and a gazillion more
listed [here][static-sites]. I opted for Hugo mostly because I didn't need to setup a development
environment (it's a static binary), fairly light weight, and sufficiently mature.

[hugo]: https://gohugo.io/
[jekyll]: https://jekyllrb.com/
[github pages]: https://pages.github.com/
[static-sites]: https://www.staticgen.com/

## Serving

For my actual web host, I opted to go with [Netlify][]. Other options include github pages, or
simply static file hosting through something like [GCS][]. Another advantage to static sites is they
typically decouple the content from the hosting, meaning it is easy to migrate hosting providers as
requirements and services evolve. I opted to go with Netlify because it was an easy one-stop-shop
that met my needs. From a threat modeling perspective I treat it as a black box, putting my faith in
their security teams and practices.

[netlify]: https://www.netlify.com  FIXME - verify
[gcs]: FIXME

### TLS

Unfortunately, in 2018 the decision to use [TLS][] ([a.k.a. SSL][aka-ssl]) is still very much an
active choice. TLS provides end-to-end encryption between a client and server. In the case of this
blog, we are serving with HTTP over TLS (i.e. [HTTPS][]), and encrypting the connection between the
reader's browser and the webhost.

Why care about TLS when I already stated that confidentiality was not a significant threat? First,
confidentiality is not entirely irrelevant: although the content of this blog will not be
particularly sensitive, I still want to respect user's rights to privacy, and TLS provides some
degree of privacy (though it won't necessarily hide the domain). Second, end-to-end encryption is
critical for protecting the integrity from middlemen, such as [ISPs that like to inject
ads][ad-injection], or selective censorship. See [Troy Hunt's post][static-tls] on the topic for
more examples. Finally, serving HTTPS content is basic web hygeine, and will help promote confidence
in readers and search engines.

Implementation wise, Netlify [makes it easy][netlify-tls] with certificates provided by [Let's
Encrypt][lets-encrypt]. Additionally, I enabled [HSTS][] to protect against [downgrade attacks][] by
ensuring that the content is _only_ served over HTTPS.

FIXME: HSTS - only requiring https?

[tls]: FIXME
[aka-ssl]: https://certsimple.com/blog/ssl-or-tls
[https]: FIXME
[ad-injection]: FIXME
[static-tls]: FIXME
[netlify-tls]: FIXME
[lets-encrypt]: FIXME
[hsts]: FIXME
[downgrade attacks]: FIXME

### DNSSEC

- what is it
- why it matters

### Content Security Policy

[Content security policy][] (CSP) is, in my opinion, the greatest web security improvement since I
stopped doing web-development work 5 years ago. CSP only allows content from trusted sources to be
executed or injected into a web page. For websites with dynamic user-provided content this is
especially important, as it can prevent a whole class of XSS attacks. For a static site, it is
mostly just providing an additional layer of defense, particularly for the few dynamic portions of
the site (Google Analytics & font awesome javascript).

A full CSP tutorial is out of scope, but a few resources that I found useful when setting it up
include:

- CSP tutorial
- Netlify tutorial
- [Mozilla observatory](https://observatory.mozilla.org/analyze/tim.allclair.org)

[content security policy]: FIXME

## How to attack this blog

This might seem like a funny thing to write about, but I wanted to include it as I think it is an
important part of the security process. There is [no such thing as perfect
security][perfect-security], and after all these mitigations there are still holes. Many of these
are still hidden from us (the "unknown unknowns"), but it is still useful to discuss the
"known-unknowns" - the parts of the system that we know we have not looked at yet. This lets us
understand where to invest future efforts, and also what parts to watch out for suspicious activity.

The first of these known-unknowns to cover are all the bits of infrastructure black-boxes that serve
this blog. This includes Netlify's servers and infrastructure, the third-party content providers'
(Google Analytics & Font Awesome) infrastructure, and my DNS provider. The second category are the
various pieces of the supply chain - my development laptop, my Netlify & Google credentials, the git
source (including GitHub), and other file sources. If I were tasked with attacking this blog, these
are likely the areas I would focus on.

[perfect-security]: FIXME

## Monitoring

The final piece is monitoring. No security story is complete without it. How do we know when a
security incident has occurred, so that we can take remedial action? For a static website with a
single developer, this actually very easy - I just want to be notified whenever any content on the
site changes, so I can verify whether those changes were expected. Netlify provides this capability
(notify on content push), but that would not protect against a Netlify compromise, so I prefer to
use an independent solution. The first option is to use a visual-diff: take an automated rendered
screenshot periodically, and compare against past versions. Alternatively, the raw content (html,
javascript, and css sources) can be compared. Either way, monitoring is not fool-proof, as a
compromised server could potentially serve up different content based on the clients IP or user-agent.

## Conclusion

In conclusion, there is no simple security solution that will protect us perfectly, but modern
technologies can provide a great deal more protection than was possible (or easy) in the past. A few
of the most important protections I would prioritize for a blog are:

1. **Reliable Host** - use a reliable content host that has already solved a lot of security
   problems for you
2. **Secured Credentials** - we didn't cover this, but use [MFA][] when possible and don't reuse
  passwords
3. **Static Content** (when possible) - mitigate XSS & SQLI, separate content & hosting, and avoid
  CMS complexity
4. **Monitoring** - know when a compromise has taken place so an appropriate response can be taken

Next, these mechanisms mitigate some additional attacks, provide some defense in depth,
and are just good hygiene.

- TLS / HSTS
- Content Security Policy
- DNSSEC

[MFA]: FIXME
