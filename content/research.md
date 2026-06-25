---
title: "Research"
description: "From the physics of microwaves to the satellite data products the world relies on — and closing the loop between them."
layout: standard
show_title_as_headline: true
headline: "From wave physics to data products — and back"
---

Satellites can sense how much water is in the soil, how deep the snow lies, and whether the ground is frozen — not by seeing it, but by measuring faint microwaves that scatter off the land. The science that makes this possible is **microwave electromagnetic wave physics**: understanding exactly how radio waves interact with natural terrain — scattering from rough soil, bouncing around inside a snowpack, threading through vegetation.

This physics is the **backbone of the entire measurement**. Every soil-moisture or snow value a microwave satellite produces is only as trustworthy as our understanding of how the wave met the ground in the first place. That backbone is what I own — and turning it into trustworthy numbers takes a chain of models and algorithms. Building that chain, end to end, is what I do.

My work has two parts: the threads I've built over a decade, and the direction I'm pushing now.

## What I've built

**Soil moisture.** I develop the algorithms that read soil moisture from radar and radiometer measurements at L-band — the approach behind NASA's SMAP mission, carried forward into the joint SMAP–NISAR algorithm, and extended to reflected navigation-satellite signals through CYGNSS, where I built JPL's soil-moisture product.

**Snow.** More than a decade estimating snow — how much water a snowpack holds — from radar, including newer work that uses the phase of radar signals across repeat passes to track seasonal snow.

**Freeze–thaw.** Detecting whether the land surface is frozen or thawed, a signal that marks the start of spring and the timing of frost. This began with the Aquarius mission and became an operational SMAP product.

**The physics underneath.** All of the above rests on first-principles models of how microwaves scatter inside snow and off rough, vegetated ground — solving the wave physics of terrain from the ground up rather than fitting curves to data. This is the core of my expertise, and the work recognized with the 2020 URSI Santimay Basu Prize.

## The direction: closing the loop

Here is the problem that drives me now. The equations we use to retrieve soil moisture or snow are simplified descendants of fundamental physics — wave equations boiled down, step by step, into something simple enough to run. Each simplification makes an assumption. Those assumptions are rarely written down, rarely tested against the conditions where the algorithm actually runs, and almost never corrected when the data hints they're wrong. We check our answers against ground measurements, but the lesson seldom flows back to fix the equations themselves. It's an **open loop**.

I want to close it. In plain terms, that means:

- **Make the assumptions explicit** — trace exactly where, in the path from physics to working equation, each simplification enters, so we know when it holds and when it doesn't.
- **Say honestly how sure we are** — replace rough error bars with rigorous **uncertainty quantification**: a full, defensible picture of how confident we should be in each retrieved value.
- **Let the data improve the equations** — build a principled way for validation data to update not just the numbers in a model but its *shape*, without turning it into an unexplainable black box.
- **Check the chain itself** — bring the rigor of formal verification to the derivation that links fundamental physics to the equations we deploy.

These are open problems, and I don't have all the answers — that's exactly why they're worth working on. What I'm sure of is that no one field can do this alone. It needs physics, hydrology, statistics, and verification working together, and my view is that AI's real value here isn't to replace the scientist but to be the **connective tissue between fields** — lowering the cost of translation across specialties enough that a collaboration which used to take a decade of relationship-building can begin in a conversation.

If any of this overlaps with your own work — or you just find the problem interesting — I'd genuinely like to hear from you. The best parts of this research have always come from someone outside my field asking the question I hadn't thought to ask.

For the full record, see [Publications](/publication/) and [Projects](/project/).
