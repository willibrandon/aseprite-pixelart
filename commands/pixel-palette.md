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

**Commodore 64 Palette:**
```
#000000 (black), #ffffff (white), #880000 (red), #aaffee (cyan),
#cc44cc (purple), #00cc55 (green), #0000aa (blue), #eeee77 (yellow),
#dd8855 (orange), #664400 (brown), #ff7777 (light red), #333333 (dark gray),
#777777 (gray), #aaff66 (light green), #0088ff (light blue), #bbbbbb (light gray)
```

**CGA Palette:**
```
#000000 (black), #00aaaa (cyan), #aa00aa (magenta), #aaaaaa (white)
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

### GIMP Palette Format (.gpl)

```
GIMP Palette
Name: My Palette
Columns: 4
#
0   0   0   Black
255 255 255 White
255 0   0   Red
```

### Validation

**For set action:**
- Validate preset name exists
- For custom, validate hex color format (#RRGGBB)
- Ensure palette fits indexed mode limits (max 256 colors)

**For optimize action:**
- Target color count must be 2-256
- Cannot optimize blank/empty sprites

**For export action:**
- Validate file path and permissions
- Ensure output directory exists

### Error Handling

**Invalid action:**
```
Invalid action. Use: set, optimize, show, or export
```

**Invalid preset:**
```
Unknown palette preset: xyz
Available: nes, gameboy, c64, pico8, db16, db32, etc.
```

**Optimization failed:**
```
Cannot optimize: sprite has no content or target color count invalid (2-256)
```

**Export failed:**
```
Cannot export palette to: /path/file.gpl
Check path and permissions.
```

### Notes

- Setting palette converts sprite to Indexed color mode
- Optimize action reduces colors while preserving visual quality
- Custom palettes: comma-separated hex colors (#RRGGBB)
- Palette files use .gpl (GIMP) or .pal (Adobe) format
- Maximum 256 colors for indexed mode
- Show action displays colors in grid format
- Export creates portable palette files

### Tips

**For retro authenticity:**
- Use NES palette with 4-color limit per sprite
- Use Game Boy palette for monochrome green aesthetic
- Use PICO-8 for modern retro/fantasy console look

**For optimization:**
- Start with high color count (64+)
- Gradually reduce with optimize action
- Use quantization before dithering for best results

**For custom palettes:**
- Start with base colors you need
- Add shade variations (darker/lighter)
- Keep count even for better organization
- Test palette on actual sprite content
