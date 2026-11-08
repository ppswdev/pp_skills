# PP 技能一键安装

执行以下命令，选择 Codex、Claude Code、Trae 中国版或全部工具，将 GitHub 仓库 `skills/99_ppskills/` 下的技能安装到当前项目。

```bash
curl -fsSL https://raw.githubusercontent.com/ppswdev/pp_skills/main/scripts/install-ppskills.sh | bash
```

安装全局技能时加入 `--global`：

```bash
curl -fsSL https://raw.githubusercontent.com/ppswdev/pp_skills/main/scripts/install-ppskills.sh | bash -s -- --global
```

也可以直接指定工具，适用于非交互环境：

```bash
curl -fsSL https://raw.githubusercontent.com/ppswdev/pp_skills/main/scripts/install-ppskills.sh | bash -s -- --agent codex
```

`--agent` 支持 `codex`、`claude`、`trae-cn` 和 `all`。项目级安装位置是当前工作目录下对应的 `.codex/skills/`、`.claude/skills/` 或 `.trae-cn/skills/`，全局安装位置是用户主目录下的同名目录。

安装需要 Git、curl 和网络访问。默认跳过已存在的同名技能；需要更新时可加入 `--force` 覆盖同名技能。其他技能不受影响。

命令从 GitHub `main` 分支下载安装脚本及技能，仓库变更推送到该分支后才会生效。
