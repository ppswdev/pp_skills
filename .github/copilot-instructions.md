# Copilot Instructions

This repository stores reusable agent skills for multiple tools.

## Source of truth

- Shared skills are authored in `skills/` under independent-maker domain folders such as `opportunity/`, `engineering/`, `growth/`, and `localization/`
- VS Code adapter content is mirrored into `.github/skills/`

## Editing rules

1. Update shared skills in the correct domain folder under `skills/`.
2. Avoid adding duplicate logic directly in `.github/skills/`.
3. After updates, run `scripts/sync-skills.sh`.

## Skill quality bar

- Clear trigger description
- Explicit workflow
- Structured output guidance
- Reusable across tools where possible
