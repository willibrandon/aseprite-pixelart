---
name: Pixel Art Professional
description: Apply advanced pixel art techniques including dithering, palette optimization, shading, antialiasing, and color theory. Use when the user mentions "dithering", "dither", "Bayer", "Floyd-Steinberg", "palette", "colors", "reduce colors", "optimize palette", "color limit", "shading", "shadows", "highlights", "lighting", "light source", "antialiasing", "smooth", "smoothing", "anti-alias", "AA", "color ramp", "gradient", "hue shifting", "saturation", "value", "contrast", or wants to "refine", "polish", "improve", "enhance", "make better", "add depth", "add dimension" to existing pixel art. Trigger on retro palette names (NES, Game Boy, C64, PICO-8), texture terms ("metal", "fabric", "stone", "wood"), and visual quality terms ("professional", "clean", "smooth", "vibrant").
allowed-tools: Read, Bash, mcp__aseprite__get_sprite_info, mcp__aseprite__draw_pixels, mcp__aseprite__set_palette, mcp__aseprite__get_palette, mcp__aseprite__quantize_palette, mcp__aseprite__apply_auto_shading, mcp__aseprite__draw_with_dither, mcp__aseprite__add_layer, mcp__aseprite__flatten_layers
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
Use `mcp__aseprite__quantize_palette` to reduce sprite colors intelligently:
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
3. Use `mcp__aseprite__quantize_palette` with:
   - target_colors: 16
   - algorithm: "median_cut" or "kmeans"
   - dither: true (enables Floyd-Steinberg dithering)
4. Review result and adjust if needed

**Workflow 2: Adding Shading to Flat Sprite**

User Request: "Add shading to this sprite with light from top-left"

**Option A - Automatic Shading (Quick):**
1. Use `mcp__aseprite__apply_auto_shading` with:
   - light_direction: "top_left"
   - intensity: 0.3-0.7 (adjust to preference)
   - style: "smooth", "hard", or "pillow"
   - hue_shift: true (for vibrant results)
2. Tool automatically detects regions and adds shading
3. Review and manually refine if needed

**Option B - Manual Shading (Precise):**
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

**Workflow 4: Converting to Retro Palette (Full Palette Conversion)**

User Request: "Convert this to NES palette"

Approach:
1. Use `mcp__aseprite__quantize_palette` with retro palette colors
2. Specify target palette (e.g., 54 NES colors, 4 Game Boy colors, 16 C64 colors)
3. Algorithm maps each pixel to nearest palette color
4. Pixels are remapped to new palette indices
5. Optionally apply dithering for smoother transitions
6. Verify all colors match target palette

**IMPORTANT**: Use `quantize_palette`, NOT `set_palette`. The `set_palette` tool only replaces the color table without remapping pixel data, which will produce incorrect colors in indexed mode.

Example:
```
quantize_palette(
  sprite_path: "sprite.aseprite",
  target_colors: 54,  # NES full palette
  algorithm: "median_cut",
  convert_to_indexed: true,
  dither: false  # or true for Bayer dithering
)
```

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
