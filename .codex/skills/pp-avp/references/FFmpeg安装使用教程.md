# FFmpeg介绍概述

官网：https://ffmpeg.org/

下载地址：https://ffmpeg.org/download.html

FFmpeg（Fast Forward MPEG）是一个开源的多媒体处理工具集，它提供了丰富的音频和视频处理功能，包括编解码、转码、格式转换、剪辑、编辑、流媒体处理等。以下是FFmpeg的详细介绍：

## 一、基本概述

- **定义**：FFmpeg是一个开源的多媒体处理框架，它包含了多种音频和视频处理库、编码器、解码器、转码器等工具，能够处理几乎所有的音视频格式和编解码器。
- **跨平台性**：FFmpeg可以在多种操作系统上运行，包括但不限于Linux、Windows、macOS等，具有非常广泛的适用性。

## 二、主要功能

1. 音视频编解码：
   - 支持多种音频和视频编解码器，如H.264、H.265、AAC、MP3等。
   - 可以将不同格式的音频和视频文件相互转换，如将MP4转换为AVI、将WAV转换为MP3等。
2. 格式转换：
   - 支持将多媒体文件从一种格式转换为另一种格式，包括音频、视频、图像等。
   - 例如，从WAV到MP3、从MP4到GIF、从PNG到JPEG等。
3. 流媒体处理：
   - 能够捕获、处理和传输流媒体数据，适用于直播、视频会议等场景。
   - 支持从网络摄像头、文件、或其他来源捕获音视频流，并能将处理后的流推送到服务器或其他设备。
4. 音视频剪辑和编辑：
   - 支持对音视频进行剪辑、裁剪、剪切、拼接等操作。
   - 支持字幕的添加、移除和编辑，可以将字幕嵌入到视频中或者从视频中提取字幕。
5. 音频处理：
   - 提供了丰富的音频处理功能，包括音频的剪辑、混音、音量调节等。
6. 图像处理：
   - 支持图像处理，如提取视频帧，合成图片和视频等。
7. 滤镜和效果：
   - 支持各种滤镜和效果，如模糊、旋转、调整亮度、对比度等，可以用于音视频特效处理。

## 三、核心组件

FFmpeg由多个库组成，每个库都有其特定的功能：

- **libavcodec**：包含了大量的音视频编解码器，用于处理各种格式的音视频数据。
- **libavformat**：提供了对各种音视频封装格式的读写支持，如MP4、FLV等。
- **libavfilter**：包含了大量的音视频滤镜，可以对音视频数据进行各种处理。
- **libavdevice**：提供了对各种输入/输出设备的支持，如摄像头、麦克风等。
- **libswscale**：主要用于图像缩放、色彩空间转换等操作。
- **libswresample**：主要用于音频重采样和格式转换。

## 四、使用方式

FFmpeg主要通过命令行工具ffmpeg来使用，用户可以通过指定不同的参数来实现各种复杂的音视频处理任务。例如，使用FFmpeg将WAV文件转换为AAC格式，可以使用以下命令：

```bash
ffmpeg -i input.wav -c:a aac output.aac
```

## 五、优势与不足

**优势**：

- 功能强大，支持几乎所有的音视频格式和编解码器。
- 跨平台性好，可以在多种操作系统上运行。
- 提供了丰富的命令行选项，用户可以定制各种复杂的音视频处理任务。

**不足**：

- 学习成本较高，因为命令行选项众多且复杂。
- 在某些情况下，软编解码的功耗可能较大。

## 六、商业应用与开源协议

FFmpeg大部分代码遵循LGPL许可证，要求使用者对FFmpeg的修改进行公布。在商业软件中使用FFmpeg时，需要特别注意可能涉及的专利问题，因为FFmpeg所触及的多媒体编解码算法中有相当一部分处于专利涵盖范围之内。

综上所述，FFmpeg是一款功能强大、灵活高效的音视频处理工具，广泛应用于各种多媒体处理场景。无论是专业的音视频处理人员还是普通的计算机用户，都可以通过学习和使用FFmpeg来满足自己的需求。

# macOS上安装FFmpeg

在macOS上安装FFmpeg有多种方法，以下是几种常见的安装方式：

**使用Homebrew安装**

- Homebrew的安装

打开终端命令输入：

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

或使用国内镜像更快

```bash
/bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
```

如果失败多试几次，可能是你的网络问题，安装完成以后命令行输入：brew -v ，查看homebrew版本看看是否安装成功。

``` bash
brew -v 
#或
brew --version
#Homebrew 4.3.12
```



- 使用Homebrew安装FFmpeg

``` bash
brew install ffmpeg
```

- 验证安装

``` bash
ffmpeg -version
```

```
mymac@192 ~ % ffmpeg -version
ffmpeg version 7.0.1 Copyright (c) 2000-2024 the FFmpeg developers
built with Apple clang version 15.0.0 (clang-1500.3.9.4)
configuration: --prefix=/opt/homebrew/Cellar/ffmpeg/7.0.1 --enable-shared --enable-pthreads --enable-version3 --cc=clang --host-cflags= --host-ldflags='-Wl,-ld_classic' --enable-ffplay --enable-gnutls --enable-gpl --enable-libaom --enable-libaribb24 --enable-libbluray --enable-libdav1d --enable-libharfbuzz --enable-libjxl --enable-libmp3lame --enable-libopus --enable-librav1e --enable-librist --enable-librubberband --enable-libsnappy --enable-libsrt --enable-libssh --enable-libsvtav1 --enable-libtesseract --enable-libtheora --enable-libvidstab --enable-libvmaf --enable-libvorbis --enable-libvpx --enable-libwebp --enable-libx264 --enable-libx265 --enable-libxml2 --enable-libxvid --enable-lzma --enable-libfontconfig --enable-libfreetype --enable-frei0r --enable-libass --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libopenjpeg --enable-libspeex --enable-libsoxr --enable-libzmq --enable-libzimg --disable-libjack --disable-indev=jack --enable-videotoolbox --enable-audiotoolbox --enable-neon
libavutil      59.  8.100 / 59.  8.100
libavcodec     61.  3.100 / 61.  3.100
libavformat    61.  1.100 / 61.  1.100
libavdevice    61.  1.100 / 61.  1.100
libavfilter    10.  1.100 / 10.  1.100
libswscale      8.  1.100 /  8.  1.100
libswresample   5.  1.100 /  5.  1.100
libpostproc    58.  1.100 / 58.  1.100
```

# Ubuntu/Debian上安装FFmpeg

``` bash
sudo apt-get update
sudo apt-get install ffmpeg
```



# lipo移除x86_64&i386架构

https://github.com/arthenica/ffmpeg-kit

使用 lipo 工具来移除 ffmpegkit.framework 中的 x86_64 和 i386 架构。

``` 
ffmpegkit.framework
libavcodec.framework
libavdevice.framework
libavfilter.framework
libavformat.framework
libavutil.framework
libswresample.framework
libswscale.framework
```

将上面的下载的包，依此根据以下模版进行命令执行即可

``` bash
cd path/to/your/project/FFmpegKit/ffmpegkit.framework

# 查看当前架构
lipo -info ffmpegkit

# 创建一个新的框架文件夹来存储移除不支持架构后的文件
mkdir -p arm64

# 移除不支持的架构
lipo -remove x86_64 ffmpegkit -o arm64/ffmpegkit
lipo -remove i386 ffmpegkit -o arm64/ffmpegkit

# 替换原始框架文件
mv arm64/ffmpegkit ffmpegkit
rm -rf arm64
```



# 常见音频格式

### 1. 无损音频格式

这些格式保留了原始音频的所有细节，通常用于专业音频制作和高品质音乐播放。

- **FLAC (Free Lossless Audio Codec)**：一种免费、开放的无损压缩格式。
  - **特点**：FLAC 是一种无损压缩格式，可以将原始音频数据压缩到大约一半的大小，同时保持原始音频的质量不变。
  - **用途**：FLAC 广泛用于音乐下载和高品质音乐播放器，因为它提供了无损音质，同时占用的空间相对较小。
- **ALAC (Apple Lossless Audio Codec)**：苹果开发的一种无损音频格式。
  - **特点**：ALAC 是苹果公司开发的一种无损音频格式，可以将原始音频数据无损压缩到约50%的大小。
  - **用途**：ALAC 主要用于iTunes和Apple Music，以及苹果设备上的高品质音频播放。
  - **文件扩展名**：通常使用 `.m4a` 或 `.alac` 扩展名。
- **WAV (Waveform Audio File Format)**：一种标准的音频文件格式，通常不压缩，但也有压缩的变体（如WAV/PCM和WAV/ADPCM）。
  - **特点**：WAV 是一种标准的音频文件格式，可以存储未经压缩的音频数据，也可以存储使用PCM（脉冲编码调制）或其他编码方式压缩的音频数据。
  - **用途**：WAV 格式广泛用于音频制作和录音室环境，因为它提供了原始的、未经压缩的音频质量。
- **AIFF (Audio Interchange File Format)**：类似于WAV，由Apple开发。
  - **特点**：AIFF 也是由Apple开发的一种标准音频文件格式，类似于WAV格式，通常用于未压缩的音频数据。
  - **用途**：AIFF 通常用于专业音频制作和音乐创作。

### 2. 有损压缩音频格式

这些格式通过去除人耳不易察觉的声音细节来实现文件大小的压缩，适用于大多数日常用途。

- **MP3 (MPEG-1 Audio Layer III)**：最常见的有损音频格式之一，广泛应用于互联网和便携式音乐播放器。
  - **特点**：MP3 是一种有损音频压缩格式，通过去除人耳不易察觉的音频细节来实现高压缩率。
  - **用途**：MP3 是最常见的音频格式之一，广泛用于互联网传输和便携式音乐播放器。
- **AAC (Advanced Audio Coding)**：一种高级的有损音频格式，比MP3提供更好的音质和更高的压缩率。
  - **特点**：AAC 是一种先进的有损音频压缩格式，相比MP3提供了更好的音质和更高的压缩率。
  - **用途**：AAC 被广泛应用于各种数字媒体播放器和流媒体服务，包括iTunes和Apple Music。
  - **文件扩展名**：通常使用 `.m4a` 或 `.aac` 扩展名。
- **OGG Vorbis**：一种开源的有损音频格式，适用于网络流媒体和存储。
  - **特点**：OGG Vorbis 是一种开源的有损音频压缩格式，支持多种比特率，可以提供接近CD质量的音质。
  - **用途**：OGG Vorbis 通常用于网络流媒体和音频文件的存储。
- **Opus**：一种高效的有损音频格式，特别适用于互联网语音通信和多媒体流媒体。
  - **特点**：Opus 是一种高效的有损音频编码格式，支持低延迟传输，非常适合互联网语音通信和多媒体流媒体。
  - **用途**：Opus 被广泛应用于VoIP和视频会议软件。
- **WMA (Windows Media Audio)**：由微软开发的音频格式，分为多个版本，包括WMA Pro和WMA Lossless。

### 3. 其他音频格式

除了上述格式外，还有一些其他类型的音频格式，用于特定的用途。

- **AMR (Adaptive Multi-Rate)**：一种专为手机语音通话设计的格式。
  - **特点**：AMR 是一种专为手机语音通话设计的有损音频格式，支持不同的比特率。
  - **用途**：AMR 通常用于移动电话的语音通话记录。
- **DTS (Digital Theater Systems)**：一种用于家庭影院系统的高质量音频格式。
  - **特点**：DTS 是一种高质量的环绕声音频格式，用于家庭影院系统。
  - **用途**：DTS 通常用于电影院和家庭影院系统，提供环绕声体验。
- **AC3 (Audio Codec 3)**：一种环绕声音频格式，常用于电影和家庭影院系统。
  - **特点**：AC3 是一种环绕声音频格式，广泛用于电影和家庭影院系统。
  - **用途**：AC3 提供5.1或7.1声道环绕声，适用于电影和电视节目。
- **MIDI (Musical Instrument Digital Interface)**：一种描述音乐数据而不是实际声音波形的格式，用于乐器合成。
  - **特点**：MIDI 不是音频文件格式，而是一种描述音乐数据的标准，可以控制电子乐器和合成器。
  - **用途**：MIDI 用于音乐制作、电子乐器和游戏音乐。
- **WebM Audio**：一种基于VPX视频压缩技术和Vorbis音频压缩技术的开放媒体容器格式。
  - **特点**：WebM 是一种基于VPX视频压缩技术和Vorbis音频压缩技术的开放媒体容器格式。
  - **用途**：WebM 主要用于网络视频和音频流媒体。

### 4. 音频容器格式

这些格式用于封装音频数据及其元数据。

- **MP4 (MPEG-4 Part 14)**：一种通用的多媒体容器格式，可以包含音频、视频和字幕等多种类型的数据。
  - **特点**：MP4 是一种通用的多媒体容器格式，可以包含音频、视频和字幕等多种类型的数据。
  - **用途**：MP4 广泛用于存储和传输多媒体文件。
- **M4A (MPEG-4 Audio)**：一种音频专用的MP4格式。
  - **特点**：M4A 是一种音频专用的MP4格式，通常用于存储AAC编码的音频数据。
  - **用途**：M4A 通常用于音频文件存储和传输。
- **AAC-LC (Advanced Audio Coding - Low Complexity)**：一种高效且广泛应用的有损音频编码格式。
- **AAC-HE (AAC High Efficiency)**：一种高效的有损音频编码格式，提供更高的压缩率。

# 具体常用命令示例

## 视频处理

### 视频压缩

``` bash
ffmpeg -i input.mp4 -c:v libx264 -preset slow -crf 23 -c:a copy output.mp4
```

- `-i input.mp4`：指定输入文件。

- `-c:v libx264`：指定视频编码器为 H.264。

- `-preset slow`：设置编码速度预设，`slow` 表示更高的压缩比和更好的视频质量。

- `-crf 23`：设置恒定速率因子 (CRF)，数值越小，质量越好，但文件大小也会更大。通常 `23` 左右是一个不错的平衡点。

- `-c:a copy`：保持音频不变，即不重新编码音频。

- `output.mp4`：输出文件名。

  

### 修改分辨率

``` bash
ffmpeg -i input.mp4 -vf "scale=1280:720" -c:v libx264 -preset slow -crf 23 -c:a copy output.mp4
```

- `-vf "scale=1280:720"`：将视频分辨率调整为 1280x720。


``` bash
ffmpeg -i input.mp4 -vf "scale=WIDTH:-1" output.mp4
```

- -i input.mp4：输入视频文件。

- -vf "scale=WIDTH:-1"：

- WIDTH：你希望的视频宽度（指定你想要的值）。

- -1：让 ffmpeg 自动计算高度以保持原始的宽高比。

- output.mp4：输出文件。

### 裁剪视频

  ``` bash
  ffmpeg -i input.mp4 -vf "crop=in_w:in_h-100" -c:v libx264 -preset slow -crf 23 -c:a copy output.mp4
  ```

  - `-vf "crop=in_w:in_h-100"`：将视频的高度裁剪掉 100 像素。



### 调整比特率

  ``` bash
  ffmpeg -i input.mp4 -c:v libx264 -preset slow -b:v 1000k -c:a copy output.mp4
  ```

  - `-b:v 1000k`：设置视频比特率为 1000kbps。



### 添加水印

  ``` bash
  ffmpeg -i input.mp4 -i watermark.png -filter_complex "[1:v][0:v]overlay=10:10" -c:v libx264 -preset slow -crf 23 -c:a copy output.mp4
  ```

  - `-i watermark.png`：指定水印图片。
  - `-filter_complex "[1:v][0:v]overlay=10:10"`：将水印叠加到视频左上角，距离边缘各 10 像素。

### 去除水印

去除水印无法实际去除，只能通过蒙版和裁剪视频来解决

``` bash
#把B站下载下来的视频顶部的水印去除，高度是135
ffmpeg -i input_video.mp4 -vf "crop=in_w:in_h-135" -c:a copy output_video.mp4
```



### 视频转码

格式转换

``` bash
ffmpeg -i input.avi -c:v libx264 -c:a aac output.mp4
```

### 提取音频

``` bash
ffmpeg -i input.mp4 -vn -acodec copy output.aac
```

### 合并视频和音频

``` bash
ffmpeg -i video.mp4 -i audio.aac -c copy output.mp4
```

### 视频剪辑

从视频中截取特定时间段的内容

``` bash
ffmpeg -i input.mp4 -ss 00:00:30 -to 00:01:00 -c:v copy -c:a copy output.mp4
```

  • -i input.mp4：输入文件。

  • -ss 00:00:30：开始时间，表示从30秒开始剪辑。

  • -to 00:01:00：结束时间，表示剪辑到60秒。

  • -c:v copy -c:a copy：复制视频和音频流，避免重新编码，提高处理速度。

### 视频分割

``` bash
ffmpeg -i input.mp4 -c copy -map 0 -segment_time 10 - 
```

### 视频嵌入字幕文件

``` bash
ffmpeg -i input.mp4 -i subtitles.srt -c:v copy -c:s srt -map 0:v -map 0:a -map 1:s output.mp4
```

### 视频转GIF

- 方法1：基本命令（默认参数，适合小文件）：

``` bash
ffmpeg -i input.mp4 output.gif
```

- 方法 2：优化 GIF（减少体积，提高质量）

默认转换的 GIF 可能会很大，以下是一些优化方案：

1.**限制帧率**

减少 GIF 的帧率可以降低文件大小，-r 10：设置 GIF 帧率为 10 FPS（默认可能高达 30 FPS）

``` bash
ffmpeg -i input.mp4 -r 10 output.gif
```

2.**限制分辨率**

如果 GIF 太大，可以降低分辨率：

``` bash
ffmpeg -i input.mp4 -vf "scale=640:-1" output.gif
```

scale=640:-1：将宽度缩放到 **640px**，高度自动适配。

3.**使用调色板优化（推荐）**

**先生成调色板**（提高 GIF 颜色质量）：

``` bash
ffmpeg -i input.mp4 -vf "palettegen" palette.png
```

**然后使用调色板转换 GIF**：

``` bash
ffmpeg -i input.mp4 -i palette.png -filter_complex "paletteuse" output.gif
```

📌 **优点**：画质更清晰，文件大小更小。

- 方法 3：使用 gifski（更高质量 GIF）

如果 ffmpeg 生成的 GIF 质量不够好，可以使用 gifski：

1. 安装 gifski：

``` bash
brew install gifski  # macOS
```

2. 先用 ffmpeg 提取 PNG 帧：

``` bash
ffmpeg -i input.mp4 -vf "fps=10,scale=640:-1" frame%04d.png
```

3. 然后用 gifski 生成高质量 GIF：

``` bash
gifski -o output.gif frame*.png
```

### 视频转webp

- 普通转换

```bash
ffmpeg -i input.mp4 -c:v libwebp -lossless 0 -q:v 80 -preset default -an -vsync 0 output.webp
```

**解释**：

 • input.mp4：输入的 MP4 文件。

 • -c:v libwebp：使用 **libwebp** 编解码器将视频转换为 WebP 格式。

 • -lossless 0：指定压缩方式，0 表示有损压缩。

 • -q:v 80：设置 WebP 的质量，80 为质量百分比（0-100）。

 • -preset default：设置 WebP 压缩的预设。

 • -an：不处理音频（WebP 格式不包含音频）。

 • -vsync 0：禁用视频同步。



- 转换成动画

``` bash
ffmpeg -i input.mp4 -c:v libwebp -lossless 0 -q:v 80 -preset default -an -vsync 0 -filter:v "fps=10,scale=320:-1" output.webp
```

 • fps=10：每秒 10 帧，调整输出 WebP 动画的帧率。

 • scale=320:-1：调整输出图像的宽度为 320px，高度自适应。

### 提取视频帧转图片

#### **提取指定时间点的帧**

``` bash
ffmpeg -i input.mp4 -ss 00:00:10 -vframes 1 -q:v 2 output.jpg
```

**解释：**

- -i input.mp4 指定输入视频。

- -ss 00:00:10 设置从视频的第 **10 秒** 开始截取帧。

- -vframes 1 仅提取 **1 帧** 作为图片。

- -q:v 2 设置图片质量，值范围 **2-31**（2 最高）。

- output.jpg 生成的封面图像。

#### **提取第 N 帧（按帧数截取）**

``` bash
ffmpeg -i input.mp4 -vf "select=eq(n\,100)" -vsync vfr output.jpg
```

- -vf "select=eq(n\,100)" 选择第 **100 帧**。

- -vsync vfr 避免输出重复帧。

- output.jpg 保存的图片。

#### **批量提取多个封面帧（如每 10 秒一张）**

``` bash
ffmpeg -i input.mp4 -vf "fps=1/10" -q:v 2 frame_%03d.jpg
```

- fps=1/10 每 **10 秒** 截取 **1 帧**。

- frame_%03d.jpg 生成 frame_001.jpg, frame_002.jpg…

## 音频处理

### 格式转换

``` bash
#将 MP3 转换为 WAV
ffmpeg -i input.mp3 output.wav
#将 WAV 转换为 MP3
ffmpeg -i input.wav output.mp3
#将 FLAC 转换为 MP3
ffmpeg -i input.flac output.mp3
#将 MP3 转换为 FLAC
ffmpeg -i input.mp3 output.flac
#将 AAC 转换为 MP3
ffmpeg -i input.m4a output.mp3
#将 MP3 转换为 AAC
ffmpeg -i input.mp3 output.m4a
#将 WAV 转换为 OGG
ffmpeg -i input.wav output.ogg
#将 OGG 转换为 WAV
ffmpeg -i input.ogg output.wav
#将 ALAC 转换为 MP3
ffmpeg -i input.m4a output.mp3
#将 MP3 转换为 ALAC
ffmpeg -i input.mp3 output.m4a
```

### 调整比特率

``` bash
ffmpeg -i input.mp3 -c:a libmp3lame -b:a 128k output.mp3
```

### 调整采样率

``` bash
ffmpeg -i input.wav -ar 44100 output.wav
```

### 调整声道数

```
ffmpeg -i input.wav -ac 1 output_mono.wav
```

### 添加元数据

```bash
ffmpeg -i input.mp3 -metadata title="My Song" -metadata artist="Artist Name" output.mp3
```

### 截取音频片段

``` bash
#截取音频的第 10 秒至第 30 秒
ffmpeg -i input.mp3 -ss 00:00:10 -to 00:00:30 output.mp3
```

### 合并多个音频

``` bash
ffmpeg -i "concat:input1.mp3|input2.mp3|input3.mp3" -c copy output.mp3
```

### 调整音频音量

``` bash
ffmpeg -i input.mp3 -af volume=6dB output.mp3
```

### 裁剪音频长度

``` bash
#裁剪音频的前 30 秒
ffmpeg -i input.mp3 -t 00:00:30 output.mp3
```

# 音频格式转换脚本

## 基础版本

``` bash
#!/bin/bash

# 批量音频格式转换脚本
# 使用方法: ./convert_audio.sh 输入格式 输出格式 [质量参数]

# 检查参数数量
if [ $# -lt 2 ]; then
    echo "使用方法: $0 输入格式 输出格式 [质量参数]"
    echo "示例: $0 flac mp3 192k"
    echo "示例: $0 wav aac 128k"
    echo "示例: $0 mp3 ogg"
    exit 1
fi

# 获取参数
INPUT_FORMAT=$1
OUTPUT_FORMAT=$2
QUALITY=${3:-"192k"}  # 默认质量192k

# 支持的格式映射
declare -A FORMAT_MAP=(
    ["wav"]="pcm_s16le"
    ["mp3"]="libmp3lame"
    ["aac"]="aac"
    ["m4a"]="aac"
    ["ogg"]="libvorbis"
    ["opus"]="libopus"
    ["flac"]="flac"
    ["alac"]="alac"
    ["wma"]="wmav2"
    ["ac3"]="ac3"
    ["dts"]="dca"
)

# 特殊格式处理
declare -A SPECIAL_FLAGS=(
    ["alac"]="-vn -strict -2"
    ["dts"]="-vn -strict -2"
    ["wma"]="-vn"
    ["ac3"]="-vn"
)

# 检查输入格式是否支持
if [[ ! ${FORMAT_MAP[$INPUT_FORMAT]} ]]; then
    echo "错误: 不支持的输入格式 '$INPUT_FORMAT'"
    echo "支持的输入格式: ${!FORMAT_MAP[@]}"
    exit 1
fi

# 检查输出格式是否支持
if [[ ! ${FORMAT_MAP[$OUTPUT_FORMAT]} ]]; then
    echo "错误: 不支持的输出格式 '$OUTPUT_FORMAT'"
    echo "支持的输出格式: ${!FORMAT_MAP[@]}"
    exit 1
fi

# 获取编码器
ENCODER=${FORMAT_MAP[$OUTPUT_FORMAT]}
SPECIAL_FLAG=${SPECIAL_FLAGS[$OUTPUT_FORMAT]:-""}

# 检查文件是否存在
if ! ls *.$INPUT_FORMAT 1> /dev/null 2>&1; then
    echo "错误: 当前目录没有找到 *.$INPUT_FORMAT 文件"
    exit 1
fi

echo "开始批量转换..."
echo "输入格式: $INPUT_FORMAT"
echo "输出格式: $OUTPUT_FORMAT"
echo "质量设置: $QUALITY"
echo "编码器: $ENCODER"
echo ""

# 计数器
TOTAL_FILES=$(ls *.$INPUT_FORMAT | wc -l)
CURRENT=0
SUCCESS=0
FAILED=0

# 批量转换
for file in *.$INPUT_FORMAT; do
    CURRENT=$((CURRENT + 1))
    output_file="${file%.$INPUT_FORMAT}.$OUTPUT_FORMAT"
    
    echo "[$CURRENT/$TOTAL_FILES] 转换: $file -> $output_file"
    
    # 构建FFmpeg命令
    if [[ $OUTPUT_FORMAT == "wav" ]]; then
        # WAV格式特殊处理
        cmd="ffmpeg -i \"$file\" -c:a $ENCODER $SPECIAL_FLAG \"$output_file\""
    elif [[ $OUTPUT_FORMAT == "flac" ]]; then
        # FLAC格式特殊处理
        cmd="ffmpeg -i \"$file\" -c:a $ENCODER $SPECIAL_FLAG \"$output_file\""
    elif [[ $OUTPUT_FORMAT == "alac" ]]; then
        # ALAC格式特殊处理
        cmd="ffmpeg -i \"$file\" -vn -c:a $ENCODER -map_metadata 0 $SPECIAL_FLAG \"$output_file\""
    else
        # 其他格式
        cmd="ffmpeg -i \"$file\" -c:a $ENCODER -b:a $QUALITY $SPECIAL_FLAG \"$output_file\""
    fi
    
    # 执行转换
    if eval $cmd; then
        echo "✅ 成功: $output_file"
        SUCCESS=$((SUCCESS + 1))
    else
        echo "❌ 失败: $file"
        FAILED=$((FAILED + 1))
    fi
    echo ""
done

# 显示结果
echo "转换完成!"
echo "总文件数: $TOTAL_FILES"
echo "成功: $SUCCESS"
echo "失败: $FAILED"
```

## 高级版本

``` bash
#!/bin/bash

# 高级批量音频格式转换脚本
# 使用方法: ./convert_audio_advanced.sh [选项] 输入格式 输出格式

# 默认参数
QUALITY="192k"
PRESERVE_METADATA=true
OVERWRITE=false
VERBOSE=false
DRY_RUN=false

# 帮助信息
show_help() {
    echo "高级批量音频格式转换脚本"
    echo ""
    echo "使用方法: $0 [选项] 输入格式 输出格式"
    echo ""
    echo "选项:"
    echo "  -q, --quality RATE     设置比特率 (默认: 192k)"
    echo "  -m, --no-metadata      不保留元数据"
    echo "  -o, --overwrite        覆盖已存在的文件"
    echo "  -v, --verbose          显示详细信息"
    echo "  -d, --dry-run          仅显示将要执行的命令"
    echo "  -h, --help             显示此帮助信息"
    echo ""
    echo "示例:"
    echo "  $0 flac mp3                    # 基础转换"
    echo "  $0 -q 320k wav mp3            # 高质量转换"
    echo "  $0 -m -o flac aac             # 不保留元数据，覆盖文件"
    echo "  $0 -v -d flac ogg             # 详细模式，仅预览"
    echo ""
    echo "支持的格式: wav, mp3, aac, m4a, ogg, opus, flac, alac, wma, ac3, dts"
}

# 解析命令行参数
while [[ $# -gt 0 ]]; do
    case $1 in
        -q|--quality)
            QUALITY="$2"
            shift 2
            ;;
        -m|--no-metadata)
            PRESERVE_METADATA=false
            shift
            ;;
        -o|--overwrite)
            OVERWRITE=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -d|--dry-run)
            DRY_RUN=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        -*)
            echo "错误: 未知选项 $1"
            show_help
            exit 1
            ;;
        *)
            break
            ;;
    esac
done

# 检查参数数量
if [ $# -ne 2 ]; then
    echo "错误: 需要指定输入格式和输出格式"
    show_help
    exit 1
fi

INPUT_FORMAT=$1
OUTPUT_FORMAT=$2

# 格式配置
declare -A FORMAT_CONFIG=(
    # 格式: "编码器:扩展名:特殊参数"
    ["wav"]="pcm_s16le:wav:"
    ["mp3"]="libmp3lame:mp3:-b:a"
    ["aac"]="aac:m4a:-b:a"
    ["m4a"]="aac:m4a:-b:a"
    ["ogg"]="libvorbis:ogg:-b:a"
    ["opus"]="libopus:opus:-b:a"
    ["flac"]="flac:flac:"
    ["alac"]="alac:m4a:-vn"
    ["wma"]="wmav2:wma:-b:a -vn"
    ["ac3"]="ac3:ac3:-b:a -vn"
    ["dts"]="dca:dts:-b:a -vn -strict -2"
)

# 检查格式支持
if [[ ! ${FORMAT_CONFIG[$INPUT_FORMAT]} ]]; then
    echo "错误: 不支持的输入格式 '$INPUT_FORMAT'"
    echo "支持的格式: ${!FORMAT_CONFIG[@]}"
    exit 1
fi

if [[ ! ${FORMAT_CONFIG[$OUTPUT_FORMAT]} ]]; then
    echo "错误: 不支持的输出格式 '$OUTPUT_FORMAT'"
    echo "支持的格式: ${!FORMAT_CONFIG[@]}"
    exit 1
fi

# 解析格式配置
IFS=':' read -r ENCODER EXTENSION SPECIAL_PARAMS <<< "${FORMAT_CONFIG[$OUTPUT_FORMAT]}"

# 检查文件存在
if ! ls *.$INPUT_FORMAT 1> /dev/null 2>&1; then
    echo "错误: 当前目录没有找到 *.$INPUT_FORMAT 文件"
    exit 1
fi

# 显示配置信息
echo "=== 批量音频格式转换 ==="
echo "输入格式: $INPUT_FORMAT"
echo "输出格式: $OUTPUT_FORMAT"
echo "编码器: $ENCODER"
echo "质量: $QUALITY"
echo "保留元数据: $PRESERVE_METADATA"
echo "覆盖文件: $OVERWRITE"
echo "详细模式: $VERBOSE"
echo "预览模式: $DRY_RUN"
echo ""

# 统计文件
TOTAL_FILES=$(ls *.$INPUT_FORMAT | wc -l)
echo "找到 $TOTAL_FILES 个文件需要转换"
echo ""

# 进度条函数
show_progress() {
    local current=$1
    local total=$2
    local width=50
    local percentage=$((current * 100 / total))
    local completed=$((width * current / total))
    local remaining=$((width - completed))
    
    printf "\r["
    printf "%${completed}s" | tr ' ' '#'
    printf "%${remaining}s" | tr ' ' '-'
    printf "] %d%% (%d/%d)" $percentage $current $total
}

# 转换函数
convert_file() {
    local input_file=$1
    local output_file=$2
    
    # 构建FFmpeg命令
    local cmd="ffmpeg"
    
    # 添加详细模式
    if [[ $VERBOSE == true ]]; then
        cmd="$cmd -v verbose"
    else
        cmd="$cmd -v quiet"
    fi
    
    # 添加覆盖选项
    if [[ $OVERWRITE == true ]]; then
        cmd="$cmd -y"
    else
        cmd="$cmd -n"
    fi
    
    # 添加输入文件
    cmd="$cmd -i \"$input_file\""
    
    # 添加编码器
    cmd="$cmd -c:a $ENCODER"
    
    # 添加特殊参数
    if [[ -n $SPECIAL_PARAMS ]]; then
        if [[ $SPECIAL_PARAMS == *"-b:a"* ]]; then
            cmd="$cmd -b:a $QUALITY"
        fi
        cmd="$cmd $SPECIAL_PARAMS"
    fi
    
    # 添加元数据保留
    if [[ $PRESERVE_METADATA == true ]]; then
        cmd="$cmd -map_metadata 0"
    fi
    
    # 添加输出文件
    cmd="$cmd \"$output_file\""
    
    # 执行或显示命令
    if [[ $DRY_RUN == true ]]; then
        echo "命令: $cmd"
        return 0
    else
        if eval $cmd; then
            return 0
        else
            return 1
        fi
    fi
}

# 主转换循环
CURRENT=0
SUCCESS=0
FAILED=0

for file in *.$INPUT_FORMAT; do
    CURRENT=$((CURRENT + 1))
    output_file="${file%.$INPUT_FORMAT}.$EXTENSION"
    
    # 显示进度
    if [[ $VERBOSE == false && $DRY_RUN == false ]]; then
        show_progress $CURRENT $TOTAL_FILES
    fi
    
    # 检查输出文件是否已存在
    if [[ -f "$output_file" && $OVERWRITE == false ]]; then
        if [[ $VERBOSE == true ]]; then
            echo "跳过已存在的文件: $output_file"
        fi
        SUCCESS=$((SUCCESS + 1))
        continue
    fi
    
    # 转换文件
    if convert_file "$file" "$output_file"; then
        if [[ $VERBOSE == true ]]; then
            echo "✅ 成功: $output_file"
        fi
        SUCCESS=$((SUCCESS + 1))
    else
        if [[ $VERBOSE == true ]]; then
            echo "❌ 失败: $file"
        fi
        FAILED=$((FAILED + 1))
    fi
done

echo ""
echo "=== 转换完成 ==="
echo "总文件数: $TOTAL_FILES"
echo "成功: $SUCCESS"
echo "失败: $FAILED"

if [[ $FAILED -gt 0 ]]; then
    exit 1
fi
```

## 使用示例

``` bash
# 给脚本添加执行权限
chmod +x convert_audio.sh
chmod +x convert_audio_advanced.sh

# 基础使用
./convert_audio.sh flac mp3
./convert_audio.sh wav aac 256k
./convert_audio.sh mp3 ogg 192k

# 高级使用
./convert_audio_advanced.sh flac mp3
./convert_audio_advanced.sh -q 320k wav mp3
./convert_audio_advanced.sh -m -o flac aac
./convert_audio_advanced.sh -v -d flac ogg
```

## 支持的组合格式

``` bash
# 无损格式转换
flac -> wav, mp3, aac, ogg, opus, alac
wav -> flac, mp3, aac, ogg, opus, alac
alac -> wav, mp3, aac, ogg, opus, flac

# 有损格式转换
mp3 -> wav, aac, ogg, opus, flac
aac -> wav, mp3, ogg, opus, flac
ogg -> wav, mp3, aac, opus, flac
opus -> wav, mp3, aac, ogg, flac

# 专业格式转换
ac3 -> wav, mp3, aac, ogg, opus, flac
dts -> wav, mp3, aac, ogg, opus, flac
wma -> wav, mp3, aac, ogg, opus, flac
```

