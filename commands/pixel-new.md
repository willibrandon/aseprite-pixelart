---
description: Create a new pixel art sprite with optional size and palette presets
argument-hint: [size] [palette]
allowed-tools: Read, Bash, mcp__aseprite__create_canvas, mcp__aseprite__set_palette
---

## /pixel-new - Quick Sprite Creation

Creates a new pixel art sprite with optional presets for size and palette.

### Usage

```
/pixel-new [size] [palette]
```

### Arguments

**size** (optional): Canvas dimensions or preset name
- Presets: icon, small, medium, large, tile, gameboy, nes
- Custom: WIDTHxHEIGHT (e.g., 64x64, 128x96)
- Default: 64x64

**palette** (optional): Color palette preset
- retro, nes, gameboy, c64, cga, snes, custom
- Default: RGB (no palette limit)

### Examples

```
/pixel-new
→ Creates 64x64 RGB canvas

/pixel-new icon
→ Creates 32x32 RGB canvas

/pixel-new gameboy gameboy
→ Creates 160x144 canvas with Game Boy 4-color palette

/pixel-new 128x128 nes
→ Creates 128x128 canvas with NES palette

/pixel-new tile retro
→ Creates 16x16 canvas with retro 16-color palette
```

### Size Presets

- **icon**: 32x32 (for icons, small sprites)
- **small**: 48x48 (characters, items)
- **medium**: 64x64 (default, versatile)
- **large**: 128x128 (detailed sprites, portraits)
- **tile**: 16x16 (tilemap tiles)
- **gameboy**: 160x144 (Game Boy screen resolution)
- **nes**: 256x240 (NES screen resolution)

### Palette Presets

- **retro**: 16-color palette (generic retro aesthetic)
- **nes**: 54-color NES palette
- **gameboy**: 4-color Game Boy palette (#0f380f, #306230, #8bac0f, #9bbc0f)
- **c64**: 16-color Commodore 64 palette
- **cga**: 4-color CGA palette
- **snes**: 256-color SNES-style palette
- **custom**: Prompts for custom palette colors

### Implementation

Parse arguments from $ARGUMENTS:
1. Extract size argument (first arg)
2. Extract palette argument (second arg)
3. Map size preset to dimensions or parse WxH
4. Create canvas with mcp__aseprite__create_canvas
5. If palette specified, set palette with mcp__aseprite__set_palette
6. Confirm creation with sprite info

### Size Preset Mapping

```
icon     → 32x32
small    → 48x48
medium   → 64x64
large    → 128x128
tile     → 16x16
gameboy  → 160x144
nes      → 256x240
```

### Palette Details

**retro** (16 colors):
- Generic retro palette with balanced colors
- Good for general pixel art without console constraints

**nes** (54 colors):
- Official NES/Famicom palette
- Use indexed color mode
- Typically limit to 4 colors per sprite for authenticity

**gameboy** (4 colors):
- #0f380f (darkest green)
- #306230 (dark green)
- #8bac0f (light green)
- #9bbc0f (lightest green)

**c64** (16 colors):
- Commodore 64 fixed palette
- Distinctive colors with high saturation

**cga** (4 colors):
- Classic IBM CGA palette
- High contrast, limited colors

**snes** (256 colors):
- SNES-style palette with rich colors
- Supports smooth gradients and detailed sprites

**custom**:
- Prompts user for custom colors
- Ask for number of colors and hex values

### Validation

**Size validation:**
- If preset name, map to dimensions
- If WxH format, parse width and height
- Ensure dimensions are 1-65535
- Reject invalid formats

**Palette validation:**
- Check if preset exists
- For custom, validate hex color format
- Ensure palette is appropriate for sprite size

### Error Handling

**Invalid size:**
- "Invalid size format. Use a preset (icon, small, medium, large, tile, gameboy, nes) or WIDTHxHEIGHT (e.g., 64x64)"

**Invalid palette:**
- "Invalid palette. Choose from: retro, nes, gameboy, c64, cga, snes, custom"

**Dimensions out of range:**
- "Dimensions must be between 1 and 65535 pixels"

**Canvas creation fails:**
- Report MCP error and suggest checking Aseprite configuration

### Notes

- If no arguments, create default 64x64 RGB canvas
- For retro palettes, use Indexed color mode
- For RGB mode, no palette needed
- Validate dimensions (1-65535)
- Provide helpful error messages for invalid input
- After creation, confirm canvas size and palette
- Use mcp__aseprite__get_sprite_info to verify creation

### Command Flow

1. Parse $ARGUMENTS into size and palette
2. If no size, use default (64x64)
3. Map size preset to dimensions or parse WxH
4. Validate dimensions
5. Call mcp__aseprite__create_canvas with dimensions
6. If palette specified:
   - Map palette preset to color list
   - Call mcp__aseprite__set_palette with colors
7. Get sprite info to confirm
8. Report success with canvas details

### Example Outputs

**Success with default:**
```
Created 64x64 RGB canvas.
Ready for pixel art creation!
```

**Success with presets:**
```
Created 160x144 canvas with Game Boy palette (4 colors).
Perfect for Game Boy-style sprites!
```

**Success with custom size and palette:**
```
Created 128x128 canvas with NES palette (54 colors).
Canvas ready with retro NES colors!
```
