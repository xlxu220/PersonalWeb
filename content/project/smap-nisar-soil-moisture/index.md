---
title: "SMAP + NISAR Soil Moisture"
subtitle: "L-band active/passive retrieval, from SMAP to the NISAR era"
excerpt: "L-band soil-moisture retrieval spanning SMAP radiometry, the SMAP-NISAR algorithm, and ROSE-L."
date: 2026-01-01
weight: 10
author: "Xiaolan Xu"
draft: false
tags:
  - soil-moisture
  - SMAP
  - NISAR
  - L-band
layout: single
---

## The problem

Soil moisture controls how water, energy, and carbon move between the land and the atmosphere — but you can't measure it globally from the ground. L-band microwaves (about 24 cm wavelength) can sense the top few centimeters of soil from orbit, because the wave's behavior changes sharply with how wet the soil is. The catch: vegetation and surface roughness change that behavior too, and untangling the three is where the physics has to be exactly right.

## What I work on

I develop the retrieval algorithms that read soil moisture from L-band measurements — both **passive** (the natural microwave emission a radiometer sees, as on SMAP) and **active** (the echo a radar sends and receives, as on NISAR). The hard part is the model that links the measurement to the soil: it has to account for how the wave scatters off rough ground and through vegetation before it ever reaches the satellite. That model is the backbone of the whole product.

This work began with **SMAP** and now extends to the joint **SMAP–NISAR** soil-moisture algorithm and the **ROSE-L** effort (a Co-I project under NASA's U.S. Participating Investigator program), bringing the same physics to new sensors.

## Where it's heading

NISAR opens a flood of high-resolution radar data, and the retrieval has to keep up without losing physical meaning. Recent work brings **deep neural networks into the radiative-transfer model** — using machine learning to speed up and sharpen the physics-based retrieval rather than replace it — and validates it against airborne L-band SAR collected to mimic NISAR over forests.

## Key references

- Kim, S., Moghaddam, M., Tsang, L., Burgin, M., **Xu, X.**, & Njoku, E. G. (2014). Models of L-Band Radar Backscattering Coefficients Over Global Terrain for Soil Moisture Retrieval. *IEEE TGRS*, 52(2).
- Optimizing the Radiative Transfer Model Using Deep Neural Networks for NISAR Soil Moisture Retrieval. *IEEE JSTARS* (2025).
- Soil Moisture Estimates Using L-Band Airborne SAR Over Forests Replicating NISAR Observations. *IEEE JSTARS* (2025).
