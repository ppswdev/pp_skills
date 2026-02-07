# PP Skills

Trae 中国版 Skills 集合，提供实用的开发辅助技能。

## 项目简介

本项目收集和整理了常用的 Trae Skills，帮助开发者提高开发效率。

## 技能列表

### i18n-translator
国际化文本翻译工具，自动以简体中文为基准翻译国际化文本文件，支持增量翻译。

## 快速开始

### 安装全局技能

使用项目提供的安装脚本，一键安装所有技能到 Trae 中国版全局目录：

```bash
./scripts/install-global-skills.sh
```

### 手动安装

1. 创建全局技能目录：
```bash
mkdir -p ~/.trae-cn/skills
```

2. 复制技能到全局目录：
```bash
cp -r .trae/skills/* ~/.trae-cn/skills/
```

3. 重启 Trae IDE

## 文档

- [Skills 使用教程](docs/skills-tutorial.md) - 如何创建和使用 Skills
- [全局配置指南](docs/skills-use-traecn.md) - 如何配置全局技能

## 许可证

MIT License
