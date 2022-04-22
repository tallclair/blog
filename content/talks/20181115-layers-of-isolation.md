---
title: Layers of Isolation in Kubernetes
date: 2018-11-15
slides: https://static.sched.com/hosted_files/kccncchina2018english/3a/KubeCon%20Shanghai%20China%202018%20-%20Final.pdf
recording: https://youtu.be/dM0lyNmt2L8
venue: KubeCon China
images:
- /images/talks/layers-of-isolation.png
---

How much isolation can you reasonably expect between two applications in the same cluster? Should
every application have its own namespace? Every service? Between containers, pods, nodes,
namespaces, and even clusters, it can be hard to know how to architect a secure system, and what
layers of isolation can be depended on.

In this talk we will start at the bottom and build up. You will learn which resources are isolated
between two containers in the same pod, and which are not. From there we will explore what changes
as the workloads are increasingly separated. You will see examples of real-world attacks, and how
these attacks are mitigated at different layers of the stack. By the end, you will have a better
understanding of how workloads can and should be separated for your own threat models.
