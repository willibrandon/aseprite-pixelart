---
description: Show help for pixel art commands and skills
argument-hint: [command-name]
allowed-tools: Read, Bash
---

## /pixel-help - Plugin Help

Display help information for the Aseprite Pixel Art Plugin.

### Usage

```
/pixel-help [command-name]
```

### Arguments

**command-name** (optional): Specific command or topic
- If not provided, shows general overview
- If provided, shows detailed help for that command/skill

### Examples

```
/pixel-help
→ Shows general plugin overview and command list

/pixel-help pixel-new
→ Shows detailed help for /pixel-new command

/pixel-help palettes
→ Shows information about available palettes

/pixel-help export
→ Shows export formats and options
```

### General Help Output

When called without arguments:

```
# Aseprite Pixel Art Plugin

Create, edit, and export pixel art using natural language or commands.

## Quick Start

1. Setup (first time only):
   /pixel-setup

2. Create a sprite:
   /pixel-new 64x64
   or: "Create a 32x32 pixel art sprite"

3. Add content:
   "Draw a red circle in the center"
   "Add a walk cycle animation with 4 frames"

4. Export:
   /pixel-export png sprite.png

## Commands

/pixel-new [size] [palette]      - Create new sprite with presets
/pixel-palette <action> [args]   - Manage color palettes
/pixel-export <format> [file]    - Export sprite
/pixel-setup [path]              - Configure plugin
/pixel-help [topic]              - Show this help

## Skills (Natural Language)

The plugin responds to natural language requests:

- **Creation**: "Create a 64x64 sprite", "Make a new canvas"
- **Animation**: "Add 4 frames", "Create a walk cycle"
- **Advanced**: "Apply dithering", "Optimize palette to 16 colors"
- **Export**: "Export as GIF", "Create a spritesheet"

## Topics

/pixel-help palettes            - Available color palettes
/pixel-help export              - Export formats and options
/pixel-help animation           - Animation features
/pixel-help shortcuts           - Common workflows

## Examples

"Create a 32x32 Game Boy style sprite"
"Add a simple idle animation"
"Export as a horizontal spritesheet"
"Apply NES palette and dither"

## Documentation

See ~/.claude-plugins/aseprite-pixelart/ for full documentation.
```

### Topic-Specific Help

**For command names** (pixel-new, pixel-palette, etc.):
1. Read corresponding command file from `commands/`
2. Extract usage, examples, and options
3. Display in readable format

**For "palettes" topic:**
```
# Color Palettes

## Retro Console Palettes

NES (54 colors)        - Nintendo Entertainment System
Game Boy (4 colors)    - Original Game Boy green palette
Game Boy Gray (4)      - Grayscale Game Boy Pocket
C64 (16 colors)        - Commodore 64
CGA (4 colors)         - IBM CGA
SNES (256 colors)      - Super Nintendo

## Modern Palettes

PICO-8 (16 colors)     - Fantasy console palette
Sweetie 16             - Popular 16-color palette by GrafxKid
DB16                   - DawnBringer's 16-color palette
DB32                   - DawnBringer's 32-color palette

## Usage

/pixel-palette set nes
/pixel-palette set gameboy
/pixel-new 64x64 pico8

## Custom Palettes

/pixel-palette set custom #000000,#ffffff,#ff0000,#00ff00

See /pixel-help pixel-palette for more details.
```

**For "export" topic:**
```
# Export Formats

## Formats

PNG       - Single frame or current frame
GIF       - Animated GIF with all frames
Sheet     - Spritesheet (multiple layouts)
JSON      - Metadata for game engines

## Layouts (Spritesheet)

horizontal  - All frames in a row
vertical    - All frames in a column
grid        - Optimal grid layout
packed      - Space-optimized layout

## Scaling

scale=1     - Original size (1x)
scale=2     - 2x size (pixel-perfect)
scale=4     - 4x size
scale=8     - 8x size

## Examples

/pixel-export png sprite.png scale=4
/pixel-export gif animation.gif fps=12
/pixel-export sheet spritesheet.png layout=grid
/pixel-export json sprite.json format=unity

See /pixel-help pixel-export for more details.
```

**For "animation" topic:**
```
# Animation Features

## Natural Language

"Add 4 frames for a walk cycle"
"Create an idle animation with 2 frames"
"Set frame duration to 100ms"
"Create animation tag 'walk' for frames 1-4"

## Frame Management

- Add frames
- Delete frames
- Duplicate frames
- Set frame duration (timing)

## Animation Tags

Tags organize frames into named sequences:
- "idle" (frames 1-2)
- "walk" (frames 3-6)
- "jump" (frames 7-10)

## Linked Cels

Share image data across frames for efficiency:
- Static background layers
- Repeated frames
- Memory optimization

## Common Animations

Idle (2-4 frames)       - Subtle breathing/bobbing
Walk (4-8 frames)       - Left-right foot alternation
Run (6-8 frames)        - Faster, exaggerated walk
Jump (4-6 frames)       - Crouch, ascend, peak, descend, land
Attack (3-6 frames)     - Windup, strike, recovery

See pixel-art-animator skill documentation for details.
```

**For "shortcuts" topic:**
```
# Common Workflows

## Quick Sprite Creation

/pixel-new icon gameboy
→ Creates 32x32 sprite with Game Boy palette

## Retro Game Sprite

1. /pixel-new 64x64 nes
2. "Draw a character"
3. "Add a 4-frame walk cycle"
4. /pixel-export sheet spritesheet.png layout=horizontal

## Modern Pixel Art

1. /pixel-new large
2. "Draw detailed portrait"
3. "Apply soft shading from top-left"
4. /pixel-export png portrait.png scale=2

## Optimize Existing Sprite

1. "Open sprite.png"
2. /pixel-palette optimize 16
3. "Apply Floyd-Steinberg dithering"
4. /pixel-export png optimized.png

## Animated GIF

1. /pixel-new 64x64
2. "Create 8-frame run cycle"
3. "Set all frames to 80ms duration"
4. /pixel-export gif running.gif fps=12

## Game Engine Export

1. Create and animate sprite
2. /pixel-export json sprite.json format=unity
3. Import sprite.png and sprite.json into Unity
```

### Implementation

Parse $ARGUMENTS:

**If no arguments:**
1. Display general help (command list, quick start, examples)
2. Show all available commands
3. List help topics
4. Provide documentation links

**If command name provided:**
1. Check if matches slash command (pixel-new, pixel-palette, etc.)
2. If yes, read command file and display usage/examples
3. If no, check if matches topic (palettes, export, animation, shortcuts)
4. If topic, display topic-specific help
5. If neither, suggest similar topics or show general help

**Reading command files:**
1. Use Read tool to load `commands/{command-name}.md`
2. Extract description, usage, examples sections
3. Format for display

**Formatting:**
- Use clear headings and sections
- Include code examples with syntax highlighting
- Show command usage patterns
- Provide related commands and topics

### Notes

- Help is context-aware (shows relevant examples)
- Command help extracted from actual command files
- Topics provide grouped information
- Examples are actionable (copy-paste ready)
- Links to full documentation files when available
