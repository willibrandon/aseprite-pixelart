# Commands

This directory contains slash commands that users invoke directly in Claude Code.

## Available Commands

### /pixel-new
Create a new pixel art sprite with optional size and palette presets.

**Usage:** `/pixel-new [size] [palette]`

**Size presets:**
- `icon` - 32x32
- `small` - 48x48
- `medium` - 64x64 (default)
- `large` - 128x128
- `tile` - 16x16
- `gameboy` - 160x144
- `nes` - 256x240

**Palette presets:**
- `retro` - 16-color generic palette
- `nes` - 54-color NES palette
- `gameboy` - 4-color Game Boy palette
- `c64` - 16-color Commodore 64 palette
- `cga` - 4-color CGA palette
- `snes` - 256-color SNES palette

**Examples:**
```
/pixel-new
/pixel-new icon
/pixel-new 128x128 nes
/pixel-new gameboy gameboy
```

### /pixel-palette
Manage sprite color palettes.

**Usage:** `/pixel-palette <action> [args]`

**Actions:**
- `set <preset>` - Apply a preset palette
- `optimize <colors>` - Reduce palette to N colors
- `show` - Display current palette
- `export <file>` - Save palette to file

**Examples:**
```
/pixel-palette set nes
/pixel-palette optimize 16
/pixel-palette show
/pixel-palette export my-palette.pal
```

### /pixel-export
Export sprite to various formats.

**Usage:** `/pixel-export <format> [file] [options]`

**Formats:**
- `png` - Single frame PNG
- `gif` - Animated GIF
- `sheet` - Spritesheet
- `json` - Metadata file

**Options:**
- `scale=N` - Pixel-perfect scaling (1, 2, 4, 8)
- `fps=N` - Frame rate for GIF
- `layout=type` - Spritesheet layout (horizontal, vertical, grid, packed)
- `format=type` - JSON format (aseprite, unity, godot, phaser)

**Examples:**
```
/pixel-export png sprite.png
/pixel-export gif animation.gif fps=12
/pixel-export sheet characters.png layout=grid
/pixel-export png icon.png scale=4
```

### /pixel-setup
Configure the Aseprite MCP server.

**Usage:** `/pixel-setup [path]`

Auto-detects Aseprite installation or accepts manual path.

**Platform paths:**
- macOS: `/Applications/Aseprite.app/Contents/MacOS/aseprite`
- Linux: `/usr/bin/aseprite`
- Windows: `C:\Program Files\Aseprite\Aseprite.exe`

**Examples:**
```
/pixel-setup
/pixel-setup /usr/local/bin/aseprite
```

### /pixel-help
Display help information.

**Usage:** `/pixel-help [topic]`

**Topics:**
- `palettes` - Available color palettes
- `export` - Export formats and options
- `animation` - Animation features
- `shortcuts` - Common workflows

**Examples:**
```
/pixel-help
/pixel-help palettes
/pixel-help export
```

## Command Structure

Each command is a markdown file with YAML frontmatter:

```yaml
---
description: Brief description shown in /help
argument-hint: [arg1] [arg2]
allowed-tools: Tool1, Tool2, mcp__aseprite__*
---
```

Commands use `$ARGUMENTS` to access user input and can execute MCP tools to interact with Aseprite.

## MCP Tools Used

Commands use these aseprite-mcp tools:
- `mcp__aseprite__create_canvas` - Create new sprites
- `mcp__aseprite__set_palette` - Set color palettes
- `mcp__aseprite__export_sprite` - Export to files
- `mcp__aseprite__get_sprite_info` - Query sprite properties

See the aseprite-mcp documentation for the full list of available tools.
