# Aseprite Pixel Art Plugin - Implementation Guide (Part 3)

**Continuation of IMPLEMENTATION_GUIDE_PART2.md**

This document contains Phase 4 chunks 4.2-4.5 (remaining slash commands).

- **Part 1**: Chunks 1.1-3.2 (Foundation, MCP Integration, Creator & Animator Skills)
- **Part 2**: Chunks 3.3-4.1 (Professional & Exporter Skills, /pixel-new command)
- **Part 3** (This Document): Chunks 4.2-4.5 (Remaining Slash Commands)
- **Part 4**: Phase 5 (Advanced Skills)
- **Part 5**: Phase 6 (Testing and Polish)
- **Part 6**: Phase 7 (Documentation and Release)

---

## Phase 4: Slash Commands (Continued)

### Chunk 4.2: Create /pixel-palette command

**Objective**: Implement the /pixel-palette slash command for managing and applying color palettes.

**Files to Create**:
1. `commands/pixel-palette.md`

---

#### File: `commands/pixel-palette.md`

```markdown
---
description: Manage sprite palettes - set, optimize, or load preset palettes
argument-hint: <action> [palette-name|color-count]
allowed-tools: Read, Bash, mcp__aseprite__set_palette, mcp__aseprite__get_palette, mcp__aseprite__quantize_colors
---

## /pixel-palette - Palette Management

Manage sprite color palettes with presets, optimization, and custom palettes.

### Usage

```
/pixel-palette <action> [palette-name|color-count]
```

### Actions

**set** - Set palette to a preset or custom colors
```
/pixel-palette set nes
/pixel-palette set gameboy
/pixel-palette set custom #000000,#ffffff,#ff0000
```

**optimize** - Reduce colors to optimal palette
```
/pixel-palette optimize 16
/pixel-palette optimize 32
```

**show** - Display current palette
```
/pixel-palette show
```

**export** - Export current palette to file
```
/pixel-palette export my-palette.gpl
```

### Palette Presets

**Retro Consoles:**
- **nes**: 54-color NES palette
- **gameboy**: 4-color Game Boy palette (#0f380f, #306230, #8bac0f, #9bbc0f)
- **gameboy-gray**: 4-shade grayscale Game Boy
- **c64**: 16-color Commodore 64 palette
- **cga**: 4-color CGA palette
- **snes**: Rich 256-color SNES-style palette

**Generic Palettes:**
- **retro16**: Generic 16-color retro palette
- **retro8**: Generic 8-color palette
- **retro4**: Generic 4-color palette
- **grayscale4**: 4 shades of gray
- **grayscale8**: 8 shades of gray
- **grayscale16**: 16 shades of gray

**Modern Palettes:**
- **pico8**: PICO-8 fantasy console 16-color palette
- **sweetie16**: Popular 16-color palette by GrafxKid
- **db16**: DawnBringer's 16-color palette
- **db32**: DawnBringer's 32-color palette

### Examples

```
/pixel-palette set nes
→ Sets sprite to NES 54-color palette (indexed mode)

/pixel-palette optimize 16
→ Reduces sprite to optimal 16 colors

/pixel-palette set custom #000000,#ffffff,#ff0000,#00ff00,#0000ff
→ Sets custom 5-color palette

/pixel-palette show
→ Displays current palette colors

/pixel-palette set pico8
→ Sets PICO-8 16-color palette
```

### Palette Definitions

**NES Palette (54 colors):**
```
#7C7C7C, #0000FC, #0000BC, #4428BC, #940084, #A80020, #A81000, #881400,
#503000, #007800, #006800, #005800, #004058, #000000, #000000, #000000,
#BCBCBC, #0078F8, #0058F8, #6844FC, #D800CC, #E40058, #F83800, #E45C10,
#AC7C00, #00B800, #00A800, #00A844, #008888, #000000, #000000, #000000,
#F8F8F8, #3CBCFC, #6888FC, #9878F8, #F878F8, #F85898, #F87858, #FCA044,
#F8B800, #B8F818, #58D854, #58F898, #00E8D8, #787878, #000000, #000000,
#FCFCFC, #A4E4FC, #B8B8F8, #D8B8F8, #F8B8F8, #F8A4C0, #F0D0B0, #FCE0A8,
#F8D878, #D8F878, #B8F8B8, #B8F8D8, #00FCFC, #F8D8F8, #000000, #000000
```

**Game Boy Palette:**
```
#0f380f (darkest green)
#306230 (dark green)
#8bac0f (light green)
#9bbc0f (lightest green)
```

**PICO-8 Palette:**
```
#000000, #1D2B53, #7E2553, #008751, #AB5236, #5F574F, #C2C3C7, #FFF1E8,
#FF004D, #FFA300, #FFEC27, #00E436, #29ADFF, #83769C, #FF77A8, #FFCCAA
```

**DawnBringer 16:**
```
#140c1c, #442434, #30346d, #4e4a4e, #854c30, #346524, #d04648, #757161,
#597dce, #d27d2c, #8595a1, #6daa2c, #d2aa99, #6dc2ca, #dad45e, #deeed6
```

**DawnBringer 32:**
```
#000000, #222034, #45283c, #663931, #8f563b, #df7126, #d9a066, #eec39a,
#fbf236, #99e550, #6abe30, #37946e, #4b692f, #524b24, #323c39, #3f3f74,
#306082, #5b6ee1, #639bff, #5fcde4, #cbdbfc, #ffffff, #9badb7, #847e87,
#696a6a, #595652, #76428a, #ac3232, #d95763, #d77bba, #8f974a, #8a6f30
```

### Implementation

Parse $ARGUMENTS to determine action:

**For "set" action:**
1. Check if argument is preset name
2. If preset, load predefined palette colors
3. If "custom", parse comma-separated hex colors
4. Use `mcp__aseprite__set_palette` with color array
5. Convert sprite to Indexed mode if needed
6. Confirm palette set

**For "optimize" action:**
1. Parse target color count from argument
2. Use `mcp__aseprite__quantize_colors` with count
3. Show before/after color counts
4. Confirm optimization

**For "show" action:**
1. Use `mcp__aseprite__get_palette`
2. Display colors in readable format (hex codes)
3. Show color count

**For "export" action:**
1. Get palette with `mcp__aseprite__get_palette`
2. Format as .gpl (GIMP Palette) or .pal file
3. Write to specified file path
4. Confirm export

### Notes

- Setting palette converts sprite to Indexed color mode
- Optimize action reduces colors while preserving visual quality
- Custom palettes: comma-separated hex colors (#RRGGBB)
- Palette files use .gpl (GIMP) or .pal (Adobe) format
- Maximum 256 colors for indexed mode
```

---

### Verification Steps

```bash
# 1. Verify file created
ls -la commands/pixel-palette.md

# 2. Check frontmatter
head -n 5 commands/pixel-palette.md

# 3. Verify allowed-tools
grep "allowed-tools:" commands/pixel-palette.md

# Should include palette management tools

# 4. Check file size
wc -l commands/pixel-palette.md

# Should be 150-250 lines
```

### Git Commit

```bash
git add commands/pixel-palette.md
git commit -m "feat(commands): add /pixel-palette command

- Create pixel-palette.md slash command
- Add palette presets (NES, Game Boy, C64, PICO-8, DB16, DB32)
- Support set, optimize, show, export actions
- Include custom palette support
- Document retro console and modern palettes

Chunk: 4.2"
```

### Success Criteria

- [ ] `commands/pixel-palette.md` created
- [ ] YAML frontmatter with description and argument-hint
- [ ] Actions documented (set, optimize, show, export)
- [ ] Palette presets defined with color values
- [ ] Usage examples provided
- [ ] Implementation instructions clear
- [ ] Verification steps pass
- [ ] Git commit with "Chunk: 4.2" footer

---

### Chunk 4.3: Create /pixel-export command

**Objective**: Implement the /pixel-export slash command for quick sprite export in various formats.

**Files to Create**:
1. `commands/pixel-export.md`

---

#### File: `commands/pixel-export.md`

```markdown
---
description: Export sprite to PNG, GIF, or spritesheet with optional scaling
argument-hint: <format> [output-file] [options]
allowed-tools: Read, Bash, mcp__aseprite__export_png, mcp__aseprite__export_gif, mcp__aseprite__export_spritesheet, mcp__aseprite__get_sprite_info
---

## /pixel-export - Quick Export

Export sprites in various formats with optional scaling and layout options.

### Usage

```
/pixel-export <format> [output-file] [options]
```

### Formats

**png** - Export single frame as PNG
```
/pixel-export png sprite.png
/pixel-export png sprite.png scale=2
```

**gif** - Export animation as GIF
```
/pixel-export gif animation.gif
/pixel-export gif animation.gif fps=10
```

**sheet** - Export spritesheet
```
/pixel-export sheet spritesheet.png
/pixel-export sheet spritesheet.png layout=horizontal
```

**json** - Export with JSON metadata
```
/pixel-export json sprite.json
/pixel-export json sprite.json format=aseprite
```

### Options

**Common Options:**
- `scale=N` - Scale output by N (1, 2, 4, 8) using nearest-neighbor
- `transparent` - Preserve transparency (default: true)
- `background=#RRGGBB` - Set background color (default: transparent)

**GIF Options:**
- `fps=N` - Frames per second (default: 10)
- `loop=N` - Loop count (0 = infinite, default: 0)
- `optimize` - Optimize GIF file size (default: true)

**Spritesheet Options:**
- `layout=horizontal|vertical|grid|packed` - Layout style (default: horizontal)
- `padding=N` - Pixels between frames (default: 0)
- `trim` - Trim transparent edges (default: false)

**JSON Options:**
- `format=aseprite|texturepacker|unity|godot` - Metadata format (default: aseprite)
- `include-layers` - Include layer information (default: false)

### Examples

```
/pixel-export png output.png
→ Exports current frame as PNG (1x scale)

/pixel-export png output.png scale=4
→ Exports at 4x scale (pixel-perfect)

/pixel-export gif animation.gif fps=12
→ Exports animation as GIF at 12 FPS

/pixel-export sheet spritesheet.png layout=grid
→ Exports frames in grid layout

/pixel-export json sprite.json format=unity
→ Exports with Unity-compatible JSON metadata

/pixel-export png sprite.png scale=2 background=#ffffff
→ Exports at 2x scale with white background
```

### Layout Styles

**horizontal** - All frames in a single row
```
[Frame1][Frame2][Frame3][Frame4]
```

**vertical** - All frames in a single column
```
[Frame1]
[Frame2]
[Frame3]
[Frame4]
```

**grid** - Frames arranged in grid (optimal rows/columns)
```
[Frame1][Frame2][Frame3]
[Frame4][Frame5][Frame6]
[Frame7][Frame8][Frame9]
```

**packed** - Optimal space usage (may vary dimensions)
```
[Frame1][Frame2][Frame5]
[Frame3][Frame4][Frame6]
```

### JSON Metadata Formats

**Aseprite Format:**
```json
{
  "frames": [
    {
      "filename": "sprite_0.png",
      "frame": {"x": 0, "y": 0, "w": 32, "h": 32},
      "duration": 100
    }
  ],
  "meta": {
    "image": "spritesheet.png",
    "size": {"w": 128, "h": 32},
    "scale": "1"
  }
}
```

**TexturePacker Format:**
```json
{
  "frames": {
    "sprite_0.png": {
      "frame": {"x": 0, "y": 0, "w": 32, "h": 32},
      "sourceSize": {"w": 32, "h": 32}
    }
  }
}
```

**Unity Format:**
```json
{
  "sprites": [
    {
      "name": "sprite_0",
      "rect": {"x": 0, "y": 0, "width": 32, "height": 32},
      "pivot": {"x": 0.5, "y": 0.5}
    }
  ]
}
```

**Godot Format:**
```json
{
  "frames": [
    {
      "name": "sprite_0",
      "region": {"x": 0, "y": 0, "w": 32, "h": 32}
    }
  ]
}
```

### Implementation

Parse $ARGUMENTS:
1. Extract format (first argument)
2. Extract output file path (second argument, or auto-generate)
3. Parse options (key=value pairs)

**For PNG export:**
1. Use `mcp__aseprite__export_png`
2. Apply scale option if specified
3. Set background or transparency
4. Confirm export with file path

**For GIF export:**
1. Use `mcp__aseprite__export_gif`
2. Set frame duration based on fps option
3. Apply loop count
4. Optimize if requested
5. Confirm export

**For Spritesheet export:**
1. Use `mcp__aseprite__export_spritesheet`
2. Apply layout option
3. Set padding between frames
4. Optionally trim transparent edges
5. Confirm export

**For JSON export:**
1. Export spritesheet image
2. Generate JSON metadata in specified format
3. Include sprite positions, dimensions, timing
4. Write JSON file alongside image
5. Confirm both files created

### Default Behavior

If output file not specified:
- PNG: `sprite.png`
- GIF: `animation.gif`
- Spritesheet: `spritesheet.png`
- JSON: `sprite.json` + `sprite.png`

Output files saved to current working directory or user-specified path.

### Notes

- Scaling uses nearest-neighbor to preserve pixel art look
- GIF optimization reduces file size without quality loss
- JSON metadata helps game engines load sprites correctly
- Spritesheet layouts optimize for different use cases
- Transparent backgrounds preserved by default
```

---

### Verification Steps

```bash
# 1. Verify file created
ls -la commands/pixel-export.md

# 2. Check frontmatter
head -n 5 commands/pixel-export.md

# 3. Verify allowed-tools
grep "allowed-tools:" commands/pixel-export.md

# Should include export tools

# 4. Check file size
wc -l commands/pixel-export.md

# Should be 200-300 lines
```

### Git Commit

```bash
git add commands/pixel-export.md
git commit -m "feat(commands): add /pixel-export command

- Create pixel-export.md slash command
- Support PNG, GIF, spritesheet, JSON formats
- Add layout options (horizontal, vertical, grid, packed)
- Include scaling and optimization options
- Document JSON metadata formats (Aseprite, TexturePacker, Unity, Godot)
- Provide comprehensive usage examples

Chunk: 4.3"
```

### Success Criteria

- [ ] `commands/pixel-export.md` created
- [ ] YAML frontmatter with description and argument-hint
- [ ] All export formats documented (PNG, GIF, sheet, JSON)
- [ ] Options clearly explained
- [ ] Layout styles documented with visual examples
- [ ] JSON metadata formats specified
- [ ] Usage examples provided
- [ ] Verification steps pass
- [ ] Git commit with "Chunk: 4.3" footer

---

### Chunk 4.4: Create /pixel-setup command

**Objective**: Implement the /pixel-setup slash command for initial plugin configuration.

**Files to Create**:
1. `commands/pixel-setup.md`

---

#### File: `commands/pixel-setup.md`

```markdown
---
description: Configure aseprite-mcp server and verify Aseprite installation
argument-hint: [aseprite-path]
allowed-tools: Read, Write, Bash
---

## /pixel-setup - Plugin Configuration

Configure the aseprite-mcp server and verify Aseprite installation.

### Usage

```
/pixel-setup [aseprite-path]
```

### Arguments

**aseprite-path** (optional): Path to Aseprite executable
- If not provided, attempts auto-detection
- If detection fails, prompts user for path

### What This Command Does

1. **Detects Aseprite installation**
   - Searches common installation paths for current platform
   - macOS: `/Applications/Aseprite.app/Contents/MacOS/aseprite`
   - Linux: `/usr/bin/aseprite`, `/usr/local/bin/aseprite`
   - Windows: `C:\Program Files\Aseprite\Aseprite.exe`

2. **Creates configuration file**
   - Generates `~/.config/aseprite-mcp/config.json` (macOS/Linux)
   - Generates `%APPDATA%\aseprite-mcp\config.json` (Windows)
   - Sets `aseprite_path` in configuration

3. **Validates configuration**
   - Tests that Aseprite executable exists and is executable
   - Verifies aseprite-mcp can communicate with Aseprite
   - Reports version information

4. **Tests MCP server**
   - Runs health check on aseprite-mcp server
   - Confirms tools are accessible
   - Reports success or errors

### Examples

```
/pixel-setup
→ Auto-detects Aseprite installation and configures

/pixel-setup /Applications/Aseprite.app/Contents/MacOS/aseprite
→ Uses specified path for macOS

/pixel-setup "C:\Program Files\Aseprite\Aseprite.exe"
→ Uses specified path for Windows

/pixel-setup /usr/local/bin/aseprite
→ Uses specified path for Linux
```

### Auto-Detection Paths

**macOS:**
- `/Applications/Aseprite.app/Contents/MacOS/aseprite`
- `$HOME/Applications/Aseprite.app/Contents/MacOS/aseprite`
- `/usr/local/bin/aseprite`
- `$HOME/.local/bin/aseprite`

**Linux:**
- `/usr/bin/aseprite`
- `/usr/local/bin/aseprite`
- `$HOME/.local/bin/aseprite`
- `$HOME/bin/aseprite`
- `/opt/aseprite/bin/aseprite`
- `/snap/bin/aseprite`

**Windows:**
- `C:\Program Files\Aseprite\Aseprite.exe`
- `C:\Program Files (x86)\Aseprite\Aseprite.exe`
- `%LOCALAPPDATA%\Aseprite\Aseprite.exe`
- `%USERPROFILE%\AppData\Local\Aseprite\Aseprite.exe`

### Configuration File Format

**Location:**
- macOS/Linux: `~/.config/aseprite-mcp/config.json`
- Windows: `%APPDATA%\aseprite-mcp\config.json`

**Contents:**
```json
{
  "aseprite_path": "/path/to/aseprite",
  "temp_dir": "/tmp/aseprite-mcp",
  "timeout": 30,
  "log_level": "info",
  "log_file": "",
  "enable_timing": false
}
```

**Required Field:**
- `aseprite_path`: Path to Aseprite executable (only required field)

**Optional Fields:**
- `temp_dir`: Temporary directory for MCP operations (default: system temp)
- `timeout`: Command timeout in seconds (default: 30)
- `log_level`: Logging level: "debug", "info", "warn", "error" (default: "info")
- `log_file`: Path to log file (default: "" = no file logging)
- `enable_timing`: Log operation timings for performance analysis (default: false)

### Implementation

**Step 1: Auto-Detection**
1. Check if aseprite-path argument provided
2. If not, run detection script: `config/detect-aseprite.sh`
3. Detection script checks common paths for current OS
4. If found, use detected path; if not, prompt user for path

**Step 2: Validate Path**
1. Check if file exists at specified path
2. Check if file is executable
3. Optionally run `aseprite --version` to verify

**Step 3: Create Configuration**
1. Determine config directory based on OS
2. Create directory if it doesn't exist: `mkdir -p ~/.config/aseprite-mcp`
3. Write config.json with aseprite_path and defaults
4. Set appropriate permissions (readable/writable by user)

**Step 4: Test MCP Server**
1. Run health check: `${CLAUDE_PLUGIN_ROOT}/bin/aseprite-mcp --health`
2. Capture output and check for success
3. Report Aseprite version and MCP status

**Step 5: Report Results**
1. Display configuration summary
2. Show config file location
3. Show Aseprite path
4. Confirm MCP server is ready
5. Provide next steps or troubleshooting if failed

### Success Output

```
✓ Aseprite detected at: /Applications/Aseprite.app/Contents/MacOS/aseprite
✓ Configuration created: ~/.config/aseprite-mcp/config.json
✓ Aseprite version: v1.3.2
✓ MCP server ready

Plugin setup complete! You can now create pixel art with commands like:
  /pixel-new
  /pixel-palette set nes
```

### Error Handling

**Aseprite not found:**
```
✗ Aseprite not found in common installation paths

Please install Aseprite from: https://www.aseprite.org/
Or specify the path manually: /pixel-setup /path/to/aseprite
```

**Invalid path provided:**
```
✗ Aseprite not found at: /invalid/path

Please check the path and try again, or run /pixel-setup without arguments for auto-detection.
```

**Permission errors:**
```
✗ Cannot create configuration directory: ~/.config/aseprite-mcp
  Permission denied

Please check directory permissions or run with appropriate privileges.
```

**MCP server health check failed:**
```
✗ MCP server health check failed
  Error: [error details]

Please check that:
  1. Aseprite path is correct
  2. Aseprite is executable
  3. aseprite-mcp binary has execute permissions
```

### Troubleshooting Tips

Include in output if errors occur:

1. **Verify Aseprite is installed**: https://www.aseprite.org/
2. **Check aseprite-mcp binary permissions**: `chmod +x ${CLAUDE_PLUGIN_ROOT}/bin/aseprite-mcp`
3. **Manually edit config**: Edit `~/.config/aseprite-mcp/config.json`
4. **Test Aseprite directly**: Run `aseprite --version` in terminal
5. **Check logs**: Set `log_file` in config for debugging

### Notes

- Setup only needs to be run once
- Re-run if Aseprite installation path changes
- Configuration persists across Claude Code sessions
- Can manually edit config.json if needed
- Health check verifies MCP server can communicate with Aseprite
```

---

### Verification Steps

```bash
# 1. Verify file created
ls -la commands/pixel-setup.md

# 2. Check frontmatter
head -n 5 commands/pixel-setup.md

# 3. Verify allowed-tools
grep "allowed-tools:" commands/pixel-setup.md

# Should include Read, Write, Bash

# 4. Check file size
wc -l commands/pixel-setup.md

# Should be 200-300 lines
```

### Git Commit

```bash
git add commands/pixel-setup.md
git commit -m "feat(commands): add /pixel-setup command

- Create pixel-setup.md configuration command
- Add auto-detection for Aseprite installation
- Support manual path specification
- Create and validate configuration file
- Test MCP server health
- Include comprehensive error handling and troubleshooting
- Document config file format and options

Chunk: 4.4"
```

### Success Criteria

- [ ] `commands/pixel-setup.md` created
- [ ] YAML frontmatter with description and argument-hint
- [ ] Auto-detection logic documented
- [ ] Configuration file format specified
- [ ] Error handling scenarios covered
- [ ] Troubleshooting tips included
- [ ] Platform-specific paths documented
- [ ] Verification steps pass
- [ ] Git commit with "Chunk: 4.4" footer

---

### Chunk 4.5: Create /pixel-help command

**Objective**: Implement the /pixel-help slash command for displaying plugin usage and available commands.

**Files to Create**:
1. `commands/pixel-help.md`

---

#### File: `commands/pixel-help.md`

```markdown
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
```

---

### Verification Steps

```bash
# 1. Verify file created
ls -la commands/pixel-help.md

# 2. Check frontmatter
head -n 5 commands/pixel-help.md

# 3. Verify allowed-tools
grep "allowed-tools:" commands/pixel-help.md

# Should include Read, Bash

# 4. Check file size
wc -l commands/pixel-help.md

# Should be 250-350 lines
```

### Git Commit

```bash
git add commands/pixel-help.md
git commit -m "feat(commands): add /pixel-help command

- Create pixel-help.md help system command
- Add general overview and command list
- Include topic-specific help (palettes, export, animation, shortcuts)
- Provide common workflow examples
- Support command-specific help display
- Document all available commands and skills

Chunk: 4.5"
```

### Success Criteria

- [ ] `commands/pixel-help.md` created
- [ ] YAML frontmatter with description and argument-hint
- [ ] General help output documented
- [ ] Topic-specific help sections included
- [ ] Command lookup logic specified
- [ ] Common workflows documented
- [ ] Usage examples provided
- [ ] Verification steps pass
- [ ] Git commit with "Chunk: 4.5" footer

---

**End of Part 3**

Continue to IMPLEMENTATION_GUIDE_PART4.md for Phase 5 (Advanced Skills).
