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

### Scaling Details

**Nearest-Neighbor Algorithm:**
- Preserves sharp pixel art look
- No blur or antialiasing
- Each pixel becomes NxN pixels
- Essential for pixel art aesthetics

**Scale Factors:**
- `scale=1` - Original size
- `scale=2` - 2x size (common for HD displays)
- `scale=4` - 4x size (very large)
- `scale=8` - 8x size (maximum)

### GIF Optimization

**Optimization reduces file size by:**
- Using local color tables per frame
- Removing duplicate pixels
- Applying delta compression
- Optimizing frame disposal methods

**Benefits:**
- Smaller file sizes (often 30-50% reduction)
- Faster loading times
- Same visual quality
- No loss of colors or frames

### Spritesheet Use Cases

**Horizontal Layout:**
- Simple animation sequences
- Easy to visualize frame order
- Works well with sprite editors
- Good for walkthroughs and documentation

**Vertical Layout:**
- Saves horizontal space
- Good for tall sprites
- Similar benefits to horizontal

**Grid Layout:**
- Optimal space usage for many frames
- Square-ish output dimensions
- Easy to calculate frame positions
- Best for game engines

**Packed Layout:**
- Maximum space efficiency
- Variable frame sizes supported
- Requires JSON metadata for positions
- Advanced game engine feature

### JSON Metadata Usage

**Aseprite Format:**
- Native format, most detailed
- Includes frame timing
- Animation tag information
- Layer data (if requested)

**TexturePacker Format:**
- Industry standard
- Widely supported
- Works with many game frameworks
- Good for cross-platform projects

**Unity Format:**
- Direct Unity import
- Includes pivot points
- Sprite Atlas compatible
- C# scripts can parse directly

**Godot Format:**
- Godot Engine native format
- SpriteFrames resource compatible
- AnimatedSprite node ready
- GDScript friendly

### Error Handling

**No sprite open:**
```
Error: No sprite open. Create or open a sprite first.
```

**Invalid format:**
```
Error: Invalid format 'xyz'. Use: png, gif, sheet, or json
```

**Invalid scale:**
```
Error: Scale must be 1, 2, 4, or 8
```

**Export failed:**
```
Error: Cannot export to /path/file.png
Check path and permissions.
```

**Invalid layout:**
```
Error: Invalid layout 'xyz'. Use: horizontal, vertical, grid, or packed
```

### Tips

**For game development:**
- Use grid layout for balanced dimensions
- Export JSON metadata for frame data
- Scale by 2x or 4x for HD displays
- Use packed layout for optimal texture memory

**For web/social media:**
- Export GIF at 10-15 FPS for smooth playback
- Optimize GIF to reduce file size
- Use transparent background
- Scale by 2x for better visibility

**For print/high-res:**
- Scale by 4x or 8x
- Export PNG for lossless quality
- Use white background for printing
- Maintain aspect ratio

**For pixel art portfolios:**
- Export PNG at original size (1x)
- Show pixel-perfect version
- Also provide scaled versions
- Include spritesheet to show animation frames

### Notes

- Scaling uses nearest-neighbor to preserve pixel art look
- GIF optimization reduces file size without quality loss
- JSON metadata helps game engines load sprites correctly
- Spritesheet layouts optimize for different use cases
- Transparent backgrounds preserved by default
- All formats support frame-based animation
- Output path can be relative or absolute
- Files overwrite existing files without warning
