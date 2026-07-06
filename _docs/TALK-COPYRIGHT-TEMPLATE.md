# Talk Page Copyright Template

## For All-JPL-Author Presentations (Solo or JPL-only co-authors)

Add to talk `index.md` front matter and/or content:

```markdown
---
title: "Talk Title"
subtitle: "Venue"
excerpt: "Description"
date: YYYY-MM-DD
author: "Xiaolan Xu"
affiliation: "Jet Propulsion Laboratory, California Institute of Technology"
location: "Conference/Event Name"
draft: false
layout: single
links:
- icon: file-pdf
  icon_pack: fas
  name: slides
  url: /files/talks/YYYY-MM-DD_Title_XU.pdf
---

## Copyright & Attribution

© YEAR. California Institute of Technology. Government sponsorship acknowledged.

**Author:** Xiaolan Xu  
**Affiliation:** Jet Propulsion Laboratory, California Institute of Technology

**Funding:** The research was carried out at the Jet Propulsion Laboratory, California Institute of Technology, under a contract with the National Aeronautics and Space Administration (80NM0018D0004).

---

[Talk description/abstract here]
```

## For JPL + Non-JPL Co-authors (if JPL is corresponding author)

```markdown
© YEAR. All rights reserved.

**Authors:** Xiaolan Xu¹, [Co-author Name]²  
¹ Jet Propulsion Laboratory, California Institute of Technology  
² [Other Institution]

**Funding:** The research was carried out at the Jet Propulsion Laboratory, California Institute of Technology, under a contract with the National Aeronautics and Space Administration (80NM0018D0004).
```

## For Non-JPL Corresponding Author + JPL Co-author

No copyright statement required. Only include:

```markdown
**Authors:** [Lead Author]¹, Xiaolan Xu²  
¹ [Lead Institution]  
² Jet Propulsion Laboratory, California Institute of Technology
```
