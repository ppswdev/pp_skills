# pp-avp Skill Configuration

## Skill Metadata

**Name**: pp-avp (pp-audio-video-processor)
**Version**: 1.0.0
**Created**: 2026-05-19
**Dependencies**: FFmpeg >= 4.0

## Directory Structure

```
pp-avp/
├── SKILL.md          # Main skill file (required)
├── README.md         # Documentation (optional)
├── CONFIG.md         # Configuration file
├── 使用指南.md       # Chinese usage guide
└── references/       # Reference documents
    ├── FFmpeg安装使用教程.md
    └── FFmpeg 从入门到精通完整教程.md
```

## Installation

### Method 1: Manual Installation
1. Copy the entire `pp-avp/` folder to your skills directory
2. Ensure FFmpeg is installed on your system
3. The skill will be automatically loaded

### Method 2: Trae IDE Integration
1. Place the skill folder in your project's `.trae/skills/` directory
2. Or configure in `~/.trae/skills/` for global access

## Dependencies

### Required
- **FFmpeg** >= 4.0
  - Installation: `brew install ffmpeg` (macOS) or `apt-get install ffmpeg` (Linux)

### Optional
- **ffprobe** (included with FFmpeg)
- **NVENC/QSV/AMF** (for hardware acceleration)

## Configuration

No additional configuration required. The skill uses system-installed FFmpeg.

## Usage

The skill activates when users mention:
- Audio/video processing tasks
- Format conversion
- Video editing
- Audio extraction
- Adding watermarks
- FFmpeg commands

## Features

### Video Processing
- Compression & transcoding
- Resolution adjustment
- Video cutting & cropping
- Watermarks (image/text)
- Format conversion
- Merge & split
- GIF/WebP conversion
- Frame extraction

### Audio Processing
- Format conversion
- Cutting & editing
- Volume adjustment
- Fade in/out effects
- Extraction from video
- Mixing
- Sample rate/channel conversion

### Image Processing
- Format conversion
- Scaling & cropping
- Rotation & filters
- Watermarks

## Troubleshooting

### FFmpeg Not Found
```bash
# Check FFmpeg installation
which ffmpeg
ffmpeg -version

# Reinstall if needed
brew reinstall ffmpeg
```

### Permission Denied
```bash
chmod +x /path/to/video.mp4
```

### Encoding Errors
- Check codec availability: `ffmpeg -codecs`
- Use compatible formats
- Update FFmpeg to latest version

## Support

For issues or questions:
1. Check FFmpeg documentation in `references/`
2. Review SKILL.md for command examples
3. Consult FFmpeg official documentation

## Migration

To migrate this skill to another location:
1. Copy the entire `audio-video-processing/` folder
2. All dependencies are self-contained in `references/`
3. No external links or dependencies

## License

Based on FFmpeg (LGPL/GPL licensed)
