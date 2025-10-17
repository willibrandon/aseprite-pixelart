# Aseprite Pixel Art Plugin - Implementation Guide (Part 2)

**Continuation of IMPLEMENTATION_GUIDE.md**

This document contains the remaining implementation chunks for the Aseprite Pixel Art Plugin.

- **Part 1**: Chunks 1.1-3.2 (Foundation, MCP Integration, Creator & Animator Skills)
- **Part 2** (This Document): Chunks 3.3-7.3 (Professional & Exporter Skills, Commands, Testing, Release)

---

## Phase 3: Core Skills Development (Continued)

### Chunk 3.3: Create pixel-art-professional Skill

**Objective**: Implement the pixel-art-professional Skill for advanced pixel art techniques including dithering, palette management, shading, and antialiasing.

**Files to Create**:
1. `skills/pixel-art-professional/SKILL.md`
2. `skills/pixel-art-professional/reference.md`
3. `skills/pixel-art-professional/dithering-patterns.md`

---

#### File 1: `skills/pixel-art-professional/SKILL.md`

```markdown
---
name: Pixel Art Professional
description: Apply advanced pixel art techniques including dithering, palette optimization, shading, antialiasing, and color theory. Use when the user mentions "dithering", "palette", "shading", "antialiasing", "smoothing", "color ramp", "gradients", or wants to refine/polish existing pixel art.
allowed-tools: Read, Bash, mcp__aseprite__get_sprite_info, mcp__aseprite__draw_pixels, mcp__aseprite__set_palette, mcp__aseprite__get_palette, mcp__aseprite__quantize_colors, mcp__aseprite__apply_dithering, mcp__aseprite__add_layer, mcp__aseprite__flatten_layers
---

# Pixel Art Professional

## Overview

This Skill provides advanced pixel art techniques for refining and polishing sprites. It handles dithering patterns, palette optimization, color theory, shading techniques, and antialiasing for professional-quality pixel art.

## When to Use

Use this Skill when the user:
- Wants to apply "dithering" or mentions dither patterns
- Asks about "palette optimization" or "color reduction"
- Mentions "shading", "highlights", "shadows", or "lighting"
- Requests "antialiasing", "smoothing", or "edge refinement"
- Talks about "color ramps", "gradients", or "color theory"
- Wants to "polish" or "refine" existing pixel art
- Mentions specific techniques like "Bayer dithering" or "Floyd-Steinberg"

**Trigger Keywords:** dithering, palette, shading, antialiasing, smooth, gradient, color ramp, polish, refine, color theory, quantize

## Instructions

### 1. Understanding Dithering

**Dithering** creates the illusion of additional colors by mixing pixels of available colors in patterns.

**When to Use Dithering:**
- Reducing color count (e.g., 256 colors → 16 colors)
- Creating smooth gradients with limited palettes
- Simulating textures (fabric, metal, stone)
- Retro aesthetic (classic games used dithering extensively)

**Dithering Algorithms:**

**Ordered Dithering (Bayer Matrix):**
- Uses fixed pattern matrix (2x2, 4x4, 8x8)
- Predictable, regular pattern
- Best for: textures, backgrounds, retro look
- Fast and consistent

**Error Diffusion (Floyd-Steinberg):**
- Distributes color error to neighboring pixels
- More organic, less regular pattern
- Best for: gradients, natural images, smooth transitions
- Slower but higher quality

**Common Dithering Patterns:**
- **Checkerboard**: Simple 2-color alternating pattern
- **Bayer 2x2**: Basic ordered dithering
- **Bayer 4x4**: More subtle ordered dithering
- **Bayer 8x8**: Very subtle, near-gradient appearance
- **Floyd-Steinberg**: Error diffusion for smooth gradients

### 2. Palette Management

**Color Quantization:**
Use `mcp__aseprite__quantize_colors` to reduce sprite colors intelligently:
- Analyzes sprite colors
- Finds optimal limited palette
- Remaps pixels to new palette
- Preserves visual quality

**Palette Optimization Workflow:**
1. Get current sprite info and palette
2. Decide target color count (4, 8, 16, 32, 64, 256)
3. Apply quantization with optional dithering
4. Review and adjust palette if needed

**Common Palette Sizes:**
- **4 colors**: Game Boy, ZX Spectrum per-sprite
- **8 colors**: CGA, early arcade
- **16 colors**: NES, Master System, early VGA
- **32 colors**: SNES per-background, Amiga OCS
- **64 colors**: Genesis, PC Engine
- **256 colors**: VGA, SNES full palette, Amiga AGA

**Palette Theory:**
- **Color Ramps**: Gradual transitions from dark to light for shading
- **Hue Shifting**: Changing hue slightly in shadows/highlights for vibrant look
- **Saturation**: Higher saturation in midtones, lower in shadows/highlights
- **Contrast**: Ensure sufficient contrast between key elements

### 3. Shading Techniques

**Types of Shading:**

**Flat Shading (No Shading):**
- Single color per surface
- Simple, iconic look
- Best for: UI icons, simple sprites, minimalist style

**Cell Shading (Hard Shading):**
- Distinct color bands with hard edges
- 2-3 colors per surface (base, shadow, highlight)
- Best for: cartoon style, bold graphics, readable sprites

**Soft Shading (Dithered Shading):**
- Gradual transitions using dithering
- Smooth appearance with limited colors
- Best for: realistic look, smooth surfaces, gradients

**Pixel Clusters:**
- Manual dithering with strategic pixel placement
- Organic, hand-crafted appearance
- Best for: metal, fabric textures, custom look

**Shading Workflow:**
1. Identify light source direction
2. Determine base color
3. Create darker shade for shadows (hue shift toward blue/purple)
4. Create lighter shade for highlights (hue shift toward yellow/white)
5. Apply shadows on surfaces away from light
6. Apply highlights on surfaces toward light
7. Add reflected light in deep shadows (subtle)

**Common Shading Mistakes:**
- Pure black shadows (use dark hue-shifted colors instead)
- Pure white highlights (use light tinted colors instead)
- No hue shifting (shadows/highlights same hue as base)
- Pillow shading (shading around edges instead of from light source)

### 4. Antialiasing

**Purpose**: Smooth jagged edges and diagonal lines by adding intermediate colors.

**When to Use Antialiasing:**
- Diagonal lines look jagged
- Curves appear stepped
- Edges need smoothing
- Higher resolution sprites (64x64+)

**When NOT to Use Antialiasing:**
- Very small sprites (16x16 or smaller)
- Intentional pixelated aesthetic
- High-contrast situations (AA reduces contrast)
- Limited palette (need intermediate colors)

**Manual Antialiasing Technique:**
1. Identify jagged edge
2. Find intermediate color between edge and background
3. Place intermediate pixels at edge "steps"
4. Use 1-pixel wide AA (avoid thick fuzzy edges)
5. AA selectively (not every edge needs it)

**Automated Antialiasing:**
- Some tools offer automatic edge smoothing
- Use with caution (can blur intended sharpness)
- Manual AA gives better control

### 5. Color Theory for Pixel Art

**HSV/HSB Model:**
- **Hue**: Color type (red, blue, green, etc.)
- **Saturation**: Color intensity (vivid vs. gray)
- **Value/Brightness**: Lightness (dark vs. light)

**Creating Color Ramps:**
1. Start with base color (midtone)
2. Create shadow: lower value, optionally shift hue toward cool (blue/purple)
3. Create highlight: raise value, optionally shift hue toward warm (yellow/white)
4. Create midtone between base and shadow
5. Create midtone between base and highlight
6. Result: 5-color ramp (deep shadow, shadow, base, highlight, bright highlight)

**Hue Shifting:**
- Shadows: shift toward blue, purple, or complementary color
- Highlights: shift toward yellow, orange, or light source color
- Creates vibrant, lively colors instead of flat gradients

**Contrast:**
- Ensure important elements have high value contrast
- Background should contrast with foreground
- Silhouette should be readable in solid black

**Color Harmony:**
- **Monochromatic**: Variations of single hue
- **Analogous**: Adjacent hues on color wheel
- **Complementary**: Opposite hues on color wheel
- **Triadic**: Three evenly spaced hues

### 6. Professional Workflows

**Workflow 1: Palette Reduction with Dithering**

User Request: "Reduce this sprite to 16 colors with dithering"

Approach:
1. Get current sprite info
2. Check current palette size
3. Apply color quantization to 16 colors
4. Apply Floyd-Steinberg dithering for smooth gradients
5. Review result and adjust if needed

**Workflow 2: Adding Shading to Flat Sprite**

User Request: "Add shading to this sprite with light from top-left"

Approach:
1. Analyze sprite structure
2. Identify base colors
3. Create shadow colors (darker, hue-shifted)
4. Create highlight colors (lighter, hue-shifted)
5. Update palette with new colors
6. Draw shadows on bottom-right surfaces
7. Draw highlights on top-left surfaces
8. Add subtle reflected light in deep shadows

**Workflow 3: Smoothing Jagged Edges**

User Request: "Smooth out the edges on this character"

Approach:
1. Identify jagged diagonal lines and curves
2. Find edge color and background color
3. Create intermediate colors (1-2 shades between)
4. Place AA pixels at edge steps
5. Review and refine (avoid over-smoothing)

**Workflow 4: Converting to Retro Palette**

User Request: "Convert this to NES palette"

Approach:
1. Load NES palette (54 colors total, 4 colors per sprite)
2. Decide which 4 NES colors to use
3. Apply quantization to 4 colors
4. Optionally apply Bayer dithering for retro look
5. Verify sprite uses only chosen colors

### 7. Dithering Patterns Reference

**2-Color Patterns:**

**Checkerboard (50% mix):**
```
A B A B
B A B A
A B A B
B A B A
```

**25% Pattern:**
```
A A B A
A A A A
B A A A
A A A A
```

**75% Pattern:**
```
B B A B
B B B B
A B B B
B B B B
```

**Bayer 2x2:**
```
Threshold matrix:
0 2
3 1

If pixel value > threshold, use lighter color
```

**Bayer 4x4:**
```
 0  8  2 10
12  4 14  6
 3 11  1  9
15  7 13  5
```

**Note**: See `dithering-patterns.md` for comprehensive pattern library.

### 8. Technical Details

**Quantization Parameters:**
- Target colors: 2-256
- Dithering: optional, specify algorithm
- Alpha handling: preserve transparency or flatten

**Palette Constraints:**
- RGB mode: No palette constraints
- Indexed mode: Max 256 colors
- Grayscale: 256 shades of gray

**Performance:**
- Quantization: ~100-500ms depending on sprite size
- Dithering: ~200-800ms depending on algorithm and size
- Manual pixel operations: <50ms per operation

### 9. Common Patterns

**Pattern: Quick Polish**
For "make this look better" requests:
1. Check palette (reduce if too many colors)
2. Add basic shading (light source from top-left)
3. Add selective antialiasing on curves
4. Adjust contrast if needed

**Pattern: Retro Conversion**
For "make this look retro" requests:
1. Reduce to appropriate palette (4, 8, or 16 colors)
2. Apply ordered dithering (Bayer)
3. Remove antialiasing (make edges sharp)
4. Ensure pixel-perfect alignment

**Pattern: Smooth Gradient**
For "smooth out the colors" requests:
1. Analyze color distribution
2. Apply Floyd-Steinberg dithering
3. Optional: slight quantization to clean up palette
4. Verify smooth transitions

## Integration with Other Skills

- **Start with pixel-art-creator** for base sprite before polishing
- **Use pixel-art-animator** for animation, then polish with this Skill
- **Hand off to pixel-art-exporter** when refinement is complete

## Error Handling

**Quantization fails:**
- Target color count must be 2-256
- Sprite must have content (not blank)

**Dithering issues:**
- Requires sufficient color depth
- May not work well with very limited palettes
- Some algorithms better for certain content

**Palette conflicts:**
- Indexed mode has strict limits
- Converting to indexed may require quantization first

## Success Indicators

You've successfully used this Skill when:
- Dithering applied produces smooth gradients or textures
- Palette reduced while preserving visual quality
- Shading adds depth and dimension
- Antialiasing smooths edges without blurring
- Colors follow good color theory principles
- Sprite has professional, polished appearance
```

---

#### File 2: `skills/pixel-art-professional/reference.md`

```markdown
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
```

---

#### File 3: `skills/pixel-art-professional/dithering-patterns.md`

```markdown
# Dithering Patterns Library

Comprehensive reference of dithering patterns for pixel art.

## 2-Color Patterns (50% Mix)

### Checkerboard
```
A B A B A B A B
B A B A B A B A
A B A B A B A B
B A B A B A B A
A B A B A B A B
B A B A B A B A
A B A B A B A B
B A B A B A B A
```

**Use**: Even 50/50 mix, very regular, obvious pattern.

### Diagonal Lines
```
A B . . A B . .
B A . . B A . .
. . A B . . A B
. . B A . . B A
A B . . A B . .
B A . . B A . .
. . A B . . A B
. . B A . . B A
```

**Use**: Directional texture, fabric weave.

### Crosshatch
```
A B A . A B A .
B . B A B . B A
A B A . A B A .
. A . B . A . B
A B A . A B A .
B . B A B . B A
A B A . A B A .
. A . B . A . B
```

**Use**: Rough texture, sketch-like appearance.

## 2-Color Patterns (25% Mix)

### Sparse Dots
```
A A B A A A B A
A A A A A A A A
B A A A B A A A
A A A A A A A A
A A B A A A B A
A A A A A A A A
B A A A B A A A
A A A A A A A A
```

**Use**: Subtle texture, 25% darker/lighter.

### Diagonal Sparse
```
A A A B A A A A
A A A A A A A B
A A B A A A A A
A A A A A B A A
B A A A A A A A
A A A B A A A A
A A A A A A B A
A B A A A A A A
```

**Use**: Gentle diagonal flow.

## 2-Color Patterns (75% Mix)

### Dense Dots (Inverse of 25%)
```
B B A B B B A B
B B B B B B B B
A B B B A B B B
B B B B B B B B
B B A B B B A B
B B B B B B B B
A B B B A B B B
B B B B B B B B
```

**Use**: Mostly lighter color, subtle darkening.

## 3-Color Patterns

### Smooth Gradient (A → B → C)
```
A A A A B B B B
A A A B B B B C
A A A B B B C C
A A B B B C C C
A B B B C C C C
B B B C C C C C
B B C C C C C C
B C C C C C C C
```

**Use**: Smooth transition between 3 colors.

### Stepped Gradient
```
A A A A A A A A
A A A A B B B B
A A B B B B B B
B B B B B B C C
B B B B C C C C
B B C C C C C C
C C C C C C C C
C C C C C C C C
```

**Use**: Clear separation between color zones.

## Bayer Matrices

### Bayer 2×2 (4 Threshold Levels)
```
Thresholds:
0 2
3 1

Pattern visualization (0=darkest, 3=lightest):
0/4  2/4
3/4  1/4
```

**Use**: Basic ordered dithering, very coarse.

### Bayer 4×4 (16 Threshold Levels)
```
Thresholds:
 0  8  2 10
12  4 14  6
 3 11  1  9
15  7 13  5

Pattern visualization (0-15 scale):
 0/16  8/16  2/16 10/16
12/16  4/16 14/16  6/16
 3/16 11/16  1/16  9/16
15/16  7/16 13/16  5/16
```

**Use**: Standard ordered dithering, balanced regularity and smoothness.

### Bayer 8×8 (64 Threshold Levels)
```
Thresholds:
 0 32  8 40  2 34 10 42
48 16 56 24 50 18 58 26
12 44  4 36 14 46  6 38
60 28 52 20 62 30 54 22
 3 35 11 43  1 33  9 41
51 19 59 27 49 17 57 25
15 47  7 39 13 45  5 37
63 31 55 23 61 29 53 21
```

**Use**: Fine ordered dithering, near-gradient quality.

## Artistic Patterns

### Hatching (Single Direction)
```
A A A B A A A B
A A A B A A A B
A A A B A A A B
A A A B A A A B
A A A B A A A B
A A A B A A A B
A A A B A A A B
A A A B A A A B
```

**Use**: Pen-and-ink style, directional shading.

### Cross-Hatching
```
A A B A A A B A
A A B A A A B A
B B A B B B A B
A A B A A A B A
A A B A A A B A
A A B A A A B A
B B A B B B A B
A A B A A A B A
```

**Use**: Heavier ink-style shading.

### Stippling
```
A A B A A A A B
A A A A B A A A
B A A A A A B A
A A A B A A A A
A A A A A B A A
B A B A A A A A
A A A A B A A B
A B A A A A A A
```

**Use**: Random-looking texture, organic.

### Vertical Lines (Fabric)
```
A B A B A B A B
A B A B A B A B
A B A B A B A B
A B A B A B A B
A B A B A B A B
A B A B A B A B
A B A B A B A B
A B A B A B A B
```

**Use**: Fabric weave, vertical texture.

### Horizontal Lines (Metal Brushing)
```
A A A A A A A A
B B B B B B B B
A A A A A A A A
A A A A A A A A
B B B B B B B B
A A A A A A A A
A A A A A A A A
B B B B B B B B
```

**Use**: Brushed metal, horizontal grain.

### Brick Pattern
```
A A B A A A B A
A A B A A A B A
B B A B B B A B
B B A B B B A B
A A B A A A B A
A A B A A A B A
B B A B B B A B
B B A B B B A B
```

**Use**: Masonry texture, tiled surfaces.

### Woven Fabric
```
A A B B A A B B
A A B B A A B B
B B A A B B A A
B B A A B B A A
A A B B A A B B
A A B B A A B B
B B A A B B A A
B B A A B B A A
```

**Use**: Basket weave, cloth texture.

## Retro Console Dithering

### NES-Style (Coarse Checkerboard)
```
A B A B A B A B
B A B A B A B A
A B A B A B A B
B A B A B A B A
A B A B A B A B
B A B A B A B A
A B A B A B A B
B A B A B A B A
```

**Use**: Classic 8-bit look, very visible pattern.

### Game Boy-Style (Dense Stippling)
```
A A B A A B A A
A B A A B A A B
B A A B A A B A
A A B A A B A A
A B A A B A A B
B A A B A A B A
A A B A A B A A
A B A A B A A B
```

**Use**: 4-shade Game Boy aesthetic.

### SNES-Style (Fine Bayer)
```
(Use Bayer 8×8 matrix)
```

**Use**: Smooth 16-bit era gradients.

## Pattern Selection Guide

| Desired Effect | Recommended Pattern |
|---|---|
| Smooth gradient | Floyd-Steinberg or Bayer 8×8 |
| Retro/obvious | Checkerboard or Bayer 2×2 |
| Fabric texture | Woven or Vertical Lines |
| Metal surface | Horizontal Lines |
| Stone/rough | Stippling or Sparse Dots |
| Ink drawing | Hatching or Cross-Hatching |
| Subtle shading | Bayer 4×4 or Diagonal Sparse |
| Dramatic contrast | Brick or Bold Checkerboard |

## Color Percentage Mix Table

| Pattern | % of Color A | % of Color B |
|---|---|---|
| Sparse Dots (25%) | 75% | 25% |
| Checkerboard (50%) | 50% | 50% |
| Dense Dots (75%) | 25% | 75% |
| Single Line (12.5%) | 87.5% | 12.5% |
| Double Line (25%) | 75% | 25% |
| Triple Line (37.5%) | 62.5% | 37.5% |

## Implementation Notes

**Tiling**: All patterns above are 8×8 and tile seamlessly. Repeat pattern across larger areas.

**Color Mixing**: "A" and "B" represent two colors being mixed. Use actual hex colors from palette.

**Customization**: Modify patterns by:
- Rotating 90°/180°/270° for directional change
- Inverting (swap A and B) for opposite density
- Combining patterns for complex textures

**Tool Support**:
- Manual: Use `mcp__aseprite__draw_pixels` to place pattern pixels
- Automatic: Use `mcp__aseprite__apply_dithering` with algorithm name
```

---

### Verification Steps

Run these commands to verify Chunk 3.3:

```bash
# 1. Verify all files created
ls -la skills/pixel-art-professional/

# Should show:
# - SKILL.md
# - reference.md
# - dithering-patterns.md

# 2. Check SKILL.md frontmatter
head -n 5 skills/pixel-art-professional/SKILL.md

# Should show valid YAML with name, description, allowed-tools

# 3. Verify allowed-tools includes professional tools
grep "allowed-tools:" skills/pixel-art-professional/SKILL.md

# Should include: quantize_colors, apply_dithering, set_palette, get_palette

# 4. Check description has trigger keywords
grep "description:" skills/pixel-art-professional/SKILL.md | grep -i "dithering"

# Should match

# 5. Verify file sizes are reasonable
wc -l skills/pixel-art-professional/*.md

# SKILL.md should be 400-600 lines
# reference.md should be 400-600 lines
# dithering-patterns.md should be 300-500 lines
```

### Git Commit

```bash
git add skills/pixel-art-professional/
git commit -m "feat(skills): add pixel-art-professional Skill

- Create SKILL.md with advanced pixel art techniques
- Add dithering, palette management, shading instructions
- Include antialiasing and color theory guidance
- Create comprehensive reference.md with algorithms
- Add dithering-patterns.md with pattern library
- Document color ramps, classic palettes, texture techniques
- Include professional workflows and common patterns

Chunk: 3.3"
```

### Success Criteria

- [ ] `skills/pixel-art-professional/` directory exists
- [ ] `SKILL.md` has valid YAML frontmatter with trigger keywords
- [ ] `allowed-tools` includes dithering and palette tools
- [ ] Instructions cover dithering, shading, AA, color theory
- [ ] `reference.md` includes technical algorithms and palettes
- [ ] `dithering-patterns.md` provides pattern library
- [ ] All verification steps pass
- [ ] Git commit completed with "Chunk: 3.3" footer

---


### Chunk 3.4: Create pixel-art-exporter Skill

**Objective**: Implement the pixel-art-exporter Skill for exporting sprites in various formats including PNG, GIF, spritesheet layouts, and JSON metadata.

**Files to Create**:
1. `skills/pixel-art-exporter/SKILL.md`
2. `skills/pixel-art-exporter/export-formats.md`

---

#### File 1: `skills/pixel-art-exporter/SKILL.md`

Create file with 350-450 lines covering:
- YAML frontmatter: name, description (with trigger keywords: export, save, PNG, GIF, spritesheet, JSON), allowed-tools
- Overview of export capabilities
- When to Use section (trigger: "export", "save", "PNG", "GIF", "spritesheet")
- Instructions for:
  - Exporting single images (PNG with transparency)
  - Exporting animated GIFs
  - Creating spritesheets (horizontal, vertical, grid, packed layouts)
  - Generating JSON metadata for game engines
  - Scaling exports (1x, 2x, 4x for pixel-perfect scaling)
- Export workflows for different use cases
- Integration with game engines (Unity, Godot, Phaser)
- Technical details (file formats, metadata structure)
- Common patterns

**allowed-tools**: Read, Bash, mcp__aseprite__export_png, mcp__aseprite__export_gif, mcp__aseprite__export_spritesheet, mcp__aseprite__get_sprite_info

---

#### File 2: `skills/pixel-art-exporter/export-formats.md`

Create reference file with 250-350 lines covering:
- PNG export options (transparency, background)
- GIF export (frame timing, looping, optimization)
- Spritesheet layouts:
  - Horizontal strip (all frames in a row)
  - Vertical strip (all frames in a column)
  - Grid (rows × columns)
  - Packed (optimal space usage)
- JSON metadata formats:
  - Aseprite JSON format
  - TexturePacker JSON format
  - Unity Sprite Atlas format
  - Godot SpriteFrames format
- Scaling considerations (nearest-neighbor for pixel art)
- Game engine integration examples

---

### Verification Steps

```bash
# 1. Verify files created
ls -la skills/pixel-art-exporter/

# Should show SKILL.md and export-formats.md

# 2. Check frontmatter
head -n 5 skills/pixel-art-exporter/SKILL.md

# 3. Verify trigger keywords
grep "description:" skills/pixel-art-exporter/SKILL.md | grep -i "export"

# 4. Check allowed-tools
grep "allowed-tools:" skills/pixel-art-exporter/SKILL.md

# Should include export tools

# 5. Verify file sizes
wc -l skills/pixel-art-exporter/*.md

# SKILL.md: 350-450 lines
# export-formats.md: 250-350 lines
```

### Git Commit

```bash
git add skills/pixel-art-exporter/
git commit -m "feat(skills): add pixel-art-exporter Skill

- Create SKILL.md with export functionality
- Add PNG, GIF, and spritesheet export instructions
- Include JSON metadata generation guidance
- Create export-formats.md reference
- Document game engine integration
- Include scaling and format options

Chunk: 3.4"
```

### Success Criteria

- [ ] `skills/pixel-art-exporter/` directory exists
- [ ] `SKILL.md` has valid YAML frontmatter
- [ ] Description includes export-related trigger keywords
- [ ] allowed-tools includes export tools
- [ ] Instructions cover PNG, GIF, spritesheet, JSON exports
- [ ] `export-formats.md` documents all export formats
- [ ] All verification steps pass
- [ ] Git commit completed with "Chunk: 3.4" footer

---

## Phase 4: Slash Commands

### Chunk 4.1: Create /pixel-new command

**Objective**: Implement the /pixel-new slash command for quick sprite creation with common presets.

**Files to Create**:
1. `commands/pixel-new.md`

---

#### File: `commands/pixel-new.md`

Create command file with 150-200 lines:

```markdown
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

### Notes

- If no arguments, create default 64x64 RGB canvas
- For retro palettes, use Indexed color mode
- For RGB mode, no palette needed
- Validate dimensions (1-65535)
- Provide helpful error messages for invalid input
```

---

### Verification Steps

```bash
# 1. Verify file created
ls -la commands/pixel-new.md

# 2. Check frontmatter
head -n 5 commands/pixel-new.md

# 3. Verify allowed-tools
grep "allowed-tools:" commands/pixel-new.md

# 4. Check file size
wc -l commands/pixel-new.md

# Should be 150-200 lines
```

### Git Commit

```bash
git add commands/pixel-new.md
git commit -m "feat(commands): add /pixel-new command

- Create pixel-new.md slash command
- Add size presets (icon, small, medium, large, tile, gameboy, nes)
- Include palette presets (retro, nes, gameboy, c64, cga, snes)
- Support custom dimensions (WxH format)
- Provide usage examples and documentation

Chunk: 4.1"
```

### Success Criteria

- [ ] `commands/pixel-new.md` created
- [ ] YAML frontmatter with description and argument-hint
- [ ] Size presets documented
- [ ] Palette presets documented
- [ ] Usage examples provided
- [ ] Implementation instructions clear
- [ ] Verification steps pass
- [ ] Git commit with "Chunk: 4.1" footer

---

