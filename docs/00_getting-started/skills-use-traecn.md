# Trae 中国版 Skills 项目级配置指南

## 1. 推荐策略

本仓库推荐使用“项目级按角色启用”：

- 全局目录只保留 `skill-creator`
- 具体业务技能放在项目级 `.trae-cn/skills/`
- 每个项目根据角色同步所需 skills，避免无关技能误触发

## 2. 全局技能 vs 项目技能

### 2.1 全局技能

- **配置位置**：`~/.trae-cn/skills/<skill-folder>/`
- **推荐内容**：只放 `skill-creator`
- **原因**：全局技能会影响所有项目，放太多会扩大触发面

### 2.2 项目技能

- **配置位置**：`<workspace-root>/.trae-cn/skills/<skill-folder>/`
- **推荐内容**：当前项目角色真正需要的 skills
- **原因**：项目上下文更清楚，误触发更少，团队协作也更稳定

## 3. 安装全局基础技能

运行：

```bash
scripts/install-global-skills.sh
```

脚本只会安装 `skill-creator` 到：

```text
~/.claude/skills/
~/.codex/skills/
~/.trae-cn/skills/
```

不再把全部 skills 安装到全局目录。

## 4. 按角色同步项目技能

### 程序开发者项目

```bash
scripts/sync-skills.sh --role 程序开发者
```

### 本地化项目

```bash
scripts/sync-skills.sh --role 本地化
```

### 同时需要开发和本地化

```bash
scripts/sync-skills.sh --role 程序开发者 --role 本地化
```

同步后会生成：

```text
.claude/skills/
.codex/skills/
.trae-cn/skills/
```

这些目录都是扁平项目入口，不保留 `00_base/`、`06_engineering/` 这类分类目录。

## 5. 验证同步结果

```bash
scripts/validate-skills.sh --role 程序开发者
scripts/validate-skills.sh --role 本地化
scripts/validate-skills.sh --role 程序开发者 --role 本地化
```

如果只是检查当前项目镜像和源目录的基本一致性，也可以运行：

```bash
scripts/validate-skills.sh
```

## 6. 全量同步仅用于维护

```bash
scripts/sync-skills.sh --all
scripts/validate-skills.sh --all
```

`--all` 会把全部 skills 放进项目入口，容易让模型在无关任务里选择错误技能。日常项目不推荐使用。

## 7. 常见问题

### 技能没有出现在项目中

检查 `docs/02_skill-catalog/role-map.yml` 是否给该 skill 配置了当前角色。

### 技能触发太频繁

优先减少项目级同步的角色数量。不要把所有 skills 装到全局目录。

### TraeCN 没有识别技能

确认目录结构为：

```text
.trae-cn/skills/<skill-name>/SKILL.md
```

然后重启 TraeCN。

## 8. 最佳实践

- 全局只放 `skill-creator`
- 项目按角色同步，不全量同步
- 新增 skill 必须更新 `role-map.yml`
- 修改 `skills/` 后重新运行对应角色的 `sync-skills.sh`
- 提交前运行 `validate-skills.sh --role <目标角色>`
