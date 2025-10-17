# Pixel Art Creator - Technical Reference

## Color Mode Reference

### RGB Mode
- **Bits Per Pixel**: 24-bit (8 bits each for R, G, B)
- **Color Range**: 16,777,216 colors (256^3)
- **Use Cases**: Modern pixel art, unrestricted color palettes, photorealistic pixel art
- **Advantages**: No color limitations, easy to work with
- **Disadvantages**: Larger file sizes, not authentic to retro aesthetics

### Grayscale Mode
- **Bits Per Pixel**: 8-bit
- **Color Range**: 256 shades of gray (black to white)
- **Use Cases**: Monochrome art, vintage aesthetics, contrast studies
- **Advantages**: Simpler color management, smaller file sizes
- **Disadvantages**: No color information

### Indexed Mode
- **Bits Per Pixel**: 1-8 bit (depending on palette size)
- **Color Range**: 1-256 colors from defined palette
- **Use Cases**: Retro game art, limited palette challenges, authentic vintage look
- **Advantages**: Authentic retro aesthetic, enforced color constraints, smaller file sizes
- **Disadvantages**: Must define palette first, color substitution required

## Common Sprite Dimensions

### Game Console Standards

**Nintendo Entertainment System (NES)**
- Sprites: 8x8, 8x16 pixels
- Screen: 256x240 pixels
- Palette: 54 colors available, 4 colors per sprite

**Game Boy**
- Sprites: 8x8, 8x16 pixels
- Screen: 160x144 pixels
- Palette: 4 shades of green/gray

**Super Nintendo (SNES)**
- Sprites: 8x8 to 64x64 pixels (various sizes)
- Screen: 256x224 pixels
- Palette: 256 colors available, 15 colors per sprite

**Sega Genesis**
- Sprites: 8x8 to 32x32 pixels
- Screen: 320x224 pixels
- Palette: 512 colors available, 15 colors per sprite

### Modern Standards

**Mobile Icons**
- 16x16, 24x24, 32x32, 48x48, 64x64, 128x128

**Game Characters**
- Small: 32x32, 48x48
- Medium: 64x64, 96x96
- Large: 128x128, 256x256

**Tiles/Blocks**
- Standard: 16x16, 32x32
- Large: 64x64, 128x128

## Drawing Coordinate System

```
(0,0) ────────────► X
  │
  │
  │
  │
  ▼
  Y

Canvas Bounds:
- Top-Left: (0, 0)
- Top-Right: (width-1, 0)
- Bottom-Left: (0, height-1)
- Bottom-Right: (width-1, height-1)
```

## Color Format Specifications

### Hexadecimal Colors
Format: `#RRGGBB`
- RR: Red component (00-FF)
- GG: Green component (00-FF)
- BB: Blue component (00-FF)

Examples:
- Red: #FF0000
- Green: #00FF00
- Blue: #0000FF
- Cyan: #00FFFF
- Magenta: #FF00FF
- Yellow: #FFFF00
- Black: #000000
- White: #FFFFFF

### RGB Values
Format: (R, G, B)
- R: 0-255
- G: 0-255
- B: 0-255

Examples:
- Red: (255, 0, 0)
- Green: (0, 255, 0)
- Blue: (0, 0, 255)

## Tool Usage Patterns

### Batch Pixel Drawing
When drawing many pixels, batch them:

```
Good (batched):
draw_pixels([
  {x: 10, y: 10, color: "#FF0000"},
  {x: 11, y: 10, color: "#FF0000"},
  {x: 12, y: 10, color: "#FF0000"}
])

Less Efficient (individual):
draw_pixels({x: 10, y: 10, color: "#FF0000"})
draw_pixels({x: 11, y: 10, color: "#FF0000"})
draw_pixels({x: 12, y: 10, color: "#FF0000"})
```

### Shape Drawing Best Practices

**Rectangles:**
- Use for backgrounds, platforms, UI elements
- Filled mode: solid blocks
- Outline mode: frames, borders

**Circles:**
- Use for round objects, planets, bubbles
- Filled mode: solid circles
- Outline mode: rings, hoops

**Lines:**
- Use for edges, connections, rays
- Diagonal lines may have pixel stepping (antialiasing in professional Skill)

**Contours:**
- Use for irregular shapes, terrain, complex outlines
- Connect points in order
- Closed polygon: last point connects to first

## Performance Guidelines

### Operation Speeds (typical)
- Create canvas: <50ms
- Add layer: <20ms
- Draw pixels (batch of 100): <50ms
- Draw rectangle: <30ms
- Draw circle: <40ms
- Fill area: <100ms (depends on area size)

### Optimization Tips
1. Batch pixel operations when drawing many pixels
2. Use shapes instead of pixels when possible (faster)
3. Fill areas instead of drawing individual pixels
4. Use layers to organize work (not for performance, but workflow)

## Palette Examples

### Game Boy (4 colors)
```json
["#0F380F", "#306230", "#8BAC0F", "#9BBC0F"]
```
Darkest to lightest green

### NES (simplified 16-color palette)
```json
[
  "#000000", "#FCFCFC", "#F8F8F8", "#BCBCBC",
  "#7C7C7C", "#A4E4FC", "#3CBCFC", "#0078F8",
  "#0000FC", "#B8B8F8", "#6888FC", "#0058F8",
  "#0000BC", "#D8B8F8", "#9878F8", "#6844FC"
]
```

### Pico-8 (16-color palette)
```json
[
  "#000000", "#1D2B53", "#7E2553", "#008751",
  "#AB5236", "#5F574F", "#C2C3C7", "#FFF1E8",
  "#FF004D", "#FFA300", "#FFEC27", "#00E436",
  "#29ADFF", "#83769C", "#FF77A8", "#FFCCAA"
]
```

### C64 (Commodore 64, 16 colors)
```json
[
  "#000000", "#FFFFFF", "#880000", "#AAFFEE",
  "#CC44CC", "#00CC55", "#0000AA", "#EEEE77",
  "#DD8855", "#664400", "#FF7777", "#333333",
  "#777777", "#AAFF66", "#0088FF", "#BBBBBB"
]
```

## Layer Naming Conventions

**Descriptive Names:**
- "Background" - solid color or pattern behind main subject
- "Character" - main subject or character
- "Foreground" - objects in front of character
- "Effects" - highlights, shadows, particles
- "Outline" - borders or edge highlights
- "Details" - fine details, accessories

**Organization Tips:**
- Use consistent naming across projects
- Name layers by content, not by color
- Keep names short but descriptive
- Use layers even for simple sprites (good habit)

## Common Patterns

### Pixelated Circle (Manual)
For precise pixel placement in a circle:
- Radius 4: 5x5 bounding box, 13 pixels
- Radius 8: 9x9 bounding box, 57 pixels
- Use symmetry: draw quadrant, mirror to others

### Pixelated Line (Manual)
Bresenham's line algorithm (built into draw_line):
- Minimizes pixel stepping
- Creates clean diagonal lines
- No gaps or overlaps

### Color Ramps (Shading)
For smooth color transitions:
- 3-color ramp: shadow, base, highlight
- 5-color ramp: darkest, dark, base, light, lightest
- Use analogous colors for smooth transitions
