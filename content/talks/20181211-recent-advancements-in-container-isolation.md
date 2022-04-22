---
title: Recent Advancements in Container Isolation
date: 2018-12-11
slides: https://static.sched.com/hosted_files/kccna18/01/Kubecon%20Seattle%20-%20Container%20Isolation.pdf
recording: https://youtu.be/E_jn2UiSWww
venue: KubeCon NA
cospeaker: Adin Scannell
images:
- /images/talks/recent-advancements-in-container-iso.png
---

Container orchestration enables higher bin-packing and utilization of machines, but native linux
containers do not offer the same degree of isolation between workloads as separate VM instances
can. Attackers could abuse this lack of isolation to move through a Kubernetes cluster after gaining
a foothold in a container. Fortunately, there are many tools in the defenders’ toolbox that can be
applied across multiple levels of the stack.

In this survey talk, we will look at several recent or upcoming advancements in container
isolation. You will learn about new kernel features, several "sandboxing" approaches, and features
being developed in Kubernetes to harden the Pod and Node boundaries. After the talk you will have a
better understanding of how to secure your Kubernetes applications and clusters with the latest
features.
