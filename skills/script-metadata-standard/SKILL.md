---
name: script-metadata-standard
description: Use this skill to apply the standard documentation, metadata, and version history protocol to Python scripts. It ensures consistency in branding (2σ+), licensing (CC BY-NC), and version tracking across projects.
---

# Script Metadata & Version History Protocol

This skill provides the mandatory structure for Python script headers, metadata variables, and version history tracking.

## Core Components

### 1. File Header & Docstring
Every script must begin with a shebang, encoding, and a comprehensive docstring structured as follows:

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
[Project/Script Name] v[X.Y]

NOTE: version history tracking policy: 
Keep all history for all improvements between minor version updates like v3.1, v3.2, v3.3. 
Only remove prior history tracking when there is a Major version bump like from VX to VY.

Improvements in v[X.Y] ([YYYY-MM-DD]):
- [Feature Group Name]:
    - [Specific Detail 1]
    - [Specific Detail 2]
- [Bug Fixes/Stability]:
    - [Specific Detail]

Improvements in v[X.X] ([YYYY-MM-DD]):
- ...

Major features in v1.0 ([YYYY-MM-DD]):
- [Baseline Feature 1]
- ...

Version: [X.Y.Z]
"""
```

### 2. Standard Metadata Variables
Explicitly define the following variables immediately after the docstring:

```python
__author__ = "Leo L."
__email__ = "twosigmaplus@gmail.com"
__copyright__ = "Copyright [YEAR] Leo L."
__version__ = "v[X.Y.Z]"
__license__ = "CC BY-NC"
__status__ = "Production"  # or "Development / Experimental"
__date__ = "[YYYY-MM-DD]"
__maintainer__ = "Leo L."
__credits__ = ["Leo L."]
__description__ = "[Brief, professional description of the script's purpose]"
```

## Usage Guidelines

- **Licensing**: Always default to **CC BY-NC** (Creative Commons Attribution-NonCommercial) unless explicitly instructed otherwise.
- **2σ+ Branding**: For projects within the 2σ+ suite, ensure titles are prefixed with `2σ+` (e.g., `2σ+ News Aggregator`).
- **Version Bumping**: When performing a minor update (e.g., v3.0 to v3.1), add a new "Improvements" section at the top of the history list.
- **Major Bumps**: When performing a major update (e.g., v2.x to v3.0), you may archive/remove history from the previous major version to keep the docstring clean.

## Examples & Templates

- **Python Template**: See [references/template_py.md](references/template_py.md) for a ready-to-copy boilerplate.
- **Reference Implementations**:
    - `ll_weekly_news.py` (v3.0.0)
    - `ll_odoo_weekly_v3.0.py` (v3.3)
