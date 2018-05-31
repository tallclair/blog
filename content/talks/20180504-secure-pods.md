---
title: Secure Pods
subtitle: Sandboxing workloads in Kubernetes
date: 2018-05-04
slides: https://static.sched.com/hosted_files/kccnceu18/96/Secure%20Pods%20-%20KubeCon%20EU%202018.pdf
recording: https://youtu.be/GLwmJh-j3rs
venue: KubeCon EU
image: /img/talks/secure-pods.jpg
---

What is a "secure pod"? What does it mean for a Kubernetes workload to have strong isolation? With
the announcement of Kata Containers and the overflowing multitenancy deep-dive at the last Kubecon,
it's clear that these topics are building momentum.

This talk will cover the current state of container isolation and why there is a need for
technologies like hypervisor-based containers in order to provide stronger security boundaries. It
will also include a discussion of how these technologies fit into Kubernetes and a roadmap for
secure pods.

This is a rapidly evolving area, and Tim anticipates that a proposal for secure pods will be
finalized by May. This talk will be shaped by the status or outcome of that proposal.
