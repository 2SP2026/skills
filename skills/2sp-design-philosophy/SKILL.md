---
name: 2sp-design-philosophy
description: Apply the 2SP Design Philosophy (Three Pillars) to any project
---

# 2SP Design Philosophy Skill

This skill defines the core design principles that apply to **ALL** 2SP projects. When starting a new project or reviewing existing code, apply these principles consistently.

---

## The Three Pillars

Every 2SP project is built on three fundamental design pillars that take precedence over feature expansion:

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

**If a feature doesn't pass all three, it either needs redesign or should be deprioritized.**

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

---

## Project-Specific Extensions

Individual projects may add a **Fourth Pillar** specific to their domain:

| Project | Fourth Pillar |
|---------|---------------|
| **2sp_lidar_viewer_potree** | Code Modularity (features portable to Standard Edition) |
| **ll_tts** | Voice Quality (natural, expressive synthesis) |
| **ll_music** | Audio Fidelity (professional-grade output) |

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

- **v1.0** (2026-02-01): Initial version, consolidated from 2sp_lidar_analysis and 2sp_lidar_viewer_potree
