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
