# pp-tran Skill Configuration

## Skill Metadata

**Name**: pp-tran  
**Alias**: pp-translator  
**Version**: 1.0.0  
**Updated**: 2026-05-19  
**Dependencies**: None

## Directory Structure

```
pp-tran/
├── SKILL.md          # Main skill file, required
├── README.md         # Package overview
├── CONFIG.md         # Configuration and maintenance notes
├── 使用指南.md       # Chinese usage guide
└── references/       # Long-form reference documents
    └── 国际化各个国家地区策略指南.md
```

## Supported Input Formats

| Format | Typical Path | Notes |
| --- | --- | --- |
| Flutter ARB | `lib/l10n/*.arb` | Preserve `@key` metadata and placeholders |
| iOS strings | `*.lproj/Localizable.strings` | Preserve comments, escaping, and semicolons |
| JSON | `src/locales/*.json` | Preserve nesting and key order where practical |
| YAML / YML | `src/i18n/*.yaml` | Preserve indentation and scalar style where practical |

## Default Behavior

| Option | Default |
| --- | --- |
| Base language | Auto-detect, prefer `zh-CN` when both `zh-CN` and `en` exist |
| Translation mode | Incremental |
| Overwrite policy | Fill missing or empty values; avoid overwriting completed translations unless requested |
| Target languages | All detected non-base language files unless user specifies a subset |
| Reference loading | Read `references/` only when culture, region, or style guidance is needed |

## Activation Cues

The skill should activate when users mention:

- `pp-tran` or `pp-translator`
- i18n, l10n, 国际化, 本地化, 多语言
- `.arb`, `.strings`, locale JSON, locale YAML
- Translating selected keys, newly added keys, or missing language entries

## Maintenance Notes

- Keep `SKILL.md` task-oriented and concise.
- Move long country, region, or terminology guidance into `references/`.
- Add deterministic scripts under `scripts/` only when repeatable parsing or validation logic is needed.
- Do not add provider-specific metadata to frontmatter unless isolated for one platform.
