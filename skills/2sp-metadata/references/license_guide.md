# License Selection Quick Guide

## Decision Flow

```
START
  ↓
Does project use open source code/libraries?
  ↓
  NO → Use CC BY-NC (default)
  ↓
  YES → Check dependency licenses
        ↓
        Contains GPL/AGPL? → YES → Use GPL/AGPL
        ↓
        NO → Contains LGPL? → YES → Use LGPL or CC BY-NC
        ↓
        NO → Only permissive (MIT/BSD/Apache)? → YES → Use CC BY-NC (default)
```

## Common Python Package Licenses

### Copyleft (Restrictive)
- **GPL-3.0**: GNU General Public License v3
  - Examples: Some scientific libraries
  - **Requirement**: Your code must be GPL-3.0

- **AGPL-3.0**: Affero GPL (network use = distribution)
  - Examples: Some database/server libraries
  - **Requirement**: Your code must be AGPL-3.0

- **LGPL-3.0**: Lesser GPL (library exception)
  - Examples: Some system libraries
  - **Requirement**: Can use with other licenses, but library modifications must be LGPL

### Permissive (Compatible)
- **MIT**: Very permissive
  - Examples: requests, Flask, Django
  - **Requirement**: Include MIT license notice
  - **Compatible with**: CC BY-NC ✓

- **BSD**: Similar to MIT
  - Examples: NumPy, SciPy, pandas
  - **Requirement**: Include BSD license notice
  - **Compatible with**: CC BY-NC ✓

- **Apache-2.0**: Permissive with patent grant
  - Examples: TensorFlow, Apache libraries
  - **Requirement**: Include Apache notice
  - **Compatible with**: CC BY-NC ✓

- **PSF**: Python Software Foundation
  - Examples: Python stdlib
  - **Requirement**: Minimal
  - **Compatible with**: CC BY-NC ✓

## Quick Commands

### Check Installed Package Licenses
```bash
# Install license checker
pip install pip-licenses

# List all package licenses
pip-licenses

# Formatted output
pip-licenses --format=markdown

# Check specific package
pip show package_name | grep License
```

### Search for License Files
```bash
# Find LICENSE files in project
find . -name "LICENSE*" -o -name "COPYING*"

# Search for license headers in Python files
grep -r "License:" --include="*.py" .
```

## License Compatibility Matrix

| Your Code Wants | Can Use GPL? | Can Use LGPL? | Can Use MIT/BSD? | Can Use Apache? |
|-----------------|--------------|---------------|------------------|-----------------|
| **CC BY-NC**    | ❌ No        | ✓ Yes         | ✓ Yes            | ✓ Yes           |
| **GPL-3.0**     | ✓ Yes        | ✓ Yes         | ✓ Yes            | ✓ Yes           |
| **AGPL-3.0**    | ✓ Yes        | ✓ Yes         | ✓ Yes            | ✓ Yes           |
| **MIT**         | ❌ No        | ⚠️ Maybe      | ✓ Yes            | ✓ Yes           |

**Key Rule**: If ANY dependency is GPL/AGPL, your entire project must be GPL/AGPL.

## Real-World Examples

### Example 1: Django Web App
```python
# Django (BSD), requests (Apache), Pillow (HPND)
# All permissive licenses
__license__ = "CC BY-NC"  # Can use default
```

### Example 2: Data Science Project
```python
# pandas (BSD), NumPy (BSD), matplotlib (PSF)
# All permissive licenses
__license__ = "CC BY-NC"  # Can use default
```

### Example 3: Project with GPL Dependency
```python
# Uses PyGObject (LGPL) for GUI
# LGPL allows other licenses, but prefer compatible
__license__ = "CC BY-NC"  # OK, or use "LGPL-3.0"
```

### Example 4: Project with GPL Code
```python
# Includes modified GPL-licensed code
# MUST use GPL
__license__ = "GPL-3.0"
__license_notes__ = "Contains modified code from [Project] under GPL-3.0"
```

## Best Practices

1. **Check Early**: Review licenses before heavily using a library
2. **Document Dependencies**: Keep track of what licenses you're using
3. **Add NOTICE File**: For permissive licenses, include their license text
4. **When Uncertain**: Choose more restrictive license (safer legally)
5. **Commercial Use**: If planning commercial use, avoid copyleft licenses

## Common Mistakes to Avoid

❌ **DON'T**: Mix GPL code with CC BY-NC
❌ **DON'T**: Forget to check transitive dependencies
❌ **DON'T**: Assume "open source" means "any license"
❌ **DON'T**: Remove license notices from vendored code

✓ **DO**: Check `requirements.txt` licenses
✓ **DO**: Document all dependencies
✓ **DO**: Include license attributions
✓ **DO**: Use compatible licenses

## Resources

- [Choose a License](https://choosealicense.com/)
- [TLDRLegal](https://tldrlegal.com/) - License explanations
- [pip-licenses](https://pypi.org/project/pip-licenses/) - Package license checker
- [SPDX License List](https://spdx.org/licenses/) - Standard license identifiers

## Summary

**Default Rule**: Use **CC BY-NC** for personal projects with no GPL dependencies.

**Exception Rule**: If using GPL/AGPL code, you **must** use GPL/AGPL.

**When in Doubt**: Check licenses with `pip-licenses` and choose the most restrictive compatible license.
