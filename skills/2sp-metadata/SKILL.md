---
name: 2sp-metadata
description: Use this skill to apply the standard documentation, metadata, and version history protocol to 2SP Python projects. It ensures consistency in branding (2SP), licensing (CC BY-NC), and version tracking across projects.
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

### License Management (CRITICAL)

**License Selection Protocol:**

1. **Check for Open Source Dependencies**: Before setting the license, check if the project uses any open source code, libraries, or dependencies with specific licensing requirements.

2. **License Compatibility Decision Tree**:

   **IF** the project uses open source code/libraries:
   - **Check `requirements.txt`** for Python package licenses
   - **Check imported/vendored code** for license headers
   - **Identify most restrictive license** among dependencies

   Common compatibility rules:
   - **GPL/AGPL dependencies** → Must use GPL/AGPL (copyleft requirement)
   - **LGPL dependencies** → Can use LGPL, GPL, or compatible licenses
   - **Apache 2.0/MIT/BSD dependencies** → Compatible with most licenses
   - **Mixed permissive licenses** → Use CC BY-NC (default) or choose compatible license

   **IF** no open source dependencies with restrictive terms:
   - **Default to CC BY-NC** (Creative Commons Attribution-NonCommercial)

3. **License Selection Examples**:
   ```python
   # Example 1: Pure original code or only permissive dependencies (MIT/BSD/Apache)
   __license__ = "CC BY-NC"

   # Example 2: Uses GPL-licensed library
   __license__ = "GPL-3.0"

   # Example 3: Uses AGPL-licensed library
   __license__ = "AGPL-3.0"

   # Example 4: Uses LGPL library (can stay CC BY-NC or use LGPL)
   __license__ = "CC BY-NC"  # or "LGPL-3.0" if preferred
   ```

4. **License Attribution**: When using open source code, add license notices:
   ```python
   __credits__ = ["Leo L.", "Original Author Name (Library/Code Used)"]
   __license_notes__ = "Uses [Library Name] under [License Type]"
   ```

5. **Verification Steps**:
   - Review `requirements.txt` for package licenses
   - Check any copied/adapted code for license headers
   - Use `pip-licenses` tool if needed: `pip install pip-licenses && pip-licenses`
   - When uncertain, choose the most restrictive compatible license

**License Compatibility Quick Reference**:
- **Most Restrictive**: AGPL-3.0 (requires source disclosure for network use)
- **Restrictive**: GPL-3.0 (requires source disclosure)
- **Moderate**: LGPL-3.0 (library-specific copyleft)
- **Permissive**: MIT, BSD, Apache-2.0 (minimal restrictions)
- **Default Personal**: CC BY-NC (non-commercial attribution)

### Other Guidelines

- **2σ+ Branding**: For projects within the 2σ+ suite, ensure titles are prefixed with `2σ+` (e.g., `2σ+ News Aggregator`).
- **Version Bumping**: When performing a minor update (e.g., v3.0 to v3.1), add a new "Improvements" section at the top of the history list.
- **Major Bumps**: When performing a major update (e.g., v2.x to v3.0), you may archive/remove history from the previous major version to keep the docstring clean.

## License Checking Workflow

When applying metadata to a new or existing project:

### Step 1: Identify Dependencies
```bash
# Check Python package dependencies
cat requirements.txt

# List installed package licenses (install tool if needed)
pip install pip-licenses
pip-licenses --format=markdown
```

### Step 2: Check for Vendored/Copied Code
- Search for LICENSE files in subdirectories
- Look for license headers in imported .py files
- Check README files for attribution requirements

### Step 3: Determine Required License
- **If GPL/AGPL found**: Must use GPL/AGPL
- **If only permissive (MIT/BSD/Apache)**: Use CC BY-NC (default)
- **If mixed**: Choose most restrictive compatible license

### Step 4: Apply License & Credits
```python
# Example with GPL dependency
__license__ = "GPL-3.0"
__credits__ = ["Leo L.", "SQLAlchemy developers"]
__license_notes__ = "Uses SQLAlchemy under BSD License, compatible with GPL-3.0"
```

### Step 5: Document in README
Add a "License & Attribution" section to README.md:
```markdown
## License & Attribution

This project is licensed under [LICENSE TYPE].

### Dependencies
- [Package Name] - [License Type]
- [Package Name] - [License Type]
```

## Examples & Templates

- **Python Template**: See [references/template_py.md](references/template_py.md) for a ready-to-copy boilerplate.
- **License Guide**: See [references/license_guide.md](references/license_guide.md) for detailed license selection guidance.
- **Reference Implementations**:
    - `ll_weekly_news.py` (v3.0.0)
    - `ll_odoo_weekly_v3.0.py` (v3.3)
