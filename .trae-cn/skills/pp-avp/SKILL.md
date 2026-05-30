---
name: pp-avp
description: pp-avp (pp-audio-video-processor) - 音视频处理技能，基于FFmpeg实现音视频格式转换、剪辑、压缩、滤镜效果等功能。当用户提到以下任何场景时，务必使用此技能：
- 处理音视频文件（MP4, AVI, MOV, MKV, MP3, WAV, FLAC等）
- 格式转换（视频转码、音频转换、图片格式）
- 剪辑视频（截取片段、剪切时间范围）
- 提取音频（从视频中提取音频、音频提取）
- 添加水印（视频水印、图片水印、文字水印）
- 压缩视频（视频压缩、减小文件大小）
- 调整分辨率（缩放视频、改变视频尺寸）
- 音频处理（音量调整、音频剪辑、淡入淡出）
- 视频转GIF/WebP（视频转动态图）
- 提取视频帧（截取视频画面）
- 合并音视频（视频拼接、音频混音）
- ffmpeg命令（任何与ffmpeg相关的操作）
支持功能：视频压缩、分辨率调整、格式转换、音频提取、音量调整、字幕处理、滤镜效果。
compatibility:
  - tools: [RunCommand]
  - dependencies:
      - name: ffmpeg
        version: ">=4.0"
---

# pp-avp - 音视频处理技能

**pp-avp** 是 `pp-audio-video-processor` 的缩写，是一个基于 FFmpeg 的专业音视频处理技能包。

## 技能名称说明

- **简短名称**: `pp-avp`
- **完整名称**: `pp-audio-video-processor`
- **用途**: 提供音视频格式转换、剪辑、压缩、滤镜效果等功能

## 功能概述

本技能基于FFmpeg提供全面的音视频处理能力，包括但不限于：

### 视频处理
- 视频压缩与转码
- 分辨率调整
- 视频剪辑（时间范围截取）
- 视频裁剪（空间区域裁剪）
- 添加水印（图片/文字）
- 视频格式转换
- 视频合并与分割
- 视频转GIF/WebP
- 提取视频帧

### 音频处理
- 音频格式转换
- 音频剪辑
- 音量调整
- 淡入淡出效果
- 音频提取（从视频中）
- 音频合并与混音
- 采样率/声道转换

### 图像处理
- 图像格式转换
- 图像缩放与裁剪
- 图像旋转与滤镜
- 图像水印添加

## 使用方法

### 1. 视频压缩
```bash
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 23 -c:a copy output.mp4
```

### 2. 视频格式转换
```bash
# MP4转AVI
ffmpeg -i input.mp4 -c:v libx264 -c:a aac output.avi

# MP4转WebM
ffmpeg -i input.mp4 -c:v libvpx -c:a libvorbis output.webm
```

### 3. 视频剪辑
```bash
# 从30秒到60秒
ffmpeg -i input.mp4 -ss 00:00:30 -to 00:01:00 -c copy output.mp4

# 前30秒
ffmpeg -i input.mp4 -t 30 -c copy output.mp4
```

### 4. 调整分辨率
```bash
# 缩放到720p
ffmpeg -i input.mp4 -vf "scale=1280:720" -c:v libx264 -crf 23 output.mp4

# 保持宽高比
ffmpeg -i input.mp4 -vf "scale=1280:-1" -c:v libx264 -crf 23 output.mp4
```

### 5. 添加水印
```bash
# 图片水印
ffmpeg -i input.mp4 -i watermark.png -filter_complex "overlay=10:10" -c:v libx264 -crf 23 output.mp4

# 文字水印
ffmpeg -i input.mp4 -vf "drawtext=text='Watermark':fontsize=24:fontcolor=white:x=10:y=10" -c:v libx264 -crf 23 output.mp4
```

### 6. 提取音频
```bash
# 保持原格式
ffmpeg -i input.mp4 -vn -acodec copy output.aac

# 转换为MP3
ffmpeg -i input.mp4 -vn -c:a libmp3lame -b:a 128k output.mp3
```

### 7. 音频格式转换
```bash
# WAV转MP3
ffmpeg -i input.wav -c:a libmp3lame -b:a 128k output.mp3

# FLAC转AAC
ffmpeg -i input.flac -c:a aac -b:a 128k output.m4a
```

### 8. 调整音量
```bash
# 增加音量
ffmpeg -i input.mp3 -af "volume=2.0" output.mp3

# 降低音量
ffmpeg -i input.mp3 -af "volume=0.5" output.mp3
```

### 9. 视频转GIF
```bash
# 基础转换
ffmpeg -i input.mp4 -r 10 output.gif

# 优化GIF（推荐）
ffmpeg -i input.mp4 -vf "scale=640:-1" -r 10 output.gif
```

### 10. 提取视频帧
```bash
# 提取第10秒的帧
ffmpeg -i input.mp4 -ss 00:00:10 -vframes 1 -q:v 2 output.jpg

# 每秒提取一帧
ffmpeg -i input.mp4 -vf "fps=1" frame_%04d.jpg
```

### 11. 视频合并
```bash
# 使用concat demuxer
echo "file 'video1.mp4'" > list.txt
echo "file 'video2.mp4'" >> list.txt
ffmpeg -f concat -safe 0 -i list.txt -c copy output.mp4
```

## 常用参数说明

### 视频编码参数
| 参数 | 说明 | 示例 |
|------|------|------|
| `-c:v` | 视频编码器 | `-c:v libx264` |
| `-b:v` | 视频比特率 | `-b:v 1000k` |
| `-crf` | 恒定质量因子 | `-crf 23` |
| `-preset` | 编码预设 | `-preset slow` |
| `-r` | 帧率 | `-r 30` |
| `-s` | 分辨率 | `-s 1920x1080` |

### 音频编码参数
| 参数 | 说明 | 示例 |
|------|------|------|
| `-c:a` | 音频编码器 | `-c:a aac` |
| `-b:a` | 音频比特率 | `-b:a 128k` |
| `-ar` | 采样率 | `-ar 44100` |
| `-ac` | 声道数 | `-ac 2` |
| `-vn` | 禁用视频 | `-vn` |

### 时间控制参数
| 参数 | 说明 | 示例 |
|------|------|------|
| `-ss` | 开始时间 | `-ss 00:00:30` |
| `-to` | 结束时间 | `-to 00:01:00` |
| `-t` | 持续时间 | `-t 60` |

### 滤镜参数
| 参数 | 说明 | 示例 |
|------|------|------|
| `-vf` | 视频滤镜 | `-vf "scale=1280:720"` |
| `-af` | 音频滤镜 | `-af "volume=2.0"` |
| `-filter_complex` | 复杂滤镜 | `-filter_complex "overlay=10:10"` |

## 编码预设说明

### x264预设（速度/质量权衡）
| 预设 | 速度 | 压缩率 |
|------|------|--------|
| ultrafast | 最快 | 最低 |
| superfast | 很快 | 较低 |
| veryfast | 快 | 中等 |
| faster | 较快 | 中高 |
| fast | 稍快 | 较高 |
| medium | 默认 | 高 |
| slow | 较慢 | 很高 |
| slower | 慢 | 极高 |
| veryslow | 最慢 | 最高 |

### CRF值说明
- **CRF范围**: 0-51
- **值越小**: 质量越好，文件越大
- **推荐值**: 23（默认）
- **高质量**: 18-22
- **高压缩**: 24-28

## 支持的格式

### 视频格式
- 输入: MP4, AVI, MOV, MKV, FLV, WebM, WMV, 3GP
- 输出: MP4, AVI, MOV, MKV, FLV, WebM, GIF, WebP

### 音频格式
- 无损: WAV, FLAC, ALAC, AIFF
- 有损: MP3, AAC, OGG, Opus, WMA
- 专业: AC3, DTS

### 图像格式
- JPEG, PNG, WebP, BMP, GIF

## 高级功能

### 1. 硬件加速
```bash
# NVIDIA NVENC
ffmpeg -hwaccel cuda -i input.mp4 -c:v h264_nvenc -preset p7 -cq 23 output.mp4

# Intel QSV
ffmpeg -hwaccel qsv -i input.mp4 -c:v h264_qsv -preset medium -global_quality 23 output.mp4
```

### 2. 批量处理
```bash
# 批量转换格式
for file in *.wav; do
    ffmpeg -i "$file" -c:a libmp3lame -b:a 128k "${file%.wav}.mp3"
done
```

### 3. 流媒体处理
```bash
# RTMP推流
ffmpeg -re -i input.mp4 -c:v libx264 -preset ultrafast -tune zerolatency -c:a aac -f flv rtmp://server/live/stream

# HLS输出
ffmpeg -i input.mp4 -c:v libx264 -c:a aac -f hls -hls_time 2 -hls_list_size 5 output.m3u8
```

## 参考文档

本技能包含完整的FFmpeg参考文档，位于 `references/` 目录下：
- [FFmpeg安装使用教程](references/FFmpeg安装使用教程.md)
- [FFmpeg从入门到精通完整教程](references/FFmpeg 从入门到精通完整教程.md)

这些文档已集成到技能包中，可随时离线查阅。

## 使用注意事项

1. **FFmpeg安装**: 确保系统已安装FFmpeg（版本>=4.0）
2. **文件路径**: 使用绝对路径或相对于当前目录的路径
3. **覆盖警告**: 使用 `-y` 参数覆盖已存在的输出文件
4. **编码时间**: 高质量编码可能需要较长时间
5. **硬件加速**: 建议使用GPU加速提高处理速度
6. **音频质量**: 转换有损格式时注意比特率设置

## 示例场景

### 场景1：压缩视频文件
```bash
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 23 -c:a copy output_compressed.mp4
```

### 场景2：从视频提取音频并转换格式
```bash
ffmpeg -i input.mp4 -vn -c:a libmp3lame -b:a 192k output.mp3
```

### 场景3：调整视频分辨率并添加水印
```bash
ffmpeg -i input.mp4 -i logo.png -vf "scale=1280:720" -filter_complex "overlay=10:10" -c:v libx264 -crf 23 -c:a copy output.mp4
```

### 场景4：批量转换音频格式
```bash
for file in *.flac; do
    ffmpeg -i "$file" -c:a aac -b:a 128k "${file%.flac}.m4a"
done
```

---

**提示**: 当用户请求音视频处理相关操作时，使用 `RunCommand` 工具执行FFmpeg命令。根据用户的具体需求选择合适的命令参数。