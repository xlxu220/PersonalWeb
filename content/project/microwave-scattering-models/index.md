---
title: "Microwave Scattering Models"
subtitle: "Forward electromagnetic models for dense random media"
excerpt: "Bicontinuous/DMRT and NMM3D forward models underpinning snow and soil retrievals."
date: 2026-01-01
weight: 50
author: "Xiaolan Xu"
draft: false
tags:
  - electromagnetics
  - DMRT
  - forward-model
layout: single
---

## The foundation

This is the backbone the rest of my work stands on. Before you can retrieve soil moisture or snow from a satellite, you need to answer a physics question precisely: *when a microwave hits this patch of snow, soil, or vegetation, exactly how does it scatter?* Get that wrong and every downstream number is wrong. Get it right and the whole measurement becomes trustworthy.

## What I work on

I build **first-principles models** of microwave scattering in complex natural media — solving the wave physics from the ground up rather than fitting curves to past data. The toolkit includes:

- **Dense-media radiative transfer (DMRT)** — describing how waves scatter among the densely packed ice grains in a snowpack.
- **Bicontinuous microstructure models** — a realistic way to represent the tangled geometry of real snow and soil, rather than idealized spheres.
- **3D numerical solutions of Maxwell's equations (NMM3D)** — computing scattering directly from the fundamental equations for rough surfaces and vegetated terrain.

Together these connect what a satellite measures to the actual physical state of the ground. This body of work was recognized with the **2020 URSI Santimay Basu Prize**, "for developments in wave propagation and scattering in dense random media with applications to microwave remote sensing of snow."

## Key references

- Ding, K. H., **Xu, X.**, & Tsang, L. (2010). Electromagnetic Scattering by Bicontinuous Random Microstructures With Discrete Permittivities. *IEEE TGRS*, 48(8).
- Tsang, L., Ding, K. H., Huang, S., & **Xu, X.** (2013). Electromagnetic Computation in Scattering of Electromagnetic Waves by Random Rough Surface and Dense Media. *Proceedings of the IEEE*, 101(2).
- **Xu, X.**, Tsang, L., & Yueh, S. (2012). Electromagnetic Models of Co/Cross Polarization of Bicontinuous/DMRT in Radar Remote Sensing of Terrestrial Snow at X- and Ku-band. *IEEE JSTARS*, 5(3).
