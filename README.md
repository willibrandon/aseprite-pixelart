# Aseprite Pixel Art Plugin for Claude Code

Create and edit professional pixel art sprites using Aseprite through natural language commands in Claude Code.

## Features

- **Natural Language Interface**: Create sprites by describing what you want
- **AI-Powered Skills**: Claude autonomously uses specialized skills for pixel art tasks
- **Animation Support**: Create multi-frame animations with tags and linked cels
- **Professional Tools**: Dithering, palette management, shading, antialiasing
- **Export Flexibility**: PNG, GIF, spritesheets with multiple layouts
- **Fast Performance**: Operations complete in <100ms typically

## What You Can Do

```
You: "Create a 64x64 sprite of a walking character with 4 animation frames"
Claude: [Creates sprite with walk cycle animation]

You: "Apply Bayer 8x8 dithering for a water texture effect"
Claude: [Applies professional dithering pattern]

You: "Extract the color palette from this reference image"
Claude: [Analyzes image and sets palette]

You: "Export as a spritesheet for Unity"
Claude: [Exports in Unity-compatible format]
```

## Requirements

- **Claude Code** (latest version)
- **Aseprite** v1.3.0+ (v1.3.10+ recommended)
- **Operating System**: macOS, Linux, or Windows

## Installation

### Quick Start

```
# Add the plugin marketplace (when available)
/plugin marketplace add willibrandon/aseprite-pixelart

# Install the plugin
/plugin install aseprite-pixelart@willibrandon
```

### Local Development Installation

Local development installation instructions will be added in Phase 7.

## Quick Start Guide

*Detailed quick start guide will be added in Phase 7.*

## Available Features

### Skills (Model-Invoked)

Claude automatically uses these skills based on your request:

- **pixel-art-creator**: Canvas creation, basic drawing, layer management
- **pixel-art-animator**: Frame management, animation tags, linked cels
- **pixel-art-professional**: Dithering, palettes, shading, antialiasing
- **pixel-art-exporter**: Export to various formats, spritesheets

### Commands (User-Invoked)

Direct control via slash commands:

- `/pixel-new [width] [height] [mode]` - Create new canvas
- `/pixel-palette [action] [args]` - Manage color palettes
- `/pixel-export [format] [filename]` - Export sprite
- `/pixel-setup` - Configure Aseprite path
- `/pixel-help` - Show available features

## Examples

*Example workflows will be added in Phase 7.*

## Troubleshooting

*Troubleshooting guide will be added in Phase 7.*

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
