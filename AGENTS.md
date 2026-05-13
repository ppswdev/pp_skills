# Agent Workspace Rules

This repository is the single source of truth for reusable agent skills.

## Repository goals

- Maintain one shared `skills/` source directory
- Reuse the same skill content across Codex, Claude Code, VS Code, and Trae
- Keep tool-specific adapters thin and easy to regenerate

## Preferred structure

- `skills/`: canonical reusable skills root
- `skills/opportunity/`
- `skills/strategy/`
- `skills/product/`
- `skills/research/`
- `skills/design/`
- `skills/engineering/`
- `skills/data/`
- `skills/growth/`
- `skills/sales/`
- `skills/monetization/`
- `skills/operations/`
- `skills/support/`
- `skills/finance-legal/`
- `skills/localization/`
- `.claude/skills/`: Claude Code project entrypoint
- `.codex/skills/`: Codex project entrypoint
- `.github/skills/`: VS Code and Copilot entrypoint
- `.trae/skills/`: Trae project entrypoint
- `docs/`: usage guides and prompt documentation
- `scripts/`: sync and install scripts

## Working rules

1. Add or update reusable skill content in the correct domain folder under `skills/`.
2. Treat tool-specific directories as generated mirrors unless a tool requires a local-only file.
3. Keep frontmatter portable:
   - required: `name`, `description`
   - avoid tool-specific metadata unless clearly isolated
4. Move large domain knowledge into `references/` instead of bloating `SKILL.md`.
5. Put deterministic or repetitive logic into `scripts/` inside a skill when needed.

## Skill authoring guidance

- Keep `SKILL.md` concise and task-oriented
- Make trigger descriptions explicit
- Add realistic user invocation examples
- Prefer compatibility over tool-specific cleverness

## Sync policy

Use `scripts/sync-skills.sh` after changing `skills/` to refresh project adapters.
