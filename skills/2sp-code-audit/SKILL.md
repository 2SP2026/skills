---
name: 2sp-code-audit
description: Use this skill to perform a comprehensive code audit for 2SP Python projects before release. It covers cross-platform compatibility, code robustness, LL-metadata, documentation, linting, and Git commit.
---

# 2SP Code Audit Protocol

This skill provides a standardized checklist for auditing Python projects within the 2SP Professional Tools suite before release or major commits.

## Audit Checklist

### 1. Poly-Computing Architecture
**Objective**: Ensure the codebase isn't just "compatible" but natively optimized for the specific hardware (macOS Metal/MPS vs Windows CUDA).

**Checks**:

- [ ] Implement a dynamic hardware dispatcher (Check for CUDA vs MPS vs CPU)
- [ ] Use `pathlib.Path` for cross-platform file handling (baseline)
- [ ] Critical compute loops are vectorized or GPU-accelerated
- [ ] Fallback paths (e.g., vectorized CPU) exist for all hardware-optimized logic
- [ ] Virtual environment uses `.venv` standard

**Commands**:

```bash
# Search for hardware-specific dispatcher logic
grep -r "torch.backends.mps.is_available" src/
grep -r "torch.cuda.is_available" src/

# Verify vectorized logic (numpy over pure python loops)
grep -r "np\.vectorize\|np\.apply_along_axis" src/
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

### 3. Import Validation
**Objective**: Verify all modules can be imported without runtime errors.

**Checks**:
- [ ] All public modules import successfully
- [ ] No circular import issues
- [ ] No missing dependencies at import time

**Commands**:
```bash
# Test all module imports (customize per project)
python -c "
from src.config import *
from src.core.graph import *
# ... add all key module imports
print('All imports OK')
"
```

---

### 4. Dependency Check
**Objective**: Ensure requirements.txt matches actual usage.

**Checks**:
- [ ] All imported third-party packages are in requirements.txt
- [ ] No unused dependencies listed
- [ ] Version constraints are appropriate

**Commands**:
```bash
# List installed packages
pip freeze | grep -v "pkg_resources"

# Check for missing imports (manual review)
grep -rh "^import \|^from " src/ | sort | uniq
```

---

### 5. LL-Metadata Protocol
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

### 6. Documentation
**Objective**: Ensure README, key docs, and project planning documents are accurate and up-to-date.

**Checks**:
- [ ] `README.md` has correct version number
- [ ] Project status section reflects current phase
- [ ] Installation instructions are accurate
- [ ] Technology stack section matches actual dependencies
- [ ] **`PROJECT_PLAN.md` accurately reflects actual development state** (see below)

**Footer Format**:
```markdown
---

**Project Version**: X.Y.Z
**Status**: Phase N Complete - [Description]
**Last Updated**: YYYY-MM-DD
```

#### Project Dev Plan Review ⚠️ CRITICAL

**Why This Matters**:
Project planning documents often become outdated as development progresses. Features that were "planned" may have been fully implemented, but the plan still lists them as "TODO". This creates confusion about the actual project state.

**Required Review Process**:

1. **Identify Planning Documents**:
   ```bash
   # Find planning/roadmap documents
   find . -name "*PLAN*.md" -o -name "*ROADMAP*.md" -o -name "*TODO*.md" 2>/dev/null
   ```

2. **Cross-Reference Code vs Plan**:
   - Read `PROJECT_PLAN.md` (or equivalent)
   - Compare listed "TODO" items against actual codebase
   - For each planned feature, search codebase to verify if implemented:
     ```bash
     # Example: Check if "streaming" is implemented
     grep -r "stream" src/ --include="*.py" | head -10
     ```

3. **Update Plan to Reflect Reality**:
   - Mark completed features with `[x]` or move to "Completed" section
   - Update version numbers and dates
   - Revise status from "Planning Phase X" to actual current state
   - Remove obsolete planning content that no longer applies

4. **Sync Version History**:
   - `version.py` version should match plan's stated version
   - `CHANGELOG.md` entries should align with plan milestones
   - Plan "Last Updated" date should be current

**Common Issues**:
- ❌ Plan says "Phase 2.5 Complete" but version is v7.3.2 (6 major versions ahead)
- ❌ "Streaming Architecture" listed as TODO but `streaming_pipeline.py` exists
- ❌ "GPU Acceleration" in future roadmap but `iptd_gpu.py` is fully implemented
- ❌ Plan describes tkinter GUI but actual code uses DearPyGui

**Good Practice**:
- Keep plan concise: Document what IS, not what WAS planned
- Use checkboxes for quick status scanning
- Include a "Future Roadmap" section for uncommitted ideas
- Version the plan document header with project version

---


### 7. Linting & Formatting
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

### 8. Technical Documentation
**Objective**: Ensure comprehensive technical documentation exists and is current.

**Required Documents** (stored in `/docs` subdirectory):

| Document | Filename | Purpose |
|----------|----------|---------|
| **Tech Stack** | `TECH_STACK.md` | Full technology composition and dependencies |
| **Architecture** | `ARCHITECTURE.md` | Program block diagram with execution flows |

**Checks**:

- [ ] `/docs` subdirectory exists in project root
- [ ] `TECH_STACK.md` exists and covers all technologies used
- [ ] `ARCHITECTURE.md` exists with Mermaid flow diagrams
- [ ] Version numbers in docs match current project version
- [ ] All major components/features are documented

**TECH_STACK.md Required Sections**:

```markdown
# [Project Name] - Tech Stack Composition
- Overview
- Technology Stack (tables with version, purpose)
- Architecture Summary (ASCII or Mermaid diagram)
- Performance Characteristics
- Cross-Platform Support
- Dependency Summary
```

**ARCHITECTURE.md Required Sections**:

```markdown
# [Project Name] - Program Block Diagram
- System Architecture Overview (Mermaid graph)
- Detailed Execution Flows (Mermaid sequence/flowcharts)
- Key Components and Functions (tables)
- Data Flow Summary
- Feature Matrix
```

**Commands**:

```bash
# Check if docs exist
ls -la docs/TECH_STACK.md docs/ARCHITECTURE.md

# Check version references are current
grep -i "version" docs/TECH_STACK.md | head -3
```

**If Missing**: Create documentation using the established templates. Analyze the codebase structure and generate comprehensive tech stack and architecture documents.

---

### 9. Hardware Efficiency Review
**Objective**: Ensure code is optimized for cross-platform hardware differences between Windows (NVIDIA GPU/CUDA) and macOS (Metal/MPS).

**Why This Matters**:
- Windows users often have NVIDIA GPUs with CUDA acceleration
- macOS users have Apple Silicon with Metal/MPS acceleration
- Web applications must work across both with WebGL/WebGPU fallbacks

**Checks**:

#### Backend (Python/C++)
- [ ] GPU acceleration has fallback to CPU when unavailable
- [ ] PyTorch code uses device-agnostic patterns (`device = torch.device(...)`)
- [ ] NumPy operations are vectorized (avoid Python loops for large arrays)
- [ ] Large file operations use memory mapping or chunked loading where appropriate
- [ ] Parallel processing uses `multiprocessing` or `concurrent.futures`

#### Frontend (JavaScript/WebGL)
- [ ] Heavy parsing uses Web Workers (background threads)
- [ ] Binary data transfer preferred over JSON for large payloads
- [ ] Response compression enabled (GZIP/ZSTD)
- [ ] WebGL buffers use typed arrays (Float32Array, Uint8Array)
- [ ] Render loop has FPS monitoring with adaptive quality

#### Platform-Specific Considerations

| Platform | GPU Stack | Considerations |
|----------|-----------|----------------|
| **Windows** | NVIDIA CUDA, DirectX | Leverage CUDA for ML/compute, larger VRAM typical |
| **macOS** | Metal, MPS | Use MPS for PyTorch, Metal for graphics, unified memory |
| **Web** | WebGL 2.0, WebGPU | Feature-detect capabilities, provide fallbacks |

**Commands**:
```bash
# Check for hardcoded CUDA references (should have fallbacks)
grep -r "\.cuda()" src/

# Check for device-agnostic patterns
grep -r "torch\.device" src/

# Check for Web Worker usage in JS
grep -r "new Worker" src/static/

# Check for compression middleware
grep -r "compress\|Compress\|gzip" src/
```

**PyTorch Device-Agnostic Pattern**:
```python
# Preferred pattern
def get_device():
    if torch.cuda.is_available():
        return torch.device("cuda")
    elif torch.backends.mps.is_available():
        return torch.device("mps")
    return torch.device("cpu")

device = get_device()
model = model.to(device)
```

**Web Performance Pattern**:
```javascript
// Heavy parsing in Web Worker
const worker = new Worker('/static/parser-worker.js');
worker.postMessage({ buffer }, [buffer]); // Zero-copy transfer

// FPS-based adaptive quality
if (currentFPS < targetFPS) {
    reduceQuality();
}
```

---

### 10. Licensing Compliance
**Objective**: Ensure all third-party dependencies and bundled components are properly licensed and documented.

**Why This Matters**:
- Open source licenses have legal requirements that must be met
- Bundling binaries requires proper attribution
- LGPL components need special handling (source access)
- GPL components can make your entire project GPL ("copyleft")

**Checks**:

#### Third-Party Documentation
- [ ] `THIRD_PARTY_LICENSES.md` exists at project root (for projects with bundled components)
- [ ] All bundled binaries/libraries are listed with versions
- [ ] License type identified for each component
- [ ] Copyright notices included for all components

#### License Compliance by Type

| License | Requirements |
|---------|--------------|
| **MIT** | Include copyright + license text |
| **BSD 2/3-Clause** | Include copyright + license text |
| **Apache 2.0** | Include copyright + license + NOTICE file (if exists) |
| **LGPL 2.1/3.0** | Include license, provide source access link, no static linking |
| **GPL** | ⚠️ Avoid unless project is GPL (copyleft viral) |

#### Python Dependencies
- [ ] All pip packages checked for compatible licenses
- [ ] No GPL packages (unless intentional)
- [ ] Commercial/proprietary packages documented

**Commands**:
```bash
# Check for THIRD_PARTY_LICENSES.md
ls THIRD_PARTY_LICENSES.md

# List bundled binaries (if any)
find bin/ -type f -executable 2>/dev/null | head -20

# Check pip package licenses (requires pip-licenses)
pip-licenses --format=markdown

# Quick license check for common problematic licenses
pip-licenses | grep -i "gpl\|agpl\|copyleft"
```

**THIRD_PARTY_LICENSES.md Template**:
```markdown
# Third-Party Licenses

## Summary
| Component | Version | License | Attribution Required |
|-----------|---------|---------|---------------------|
| [Name] | [X.Y.Z] | [MIT/BSD/etc] | Yes |

## Detailed License Texts
### [Component Name] ([License])
[Full license text or reference]
Source: [URL]
```

**Red Flags**:
- ❌ GPL/AGPL dependencies in non-GPL projects
- ❌ Bundled binaries without documented licenses
- ❌ Missing copyright notices
- ❌ LGPL components statically linked

---

### 11. Git Commit
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
| **Project Dev Plan** | ✅/⚠️/❌ | [PROJECT_PLAN.md synced with codebase] |
| Technical Docs | ✅/⚠️/❌ | [TECH_STACK.md, ARCHITECTURE.md] |
| Linting | ✅/⚠️/❌ | [Warning count] |
| Hardware Efficiency | ✅/⚠️/❌ | [Worker, compression, GPU fallbacks] |
| Licensing Compliance | ✅/⚠️/❌ | [THIRD_PARTY_LICENSES.md, no GPL] |
| Git Commit | ✅/⚠️/❌ | [Commit hash] |


---

## Reference

- **2SP Metadata Skill**: See `/2sp-metadata` for detailed metadata protocol
- **Version History Policy**: Major bumps (vX → vY) clear old history
- **Python Version**: 3.12+ required for all 2SP projects
- **Virtual Environment**: Use `.venv` (hidden directory)
