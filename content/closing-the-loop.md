---
title: "Closing the loop"
description: "From open loop to closed — data that doesn't just check our retrieval equations, but improves them, while keeping them physically understandable."
layout: sidebar-left
headline: "The direction: closing the loop"
sidebar:
  motif: true
  title: "Closing the loop"
  description: "The problem that drives me now — and why it needs more than one field."
  lists:
    - heading: "It needs"
      items:
        - "Physics"
        - "Hydrology"
        - "Statistics (UQ)"
        - "Formal verification"
  links:
    - name: "The Science"
      url: "/research/"
    - name: "Collaborate"
      url: "/collaborate/"
---

Here is the problem that drives me now. The equations we use to retrieve soil moisture or snow are simplified descendants of fundamental physics — wave equations boiled down, step by step, into something simple enough to run. Each simplification makes an assumption. Those assumptions are rarely written down, rarely tested against the conditions where the algorithm actually runs, and almost never corrected when the data hints they're wrong. We check our answers against ground measurements, but the lesson seldom flows back to fix the equations themselves. It's an **open loop**.

I want to close it. In plain terms, that means:

- **Make the assumptions explicit** — trace exactly where, in the path from physics to working equation, each simplification enters, so we know when it holds and when it doesn't.
- **Say honestly how sure we are** — replace rough error bars with rigorous **uncertainty quantification**: a full, defensible picture of how confident we should be in each retrieved value.
- **Let the data improve the equations** — build a principled way for validation data to update not just the numbers in a model but its *shape*, without turning it into an unexplainable black box.
- **Check the chain itself** — bring the rigor of formal verification to the derivation that links fundamental physics to the equations we deploy.

These are open problems, and I don't have all the answers — that's exactly why they're worth working on. What I'm sure of is that no one field can do this alone. It needs physics, hydrology, statistics, and verification working together, and my view is that AI's real value here isn't to replace the scientist but to be the **connective tissue between fields** — lowering the cost of translation across specialties enough that a collaboration which used to take a decade of relationship-building can begin in a conversation.

If any of this overlaps with your own work — or you just find the problem interesting — I'd genuinely like to hear from you. The best parts of this research have always come from someone outside my field asking the question I hadn't thought to ask.
