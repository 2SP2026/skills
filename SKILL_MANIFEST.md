# 2SP Skills Library Manifest
**Last Updated:** 2026-02-05  
**Location:** `/Users/leol/Desktop/Antigravity/skills/skills/`

This manifest enables automatic skill discovery across all Antigravity projects. Skills are organized by category with trigger conditions for AI agents.

---

## 2SP Custom Skills (Use First)

| Skill | Trigger Conditions | Description |
|-------|-------------------|-------------|
| **2sp-code-audit** | "code audit", "review code", before major release, "check code quality" | Full code quality review with Poly-Computing checks |
| **2sp-metadata** | "update metadata", new project, "version history", "program.json" | Standard documentation, metadata, and version history protocol |
| **2sp-git-check** | "sync repos", "git status", "check all repos", "push changes" | Workspace-wide git synchronization |
| **2sp-design-philosophy** | "design review", "robustness check", "four pillars" | Apply 2SP Design Philosophy (Robustness, Efficiency, UX, Maintainability) |
| **2sp-new-project-kickoff** | "new project", "start project", "create project" | Launch new 2SP project with skill sync and implementation planning |
| **new-python-project** | "create python project", "new python app", "scaffold python" | Python project with .venv, structure, and config files |

---

## Document Generation

| Skill | Trigger Conditions | Description |
|-------|-------------------|-------------|
| **docx** | "create Word doc", "edit .docx", "tracked changes", "Word document" | Create/edit Word documents with formatting and comments |
| **xlsx** | "create spreadsheet", "Excel file", "formulas", ".xlsx" | Spreadsheet creation with formulas and data analysis |
| **pptx** | "create presentation", "PowerPoint", "slides", ".pptx" | Presentation creation and editing |
| **pdf** | "create PDF", "fill PDF form", "merge PDFs", "extract from PDF" | PDF manipulation, form filling, merge/split |

---

## Web & Frontend Development

| Skill | Trigger Conditions | Description |
|-------|-------------------|-------------|
| **frontend-design** | "build website", "create UI", "landing page", "web component", "beautify" | Production-grade frontend interfaces with high design quality |
| **webapp-testing** | "test webapp", "verify UI", "browser test", "Playwright" | Test local web apps using Playwright |
| **web-artifacts-builder** | "complex artifact", "React component", "shadcn", "multi-component" | Elaborate HTML artifacts with React/Tailwind/shadcn |
| **theme-factory** | "apply theme", "style artifact", "color scheme", "custom theme" | Style artifacts with 10 pre-set themes or custom |

---

## Creative & Design

| Skill | Trigger Conditions | Description |
|-------|-------------------|-------------|
| **canvas-design** | "create poster", "visual art", "design image", "static design" | Visual art in .png/.pdf using design philosophy |
| **algorithmic-art** | "generative art", "p5.js", "flow field", "particle system", "code art" | Algorithmic art with seeded randomness |
| **slack-gif-creator** | "GIF for Slack", "animated GIF", "Slack animation" | Animated GIFs optimized for Slack |
| **brand-guidelines** | "Anthropic brand", "brand colors", "company style" | Apply Anthropic brand colors/typography |

---

## Documentation & Communication

| Skill | Trigger Conditions | Description |
|-------|-------------------|-------------|
| **doc-coauthoring** | "write documentation", "draft spec", "create proposal", "technical doc" | Structured workflow for co-authoring docs |
| **internal-comms** | "status report", "project update", "company newsletter", "incident report" | Internal communications templates |

---

## Developer Tools

| Skill | Trigger Conditions | Description |
|-------|-------------------|-------------|
| **mcp-builder** | "build MCP server", "MCP integration", "FastMCP", "external API" | Create MCP servers for LLM integrations |
| **skill-creator** | "create skill", "new skill", "update skill", "extend capabilities" | Guide for creating/updating skills |

---

## Usage Instructions

### For AI Agents
1. At conversation start, check if task matches any trigger conditions
2. Read the relevant `SKILL.md` before proceeding
3. Follow skill instructions exactly

### Skill Path Pattern
```
/Users/leol/Desktop/Antigravity/skills/skills/{skill-name}/SKILL.md
```

### Priority Order
1. **2SP Custom Skills** - Always prefer these for 2SP projects
2. **Document Generation** - For file output tasks
3. **Web/Frontend** - For UI/web development
4. **Creative/Design** - For visual content
5. **Developer Tools** - For meta/tooling tasks
