# pp-avp - 音视频处理技能包

**pp-avp** 是 `pp-audio-video-processor` 的缩写，基于 FFmpeg 的专业音视频处理技能，可独立使用和迁移。

## 📁 目录结构

```
pp-avp/
├── SKILL.md                          # 技能主文件
├── README.md                         # 说明文档
├── CONFIG.md                         # 配置说明文档
├── 使用指南.md                       # 中文使用指南
└── references/                       # 参考文档目录
    ├── FFmpeg安装使用教程.md         # FFmpeg安装和基础使用
    └── FFmpeg 从入门到精通完整教程.md # FFmpeg完整教程
```

## ✨ 功能特性

### 视频处理
- ✅ 视频压缩与转码
- ✅ 分辨率调整
- ✅ 视频剪辑（时间范围截取）
- ✅ 视频裁剪（空间区域裁剪）
- ✅ 添加水印（图片/文字）
- ✅ 视频格式转换
- ✅ 视频合并与分割
- ✅ 视频转GIF/WebP
- ✅ 提取视频帧

### 音频处理
- ✅ 音频格式转换
- ✅ 音频剪辑
- ✅ 音量调整
- ✅ 淡入淡出效果
- ✅ 音频提取（从视频中）
- ✅ 音频合并与混音
- ✅ 采样率/声道转换

### 图像处理
- ✅ 图像格式转换
- ✅ 图像缩放与裁剪
- ✅ 图像旋转与滤镜
- ✅ 图像水印添加

## 🚀 快速开始

### 1. 安装要求
- FFmpeg >= 4.0
- macOS / Linux / Windows

### 2. 安装FFmpeg

**macOS:**
```bash
brew install ffmpeg
```

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install ffmpeg
```

### 3. 验证安装
```bash
ffmpeg -version
```

## 📖 使用方法

### 基本命令示例

#### 视频压缩
```bash
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 23 -c:a copy output.mp4
```

#### 提取音频
```bash
ffmpeg -i input.mp4 -vn -c:a libmp3lame -b:a 128k output.mp3
```

#### 视频转GIF
```bash
ffmpeg -i input.mp4 -vf "scale=640:-1" -r 10 output.gif
```

#### 添加水印
```bash
ffmpeg -i input.mp4 -i logo.png -filter_complex "overlay=10:10" output.mp4
```

### 查看完整文档
请参阅 [SKILL.md](SKILL.md) 获取详细的使用说明和命令示例。

## 📚 参考文档

技能包中包含两个完整的FFmpeg参考文档：

1. **FFmpeg安装使用教程** - 包含安装指南和常用命令示例
2. **FFmpeg从入门到精通完整教程** - 涵盖FFmpeg的所有核心功能

## 🔧 依赖工具

| 工具 | 版本要求 | 说明 |
|------|---------|------|
| FFmpeg | >= 4.0 | 核心音视频处理工具 |
| ffprobe | (FFmpeg自带) | 多媒体流分析工具 |

## 💡 提示

- 使用 `-y` 参数自动覆盖已存在的输出文件
- 使用 `-preset` 参数调整编码速度（ultrafast → veryslow）
- 使用 `-crf` 参数控制质量（18-28为常用范围）
- 批处理时可使用Shell脚本提高效率

## 📦 打包与迁移

### 打包技能
本技能包已配置为可独立迁移的格式：
1. 整个 `audio-video-processing/` 文件夹可复制到任意位置
2. 所有依赖文件都位于 `references/` 目录中
3. 无需额外配置，解压即可使用

### 迁移方法
```bash
# 复制整个技能文件夹
cp -r audio-video-processing/ /目标路径/

# 或使用ZIP打包
zip -r audio-video-processing.zip audio-video-processing/
```

## 📝 许可

本技能包基于FFmpeg开源工具集，遵循LGPL/GPL许可证。

## 🔗 相关链接

- [FFmpeg官网](https://ffmpeg.org/)
- [FFmpeg文档](https://ffmpeg.org/documentation.html)
- [FFmpeg Wiki](https://trac.ffmpeg.org/wiki)

---

**版本**: 1.0.0
**更新日期**: 2026-05-19
**维护者**: Claude AI Assistant
