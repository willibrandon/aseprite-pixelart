# Pixel Art Professional - Technical Reference

## Dithering Algorithms

### Ordered Dithering (Bayer Matrix)

**Bayer 2x2 Matrix:**
```
0/4  2/4
3/4  1/4
```

**Bayer 4x4 Matrix:**
```
 0/16  8/16  2/16 10/16
12/16  4/16 14/16  6/16
 3/16 11/16  1/16  9/16
15/16  7/16 13/16  5/16
```

**Bayer 8x8 Matrix:**
```
 0 32  8 40  2 34 10 42
48 16 56 24 50 18 58 26
12 44  4 36 14 46  6 38
60 28 52 20 62 30 54 22
 3 35 11 43  1 33  9 41
51 19 59 27 49 17 57 25
15 47  7 39 13 45  5 37
63 31 55 23 61 29 53 21
```

**Usage**: For pixel at (x, y) with color value C (0-255):
1. Get threshold T from matrix[y % size][x % size]
2. If C > T, use lighter color; else use darker color

### Error Diffusion Dithering

**Floyd-Steinberg Algorithm:**

Distributes quantization error to neighboring pixels:
```
        X   7/16
3/16  5/16  1/16
```

Where X is current pixel.

**Process:**
1. Quantize current pixel to nearest palette color
2. Calculate error = original_color - quantized_color
3. Distribute error to neighbors:
   - Right pixel: error × 7/16
   - Bottom-left: error × 3/16
   - Bottom: error × 5/16
   - Bottom-right: error × 1/16

**Jarvis-Judice-Ninke Algorithm:**

More distributed error diffusion:
```
          X   7/16  5/16
3/16  5/16  7/16  5/16  3/16
1/16  3/16  5/16  3/16  1/16
```

**Atkinson Algorithm:**

Simplified error diffusion (popularized by Apple):
```
      X  1/8  1/8
1/8  1/8  1/8
     1/8
```

Note: Only distributes 6/8 of error, allows some to "bleed off" for lighter appearance.

## Color Ramp Theory

### Creating Smooth Ramps

**5-Step Ramp Example (Skin Tone):**
1. **Deep Shadow**: #3a2419 (dark brown, shifted toward cool)
2. **Shadow**: #5c3a28 (brown)
3. **Base/Midtone**: #8d5a3e (medium brown)
4. **Highlight**: #b8825c (light brown, shifted toward warm)
5. **Bright Highlight**: #e6b896 (very light, warm)

**Hue Shifting Pattern:**
- Deep shadow: Hue -10°, Saturation -10%, Value -40%
- Shadow: Hue -5°, Saturation -5%, Value -20%
- Base: Original color
- Highlight: Hue +5°, Saturation -5%, Value +20%
- Bright Highlight: Hue +10°, Saturation -10%, Value +40%

### Metal Shading

**Characteristics:**
- High contrast (very dark shadows, very bright highlights)
- Sharp transitions
- Reflected environment colors
- Minimal mid-tones

**Example Ramp (Steel):**
1. Deep Shadow: #1a1a24 (dark blue-gray)
2. Shadow: #3a3a4a (medium blue-gray)
3. Base: #6a6a7a (light blue-gray)
4. Highlight: #aaaabb (very light blue-gray)
5. Specular: #ffffff (pure white reflection)

### Fabric Shading

**Characteristics:**
- Soft transitions
- Subsurface scattering simulation (lighter shadows)
- Texture can be suggested with dithering
- Less contrast than metal

**Example Ramp (Red Fabric):**
1. Deep Shadow: #5a1a1a (dark red)
2. Shadow: #8a2a2a (medium-dark red)
3. Base: #c43a3a (medium red)
4. Highlight: #e66a6a (light red)
5. Bright Highlight: #ff9a9a (very light red)

## Classic Palettes

### NES Palette

**Total Colors**: 54 usable colors (64 total, but some are identical or unusable)

**Sprite Limitation**: 3 colors + transparent per sprite (4 total palette entries)

**Common NES Palettes:**
- **Mario**: #000000, #ff0000, #a64400, #ffc864
- **Megaman**: #000000, #0078f8, #89d7ff, #ffffff
- **Zelda Gold**: #000000, #b8b800, #fcfc00, #a8a080

### Game Boy Palette

**Original Game Boy (DMG):**
- 4 shades of green
- Palette: #0f380f, #306230, #8bac0f, #9bbc0f

**Game Boy Pocket (MGB):**
- 4 shades of gray
- Palette: #000000, #555555, #aaaaaa, #ffffff

### SNES Palette

**Capabilities**: 32,768 total colors (15-bit)
**Per Background**: 16-256 colors depending on mode
**Per Sprite**: 16 colors (15 + transparent)

**Common SNES Style:**
- Rich, vibrant colors
- Smooth gradients
- Up to 256 simultaneous colors on screen

### Commodore 64 Palette

**Total Colors**: 16 fixed colors

**Palette**:
- Black: #000000
- White: #ffffff
- Red: #880000
- Cyan: #aaffee
- Purple: #cc44cc
- Green: #00cc55
- Blue: #0000aa
- Yellow: #eeee77
- Orange: #dd8855
- Brown: #664400
- Light Red: #ff7777
- Dark Gray: #333333
- Medium Gray: #777777
- Light Green: #aaff66
- Light Blue: #0088ff
- Light Gray: #bbbbbb

## Antialiasing Techniques

### Single-Pixel AA

**Before:**
```
. . . . . .
. . X X X .
. X . . . .
X . . . . .
```

**After (with AA):**
```
. . . . . .
. . X X X .
. X a . . .
X a . . . .
```

Where:
- X = edge color
- . = background
- a = antialiased intermediate color

### Double-Pixel AA (Softer)

**Before:**
```
. . . . . .
. X X X X .
X . . . . .
```

**After:**
```
. . . a a .
. X X X X .
X a . . . .
```

### Selective AA

**Rule**: Only AA where necessary:
- Long diagonal lines
- Visible curves
- High-contrast edges

**Don't AA:**
- Horizontal/vertical lines (already smooth)
- Intentional jagged details
- Very small sprites

## Shading from Different Light Sources

### Top-Left Light (Most Common)

```
    ☀️
   ↙
[Sprite]
  ↘
   (shadow)
```

- Highlights: top and left surfaces
- Shadows: bottom and right surfaces

### Top-Down Light (Dramatic)

```
    ☀️
    ↓
[Sprite]
```

- Highlights: top surfaces
- Shadows: all vertical surfaces
- Strong cast shadows on ground

### Rim Lighting (Backlit)

```
[Sprite] ← ☀️
```

- Highlights: edges facing light
- Most of sprite in shadow
- Dramatic silhouette effect

### Multiple Light Sources

**Example: Fire + Moonlight**
- Fire (warm orange): bottom and left
- Moon (cool blue): top and right
- Mixing creates interesting color interplay

## Texture Suggestions with Dithering

### Stone/Rock Texture

Use irregular dithering pattern:
```
A A B A A B A
A B A A B A A
B A A B A A B
A A B A B A A
```

Mix 2-3 related gray/brown tones.

### Metal Texture

Use horizontal line dithering:
```
A A A A A A A
B B B B B B B
A A A A A A A
A A A A A A A
B B B B B B B
```

Creates brushed metal effect.

### Fabric Texture

Use soft checkerboard:
```
A A B A A B A
A A A A A A A
B A A B A A B
A A A A A A A
```

Suggests woven or cloth texture.

### Wood Grain

Use wavy vertical lines:
```
A B A A B A A
A A B A A B A
A B A A B A A
A A B A B A A
```

Suggests wood grain direction.

## Performance Benchmarks

**Color Quantization:**
- 64x64 sprite, 100 colors → 16 colors: ~150ms
- 128x128 sprite, 500 colors → 32 colors: ~400ms
- 256x256 sprite, 1000 colors → 64 colors: ~1200ms

**Dithering:**
- Floyd-Steinberg, 64x64: ~200ms
- Floyd-Steinberg, 128x128: ~600ms
- Bayer 4x4, 64x64: ~80ms
- Bayer 4x4, 128x128: ~250ms

**Manual Pixel Operations:**
- Drawing single pixel: <5ms
- Drawing 100 pixels (batch): ~20ms
- Palette update: ~15ms

## Common Mistakes and Fixes

### Mistake: Pillow Shading

**Problem**: Shading around edges instead of from light source.

**Looks Like:**
```
. . . X X X . .
. X x x x x X .
X x o o o o x X
X x o o o o x X
. X x x x x X .
. . . X X X . .
```

Where o = base, x = shadow, X = dark shadow (all around edge).

**Fix**: Shade from consistent light direction:
```
. . H H H X X .
. H h o o x X .
H h o o o o x X
H h o o o o x X
. H h x x x X .
. . H X X X . .
```

Where H = highlight, h = light, o = base, x = shadow, X = dark shadow (directional).

### Mistake: Pure Black Shadows

**Problem**: Using #000000 for shadows makes them look flat and dead.

**Fix**: Use dark version of base color with hue shift:
- Base: #ff6b6b (red)
- Bad shadow: #000000 (pure black)
- Good shadow: #5a1a1a (dark red with slight purple shift)

### Mistake: Banding in Gradients

**Problem**: Visible steps in gradients due to too few colors.

**Fix**: Apply dithering between color steps:
```
Bad:
AAAABBBBCCCCDDDD

Good (with dithering):
AAAAA/BBA/BB/CCB/CCC/DCD/DDDD
```

Where / represents dithered transition.

### Mistake: Over-Antialiasing

**Problem**: Too many AA pixels make edges blurry.

**Fix**: Use 1-pixel wide AA only where needed:
- Bad: 2-3 pixels of intermediate colors (blurry)
- Good: 1 pixel of intermediate color at steps only

## Color Harmony Examples

### Monochromatic (Blue)

```
#001f3f (dark blue)
#0074D9 (medium blue)
#7FDBFF (light blue)
#aef3ff (very light blue)
```

### Analogous (Red-Orange-Yellow)

```
#ff4136 (red)
#ff851b (orange)
#ffdc00 (yellow)
```

### Complementary (Blue-Orange)

```
#0074D9 (blue)
#ff851b (orange)
```

### Triadic (Red-Yellow-Blue)

```
#ff4136 (red)
#ffdc00 (yellow)
#0074D9 (blue)
```

### Split Complementary (Blue + Red-Orange + Yellow-Orange)

```
#0074D9 (blue)
#ff4136 (red-orange)
#ffdc00 (yellow-orange)
```
