---
name: 2sp-code-audit
description: Use this skill to perform a comprehensive code audit for 2SP Python projects before release. It covers cross-platform compatibility, code robustness, LL-metadata, documentation, linting, and Git commit.
---

# 2SP Code Audit Protocol

This skill provides a standardized checklist for auditing Python projects within the 2SP Professional Tools suite before release or major commits.

## Audit Checklist

### 1. Cross-Platform Compatibility
**Objective**: Ensure the codebase works on macOS, Windows, and Linux.

**Checks**:
- [ ] Use `pathlib.Path` instead of `os.path.join` for all file path operations
- [ ] No hardcoded path separators (`/` or `\`)
- [ ] Check for platform-specific code and ensure alternatives exist
- [ ] Virtual environment uses `.venv` (hidden directory standard)

**Commands**:
```bash
# Search for os.path usage (should return no results)
grep -r "os.path.join" src/

# Verify pathlib usage
grep -r "from pathlib import Path" src/
```

---

### 2. Code Robustness
**Objective**: Validate that core modules compile and tests pass.

**Checks**:
- [ ] All Python modules compile without syntax errors
- [ ] Type hints are present on public functions
- [ ] Exception handling is appropriate (not too broad)
- [ ] All tests pass

**Commands**:
```bash
# Compile check (should produce no output)
python -m py_compile src/**/*.py

# Run tests
pytest tests/ -v
```

---

### 3. LL-Metadata Protocol
**Objective**: Ensure project metadata follows 2SP standards.

**Checks**:
- [ ] `program.json` exists at project root
- [ ] Version in `program.json` matches `src/version.py`
- [ ] Author, license, and branding fields are correct

**Required `program.json` Structure**:
```json
{
    "program_name": "2SP [Project Name]",
    "program_version": "X.Y.Z",
    "program_description": "[Description]",
    "program_author": "Leo L.",
    "program_email": "twosigmaplus@gmail.com",
    "program_license": "CC BY-NC",
    "program_status": "Production",
    "program_date": "YYYY-MM-DD",
    "program_entry_point": "[main_script.py]",
    "program_python_version": ">=3.12",
    "branding": {
        "suite": "2SP Professional Tools",
        "visual_identity": "Yellow on Black",
        "primary_color": "#FFE500",
        "background_color": "#000000"
    }
}
```

---

### 4. Documentation
**Objective**: Ensure README and key docs are accurate and up-to-date.

**Checks**:
- [ ] `README.md` has correct version number
- [ ] Project status section reflects current phase
- [ ] Installation instructions are accurate
- [ ] Technology stack section matches actual dependencies

**Footer Format**:
```markdown
---

**Project Version**: X.Y.Z
**Status**: Phase N Complete - [Description]
**Last Updated**: YYYY-MM-DD
```

---

### 5. Linting & Formatting
**Objective**: Ensure code quality and consistency.

**Checks**:
- [ ] No critical linting errors in Python files
- [ ] Markdown lint warnings addressed (if applicable)
- [ ] Consistent code style

**Commands**:
```bash
# Python linting (optional, if tools installed)
flake8 src/ --max-line-length=120
black src/ --check

# Check for type errors (optional)
mypy src/
```

---

### 6. Git Commit
**Objective**: Stage and commit all changes with a meaningful message.

**Process**:
1. Review changes: `git status`
2. Stage all: `git add -A`
3. Commit with structured message

**Commit Message Format**:
```
vX.Y.Z: [Brief Summary]

[Section 1]:
- [Detail 1]
- [Detail 2]

[Section 2]:
- [Detail]

[Tests/Verification]:
- [N] tests passing
```

**Commands**:
```bash
git add -A
git status --short
git commit -m "vX.Y.Z: [Summary]

- [Details]"
git push
```

---

## Quick Audit Workflow

```bash
# 1. Cross-platform check
grep -r "os.path.join" src/ && echo "FAIL: Use pathlib" || echo "PASS"

# 2. Compile check
python -m py_compile $(find src -name "*.py") && echo "PASS"

# 3. Run tests
pytest tests/ -v

# 4. Check metadata
cat program.json | head -5

# 5. Check README version
grep "Project Version" README.md

# 6. Git status
git status --short
```

---

## Audit Report Template

After completing the audit, summarize findings:

| Category | Status | Notes |
|----------|--------|-------|
| Cross-Platform | ✅/⚠️/❌ | [Notes] |
| Code Robustness | ✅/⚠️/❌ | [Tests: X/Y passing] |
| LL-Metadata | ✅/⚠️/❌ | [program.json status] |
| Documentation | ✅/⚠️/❌ | [README status] |
| Linting | ✅/⚠️/❌ | [Warning count] |
| Git Commit | ✅/⚠️/❌ | [Commit hash] |

---

## Reference

- **2SP Metadata Skill**: See `/2sp-metadata` for detailed metadata protocol
- **Version History Policy**: Major bumps (vX → vY) clear old history
- **Python Version**: 3.12+ required for all 2SP projects
- **Virtual Environment**: Use `.venv` (hidden directory)
