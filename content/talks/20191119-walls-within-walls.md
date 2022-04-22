---
title: Walls Within Walls
subtitle: What if your attacker knows parkour?
date: 2019-11-19
slides: https://static.sched.com/hosted_files/kccncna19/0f/walls_within_walls_castle_tallclair_kubeconUSA2019.pdf
recording: https://youtu.be/6rMGRvcjvKc
venue: KubeCon NA
cospeaker: Greg Castle
images:
- /images/talks/walls-within-walls.jpg
---

What happens if an attacker escapes a container and compromises your node? Is it game over for the
whole cluster, or can you limit the blast radius? Whether it be for defense in depth or
multi-tenancy, it is important to understand the security boundaries in your cluster. In this talk,
we’ll discuss various isolation approaches and evaluate them through the eyes of an attacker who has
compromised a node and is looking to propagate.

We’ll deep dive on ‘node isolation’: using Kubernetes scheduling to execute workloads on separate
nodes, and demonstrate live attacks and defences to educate about strengths and weaknesses of this
strategy. We’ll also discuss progress made by SIG-Auth in this area over the past few
releases. After this talk you will understand when node isolation is or isn't an appropriate
security mechanism, the steps to implement it, and what some alternatives are.
