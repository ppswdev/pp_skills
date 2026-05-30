# FFmpeg 从入门到精通完整教程

## 目录

1. [FFmpeg基础概念](#ffmpeg基础概念)
2. [安装与配置](#安装与配置)
3. [核心组件详解](#核心组件详解)
4. [音视频技术原理](#音视频技术原理)
5. [基础命令语法](#基础命令语法)
6. [视频处理实战](#视频处理实战)
7. [音频处理实战](#音频处理实战)
8. [图像处理实战](#图像处理实战)
9. [高级滤镜应用](#高级滤镜应用)
10. [流媒体处理](#流媒体处理)
11. [性能优化技巧](#性能优化技巧)
12. [常见问题解决](#常见问题解决)

---

## FFmpeg基础概念

### 什么是FFmpeg

**FFmpeg**（Fast Forward MPEG）是一个开源的跨平台多媒体处理框架，由Fabrice Bellard于2000年创建。它提供了完整的音视频解决方案，包括录制、转换、流媒体传输等功能。

### 核心特性

- **跨平台性**：支持Windows、macOS、Linux等主流操作系统
- **格式支持广泛**：支持几乎所有常见的音视频格式
- **高性能**：采用优化的C语言编写，处理效率极高
- **模块化设计**：由多个独立的库组成，可根据需要选择性使用
- **开源免费**：遵循LGPL/GPL许可证，可自由使用和修改

### 主要应用场景

1. **视频转码**：将视频从一种格式转换为另一种格式
2. **视频压缩**：减小视频文件大小，保持质量
3. **视频剪辑**：剪切、合并、分割视频
4. **音频处理**：音频格式转换、音量调节、降噪等
5. **流媒体**：直播推流、视频会议
6. **图像处理**：视频帧提取、图像格式转换
7. **字幕处理**：添加、提取、转换字幕
8. **特效制作**：添加滤镜、水印、转场效果

---

## 安装与配置

### macOS安装

#### 方法一：使用Homebrew（推荐）

```bash
# 安装Homebrew（如果未安装）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# 使用国内镜像（更快）
/bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"

# 安装FFmpeg
brew install ffmpeg

# 验证安装
ffmpeg -version
```

#### 方法二：从官网下载

1. 访问 <https://ffmpeg.org/download.html>
2. 下载macOS版本
3. 解压并配置环境变量

### Linux安装

#### Ubuntu/Debian

```bash
sudo apt update
sudo apt install ffmpeg
```

#### CentOS/RHEL

```bash
# 启用EPEL仓库
sudo yum install epel-release

# 安装FFmpeg
sudo yum install ffmpeg ffmpeg-devel
```

#### 从源码编译（高级用户）

```bash
# 下载源码
git clone https://github.com/FFmpeg/FFmpeg.git
cd FFmpeg

# 配置编译选项
./configure --enable-gpl --enable-libx264 --enable-libx265 --enable-libmp3lame --enable-libopus

# 编译安装
make -j$(nproc)
sudo make install
```

### Windows安装

1. 访问 <https://ffmpeg.org/download.html>
2. 下载Windows版本
3. 解压到指定目录（如 C:\ffmpeg）
4. 添加到系统PATH环境变量

### 验证安装

```bash
# 检查版本信息
ffmpeg -version

# 查看支持的编解码器
ffmpeg -codecs

# 查看支持的格式
ffmpeg -formats

# 查看支持的滤镜
ffmpeg -filters
```

---

## 核心组件详解

FFmpeg由多个核心库组成，每个库负责特定的功能：

### 1. libavcodec - 编解码库

**功能**：提供音视频编解码功能
**支持的格式**：

- 视频：H.264/AVC、H.265/HEVC、VP8、VP9、AV1
- 音频：AAC、MP3、FLAC、Opus、Vorbis

**关键特性**：

- 支持硬件加速（NVENC、QSV、V4L2）
- 支持多种编码预设（ultrafast到veryslow）
- 支持质量控制和比特率控制

### 2. libavformat - 容器格式库

**功能**：处理音视频容器格式
**支持的容器**：

- 视频：MP4、AVI、MKV、MOV、FLV、WebM
- 音频：M4A、OGG、WAV、FLAC

**关键特性**：

- 支持元数据读写
- 支持流媒体协议
- 支持章节和字幕

### 3. libavfilter - 滤镜库

**功能**：提供音视频滤镜和特效
**主要滤镜类型**：

- 视频滤镜：scale、crop、rotate、blur、overlay
- 音频滤镜：volume、highpass、lowpass、echo
- 复杂滤镜：filtergraph、complex filters

### 4. libavdevice - 设备库

**功能**：处理输入输出设备
**支持的设备**：

- 摄像头：v4l2、dshow、avfoundation
- 音频设备：alsa、pulseaudio、coreaudio
- 屏幕录制：x11grab、gdigrab、avfoundation

### 5. libswscale - 图像缩放库

**功能**：图像格式转换和缩放
**支持的操作**：

- 分辨率缩放
- 色彩空间转换（RGB、YUV、YCbCr）
- 图像格式转换

### 6. libswresample - 音频重采样库

**功能**：音频格式转换和重采样
**支持的操作**：

- 采样率转换
- 声道数转换（单声道/立体声）
- 音频格式转换

---

## 音视频技术原理

### 视频编码原理

#### 1. 视频压缩基础

**空间冗余**：相邻像素通常相似
**时间冗余**：相邻帧通常相似
**视觉冗余**：人眼对某些细节不敏感

#### 2. 主流编码标准

**H.264/AVC**

- 压缩比：约100:1
- 应用：蓝光、网络视频、移动设备
- 特点：成熟稳定，兼容性好

**H.265/HEVC**

- 压缩比：约200:1
- 应用：4K视频、流媒体
- 特点：压缩效率高，但计算复杂

**VP9**

- 开源编码器
- 应用：YouTube、WebM
- 特点：Google开发，免费使用

**AV1**

- 最新开源编码器
- 应用：流媒体、网络视频
- 特点：压缩效率最高，但编码速度慢

##### 编码器对比

| 编码器     | 压缩比 | 质量 | 兼容性 | 处理速度 |
| :--------- | :----- | :--- | :----- | :------- |
| H.264/AVC  | 高     | 优秀 | ⭐⭐⭐⭐⭐  | 中等     |
| H.265/HEVC | 很高   | 优秀 | ⭐⭐⭐    | 慢       |
| VP9        | 高     | 优秀 | ⭐⭐⭐    | 中等     |
| AV1        | 很高   | 优秀 | ⭐⭐     | 很慢     |
| Xvid       | 中等   | 良好 | ⭐⭐⭐⭐   | 快       |
| DivX       | 中等   | 良好 | ⭐⭐⭐    | 快       |

#### 3. 编码参数详解

**CRF（Constant Rate Factor）**

```bash
# CRF值范围：0-51，值越小质量越好
ffmpeg -i input.mp4 -c:v libx264 -crf 23 output.mp4
```

**预设（Preset）**

```bash
# 预设选项：ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 23 output.mp4
```

**比特率控制**

```bash
# 固定比特率
ffmpeg -i input.mp4 -c:v libx264 -b:v 1000k output.mp4

# 可变比特率
ffmpeg -i input.mp4 -c:v libx264 -b:v 1000k -maxrate 1500k -bufsize 2000k output.mp4
```

#### 4.视频格式

##### 主流跨平台格式

| 格式 | 扩展名 | 跨平台性 | 压缩效率 | 质量 | 文件大小 | 主要应用   |
| :--- | :----- | :------- | :------- | :--- | :------- | :--------- |
| MP4  | .mp4   | ⭐⭐⭐⭐⭐    | 高       | 优秀 | 小       | 通用标准   |
| MKV  | .mkv   | ⭐⭐⭐⭐     | 高       | 优秀 | 小       | 高清视频   |
| WebM | .webm  | ⭐⭐⭐⭐     | 高       | 优秀 | 小       | 网页视频   |
| AVI  | .avi   | ⭐⭐⭐      | 中等     | 良好 | 中等     | 传统格式   |
| MOV  | .mov   | ⭐⭐⭐      | 中等     | 优秀 | 中等     | Apple生态  |
| FLV  | .flv   | ⭐⭐⭐      | 中等     | 良好 | 小       | 网络流媒体 |

##### 平台特定格式

| 格式 | 扩展名 | 主要平台 | 兼容性 | 特点       |
| :--- | :----- | :------- | :----- | :--------- |
| WMV  | .wmv   | Windows  | 中等   | 微软专属   |
| M4V  | .m4v   | Apple    | 中等   | iTunes优化 |
| 3GP  | .3gp   | 移动设备 | 高     | 移动优化   |
| OGV  | .ogv   | 开源平台 | 中等   | 开源格式   |

##### 专业和特殊格式

| 格式 | 扩展名     | 用途        | 特点       |
| :--- | :--------- | :---------- | :--------- |
| TS   | .ts        | 流媒体传输  | 实时传输   |
| M3U8 | .m3u8      | HLS流媒体   | 自适应码率 |
| F4V  | .f4v       | Adobe Flash | Flash视频  |
| MPEG | .mpeg/.mpg | 传统标准    | 广泛兼容   |



##### 平台支持情况

| 格式 | Windows | macOS | Linux | Android | iOS  | Web  |
| :--- | :------ | :---- | :---- | :------ | :--- | :--- |
| MP4  | ✅       | ✅     | ✅     | ✅       | ✅    | ✅    |
| MKV  | ⚠️       | ⚠️     | ✅     | ⚠️       | ❌    | ❌    |
| WebM | ✅       | ✅     | ✅     | ✅       | ⚠️    | ✅    |
| AVI  | ✅       | ✅     | ✅     | ✅       | ✅    | ⚠️    |
| MOV  | ⚠️       | ✅     | ⚠️     | ⚠️       | ✅    | ⚠️    |
| WMV  | ✅       | ❌     | ⚠️     | ❌       | ❌    | ❌    |
| FLV  | ✅       | ✅     | ✅     | ⚠️       | ❌    | ✅    |
| 3GP  | ⚠️       | ⚠️     | ⚠️     | ✅       | ✅    | ❌    |

### 音频编码原理

#### 1. 音频压缩基础

**心理声学模型**：去除人耳听不到的频率
**时域冗余**：相邻采样点相似
**频域冗余**：某些频率成分较少

#### 2. 主流音频编码

| 格式名称               | 类型       | 压缩比            | 音质       | 主要应用                  | 扩展名      | 特点                          |
|-----------------------|------------|-------------------|------------|---------------------------|-------------|-------------------------------|
| WAV                   | 无损       | 1:1（无压缩）     | -          | 专业音频制作/原始录音     | .wav        | Windows系统标准音频格式       |
| FLAC                  | 无损压缩   | 约2:1             | 无损音质   | 音乐存储/高保真音频       | .flac       | 开源免费，完美保留音质        |
| ALAC                  | 无损压缩   | 约2:1             | 无损音质   | Apple设备/iTunes          | .m4a/.alac        | 苹果生态专用无损格式          |
| AIFF                  | 无损       | 1:1（无压缩）     | -          | 专业音频制作/Mac系统      | .aiff       | 苹果版WAV格式                 |
| MP3                   | 有损压缩   | 约12:1            | 可接受     | 通用格式                  | .mp3        | 广泛兼容                      |
| AAC                   | 有损压缩   | 约10:1            | 接近CD     | iTunes/流媒体/移动设备    | .m4a/.aac   | 高质量压缩                    |
| OGG Vorbis            | 有损压缩   | 约10:1            | 优于MP3    | 游戏音效/开源项目         | .ogg        | 开源免费格式                  |
| Opus                  | 有损压缩   | 约20:1            | 高         | VoIP/实时通信/网络流媒体  | .opus       | 低延迟高压缩                  |
| WMA                   | 有损/无损  | 有损12:1/无损2:1  | -          | Windows系统/DRM内容       | .wma        | 微软专属格式                  |
| AC3 (Dolby Digital)   | 有损压缩   | 约12:1            | -          | DVD/蓝光/广播电视         | .ac3        | 支持5.1声道                   |
| DTS                   | 有损压缩   | 约4:1             | -          | 蓝光/家庭影院             | .dts        | 高码率多声道编码              |

#### 3. 音频参数

**采样率（Sample Rate）**

```bash
# 常见采样率：8000Hz, 22050Hz, 44100Hz, 48000Hz
ffmpeg -i input.wav -ar 44100 output.wav
```

**比特率（Bitrate）**

```bash
# 音频比特率
ffmpeg -i input.wav -c:a aac -b:a 128k output.m4a
```

**声道数（Channels）**

```bash
# 转换为单声道
ffmpeg -i input.wav -ac 1 output_mono.wav

# 转换为立体声
ffmpeg -i input.wav -ac 2 output_stereo.wav
```

---

#### 4.音频格式

##### 无损格式支持情况

| 格式 | Windows | macOS  | iOS    | Android | Linux  | Web浏览器 | 游戏主机 | 车载系统 |
| :--- | :------ | :----- | :----- | :------ | :----- | :-------- | :------- | :------- |
| WAV  | ✅ 原生  | ✅ 原生 | ✅ 原生 | ✅ 原生  | ✅ 原生 | ✅ 支持    | ✅ 支持   | ✅ 支持   |
| FLAC | ✅ 原生  | ✅ 原生 | ✅ 原生 | ✅ 原生  | ✅ 原生 | ✅ 支持    | ✅ 支持   | ⚠️ 部分   |
| ALAC | ⚠️ 部分  | ✅ 原生 | ✅ 原生 | ✅ 原生  | ✅ 支持 | ⚠️ 部分    | ⚠️ 部分   | ⚠️ 部分   |
| AIFF | ⚠️ 部分  | ✅ 原生 | ✅ 原生 | ✅ 支持  | ✅ 支持 | ⚠️ 部分    | ⚠️ 部分   | ⚠️ 部分   |

##### 有损格式支持情况

| 格式       | Windows | macOS    | iOS      | Android  | Linux  | Web浏览器 | 游戏主机 | 车载系统 |
| :--------- | :------ | :------- | :------- | :------- | :----- | :-------- | :------- | :------- |
| MP3        | ✅ 原生  | ✅ 原生   | ✅ 原生   | ✅ 原生   | ✅ 原生 | ✅ 支持    | ✅ 支持   | ✅ 支持   |
| AAC        | ✅ 原生  | ✅ 原生   | ✅ 原生   | ✅ 原生   | ✅ 原生 | ✅ 支持    | ✅ 支持   | ✅ 支持   |
| OGG Vorbis | ✅ 原生  | ❌ 不原生 | ❌ 不原生 | ✅ 原生   | ✅ 原生 | ✅ 支持    | ⚠️ 部分   | ⚠️ 部分   |
| Opus       | ✅ 原生  | ✅ 原生   | ✅ 原生   | ✅ 原生   | ✅ 原生 | ✅ 支持    | ⚠️ 部分   | ⚠️ 部分   |
| WMA        | ✅ 原生  | ❌ 不原生 | ❌ 不原生 | ❌ 不原生 | ⚠️ 部分 | ❌ 不支持  | ⚠️ 部分   | ⚠️ 部分   |

##### 专业格式支持情况

| 格式 | Windows | macOS  | iOS    | Android | Linux  | Web浏览器 | 游戏主机 | 车载系统 |
| :--- | :------ | :----- | :----- | :------ | :----- | :-------- | :------- | :------- |
| AC3  | ✅ 原生  | ✅ 原生 | ✅ 原生 | ✅ 原生  | ✅ 原生 | ✅ 支持    | ✅ 支持   | ✅ 支持   |
| DTS  | ✅ 原生  | ✅ 原生 | ✅ 原生 | ✅ 原生  | ✅ 原生 | ⚠️ 部分    | ✅ 支持   | ✅ 支持   |

## 基础命令语法

### FFmpeg命令结构

```bash
ffmpeg [全局选项] [输入文件选项] -i 输入文件 [输出文件选项] 输出文件
```

### 常用全局选项

```bash
# 显示详细信息
ffmpeg -v verbose -i input.mp4 output.mp4

# 覆盖输出文件
ffmpeg -y -i input.mp4 output.mp4

# 不覆盖输出文件
ffmpeg -n -i input.mp4 output.mp4

# 显示进度
ffmpeg -progress pipe:1 -i input.mp4 output.mp4
```

### 输入文件选项

```bash
# 指定输入格式
ffmpeg -f mp4 -i input.mp4 output.mp4

# 指定输入帧率
ffmpeg -r 30 -i input.mp4 output.mp4

# 指定输入分辨率
ffmpeg -s 1920x1080 -i input.mp4 output.mp4

# 指定输入时长
ffmpeg -t 60 -i input.mp4 output.mp4
```

### 输出文件选项

```bash
# 指定视频编码器
ffmpeg -i input.mp4 -c:v libx264 output.mp4

# 指定音频编码器
ffmpeg -i input.mp4 -c:a aac output.mp4

# 指定比特率
ffmpeg -i input.mp4 -b:v 1000k -b:a 128k output.mp4

# 指定帧率
ffmpeg -i input.mp4 -r 30 output.mp4
```

### 参数汇总说明

#### 基础参数

| 参数 | 说明           | 示例                                |
| :--- | :------------- | :---------------------------------- |
| -i   | 指定输入文件   | -i input.mp4                        |
| -y   | 覆盖输出文件   | -y                                  |
| -n   | 不覆盖输出文件 | -n                                  |
| -v   | 设置日志级别   | -v quiet/error/warning/info/verbose |
| -f   | 强制指定格式   | -f mp4                              |

#### 视频编码参数

| 参数       | 说明           | 示例                     |
| :--------- | :------------- | :----------------------- |
| -c:v       | 指定视频编码器 | -c:v libx264             |
| -b:v       | 视频比特率     | -b:v 1000k               |
| -r         | 帧率           | -r 30                    |
| -s         | 分辨率         | -s 1920x1080             |
| -crf       | 恒定质量因子   | -crf 23                  |
| -preset    | 编码预设       | -preset slow/medium/fast |
| -profile:v | 编码配置文件   | -profile:v high          |
| -level     | 编码级别       | -level 4.1               |

#### 音频编码参数

| 参数 | 说明           | 示例      |
| :--- | :------------- | :-------- |
| -c:a | 指定音频编码器 | -c:a aac  |
| -b:a | 音频比特率     | -b:a 128k |
| -ar  | 采样率         | -ar 44100 |
| -ac  | 声道数         | -ac 2     |
| -q:a | 音频质量       | -q:a 0    |
| -vn  | 禁用视频流     | -vn       |
| -an  | 禁用音频流     | -an       |

#### 时间控制参数

| 参数      | 说明     | 示例         |
| :-------- | :------- | :----------- |
| -ss       | 开始时间 | -ss 00:00:30 |
| -to       | 结束时间 | -to 00:01:00 |
| -t        | 持续时间 | -t 60        |
| -duration | 指定时长 | -duration 30 |

#### 流映射参数

| 参数              | 说明           | 示例                |
| :---------------- | :------------- | :------------------ |
| -map              | 映射流         | -map 0:v -map 0:a   |
| -map_metadata     | 映射元数据     | -map_metadata 0     |
| -map_chapters     | 映射章节       | -map_chapters 0     |
| -map_metadata:s:v | 映射视频元数据 | -map_metadata:s:v 0 |

#### 滤镜参数

| 参数            | 说明     | 示例                            |
| :-------------- | :------- | :------------------------------ |
| -vf             | 视频滤镜 | -vf "scale=1280:720"            |
| -af             | 音频滤镜 | -af "volume=2.0"                |
| -filter_complex | 复杂滤镜 | -filter_complex "overlay=10:10" |

---

## 视频处理实战

### 1. 视频压缩

#### 基础压缩

```bash
# 使用H.264编码，CRF控制质量
ffmpeg -i input.mp4 -c:v libx264 -crf 23 -c:a copy output.mp4
```

#### 高质量压缩

```bash
# 使用慢速预设，获得更好的压缩效果
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 18 -c:a aac -b:a 128k output.mp4
```

#### 快速压缩

```bash
# 使用快速预设，适合实时处理
ffmpeg -i input.mp4 -c:v libx264 -preset ultrafast -crf 28 -c:a copy output.mp4
```

### 2. 分辨率调整

#### 缩放到指定分辨率

```bash
# 缩放到720p
ffmpeg -i input.mp4 -vf "scale=1280:720" -c:v libx264 -crf 23 output.mp4

# 保持宽高比缩放
ffmpeg -i input.mp4 -vf "scale=1280:-1" -c:v libx264 -crf 23 output.mp4
```

#### 放大视频

```bash
# 放大到1080p
ffmpeg -i input.mp4 -vf "scale=1920:1080:flags=lanczos" -c:v libx264 -crf 23 output.mp4
```

### 3. 视频剪辑

#### 时间剪辑

```bash
# 剪辑30秒到60秒
ffmpeg -i input.mp4 -ss 00:00:30 -to 00:01:00 -c copy output.mp4

# 剪辑前30秒
ffmpeg -i input.mp4 -t 30 -c copy output.mp4
```

#### 空间裁剪

```bash
# 裁剪视频区域
ffmpeg -i input.mp4 -vf "crop=800:600:100:100" -c:v libx264 -crf 23 output.mp4

# 裁剪掉水印区域
ffmpeg -i input.mp4 -vf "crop=in_w:in_h-100" -c:v libx264 -crf 23 output.mp4
```

### 4. 视频合并

#### 使用concat demuxer

```bash
# 创建文件列表
echo "file 'video1.mp4'" > list.txt
echo "file 'video2.mp4'" >> list.txt

# 合并视频
ffmpeg -f concat -safe 0 -i list.txt -c copy output.mp4
```

#### 使用concat filter

```bash
# 直接合并
ffmpeg -i video1.mp4 -i video2.mp4 -filter_complex "[0:v][0:a][1:v][1:a]concat=n=2:v=1:a=1[outv][outa]" -map "[outv]" -map "[outa]" output.mp4
```

### 5. 视频转码

#### 格式转换

```bash
# MP4转AVI
ffmpeg -i input.mp4 -c:v libx264 -c:a aac output.avi

# MP4转MKV
ffmpeg -i input.mp4 -c copy output.mkv

# MP4转WebM
ffmpeg -i input.mp4 -c:v libvpx -c:a libvorbis output.webm
```

#### 编码器转换

```bash
# H.264转H.265
ffmpeg -i input.mp4 -c:v libx265 -crf 28 -c:a copy output.mp4

# H.264转VP9
ffmpeg -i input.mp4 -c:v libvpx-vp9 -crf 30 -c:a libopus output.webm
```

### 6. 视频特效

#### 添加水印

```bash
# 图片水印
ffmpeg -i input.mp4 -i watermark.png -filter_complex "overlay=10:10" -c:v libx264 -crf 23 output.mp4

# 文字水印
ffmpeg -i input.mp4 -vf "drawtext=text='Watermark':fontsize=24:fontcolor=white:x=10:y=10" -c:v libx264 -crf 23 output.mp4
```

#### 视频旋转

```bash
# 旋转90度
ffmpeg -i input.mp4 -vf "rotate=90*PI/180" -c:v libx264 -crf 23 output.mp4

# 旋转180度
ffmpeg -i input.mp4 -vf "rotate=PI" -c:v libx264 -crf 23 output.mp4
```

#### 视频模糊

```bash
# 高斯模糊
ffmpeg -i input.mp4 -vf "boxblur=10:10" -c:v libx264 -crf 23 output.mp4

# 运动模糊
ffmpeg -i input.mp4 -vf "motionblur=10:10:10" -c:v libx264 -crf 23 output.mp4
```

### 7. 视频分析

#### 获取视频信息

```bash
# 显示详细信息
ffmpeg -i input.mp4

# 显示格式信息
ffprobe -v quiet -print_format json -show_format input.mp4

# 显示流信息
ffprobe -v quiet -print_format json -show_streams input.mp4
```

#### 提取视频帧

```bash
# 提取指定时间的帧
ffmpeg -i input.mp4 -ss 00:00:10 -vframes 1 output.jpg

# 每秒提取一帧
ffmpeg -i input.mp4 -vf "fps=1" frame_%04d.jpg

# 提取关键帧
ffmpeg -i input.mp4 -vf "select=eq(pict_type\,I)" -vsync vfr keyframe_%04d.jpg
```

---

## 音频处理实战

### 1. 音频格式转换

#### 无损格式转换

```bash
# WAV转FLAC（无损）
ffmpeg -i input.wav -c:a flac output.flac

# FLAC转WAV（无损）
ffmpeg -i input.flac -c:a pcm_s16le output.wav

# WAV转ALAC（Apple无损）
ffmpeg -i input.wav -c:a alac output.m4a

# ALAC转WAV（无损）
ffmpeg -i input.m4a -c:a pcm_s16le output.wav

# AIFF转WAV（无损）
ffmpeg -i input.aiff -c:a pcm_s16le output.wav

# WAV转AIFF（无损）
ffmpeg -i input.wav -c:a pcm_s16le output.aiff
```

#### 有损格式转换

```bash
# WAV转MP3
ffmpeg -i input.wav -c:a libmp3lame -b:a 128k output.mp3

# WAV转AAC
ffmpeg -i input.wav -c:a aac -b:a 128k output.m4a

# WAV转OGG Vorbis
ffmpeg -i input.wav -c:a libvorbis -b:a 128k output.ogg

# WAV转Opus
ffmpeg -i input.wav -c:a libopus -b:a 128k output.opus

# WAV转WMA
ffmpeg -i input.wav -c:a wmav2 -b:a 128k output.wma
```

#### MP3格式转换

```bash
# MP3转WAV
ffmpeg -i input.mp3 -c:a pcm_s16le output.wav

# MP3转AAC
ffmpeg -i input.mp3 -c:a aac -b:a 128k output.m4a

# MP3转FLAC
ffmpeg -i input.mp3 -c:a flac output.flac

# MP3转OGG Vorbis
ffmpeg -i input.mp3 -c:a libvorbis -b:a 128k output.ogg

# MP3转Opus
ffmpeg -i input.mp3 -c:a libopus -b:a 128k output.opus

# MP3转WMA
ffmpeg -i input.mp3 -c:a wmav2 -b:a 128k output.wma
```

#### AAC格式转换

```bash
# AAC转WAV
ffmpeg -i input.m4a -c:a pcm_s16le output.wav

# AAC转MP3
ffmpeg -i input.m4a -c:a libmp3lame -b:a 128k output.mp3

# AAC转FLAC
ffmpeg -i input.m4a -c:a flac output.flac

# AAC转OGG Vorbis
ffmpeg -i input.m4a -c:a libvorbis -b:a 128k output.ogg

# AAC转Opus
ffmpeg -i input.m4a -c:a libopus -b:a 128k output.opus
```

#### FLAC格式转换

```bash
# FLAC转WAV（无损）
ffmpeg -i input.flac -c:a pcm_s16le output.wav

# FLAC转ALAC（Apple无损）标准质量，保留元数据和封面(已测)
ffmpeg -i input.flac -c:a aac -b:a 128k -c:v copy -map 0:a -map 0:v -map_metadata 0 -y output.m4a

# FLAC转AIFF（无损）
ffmpeg -i input.flac -c:a pcm_s16le output.aiff

# FLAC转MP3
ffmpeg -i input.flac -c:a libmp3lame -b:a 192k output.mp3

# FLAC转AAC
ffmpeg -i input.flac -c:a aac output.aac

# FLAC转OGG Vorbis
ffmpeg -i input.flac -c:a libvorbis -b:a 192k output.ogg

# FLAC转Opus
ffmpeg -i input.flac -c:a libopus -b:a 192k output.opus

# FLAC转WMA
ffmpeg -i input.flac -c:a wmav2 -b:a 192k output.wma

# FLAC转AC3
ffmpeg -i input.flac -c:a ac3 -b:a 192k output.ac3

# FLAC转DTS
ffmpeg -i input.flac -c:a dca -strict -2 output.dts
```

#### OGG Vorbis格式转换

```bash
# OGG转WAV
ffmpeg -i input.ogg -c:a pcm_s16le output.wav

# OGG转MP3
ffmpeg -i input.ogg -c:a libmp3lame -b:a 128k output.mp3

# OGG转AAC
ffmpeg -i input.ogg -c:a aac -b:a 128k output.m4a

# OGG转FLAC
ffmpeg -i input.ogg -c:a flac output.flac

# OGG转Opus
ffmpeg -i input.ogg -c:a libopus -b:a 128k output.opus
```

#### Opus格式转换

```bash
# Opus转WAV
ffmpeg -i input.opus -c:a pcm_s16le output.wav

# Opus转MP3
ffmpeg -i input.opus -c:a libmp3lame -b:a 128k output.mp3

# Opus转AAC
ffmpeg -i input.opus -c:a aac -b:a 128k output.m4a

# Opus转FLAC
ffmpeg -i input.opus -c:a flac output.flac

# Opus转OGG Vorbis
ffmpeg -i input.opus -c:a libvorbis -b:a 128k output.ogg
```

#### 特殊格式转换

```bash
# WMA转WAV
ffmpeg -i input.wma -c:a pcm_s16le output.wav

# WMA转MP3
ffmpeg -i input.wma -c:a libmp3lame -b:a 128k output.mp3

# WMA转AAC
ffmpeg -i input.wma -c:a aac -b:a 128k output.m4a

# AC3转WAV
ffmpeg -i input.ac3 -c:a pcm_s16le output.wav

# AC3转MP3
ffmpeg -i input.ac3 -c:a libmp3lame -b:a 128k output.mp3

# DTS转WAV
ffmpeg -i input.dts -c:a pcm_s16le output.wav

# DTS转MP3
ffmpeg -i input.dts -c:a libmp3lame -b:a 128k output.mp3
```

#### 高质量转换

```bash
# 高质量MP3（320kbps）
ffmpeg -i input.wav -c:a libmp3lame -b:a 320k -q:a 0 output.mp3

# 高质量AAC（256kbps）
ffmpeg -i input.wav -c:a aac -b:a 256k output.m4a

# 高质量OGG Vorbis（192kbps）
ffmpeg -i input.wav -c:a libvorbis -b:a 192k output.ogg

# 高质量Opus（128kbps）
ffmpeg -i input.wav -c:a libopus -b:a 128k output.opus

# 高质量WMA（192kbps）
ffmpeg -i input.wav -c:a wmav2 -b:a 192k output.wma
```

#### 低质量转换（节省空间）

```bash
# 低质量MP3（64kbps）
ffmpeg -i input.wav -c:a libmp3lame -b:a 64k output.mp3

# 低质量AAC（64kbps）
ffmpeg -i input.wav -c:a aac -b:a 64k output.m4a

# 低质量OGG Vorbis（64kbps）
ffmpeg -i input.wav -c:a libvorbis -b:a 64k output.ogg

# 低质量Opus（32kbps）
ffmpeg -i input.wav -c:a libopus -b:a 32k output.opus
```

#### 批量转换示例

```bash
# 批量WAV转MP3
for file in *.wav; do
    ffmpeg -i "$file" -c:a libmp3lame -b:a 128k "${file%.wav}.mp3"
done

# 批量MP3转AAC
for file in *.mp3; do
    ffmpeg -i "$file" -c:a aac -b:a 128k "${file%.mp3}.m4a"
done

# 批量FLAC转MP3
for file in *.flac; do
    ffmpeg -i "$file" -c:a libmp3lame -b:a 192k "${file%.flac}.mp3"
done

# 批量OGG转MP3
for file in *.ogg; do
    ffmpeg -i "$file" -c:a libmp3lame -b:a 128k "${file%.ogg}.mp3"
done
```

#### 格式转换参数说明

| 参数 | 说明 | 推荐值 |
|------|------|--------|
| `-c:a libmp3lame` | MP3编码器 | 128k-320k |
| `-c:a aac` | AAC编码器 | 128k-256k |
| `-c:a libvorbis` | OGG Vorbis编码器 | 128k-192k |
| `-c:a libopus` | Opus编码器 | 64k-128k |
| `-c:a flac` | FLAC编码器（无损） | 无比特率参数 |
| `-c:a pcm_s16le` | WAV编码器（无损） | 无比特率参数 |
| `-b:a` | 音频比特率 | 32k-320k |
| `-q:a` | 音频质量（仅MP3） | 0-9（0最高） |

### 2. 音频参数调整

#### 采样率转换

```bash
# 转换为44.1kHz
ffmpeg -i input.wav -ar 44100 output.wav

# 转换为48kHz
ffmpeg -i input.wav -ar 48000 output.wav
```

#### 声道转换

```bash
# 转换为单声道
ffmpeg -i input.wav -ac 1 output_mono.wav

# 转换为立体声
ffmpeg -i input.wav -ac 2 output_stereo.wav

# 转换为5.1声道
ffmpeg -i input.wav -ac 6 output_5_1.wav
```

#### 比特率调整

```bash
# 调整MP3比特率
ffmpeg -i input.mp3 -c:a libmp3lame -b:a 192k output.mp3

# 调整AAC比特率
ffmpeg -i input.m4a -c:a aac -b:a 256k output.m4a
```

### 3. 音频剪辑

#### 时间剪辑

```bash
# 剪辑30秒到60秒
ffmpeg -i input.mp3 -ss 00:00:30 -to 00:01:00 -c copy output.mp3

# 剪辑前30秒
ffmpeg -i input.mp3 -t 30 -c copy output.mp3
```

#### 淡入淡出

```bash
# 添加淡入效果
ffmpeg -i input.mp3 -af "afade=t=in:st=0:d=3" output.mp3

# 添加淡出效果
ffmpeg -i input.mp3 -af "afade=t=out:st=27:d=3" output.mp3

# 同时添加淡入淡出
ffmpeg -i input.mp3 -af "afade=t=in:st=0:d=3,afade=t=out:st=27:d=3" output.mp3
```

### 4. 音频效果

#### 音量调节

```bash
# 增加音量
ffmpeg -i input.mp3 -af "volume=2.0" output.mp3

# 降低音量
ffmpeg -i input.mp3 -af "volume=0.5" output.mp3

# 标准化音量
ffmpeg -i input.mp3 -af "loudnorm" output.mp3
```

#### 音频滤镜

```bash
# 低通滤波器
ffmpeg -i input.mp3 -af "lowpass=f=1000" output.mp3

# 高通滤波器
ffmpeg -i input.mp3 -af "highpass=f=1000" output.mp3

# 带通滤波器
ffmpeg -i input.mp3 -af "bandpass=f=1000:width_q=1" output.mp3
```

#### 音频特效

```bash
# 回声效果
ffmpeg -i input.mp3 -af "aecho=0.8:0.88:60:0.4" output.mp3

# 混响效果
ffmpeg -i input.mp3 -af "aeval=val(0)*0.5+val(1)*0.5" output.mp3

# 变调效果
ffmpeg -i input.mp3 -af "asetrate=44100*1.5" output.mp3
```

### 5. 音频分析

#### 获取音频信息

```bash
# 显示音频信息
ffprobe -v quiet -print_format json -show_streams input.mp3

# 显示音频格式
ffprobe -v quiet -print_format json -show_format input.mp3
```

#### 音频可视化

```bash
# 生成频谱图
ffmpeg -i input.mp3 -filter_complex "showspectrum=mode=combined:color=channel:scale=log" -y output.png

# 生成波形图
ffmpeg -i input.mp3 -filter_complex "showwavespic=s=640x120" -y output.png
```

### 6. 音频合并

#### 使用concat demuxer

```bash
# 创建文件列表
echo "file 'audio1.mp3'" > list.txt
echo "file 'audio2.mp3'" >> list.txt

# 合并音频
ffmpeg -f concat -safe 0 -i list.txt -c copy output.mp3
```

#### 音频混音

```bash
# 两个音频文件混音
ffmpeg -i audio1.mp3 -i audio2.mp3 -filter_complex "[0:a][1:a]amix=inputs=2:duration=longest" output.mp3

# 多个音频文件混音
ffmpeg -i audio1.mp3 -i audio2.mp3 -i audio3.mp3 -filter_complex "[0:a][1:a][2:a]amix=inputs=3:duration=longest" output.mp3

# 带权重的混音
ffmpeg -i audio1.mp3 -i audio2.mp3 -filter_complex "[0:a]volume=0.7[a1];[1:a]volume=0.3[a2];[a1][a2]amix=inputs=2:duration=longest" output.mp3
```

### 7. 音频提取

#### 从视频提取音频

```bash
# 提取音频（保持原格式）
ffmpeg -i input.mp4 -vn -acodec copy output.aac

# 提取为MP3
ffmpeg -i input.mp4 -vn -c:a libmp3lame -b:a 128k output.mp3

# 提取为WAV
ffmpeg -i input.mp4 -vn -c:a pcm_s16le output.wav
```

#### 分离多声道音频

```bash
# 分离立体声为两个单声道文件
ffmpeg -i input.wav -filter_complex "channelsplit=channel_layout=stereo" output_L.wav output_R.wav

# 提取5.1声道中的特定声道
ffmpeg -i input.wav -af "pan=mono|c0=FL" output_front_left.wav
```

---

## 图像处理实战

### 1. 图像格式转换

#### 基础转换

```bash
# JPEG转PNG
ffmpeg -i input.jpg output.png

# PNG转JPEG
ffmpeg -i input.png -q:v 2 output.jpg

# 批量转换
for file in *.jpg; do ffmpeg -i "$file" "${file%.jpg}.png"; done
```

#### 高质量转换

```bash
# 高质量JPEG
ffmpeg -i input.png -q:v 1 output.jpg

# 无损PNG
ffmpeg -i input.jpg -c:v png output.png

# WebP转换
ffmpeg -i input.jpg -c:v libwebp -q:v 80 output.webp
```

### 2. 图像缩放

#### 基础缩放

```bash
# 缩放到指定尺寸
ffmpeg -i input.jpg -vf "scale=800:600" output.jpg

# 保持宽高比缩放
ffmpeg -i input.jpg -vf "scale=800:-1" output.jpg

# 放大图像
ffmpeg -i input.jpg -vf "scale=1920:1080:flags=lanczos" output.jpg
```

#### 高质量缩放

```bash
# 使用Lanczos算法（高质量）
ffmpeg -i input.jpg -vf "scale=1920:1080:flags=lanczos" output.jpg

# 使用双线性插值（快速）
ffmpeg -i input.jpg -vf "scale=1920:1080:flags=bilinear" output.jpg

# 使用最近邻插值（像素化效果）
ffmpeg -i input.jpg -vf "scale=1920:1080:flags=neighbor" output.jpg
```

### 3. 图像裁剪

#### 基础裁剪

```bash
# 裁剪指定区域
ffmpeg -i input.jpg -vf "crop=800:600:100:100" output.jpg

# 居中裁剪
ffmpeg -i input.jpg -vf "crop=800:600" output.jpg

# 裁剪为正方形
ffmpeg -i input.jpg -vf "crop=min(iw,ih):min(iw,ih)" output.jpg
```

#### 智能裁剪

```bash
# 裁剪掉边缘
ffmpeg -i input.jpg -vf "crop=in_w-100:in_h-100:50:50" output.jpg

# 裁剪水印区域
ffmpeg -i input.jpg -vf "crop=in_w:in_h-50:0:0" output.jpg
```

### 4. 图像旋转

#### 基础旋转

```bash
# 旋转90度
ffmpeg -i input.jpg -vf "rotate=90*PI/180" output.jpg

# 旋转180度
ffmpeg -i input.jpg -vf "rotate=PI" output.jpg

# 旋转270度
ffmpeg -i input.jpg -vf "rotate=270*PI/180" output.jpg
```

#### 任意角度旋转

```bash
# 旋转45度
ffmpeg -i input.jpg -vf "rotate=45*PI/180" output.jpg

# 旋转并填充背景
ffmpeg -i input.jpg -vf "rotate=45*PI/180:fillcolor=white" output.jpg
```

### 5. 图像滤镜

#### 基础滤镜

```bash
# 高斯模糊
ffmpeg -i input.jpg -vf "gblur=sigma=5" output.jpg

# 锐化
ffmpeg -i input.jpg -vf "unsharp=5:5:1.5:5:5:0.0" output.jpg

# 边缘检测
ffmpeg -i input.jpg -vf "edgedetect=mode=colormix:high=0" output.jpg
```

#### 色彩滤镜

```bash
# 黑白转换
ffmpeg -i input.jpg -vf "hue=s=0" output.jpg

# 调整亮度
ffmpeg -i input.jpg -vf "eq=brightness=0.1" output.jpg

# 调整对比度
ffmpeg -i input.jpg -vf "eq=contrast=1.5" output.jpg

# 调整饱和度
ffmpeg -i input.jpg -vf "eq=saturation=1.5" output.jpg
```

#### 特效滤镜

```bash
# 马赛克效果
ffmpeg -i input.jpg -vf "pixelize=10:10" output.jpg

# 油画效果
ffmpeg -i input.jpg -vf "edgedetect=mode=colormix:high=0,unsharp=5:5:1.5:5:5:0.0" output.jpg

# 老照片效果
ffmpeg -i input.jpg -vf "colorbalance=rs=-0.1:gs=0:bs=0.1,eq=brightness=-0.1:contrast=1.1" output.jpg
```

### 6. 图像合成

#### 水印添加

```bash
# 添加图片水印
ffmpeg -i input.jpg -i watermark.png -filter_complex "overlay=10:10" output.jpg

# 添加文字水印
ffmpeg -i input.jpg -vf "drawtext=text='Watermark':fontsize=24:fontcolor=white:x=10:y=10" output.jpg

# 半透明水印
ffmpeg -i input.jpg -i watermark.png -filter_complex "[1:v]format=rgba,colorchannelmixer=aa=0.5[watermark];[0:v][watermark]overlay=10:10" output.jpg
```

#### 图像拼接

```bash
# 水平拼接
ffmpeg -i image1.jpg -i image2.jpg -filter_complex "hstack" output.jpg

# 垂直拼接
ffmpeg -i image1.jpg -i image2.jpg -filter_complex "vstack" output.jpg

# 网格拼接
ffmpeg -i image1.jpg -i image2.jpg -i image3.jpg -i image4.jpg -filter_complex "xstack=inputs=4:layout=0_0|w0_0|0_h0|w0_h0" output.jpg
```

### 7. 图像分析

#### 获取图像信息

```bash
# 显示图像信息
ffprobe -v quiet -print_format json -show_streams input.jpg

# 显示图像格式
ffprobe -v quiet -print_format json -show_format input.jpg
```

#### 图像质量分析

```bash
# 计算PSNR（峰值信噪比）
ffmpeg -i original.jpg -i compressed.jpg -filter_complex "psnr" -f null -

# 计算SSIM（结构相似性）
ffmpeg -i original.jpg -i compressed.jpg -filter_complex "ssim" -f null -
```

---

## 高级滤镜应用

### 1. 复杂滤镜链

#### 视频滤镜链

```bash
# 多步骤视频处理
ffmpeg -i input.mp4 -vf "scale=1280:720,rotate=90*PI/180,boxblur=5:5,drawtext=text='Processed':fontsize=24:fontcolor=white:x=10:y=10" -c:v libx264 -crf 23 output.mp4

# 分步处理
ffmpeg -i input.mp4 -vf "scale=1280:720" -c:v libx264 -crf 23 temp1.mp4
ffmpeg -i temp1.mp4 -vf "rotate=90*PI/180" -c:v libx264 -crf 23 temp2.mp4
ffmpeg -i temp2.mp4 -vf "boxblur=5:5" -c:v libx264 -crf 23 output.mp4
```

#### 音频滤镜链

```bash
# 多步骤音频处理
ffmpeg -i input.mp3 -af "volume=1.5,highpass=f=1000,lowpass=f=8000,aecho=0.8:0.88:60:0.4" output.mp3

# 分步处理
ffmpeg -i input.mp3 -af "volume=1.5" temp1.mp3
ffmpeg -i temp1.mp3 -af "highpass=f=1000" temp2.mp3
ffmpeg -i temp2.mp3 -af "lowpass=f=8000" temp3.mp3
ffmpeg -i temp3.mp3 -af "aecho=0.8:0.88:60:0.4" output.mp3
```

### 2. 自定义滤镜

#### 视频自定义滤镜

```bash
# 自定义色彩调整
ffmpeg -i input.mp4 -vf "colorbalance=rs=-0.1:gs=0:bs=0.1,eq=brightness=0.1:contrast=1.1:saturation=1.2" -c:v libx264 -crf 23 output.mp4

# 自定义模糊效果
ffmpeg -i input.mp4 -vf "gblur=sigma=3:steps=6:planes=0:sigmaV=3:stepsV=6:planesV=1" -c:v libx264 -crf 23 output.mp4

# 自定义锐化效果
ffmpeg -i input.mp4 -vf "unsharp=3:3:1.5:3:3:0.0" -c:v libx264 -crf 23 output.mp4
```

#### 音频自定义滤镜

```bash
# 自定义均衡器
ffmpeg -i input.mp3 -af "equalizer=f=1000:width_type=o:width=200:g=-10,equalizer=f=3000:width_type=o:width=200:g=5" output.mp3

# 自定义压缩器
ffmpeg -i input.mp3 -af "acompressor=threshold=0.1:ratio=9:attack=200:release=1000" output.mp3

# 自定义混响
ffmpeg -i input.mp3 -af "aecho=0.8:0.88:60:0.4,aecho=0.8:0.88:60:0.4" output.mp3
```

### 3. 高级视频特效

#### 转场效果

```bash
# 淡入淡出转场
ffmpeg -i video1.mp4 -i video2.mp4 -filter_complex "[0:v]fade=t=out:st=4:d=1[v0];[1:v]fade=t=in:st=0:d=1[v1];[v0][v1]concat=n=2:v=1:a=0[outv]" -map "[outv]" output.mp4

# 交叉淡入淡出
ffmpeg -i video1.mp4 -i video2.mp4 -filter_complex "[0:v]fade=t=out:st=4:d=1[v0];[1:v]fade=t=in:st=0:d=1[v1];[v0][v1]overlay=0:0:shortest=1[outv]" -map "[outv]" output.mp4
```

#### 画中画效果

```bash
# 基础画中画
ffmpeg -i main.mp4 -i pip.mp4 -filter_complex "[1:v]scale=320:240[pip];[0:v][pip]overlay=10:10" -c:v libx264 -crf 23 output.mp4

# 动态画中画
ffmpeg -i main.mp4 -i pip.mp4 -filter_complex "[1:v]scale=320:240[pip];[0:v][pip]overlay=10+sin(t*2*PI/5)*50:10+cos(t*2*PI/5)*50" -c:v libx264 -crf 23 output.mp4
```

#### 绿幕抠像

```bash
# 基础绿幕抠像
ffmpeg -i background.mp4 -i greenscreen.mp4 -filter_complex "[1:v]colorkey=0x00ff00:0.1:0.2[ckout];[0:v][ckout]overlay=0:0" -c:v libx264 -crf 23 output.mp4

# 高级绿幕抠像
ffmpeg -i background.mp4 -i greenscreen.mp4 -filter_complex "[1:v]colorkey=0x00ff00:0.1:0.2,format=yuva420p[ckout];[0:v][ckout]overlay=0:0" -c:v libx264 -crf 23 output.mp4
```

### 4. 高级音频特效

#### 立体声处理

```bash
# 立体声增强
ffmpeg -i input.mp3 -af "stereotools=balance_in=0:balance_out=0:phase_l=0:phase_r=0:mode=0:sclevel_in=1:sclevel_out=1:phase_l=0:phase_r=0:mlev_in=1:mlev_out=1:slev_in=1:slev_out=1:sbal_in=0:sbal_out=0:stereo_base=0:scmode=0" output.mp3

# 立体声分离
ffmpeg -i input.mp3 -af "stereotools=balance_in=0:balance_out=0:phase_l=0:phase_r=0:mode=1:sclevel_in=1:sclevel_out=1:phase_l=0:phase_r=0:mlev_in=1:mlev_out=1:slev_in=1:slev_out=1:sbal_in=0:sbal_out=0:stereo_base=0:scmode=0" output.mp3
```

#### 动态范围压缩

```bash
# 动态范围压缩
ffmpeg -i input.mp3 -af "acompressor=threshold=0.1:ratio=9:attack=200:release=1000:makeup=2" output.mp3

# 多频段压缩
ffmpeg -i input.mp3 -af "acompressor=threshold=0.1:ratio=9:attack=200:release=1000,acompressor=threshold=0.05:ratio=20:attack=50:release=500" output.mp3
```

#### 音频修复

```bash
# 降噪
ffmpeg -i input.mp3 -af "anlmdn=s=7:p=0.002:r=0.01" output.mp3

# 去爆音
ffmpeg -i input.mp3 -af "acompressor=threshold=0.05:ratio=20:attack=50:release=500" output.mp3

# 去回声
ffmpeg -i input.mp3 -af "highpass=f=200,lowpass=f=3000" output.mp3
```

---

## 流媒体处理

### 1. 直播推流

#### RTMP推流

```bash
# 推流到RTMP服务器
ffmpeg -re -i input.mp4 -c copy -f flv rtmp://server/live/stream

# 推流本地摄像头
ffmpeg -f avfoundation -i "0:0" -c:v libx264 -preset ultrafast -tune zerolatency -c:a aac -f flv rtmp://server/live/stream

# 推流屏幕录制
ffmpeg -f avfoundation -i "1:0" -c:v libx264 -preset ultrafast -tune zerolatency -c:a aac -f flv rtmp://server/live/stream
```

#### HLS推流

```bash
# 生成HLS流
ffmpeg -i input.mp4 -c:v libx264 -c:a aac -f hls -hls_time 2 -hls_list_size 5 -hls_flags delete_segments output.m3u8

# 实时HLS推流
ffmpeg -re -i input.mp4 -c:v libx264 -c:a aac -f hls -hls_time 2 -hls_list_size 5 -hls_flags delete_segments+append_list output.m3u8
```

#### DASH推流

```bash
# 生成DASH流
ffmpeg -i input.mp4 -c:v libx264 -c:a aac -f dash -seg_duration 2 -use_template 1 -use_timeline 1 output.mpd

# 多码率DASH
ffmpeg -i input.mp4 -map 0:v:0 -map 0:a:0 -c:v libx264 -b:v 1000k -c:a aac -b:a 128k -f dash -seg_duration 2 -use_template 1 -use_timeline 1 output_1000k.mpd
```

### 2. 流媒体接收

#### 接收RTMP流

```bash
# 接收并保存
ffmpeg -i rtmp://server/live/stream -c copy output.mp4

# 接收并转码
ffmpeg -i rtmp://server/live/stream -c:v libx264 -c:a aac output.mp4

# 接收并推流到其他服务器
ffmpeg -i rtmp://server1/live/stream -c copy -f flv rtmp://server2/live/stream
```

#### 接收HLS流

```bash
# 接收HLS流
ffmpeg -i http://server/live/stream.m3u8 -c copy output.mp4

# 接收并转码
ffmpeg -i http://server/live/stream.m3u8 -c:v libx264 -c:a aac output.mp4
```

### 3. 流媒体处理

#### 实时转码

```bash
# 实时转码并推流
ffmpeg -i rtmp://input/stream -c:v libx264 -preset ultrafast -tune zerolatency -c:a aac -f flv rtmp://output/stream

# 多码率转码
ffmpeg -i rtmp://input/stream -filter_complex "[0:v]split=3[v1][v2][v3];[v1]scale=1280:720[v1out];[v2]scale=854:480[v2out];[v3]scale=640:360[v3out]" -map "[v1out]" -map 0:a -c:v libx264 -b:v 2000k -c:a aac -b:a 128k -f flv rtmp://output/high -map "[v2out]" -map 0:a -c:v libx264 -b:v 1000k -c:a aac -b:a 96k -f flv rtmp://output/medium -map "[v3out]" -map 0:a -c:v libx264 -b:v 500k -c:a aac -b:a 64k -f flv rtmp://output/low
```

#### 流媒体录制

```bash
# 录制流媒体
ffmpeg -i rtmp://server/live/stream -c copy -f segment -segment_time 300 -reset_timestamps 1 output_%03d.mp4

# 录制并自动分割
ffmpeg -i rtmp://server/live/stream -c copy -f segment -segment_time 3600 -segment_format mp4 -reset_timestamps 1 output_%Y%m%d_%H%M%S.mp4
```

### 4. 流媒体优化

#### 延迟优化

```bash
# 低延迟推流
ffmpeg -i input.mp4 -c:v libx264 -preset ultrafast -tune zerolatency -g 30 -keyint_min 30 -c:a aac -b:a 128k -f flv rtmp://server/live/stream

# 低延迟接收
ffmpeg -i rtmp://server/live/stream -c copy -fflags +genpts -avoid_negative_ts make_zero output.mp4
```

#### 带宽优化

```bash
# 自适应比特率
ffmpeg -i input.mp4 -c:v libx264 -b:v 1000k -maxrate 1500k -bufsize 2000k -c:a aac -b:a 128k -f flv rtmp://server/live/stream

# 多码率自适应
ffmpeg -i input.mp4 -filter_complex "[0:v]split=3[v1][v2][v3];[v1]scale=1920:1080[v1out];[v2]scale=1280:720[v2out];[v3]scale=854:480[v3out]" -map "[v1out]" -map 0:a -c:v libx264 -b:v 3000k -maxrate 4000k -bufsize 6000k -c:a aac -b:a 192k -f flv rtmp://output/1080p -map "[v2out]" -map 0:a -c:v libx264 -b:v 1500k -maxrate 2000k -bufsize 3000k -c:a aac -b:a 128k -f flv rtmp://output/720p -map "[v3out]" -map 0:a -c:v libx264 -b:v 800k -maxrate 1000k -bufsize 1500k -c:a aac -b:a 96k -f flv rtmp://output/480p
```

---

## 性能优化技巧

### 1. 硬件加速

#### NVIDIA GPU加速

```bash
# 使用NVENC编码
ffmpeg -i input.mp4 -c:v h264_nvenc -preset p7 -rc vbr -cq 23 -b:v 5000k -maxrate 6000k -bufsize 8000k -c:a aac -b:a 128k output.mp4

# 使用NVDEC解码
ffmpeg -hwaccel cuda -i input.mp4 -c:v h264_nvenc -preset p7 -rc vbr -cq 23 -b:v 5000k -maxrate 6000k -bufsize 8000k -c:a aac -b:a 128k output.mp4
```

#### Intel GPU加速

```bash
# 使用QSV编码
ffmpeg -i input.mp4 -c:v h264_qsv -preset medium -global_quality 23 -c:a aac -b:a 128k output.mp4

# 使用QSV解码
ffmpeg -hwaccel qsv -i input.mp4 -c:v h264_qsv -preset medium -global_quality 23 -c:a aac -b:a 128k output.mp4
```

#### AMD GPU加速

```bash
# 使用AMF编码
ffmpeg -i input.mp4 -c:v h264_amf -quality quality -rc cqp -qp_i 23 -qp_p 23 -c:a aac -b:a 128k output.mp4

# 使用AMF解码
ffmpeg -hwaccel amf -i input.mp4 -c:v h264_amf -quality quality -rc cqp -qp_i 23 -qp_p 23 -c:a aac -b:a 128k output.mp4
```

### 2. 多线程优化

#### CPU多线程

```bash
# 指定线程数
ffmpeg -threads 8 -i input.mp4 -c:v libx264 -preset slow -crf 23 -c:a aac -b:a 128k output.mp4

# 自动检测CPU核心数
ffmpeg -threads 0 -i input.mp4 -c:v libx264 -preset slow -crf 23 -c:a aac -b:a 128k output.mp4
```

#### 并行处理

```bash
# 并行处理多个文件
for file in *.mp4; do
    ffmpeg -i "$file" -c:v libx264 -crf 23 -c:a aac -b:a 128k "compressed_$file" &
done
wait
```

### 3. 内存优化

#### 缓冲区优化

```bash
# 调整缓冲区大小
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 23 -maxrate 5000k -bufsize 10000k -c:a aac -b:a 128k output.mp4

# 使用内存映射
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 23 -c:a aac -b:a 128k -f mp4 -movflags +faststart output.mp4
```

#### 分段处理

```bash
# 分段处理大文件
ffmpeg -i input.mp4 -ss 0 -t 300 -c:v libx264 -crf 23 -c:a aac -b:a 128k part1.mp4
ffmpeg -i input.mp4 -ss 300 -t 300 -c:v libx264 -crf 23 -c:a aac -b:a 128k part2.mp4
ffmpeg -i input.mp4 -ss 600 -c:v libx264 -crf 23 -c:a aac -b:a 128k part3.mp4

# 合并分段
ffmpeg -f concat -safe 0 -i <(echo "file 'part1.mp4'"; echo "file 'part2.mp4'"; echo "file 'part3.mp4'") -c copy output.mp4
```

### 4. 编码优化

#### 编码预设选择

```bash
# 质量优先（慢速）
ffmpeg -i input.mp4 -c:v libx264 -preset veryslow -crf 18 -c:a aac -b:a 128k output.mp4

# 速度优先（快速）
ffmpeg -i input.mp4 -c:v libx264 -preset ultrafast -crf 28 -c:a aac -b:a 128k output.mp4

# 平衡选择（推荐）
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 23 -c:a aac -b:a 128k output.mp4
```

#### 质量参数优化

```bash
# 高质量设置
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 18 -x264-params "ref=6:me=umh:subme=9:bframes=8:b-adapt=2" -c:a aac -b:a 192k output.mp4

# 快速设置
ffmpeg -i input.mp4 -c:v libx264 -preset ultrafast -crf 28 -x264-params "ref=1:me=dia:subme=1:bframes=0" -c:a aac -b:a 128k output.mp4
```

### 5. 网络优化

#### 流媒体优化

```bash
# 优化网络传输
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 23 -x264-params "keyint=60:min-keyint=60:scenecut=0" -c:a aac -b:a 128k -f mp4 -movflags +faststart output.mp4

# 优化直播延迟
ffmpeg -i input.mp4 -c:v libx264 -preset ultrafast -tune zerolatency -g 30 -keyint_min 30 -c:a aac -b:a 128k -f flv rtmp://server/live/stream
```

#### 缓存优化

```bash
# 启用缓存
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 23 -c:a aac -b:a 128k -f mp4 -movflags +faststart+frag_keyframe+empty_moov output.mp4

# 分段缓存
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 23 -c:a aac -b:a 128k -f hls -hls_time 2 -hls_list_size 5 -hls_flags delete_segments output.m3u8
```

---

## 常见问题解决

### 1. 编码问题

#### 编码器不支持

```bash
# 检查可用编码器
ffmpeg -codecs | grep -i h264

# 使用替代编码器
ffmpeg -i input.mp4 -c:v libxvid -c:a mp3 output.avi

# 重新编译FFmpeg
./configure --enable-gpl --enable-libx264 --enable-libx265 --enable-libmp3lame --enable-libopus
```

#### 编码参数错误

```bash
# 检查编码参数
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 23 -c:a aac -b:a 128k -y output.mp4

# 使用默认参数
ffmpeg -i input.mp4 -c:v libx264 -c:a aac output.mp4

# 逐步调试
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 23 temp.mp4
ffmpeg -i temp.mp4 -c:a aac -b:a 128k output.mp4
```

### 2. 格式问题

#### 容器格式不支持

```bash
# 检查支持的格式
ffmpeg -formats | grep -i mp4

# 转换容器格式
ffmpeg -i input.avi -c copy output.mp4

# 重新封装
ffmpeg -i input.mp4 -c copy -f mp4 output.mp4
```

#### 编解码器不兼容

```bash
# 检查编解码器兼容性
ffprobe -v quiet -print_format json -show_streams input.mp4

# 转码为兼容格式
ffmpeg -i input.mp4 -c:v libx264 -c:a aac output.mp4

# 使用通用编解码器
ffmpeg -i input.mp4 -c:v mpeg4 -c:a mp3 output.avi
```

### 3. 性能问题

#### 处理速度慢

```bash
# 使用硬件加速
ffmpeg -hwaccel cuda -i input.mp4 -c:v h264_nvenc -preset p7 -rc vbr -cq 23 output.mp4

# 降低质量设置
ffmpeg -i input.mp4 -c:v libx264 -preset ultrafast -crf 28 output.mp4

# 使用多线程
ffmpeg -threads 8 -i input.mp4 -c:v libx264 -preset slow -crf 23 output.mp4
```

#### 内存不足

```bash
# 分段处理
ffmpeg -i input.mp4 -ss 0 -t 300 -c:v libx264 -crf 23 part1.mp4
ffmpeg -i input.mp4 -ss 300 -t 300 -c:v libx264 -crf 23 part2.mp4

# 降低分辨率
ffmpeg -i input.mp4 -vf "scale=1280:720" -c:v libx264 -crf 23 output.mp4

# 使用流式处理
ffmpeg -i input.mp4 -c:v libx264 -preset ultrafast -crf 28 -f mp4 -movflags +frag_keyframe+empty_moov output.mp4
```

### 4. 音视频同步问题

#### 音视频不同步

```bash
# 修复音视频同步
ffmpeg -i input.mp4 -vsync cfr -c:v libx264 -crf 23 -c:a aac -b:a 128k output.mp4

# 调整音频延迟
ffmpeg -i input.mp4 -itsoffset 0.5 -i input.mp4 -map 0:v -map 1:a -c copy output.mp4

# 重新编码同步
ffmpeg -i input.mp4 -c:v libx264 -crf 23 -c:a aac -b:a 128k -async 1 output.mp4
```

#### 帧率问题

```bash
# 固定帧率
ffmpeg -i input.mp4 -r 30 -c:v libx264 -crf 23 output.mp4

# 可变帧率转固定帧率
ffmpeg -i input.mp4 -vsync cfr -r 30 -c:v libx264 -crf 23 output.mp4

# 帧率转换
ffmpeg -i input.mp4 -filter:v "fps=fps=30" -c:v libx264 -crf 23 output.mp4
```

### 5. 网络问题

#### 流媒体连接失败

```bash
# 检查网络连接
ffmpeg -i rtmp://server/live/stream -t 10 -c copy test.mp4

# 使用HTTP代理
ffmpeg -i http://server/live/stream.m3u8 -c copy output.mp4

# 设置超时时间
ffmpeg -timeout 30 -i rtmp://server/live/stream -c copy output.mp4
```

#### 推流失败

```bash
# 检查推流地址
ffmpeg -i input.mp4 -c copy -f flv rtmp://server/live/stream

# 使用备用协议
ffmpeg -i input.mp4 -c copy -f hls output.m3u8

# 设置重连参数
ffmpeg -re -i input.mp4 -c copy -f flv -flvflags no_duration_filesize rtmp://server/live/stream
```

### 6. 文件问题

#### 文件损坏

```bash
# 修复损坏的文件
ffmpeg -i input.mp4 -c copy -avoid_negative_ts make_zero output.mp4

# 跳过损坏的帧
ffmpeg -i input.mp4 -c copy -fflags +genpts -avoid_negative_ts make_zero output.mp4

# 重新编码修复
ffmpeg -i input.mp4 -c:v libx264 -crf 23 -c:a aac -b:a 128k output.mp4
```

#### 文件过大

```bash
# 压缩文件
ffmpeg -i input.mp4 -c:v libx264 -crf 28 -c:a aac -b:a 128k output.mp4

# 降低分辨率
ffmpeg -i input.mp4 -vf "scale=1280:720" -c:v libx264 -crf 23 output.mp4

# 分段处理
ffmpeg -i input.mp4 -c copy -map 0 -segment_time 300 -f segment output_%03d.mp4
```

### 7. 滤镜问题

#### 滤镜参数错误

```bash
# 检查滤镜语法
ffmpeg -i input.mp4 -vf "scale=1280:720" -c:v libx264 -crf 23 output.mp4

# 简化滤镜链
ffmpeg -i input.mp4 -vf "scale=1280:720,rotate=90*PI/180" -c:v libx264 -crf 23 output.mp4

# 分步应用滤镜
ffmpeg -i input.mp4 -vf "scale=1280:720" temp1.mp4
ffmpeg -i temp1.mp4 -vf "rotate=90*PI/180" -c:v libx264 -crf 23 output.mp4
```

#### 滤镜效果不理想

```bash
# 调整滤镜参数
ffmpeg -i input.mp4 -vf "boxblur=5:5" -c:v libx264 -crf 23 output.mp4

# 尝试不同滤镜
ffmpeg -i input.mp4 -vf "gblur=sigma=3" -c:v libx264 -crf 23 output.mp4

# 组合多个滤镜
ffmpeg -i input.mp4 -vf "scale=1280:720,boxblur=5:5,eq=brightness=0.1" -c:v libx264 -crf 23 output.mp4
```

### 8. 字幕问题

#### 字幕不显示

```bash
# 嵌入字幕
ffmpeg -i input.mp4 -i subtitles.srt -c:v copy -c:a copy -c:s srt -map 0:v -map 0:a -map 1:s output.mp4

# 硬编码字幕
ffmpeg -i input.mp4 -vf "subtitles=subtitles.srt" -c:v libx264 -crf 23 output.mp4

# 检查字幕格式
ffprobe -v quiet -print_format json -show_streams input.mp4
```

#### 字幕同步问题

```bash
# 调整字幕延迟
ffmpeg -i input.mp4 -vf "subtitles=subtitles.srt:force_style='FontSize=24,PrimaryColour=&Hffffff&,OutlineColour=&H000000&,BorderStyle=3,Outline=1,Shadow=1,MarginV=25'" -c:v libx264 -crf 23 output.mp4

# 重新编码字幕
ffmpeg -i input.mp4 -i subtitles.srt -c:v libx264 -crf 23 -c:a aac -b:a 128k -c:s srt output.mp4
```

### 9. 音频问题

#### 音频质量差

```bash
# 提高音频质量
ffmpeg -i input.mp4 -c:v copy -c:a aac -b:a 192k output.mp4

# 音频降噪
ffmpeg -i input.mp4 -af "anlmdn=s=7:p=0.002:r=0.01" -c:v copy -c:a aac -b:a 128k output.mp4

# 音频标准化
ffmpeg -i input.mp4 -af "loudnorm" -c:v copy -c:a aac -b:a 128k output.mp4
```

#### 音频不同步

```bash
# 调整音频延迟
ffmpeg -i input.mp4 -itsoffset 0.5 -i input.mp4 -map 0:v -map 1:a -c copy output.mp4

# 重新编码音频
ffmpeg -i input.mp4 -c:v copy -c:a aac -b:a 128k -async 1 output.mp4

# 音频重采样
ffmpeg -i input.mp4 -c:v copy -c:a aac -ar 44100 -b:a 128k output.mp4
```

### 10. 硬件加速问题

#### GPU加速失败

```bash
# 检查GPU支持
ffmpeg -hwaccels

# 检查编码器支持
ffmpeg -encoders | grep nvenc

# 使用CPU编码
ffmpeg -i input.mp4 -c:v libx264 -crf 23 -c:a aac -b:a 128k output.mp4
```

#### 硬件加速质量差

```bash
# 调整硬件编码参数
ffmpeg -i input.mp4 -c:v h264_nvenc -preset p7 -rc vbr -cq 23 -b:v 5000k -maxrate 6000k -bufsize 8000k output.mp4

# 使用CPU编码提高质量
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 18 -c:a aac -b:a 192k output.mp4

# 混合编码
ffmpeg -hwaccel cuda -i input.mp4 -c:v h264_nvenc -preset p7 -rc vbr -cq 23 output.mp4
```

---

## 总结

FFmpeg是一个功能强大、应用广泛的多媒体处理工具。通过本教程的学习，您应该能够：

1. **理解FFmpeg的基本概念和核心组件**
2. **掌握音视频编码的基本原理**
3. **熟练使用FFmpeg进行各种音视频处理**
4. **应用高级滤镜和特效**
5. **处理流媒体和直播场景**
6. **优化性能和解决常见问题**

### 学习建议

1. **循序渐进**：从基础命令开始，逐步学习复杂功能
2. **实践为主**：多动手操作，理解参数的作用
3. **查阅文档**：遇到问题时查阅官方文档和社区资源
4. **持续学习**：关注FFmpeg的更新和新功能

### 进阶方向

1. **开发应用**：使用FFmpeg库开发多媒体应用
2. **性能优化**：深入研究编码算法和硬件加速
3. **流媒体**：专注于直播和点播技术
4. **专业应用**：在特定领域（如影视制作、游戏开发）应用FFmpeg

### 资源推荐

- **官方文档**：<https://ffmpeg.org/documentation.html>
- **社区论坛**：<https://ffmpeg.org/contact.html>
- **GitHub仓库**：<https://github.com/FFmpeg/FFmpeg>
- **在线工具**：<https://ffmpeg.guide/>
- **中文社区**：<https://www.ffmpeg.org.cn/>

### 常用命令速查

#### 基础转换

```bash
# 视频压缩
ffmpeg -i input.mp4 -c:v libx264 -crf 23 -c:a copy output.mp4

# 格式转换
ffmpeg -i input.avi -c:v libx264 -c:a aac output.mp4

# 提取音频
ffmpeg -i input.mp4 -vn -c:a copy output.aac
```

#### 视频处理

```bash
# 调整分辨率
ffmpeg -i input.mp4 -vf "scale=1280:720" -c:v libx264 -crf 23 output.mp4

# 视频剪辑
ffmpeg -i input.mp4 -ss 00:00:30 -t 30 -c copy output.mp4

# 添加水印
ffmpeg -i input.mp4 -i watermark.png -filter_complex "overlay=10:10" output.mp4
```

#### 音频处理

```bash
# 音频格式转换
ffmpeg -i input.wav -c:a libmp3lame -b:a 128k output.mp3

# 音频剪辑
ffmpeg -i input.mp3 -ss 00:00:30 -t 30 -c copy output.mp3

# 音量调节
ffmpeg -i input.mp3 -af "volume=1.5" output.mp3
```

#### 流媒体

```bash
# RTMP推流
ffmpeg -i input.mp4 -c copy -f flv rtmp://server/live/stream

# HLS生成
ffmpeg -i input.mp4 -c:v libx264 -c:a aac -f hls output.m3u8

# 接收流
ffmpeg -i rtmp://server/live/stream -c copy output.mp4
```

希望这个教程能够帮助您掌握FFmpeg的使用，并在实际项目中发挥其强大的功能！
