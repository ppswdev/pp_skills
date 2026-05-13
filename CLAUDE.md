# Claude Code Workspace Guide

This repository uses a shared multi-tool skills layout.

## Where skills live

- Canonical source: `skills/` with full independent-maker domain folders such as `skills/opportunity/`, `skills/growth/`, and `skills/localization/`
- Claude Code adapter: `.claude/skills/`

## How to work here

1. Read or edit reusable skills in the matching domain folder under `skills/`
2. Only place Claude-specific files in `.claude/` when necessary
3. Run `scripts/sync-skills.sh` after changing shared skills

## Authoring preferences

- Use portable `SKILL.md` frontmatter
- Keep instructions short and trigger-focused
- Put long references in `references/`
- Put repeatable logic in `scripts/`

## Project intent

The goal is to maintain one skills repository that can be consumed by Claude Code, Codex, VS Code, and Trae with minimal duplication.
