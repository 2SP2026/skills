---
name: 2sp-new-project-kickoff
description: Use this skill to properly launch a new 2SP project. It combines skill sync, knowledge discovery, scaffolding, and implementation planning into a single protocol.
---

# 2SP New Project Kickoff Protocol

This skill provides a standardized 5-phase approach for launching new projects within the 2SP Professional Tools suite.

## Phase 1: Sync & Scout

**Objective**: Prepare context before writing any code.

**Steps**:

1. **Skill Sync**: Index the `/skills` directory to load all available protocols.
2. **Knowledge Discovery**: Review Knowledge Items (KIs) for similar past projects.
3. **Scope Definition**: Confirm project goals with the user. Ask clarifying questions if needed.

**Agent Actions**:

```bash
# Index skills library
ls /Users/leol/Desktop/Antigravity/skills/skills/

# Check for related KIs (agent reviews summaries provided at session start)
```

---

## Phase 2: Scaffold

**Objective**: Create the project structure following 2SP standards.

**Steps**:

1. Create the project directory at `/Users/leol/Desktop/Antigravity/2sp_[project_name]`
2. Initialize virtual environment (`.venv`)
3. Create standard folder structure: `/src`, `/tests`, `/docs`
4. Create `program.json` with 2SP branding
5. Create `version.py` with initial version `0.1.0`
6. Create `README.md` skeleton
7. Initialize git repository

**Commands**:

```bash
# Create project directory
mkdir -p /Users/leol/Desktop/Antigravity/2sp_[project_name]
cd /Users/leol/Desktop/Antigravity/2sp_[project_name]

# Create virtual environment
python3 -m venv .venv

# Create folder structure
mkdir -p src tests docs

# Initialize git
git init
```

**Required `program.json` Template**:

```json
{
    "program_name": "2SP [Project Name]",
    "program_version": "0.1.0",
    "program_description": "[Description]",
    "program_author": "Leo L.",
    "program_email": "twosigmaplus@gmail.com",
    "program_license": "CC BY-NC",
    "program_status": "Development",
    "program_date": "[YYYY-MM-DD]",
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

**Required `version.py` Template**:

```python
"""Version information for 2SP [Project Name]."""

__version__ = "0.1.0"
__version_info__ = tuple(int(x) for x in __version__.split("."))
```

---

## Phase 3: Blueprint (Implementation Plan)

**Objective**: Design before building.

**Steps**:

1. Create `implementation_plan.md` artifact
2. Define proposed architecture and key modules
3. Identify Poly-Computing requirements (if compute-heavy)
4. List verification strategy (tests, manual checks)
5. Request user review before proceeding

**Poly-Computing Declaration** (if applicable):

If the project involves heavy computation (e.g., LiDAR, ML, data processing), declare the hardware strategy:

- [ ] Apple Silicon: Metal/MPS acceleration
- [ ] NVIDIA/Windows: CUDA acceleration
- [ ] Web/Browser: WebGPU/Web Workers
- [ ] CPU Fallback: Vectorized NumPy

---

## Phase 4: Build (Execution)

**Objective**: Iterative development with continuous verification.

**Guidelines**:

- Update `task.md` as work progresses
- Write tests alongside features
- Sync `program.json` and `version.py` at milestones
- Commit frequently with structured messages

**Commit Message Format**:

```
v0.X.Y: [Brief Summary]

[Section]:
- [Detail 1]
- [Detail 2]
```

---

## Phase 5: Lock-In (Completion)

**Objective**: Finalize and document the project.

**Steps**:

1. Run `2sp-code-audit` skill (full checklist)
2. Generate `walkthrough.md` artifact
3. Propose Knowledge Item updates (if new patterns emerged)
4. Final git commit and push

**Commands**:

```bash
git add -A
git status --short
git commit -m "v0.1.0: Initial release"
git push -u origin main
```

---

## Quick Reference Prompts

| Phase | User Prompt |
|-------|-------------|
| **1. Sync** | "Sync skills. I want to build [X]. Check KIs for similar projects." |
| **2. Scaffold** | "Run `2sp-new-project-kickoff` to create `2sp_[name]`." |
| **3. Blueprint** | "Draft an implementation plan. I'll review before coding." |
| **4. Build** | "Let's start implementing. Begin with [feature]." |
| **5. Lock-In** | "Run `2sp-code-audit`, create walkthrough, and commit." |

---

## Integration with Other Skills

| Skill | When to Use |
|-------|-------------|
| `2sp-metadata` | After Phase 2 to verify `program.json` compliance |
| `2sp-code-audit` | Phase 5 for final quality gate |
| `2sp-git-check` | Anytime to verify repository sync status |

---

## Reference

- **Python Version**: 3.12+ required
- **Virtual Environment**: `.venv` standard
- **Branding**: Yellow on Black (2SP Corporate Identity)
- **Poly-Computing**: Required for compute-heavy projects
