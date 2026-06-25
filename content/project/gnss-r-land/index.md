---
title: "GNSS-R for Land"
subtitle: "Soil moisture and vegetation optical depth from reflected GNSS signals"
excerpt: "JPL Level-3 soil moisture from CYGNSS, and VOD retrieval from CYGNSS v3."
date: 2026-01-01
weight: 20
author: "Xiaolan Xu"
draft: false
tags:
  - GNSS-R
  - CYGNSS
  - soil-moisture
  - VOD
layout: single
---

## The idea

GPS and other navigation satellites are constantly broadcasting microwave signals. Those signals don't just reach your phone — they also bounce off the Earth's surface, and the reflection carries information about what it bounced off. **GNSS reflectometry** turns that "waste" signal into a measurement: by reading reflections picked up by small, inexpensive satellites, we can sense soil moisture far more often, and far more cheaply, than a dedicated mission alone.

## What I work on

I built JPL's **Level-3 soil-moisture product** for NASA's CYGNSS mission — a constellation of eight small satellites originally launched to study hurricanes, repurposed to watch the land. As PI of the **CYGNSS v3** effort, I work on improving both the soil-moisture retrieval and the **vegetation optical depth** (a measure of how much the plant canopy dims the signal), and on merging CYGNSS with other sources into a single, more reliable product.

The same backbone applies here as everywhere in my work: the reflection only becomes a number you can trust once you model correctly how the wave interacted with rough, vegetated, partly wet ground.

## Key references

- Yueh, S. H., Shah, R., Chaubell, M. J., Hayashi, A., **Xu, X.**, & Colliander, A. (2022). A Semiempirical Modeling of Soil Moisture, Vegetation, and Surface Roughness Impact on CYGNSS Reflectometry Data. *IEEE TGRS*, 60.
- A Merged CYGNSS Soil Moisture Product Using a Minimum Variance Estimator. *IEEE TGRS* (2025).
