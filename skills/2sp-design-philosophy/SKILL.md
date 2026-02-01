---
name: 2sp-design-philosophy
description: Apply the 2SP Design Philosophy (Four Pillars) to any project
---

# 2SP Design Philosophy Skill

This skill defines the core design principles that apply to **ALL** 2SP projects. When starting a new project or reviewing existing code, apply these principles consistently.

---

## The Four Pillars

Every 2SP project is built on four fundamental design pillars that take precedence over feature expansion:

### 1. Robustness
**No crashes. Graceful degradation. Predictable behavior.**

- Software must handle edge cases without failing
- Large files/datasets should process without crashes
- Memory usage must be bounded and predictable
- Errors should be informative, not cryptic
- Recovery mechanisms for interrupted processing

### 2. Cross-Platform Compatibility
**macOS is not an afterthought — it's a primary target.**

- Native support for Windows, macOS, and Linux
- No platform-specific dependencies that break on Mac
- Use `pathlib.Path` instead of hardcoded path separators
- Avoid libraries with known macOS issues
- Test on all target platforms before release

### 3. Processing Efficiency
**Handle files 10× larger than competitors on the same hardware.**

- Streaming architecture for memory management
- Memory-mapped I/O for extreme-scale processing
- Parallel processing with controllable resource usage
- Vectorized operations (NumPy/SciPy) over Python loops
- GPU acceleration where beneficial (optional, graceful fallback)

### 4. Code Modularity & Reusability
**Write once, use everywhere. Features should be portable across projects.**

- Extract common logic into standalone, reusable functions
- Use dependency injection for platform-specific behavior
- Keep I/O separate from business logic
- Document public APIs for cross-project use
- Design features that can be shared between related projects

---

## The LM Studio Effect

> **"Just works. No Docker, Conda, or external dependencies."**

Every 2SP application should be installable and usable without requiring:
- Docker containers
- Conda environments
- External binary dependencies (bundle them instead)
- Complex build steps

**Goal**: Download → Run → Works. Like LM Studio.

---

## Licensing Compliance

> **"Know your dependencies. Document your obligations."**

When bundling third-party components, ensure all licensing requirements are met:

### License Types & Requirements

| License | Attribution Required | Include License Text | Source Access |
|---------|---------------------|---------------------|---------------|
| **MIT** | ✅ | ✅ | ❌ |
| **BSD 2/3-Clause** | ✅ | ✅ | ❌ |
| **Apache 2.0** | ✅ | ✅ | ❌ |
| **LGPL 2.1/3.0** | ✅ | ✅ | ✅ (if modified) |
| **GPL** | ⚠️ Copyleft | ✅ | ✅ |

### Compliance Checklist

- [ ] Create `THIRD_PARTY_LICENSES.md` documenting all bundled components
- [ ] Include copyright notices for all third-party code
- [ ] Include full license texts (or reference to them)
- [ ] For LGPL components: provide link to source code
- [ ] Verify no GPL components are linked (unless project is GPL)
- [ ] Keep original `LICENSE` files in bundled directories

### Best Practices

1. **Prefer permissive licenses** (MIT, BSD, Apache) for dependencies
2. **Use external processes** for LGPL components (subprocess, not linking)
3. **Document everything** — future you will thank present you
4. **Run license audits** before major releases

---

## The 2SP Difference

### Legacy Software Problems vs 2SP Solutions

| Issue | Legacy Approach | 2SP Approach |
|-------|-----------------|--------------|
| **Feature bloat** | 200+ menu items, 90% unused | Core workflow, ruthlessly refined |
| **Mac support** | "Use Parallels" or nothing | Native, first-class citizen |
| **Stability** | Crashes on large files | Memory-managed, fault-tolerant |
| **Memory usage** | Load entire file into RAM | Streaming, mmap, chunked |
| **Speed** | Single-threaded | Multi-core parallel |
| **UX** | Install Docker, Conda, etc | Just works |

---

## Applying the Pillars

When evaluating new features or changes, ask:

| Pillar | Question |
|--------|----------|
| **Robustness** | Does this handle errors gracefully? What happens on failure? |
| **Cross-Platform** | Does this work on macOS without hacks? Did I use `pathlib.Path`? |
| **Efficiency** | What's the memory footprint at scale? Does it stream or load all? |
| **Modularity** | Can this code be reused in other projects? Is it decoupled? |

**If a feature doesn't pass all four, it either needs redesign or should be deprioritized.**

---

## Implementation Checklist

### For New Projects

- [ ] Create `docs/DESIGN_PHILOSOPHY.md` referencing this skill
- [ ] Use `pathlib.Path` for all file operations
- [ ] Set up cross-platform testing (Windows + macOS + Linux)
- [ ] Implement error handling with informative messages
- [ ] Design for streaming/chunked processing where applicable

### For Code Reviews

- [ ] Verify no `os.path.join` usage (use `pathlib.Path`)
- [ ] Check error handling is informative
- [ ] Verify memory usage is bounded for large inputs
- [ ] Confirm feature works on macOS (not just Windows)
- [ ] Ensure no new external dependencies that break UX
- [ ] Check code is modular and reusable across projects

---

## Project-Specific Extensions

Individual projects may add a **Fifth Pillar** specific to their domain:

| Project | Fifth Pillar |
|---------|--------------|
| **ll_tts** | Voice Quality (natural, expressive synthesis) |
| **ll_music** | Audio Fidelity (professional-grade output) |
| **2sp_lidar_viewer_potree** | Hybrid Architecture (instant + streaming modes) |

Document project-specific pillars in `docs/DESIGN_PHILOSOPHY.md` or `docs/DESIGN_PRINCIPLES.md`.

---

## The Vision

A suite of professional tools that:
- **Just work** — No mysterious crashes, no Docker/Conda
- **Run anywhere** — Mac, Windows, Linux
- **Handle anything** — From small samples to production-scale data
- **Trust-worthy** — The tools professionals rely on

> *"This isn't about competing on feature count. It's about being the tool professionals trust."*

---

## Version History

- **v1.2** (2026-02-01): Added Licensing Compliance section with license types and checklist
- **v1.1** (2026-02-01): Promoted Code Modularity to core Fourth Pillar (was project-specific)
- **v1.0** (2026-02-01): Initial version, consolidated from 2sp_lidar_analysis and 2sp_lidar_viewer_potree
