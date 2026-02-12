# Example Skill
---
name: example-skill
description: A basic skill to demonstrate how to register and use skills.
---

## Description
This skill showcases the required format for agent skills. By placing a `SKILL.md` file in a dedicated subfolder within `.agent/skills`, the Antigravity agent can easily discover and utilize it.

## Instructions
1.  **Placement**: Ensure this file is named `SKILL.md` and resides within a subfolder of `.agent/skills`.
2.  **Metadata**: Include the YAML frontmatter with `name` and `description`.
3.  **Content**: Provide clear instructions, scripts, or resources in this file or adjacent files.

## Usage
When the user mentions "example skill" or requires help with understanding skills, the agent will check this file for guidance.
