---
title: "The Question After the Demo"
subtitle: "Where the idea came from"
excerpt: "A demo went well. Then someone asked a question that had nothing to do with what I'd just shown, and I spent the next week realizing it applied to everything I work on."
date: 2026-07-04
author: "Xiaolan Xu"
draft: false
tags:
  - AI
  - retrieval-science
  - vision
layout: single
---

On April 24th I gave a demo of an AI-assisted, cloud-native pipeline for the SMAP-NISAR soil moisture algorithm — the kind of talk meant to show a platform working, not to make an argument. It landed well. People were generous about it afterward, including some fairly senior people at NASA HQ.

The interesting part happened after, in the informal Q&A. A colleague who works in formal verification — proving software and system contracts correct, not remote sensing — asked a question that had nothing to do with the pipeline I'd just shown. He asked about uncertainty quantification, and whether the validation data we collect ever actually changes the retrieval model, or just checks it.

I gave some answer at the time. It didn't sit well. I kept turning it over for the next few days, ahead of a follow-up conversation with him the following week.

Here is what I think the question actually was, once I stopped being defensive about it: everything I do — SMAP, NISAR, CYGNSS, snow — runs on the same basic shape. Start from real wave physics. Simplify it, step by step, until it's tractable enough to invert: the Water Cloud Model and its relatives are the end of that chain, not the beginning. Retrieve a soil moisture or snow value from the simplified equation. Compare against ground truth. If the ground truth disagrees, you learn something.

Except — where does that something go? In practice, almost nowhere. We check the numbers, note the disagreement, maybe adjust a parameter by hand, and move on. The lesson rarely propagates back to the equation itself, and never back to the physics the equation was simplified from. Every step down that chain — from Maxwell's equations to something you can run against satellite data — makes an assumption. Those assumptions mostly aren't written down. They're inherited from papers written decades ago, in conditions that may or may not match where we're applying them now. We call it validation, but it's closer to a one-way mirror: data checks the model, and stops there.

That's the open loop. His question was really: why does it stay open? What would it take to close it — so that when the data says the equation is wrong under these conditions, that correction actually flows back into the equation, and, further back, into what we understand about the underlying physics — without turning the whole thing into a black box we can no longer interpret?

I didn't have an answer in the room. I spent the week between that demo and the follow-up conversation sketching one, and it kept coming out in the same five pieces: the physics chain itself, honest uncertainty quantification, a real feedback path from data back to model structure, formal verification of the derivation chain so we know exactly which assumption broke, and — running underneath all of it — AI as the thing that makes it possible for a hydrologist, a statistician, an electromagnetics person, and someone who proves software correct to actually talk to each other fast enough to do this together.

None of that is solved. Most of it isn't even well-posed yet. But I now think it's the actual problem, underneath the three or four missions I happen to work across. I've written up the fuller shape of it separately — [Closing the loop](/closing-the-loop/) — but this is where it started: not from a plan, from a question I didn't have a good answer to.

Science isn't a claim, it's a process. Apparently that includes the process of figuring out what the real question is.
