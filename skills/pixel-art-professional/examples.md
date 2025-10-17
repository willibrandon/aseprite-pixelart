# Pixel Art Professional Examples

This document provides concrete examples of how the pixel-art-professional skill handles advanced pixel art techniques. Each example shows the user's request, step-by-step approach, actual MCP tool calls with parameters, and expected results.

Examples are organized by technique: dithering, palette optimization, shading, antialiasing, and complete refinement workflows.

---

## Dithering Applications

### Example 1: Floyd-Steinberg Dithering for Gradient

**User Request:**
> "Apply Floyd-Steinberg dithering to create a smooth gradient with a limited palette"

**Approach:**
1. Create canvas with gradient (or existing image)
2. Set limited target palette
3. Apply Floyd-Steinberg dithering algorithm
4. Diffuses error to neighboring pixels for smooth transitions

**Tool Calls:**
```javascript
// Assume canvas exists with smooth RGB gradient
// Create target palette (limited colors)
mcp__aseprite__set_palette({
  colors: [
    { r: 0, g: 0, b: 0 },        // Black
    { r: 85, g: 85, b: 85 },     // Dark gray
    { r: 170, g: 170, b: 170 },  // Light gray
    { r: 255, g: 255, b: 255 }   // White
  ]
})

// Apply Floyd-Steinberg dithering
mcp__aseprite__apply_dithering({
  algorithm: "floyd-steinberg",
  matrix: "default"
})

// Quantize to palette
mcp__aseprite__quantize_colors({
  colors: 4,
  algorithm: "default"
})
```

**Result:**
A gradient that appears smooth despite using only 4 colors, with error diffusion creating organic dither patterns.

**Visual Description:**
The gradient transitions from black to white using a checkerboard-like pattern of gray pixels. Floyd-Steinberg's error diffusion creates irregular, organic-looking patterns that avoid banding. Close pixels seem to "blend" optically when viewed at normal distance.

---

### Example 2: Bayer Dithering for Ordered Pattern

**User Request:**
> "Use Bayer dithering to create a consistent textured pattern"

**Approach:**
1. Start with image or gradient
2. Apply Bayer matrix dithering
3. Creates ordered, repeating pattern
4. Good for textures and consistent looks

**Tool Calls:**
```javascript
// Apply 8x8 Bayer matrix dithering
mcp__aseprite__apply_dithering({
  algorithm: "bayer",
  matrix: "8x8"
})

// Alternative: 4x4 for coarser pattern
// mcp__aseprite__apply_dithering({
//   algorithm: "bayer",
//   matrix: "4x4"
// })
```

**Result:**
An ordered dither pattern with consistent, repeating structure suitable for textures.

**Visual Description:**
Instead of random-looking patterns, Bayer dithering creates a regular crosshatch or grid pattern. The 8x8 matrix produces finer patterns than 4x4. This technique gives a vintage computer graphics aesthetic and works well for fabric textures or patterned surfaces.

---

### Example 3: Retro Game Style Dithering

**User Request:**
> "Apply classic dithering like old DOS games, convert my sprite to 16 colors"

**Approach:**
1. Get current sprite palette
2. Reduce to 16 colors
3. Apply ordered dithering for retro look
4. Maintain pixel art aesthetic

**Tool Calls:**
```javascript
// First, get current palette to analyze
mcp__aseprite__get_palette()

// Quantize to 16 colors (typical VGA palette size)
mcp__aseprite__quantize_colors({
  colors: 16,
  algorithm: "rgb5a3"  // Retro-friendly quantization
})

// Apply ordered dithering with smaller matrix
mcp__aseprite__apply_dithering({
  algorithm: "ordered",
  matrix: "4x4"
})
```

**Result:**
A sprite with authentic early-90s PC game aesthetic using ordered dither and 16-color palette.

**Visual Description:**
The sprite has a distinctly retro appearance with visible dither patterns. Colors are limited to 16 values, and gradients show clear crosshatch patterns typical of VGA-era games. The ordered dither gives it that classic Sierra or LucasArts adventure game look.

---

### Example 4: Subtle Dithering for Smooth Shading

**User Request:**
> "Add gentle dithering to my character's shading without making it too obvious"

**Approach:**
1. Work with existing shaded sprite
2. Apply light dithering only to transition areas
3. Use high-resolution matrix for subtlety
4. Preserve hard edges

**Tool Calls:**
```javascript
// Apply very subtle Floyd-Steinberg with reduced strength
mcp__aseprite__apply_dithering({
  algorithm: "floyd-steinberg",
  matrix: "default",
  serpentine: true  // Reduces banding artifacts
})

// Alternative: Use fine Bayer matrix
// mcp__aseprite__apply_dithering({
//   algorithm: "bayer",
//   matrix: "16x16"  // Very fine pattern
// })
```

**Result:**
Smooth shading with barely perceptible dithering that eliminates banding without dominating the aesthetic.

**Visual Description:**
The character's shading appears mostly smooth but with subtle texture in the transition zones. The dithering is fine enough that it reads as smooth shading at normal viewing distance but eliminates harsh color banding. Edges remain clean and crisp.

---

## Palette Optimization

### Example 5: Color Reduction with Quantization

**User Request:**
> "Reduce my sprite from thousands of colors to just 32 for a retro game"

**Approach:**
1. Analyze current color usage
2. Apply intelligent quantization
3. Preserve important color relationships
4. Set optimized palette

**Tool Calls:**
```javascript
// Get current palette info
mcp__aseprite__get_palette()

// Quantize to 32 colors intelligently
mcp__aseprite__quantize_colors({
  colors: 32,
  algorithm: "octree"  // Good for color preservation
})

// Alternatively, use k-means for better clustering
// mcp__aseprite__quantize_colors({
//   colors: 32,
//   algorithm: "kmeans"
// })
```

**Result:**
A sprite using exactly 32 colors that maintains the original's visual appearance while being palette-constrained.

**Visual Description:**
The quantized sprite looks remarkably similar to the original despite having far fewer colors. Important color distinctions are preserved (skin tone vs. clothing vs. highlights), while subtle variations are merged intelligently. Perfect for Game Boy Advance or similar systems.

---

### Example 6: Creating a Unified Palette

**User Request:**
> "I have multiple sprites with different palettes - create one unified 16-color palette for all of them"

**Approach:**
1. Analyze color usage across all sprites
2. Find common colors and important distinctions
3. Generate optimized shared palette
4. Apply to all sprites with dithering for transitions

**Tool Calls:**
```javascript
// For sprite 1
mcp__aseprite__get_palette()

// Quantize all sprites to same 16-color palette
// First, determine optimal palette across all sprites
mcp__aseprite__quantize_colors({
  colors: 16,
  algorithm: "octree",
  useAllFrames: true,
  useAllLayers: true
})

// Get the generated palette
const unifiedPalette = mcp__aseprite__get_palette()

// Apply Floyd-Steinberg to handle color transitions
mcp__aseprite__apply_dithering({
  algorithm: "floyd-steinberg",
  matrix: "default"
})
```

**Result:**
A cohesive 16-color palette that works across multiple sprites, enabling consistent art direction.

**Visual Description:**
All sprites now share the same 16 colors, creating visual harmony. The palette includes key colors needed by all sprites: skin tones, common material colors, and essential highlights/shadows. Dithering bridges gaps where sprites previously had unique colors.

---

### Example 7: Palette Swapping Setup

**User Request:**
> "Optimize my character palette so I can easily swap colors for different character variants"

**Approach:**
1. Organize palette by function (skin, hair, clothing, details)
2. Keep palette indices consistent
3. Create base character with organized palette
4. Enable easy color swapping

**Tool Calls:**
```javascript
// Set organized palette with functional groups
mcp__aseprite__set_palette({
  colors: [
    // Indices 0-3: Skin tones
    { r: 255, g: 220, b: 177 },  // Light skin
    { r: 220, g: 180, b: 140 },  // Mid skin
    { r: 180, g: 130, b: 90 },   // Shadow skin
    { r: 0, g: 0, b: 0 },        // Outline

    // Indices 4-7: Hair colors
    { r: 101, g: 67, b: 33 },    // Brown hair
    { r: 70, g: 45, b: 20 },     // Dark brown hair
    { r: 50, g: 30, b: 10 },     // Hair shadow
    { r: 130, g: 90, b: 50 },    // Hair highlight

    // Indices 8-11: Primary clothing
    { r: 200, g: 50, b: 50 },    // Red shirt
    { r: 150, g: 30, b: 30 },    // Red shirt shadow
    { r: 250, g: 100, b: 100 },  // Red shirt highlight
    { r: 0, g: 0, b: 0 },        // Clothing outline

    // Indices 12-15: Secondary colors
    { r: 50, g: 100, b: 200 },   // Blue pants
    { r: 30, g: 70, b: 150 },    // Blue pants shadow
    { r: 100, g: 150, b: 250 },  // Blue pants highlight
    { r: 255, g: 255, b: 255 }   // White details
  ]
})

// Draw character using these organized indices
mcp__aseprite__draw_pixels({
  pixels: [
    // Use indices 0-3 for all skin
    { x: 15, y: 8, colorIndex: 0 },  // Light skin
    { x: 16, y: 9, colorIndex: 1 },  // Mid skin
    { x: 17, y: 10, colorIndex: 2 }, // Shadow skin
    // Use indices 4-7 for all hair
    { x: 14, y: 6, colorIndex: 4 },  // Hair
    // Use indices 8-11 for clothing
    { x: 15, y: 12, colorIndex: 8 }, // Shirt
    // etc.
  ]
})
```

**Result:**
A character sprite with organized palette enabling easy variants (blonde, redhead, etc.) by swapping specific palette ranges.

**Visual Description:**
The base character uses indices organized by feature. To create a blonde variant, simply replace palette indices 4-7 with yellow/blonde values. For a green shirt, replace indices 8-11. The character's structure remains identical, but appearances change dramatically with palette swaps.

---

## Shading Techniques

### Example 8: Adding Cell Shading

**User Request:**
> "Add simple cell shading to my flat character sprite - just base color, shadow, and highlight"

**Approach:**
1. Start with flat-colored sprite
2. Identify light source direction
3. Add shadow areas (typically 50% darker)
4. Add highlight areas (typically 50% lighter)
5. Keep clean, hard edges for cell-shaded look

**Tool Calls:**
```javascript
// Assume sprite exists with flat colors
// Get current palette
const currentPalette = mcp__aseprite__get_palette()

// Add darker shadow versions of each color to palette
mcp__aseprite__set_palette({
  colors: [
    ...currentPalette.colors,
    // Add shadow versions (multiply by 0.5-0.7)
    { r: Math.floor(currentPalette.colors[1].r * 0.6),
      g: Math.floor(currentPalette.colors[1].g * 0.6),
      b: Math.floor(currentPalette.colors[1].b * 0.6) },
    // Add highlight versions (add 30-50%)
    { r: Math.min(255, Math.floor(currentPalette.colors[1].r * 1.4)),
      g: Math.min(255, Math.floor(currentPalette.colors[1].g * 1.4)),
      b: Math.min(255, Math.floor(currentPalette.colors[1].b * 1.4)) }
  ]
})

// Draw shadow pixels (assuming light from upper-left)
mcp__aseprite__draw_pixels({
  pixels: [
    // Right side of body - shadow
    { x: 17, y: 13, colorIndex: 8 },  // Shadow color index
    { x: 17, y: 14, colorIndex: 8 },
    { x: 17, y: 15, colorIndex: 8 },
    // Under chin - shadow
    { x: 15, y: 11, colorIndex: 2 },  // Skin shadow
    { x: 16, y: 11, colorIndex: 2 },
    // Right side of legs - shadow
    { x: 17, y: 18, colorIndex: 9 },  // Pants shadow
    { x: 17, y: 19, colorIndex: 9 }
  ]
})

// Draw highlight pixels
mcp__aseprite__draw_pixels({
  pixels: [
    // Top of head - highlight
    { x: 14, y: 8, colorIndex: 5 },  // Hair highlight
    { x: 15, y: 8, colorIndex: 5 },
    // Left shoulder - highlight
    { x: 14, y: 12, colorIndex: 10 }, // Shirt highlight
    // Top of legs - highlight
    { x: 14, y: 16, colorIndex: 11 }  // Pants highlight
  ]
})
```

**Result:**
A character with clean, cell-shaded appearance featuring distinct base, shadow, and highlight zones.

**Visual Description:**
The sprite has a cartoon/anime look with three distinct tones per color area. Hard-edged shadows appear on the right side and underneath forms (light from upper-left). Bright highlights pop on the upper-left surfaces. No gradients - just clean color breaks creating dimensional appearance.

---

### Example 9: Soft Shading with Gradients

**User Request:**
> "Add smooth, gradient-style shading to make my sprite look more realistic"

**Approach:**
1. Start with base colors
2. Create multiple intermediate shades
3. Apply graduated shading with subtle transitions
4. Use more colors for smoother gradients

**Tool Calls:**
```javascript
// Create expanded palette with many intermediate shades
mcp__aseprite__set_palette({
  colors: [
    // Skin tone gradient (8 steps)
    { r: 255, g: 220, b: 177 },  // Lightest
    { r: 245, g: 210, b: 167 },
    { r: 235, g: 200, b: 157 },
    { r: 225, g: 190, b: 147 },
    { r: 215, g: 180, b: 137 },  // Mid
    { r: 200, g: 165, b: 122 },
    { r: 185, g: 150, b: 107 },
    { r: 170, g: 135, b: 92 },   // Darkest

    // Red fabric gradient (6 steps)
    { r: 255, g: 100, b: 100 },  // Highlight
    { r: 230, g: 70, b: 70 },
    { r: 200, g: 50, b: 50 },    // Base
    { r: 170, g: 35, b: 35 },
    { r: 140, g: 25, b: 25 },
    { r: 110, g: 15, b: 15 }     // Shadow
  ]
})

// Draw graduated shading on face
mcp__aseprite__draw_pixels({
  pixels: [
    // Face - lightest on left, gradual transition right
    { x: 14, y: 9, colorIndex: 0 },  // Lightest
    { x: 15, y: 9, colorIndex: 1 },
    { x: 16, y: 9, colorIndex: 2 },
    { x: 17, y: 9, colorIndex: 3 },
    { x: 18, y: 9, colorIndex: 4 },  // Mid
    { x: 19, y: 9, colorIndex: 5 },
    { x: 20, y: 9, colorIndex: 6 },
    { x: 21, y: 9, colorIndex: 7 }   // Darkest
  ]
})

// Draw smooth shading on clothing
mcp__aseprite__draw_pixels({
  pixels: [
    // Shirt with gradient from light to dark
    { x: 14, y: 13, colorIndex: 8 },  // Highlight
    { x: 15, y: 13, colorIndex: 9 },
    { x: 16, y: 13, colorIndex: 10 }, // Base
    { x: 17, y: 13, colorIndex: 11 },
    { x: 18, y: 13, colorIndex: 12 }, // Shadow
    { x: 19, y: 13, colorIndex: 13 }  // Deep shadow
  ]
})
```

**Result:**
Smooth, painterly shading with subtle gradients creating realistic volume and form.

**Visual Description:**
The sprite has soft, graduated shading similar to oil painting. Forms curve smoothly with gradual light-to-dark transitions. The face has subtle volume with cheekbone highlights and jaw shadows. Clothing folds show dimensional depth. No harsh lines - everything blends naturally.

---

### Example 10: Ambient Occlusion

**User Request:**
> "Add ambient occlusion darkening where surfaces meet and in crevices"

**Approach:**
1. Identify contact points and corners
2. Add extra-dark pixels in these areas
3. Creates depth and grounds objects
4. Subtle but impactful realism boost

**Tool Calls:**
```javascript
// Add very dark AO color to palette
mcp__aseprite__set_palette({
  colors: [
    ...existingPalette,
    { r: 20, g: 20, b: 25 }  // Very dark blue-black for AO
  ]
})

// Draw AO in crevices and contact points
mcp__aseprite__draw_pixels({
  pixels: [
    // Under chin where head meets neck
    { x: 15, y: 11, colorIndex: 20 },
    { x: 16, y: 11, colorIndex: 20 },

    // Where arm meets body
    { x: 13, y: 14, colorIndex: 20 },

    // Where legs meet ground
    { x: 14, y: 21, colorIndex: 20 },
    { x: 17, y: 21, colorIndex: 20 },

    // Inside elbow crease
    { x: 12, y: 15, colorIndex: 20 },

    // Corner where torso meets legs
    { x: 15, y: 16, colorIndex: 20 },
    { x: 16, y: 16, colorIndex: 20 }
  ]
})
```

**Result:**
Added depth and realism through dark contact shadows that ground the character and define form connections.

**Visual Description:**
The character now has subtle dark pixels in recessed areas: under the chin, inside elbows, where arms press against the torso, and where feet touch ground. These dark accents make the sprite feel more three-dimensional and properly lit by environmental light rather than just direct light.

---

## Antialiasing

### Example 11: Edge Smoothing with AA

**User Request:**
> "Smooth out the jagged edges on my circle sprite with antialiasing"

**Approach:**
1. Identify hard diagonal edges
2. Add intermediate color pixels along edges
3. Blend between foreground and background
4. Creates smoother curves

**Tool Calls:**
```javascript
// Assume we have a red circle on white background
// Add AA colors to palette - blend between red and white
mcp__aseprite__set_palette({
  colors: [
    { r: 255, g: 255, b: 255 },  // White background
    { r: 200, g: 0, b: 0 },      // Red circle
    { r: 255, g: 200, b: 200 },  // Light pink (75% white, 25% red)
    { r: 230, g: 100, b: 100 }   // Pink (50% blend)
  ]
})

// Draw AA pixels along curved edges
mcp__aseprite__draw_pixels({
  pixels: [
    // Top curve - original had stair-step edge
    { x: 14, y: 5, colorIndex: 2 },  // Light AA
    { x: 18, y: 5, colorIndex: 2 },  // Light AA
    { x: 13, y: 6, colorIndex: 3 },  // Medium AA
    { x: 19, y: 6, colorIndex: 3 },  // Medium AA

    // Left curve
    { x: 11, y: 7, colorIndex: 2 },
    { x: 10, y: 8, colorIndex: 3 },
    { x: 9, y: 10, colorIndex: 3 },
    { x: 9, y: 11, colorIndex: 2 },

    // Right curve (mirror)
    { x: 21, y: 7, colorIndex: 2 },
    { x: 22, y: 8, colorIndex: 3 },
    { x: 23, y: 10, colorIndex: 3 },
    { x: 23, y: 11, colorIndex: 2 },

    // Bottom curve
    { x: 13, y: 15, colorIndex: 3 },
    { x: 19, y: 15, colorIndex: 3 },
    { x: 14, y: 16, colorIndex: 2 },
    { x: 18, y: 16, colorIndex: 2 }
  ]
})
```

**Result:**
A circle with smooth, anti-aliased edges that appear curved rather than stair-stepped.

**Visual Description:**
The circle's edges now have pink transitional pixels that blend the red circle into the white background. Diagonal and curved edges that previously showed obvious pixel stairs now appear smooth and rounded. The overall shape reads as a true circle rather than a pixelated approximation.

---

### Example 12: Selective AA for Readability

**User Request:**
> "Add antialiasing to curved parts but keep pixel-perfect straight edges"

**Approach:**
1. Identify which edges are curved vs. straight
2. Apply AA only to diagonals and curves
3. Keep horizontal/vertical edges sharp
4. Maintains clarity while smoothing curves

**Tool Calls:**
```javascript
// Character sprite - AA only on rounded features
mcp__aseprite__draw_pixels({
  pixels: [
    // Round head - add AA on curves
    { x: 13, y: 8, colorIndex: 15 },  // AA pixel
    { x: 19, y: 8, colorIndex: 15 },  // AA pixel

    // Shoulders - slight curve, add AA
    { x: 12, y: 12, colorIndex: 16 }, // AA blend
    { x: 20, y: 12, colorIndex: 16 }, // AA blend

    // Arms - straight sides, NO AA applied
    // Leave edges sharp at x: 13, 19 from y: 13-15

    // Bottom of torso - slight curve
    { x: 13, y: 16, colorIndex: 17 }, // AA blend
    { x: 19, y: 16, colorIndex: 17 }  // AA blend
  ]
})
```

**Result:**
A sprite with smooth curved features (head, shoulders) but crisp, readable straight edges (arms, torso sides).

**Visual Description:**
The character's round head has smooth antialiased edges that look natural. Shoulders curve gently into arms with subtle AA. However, the vertical edges of the torso and straight lines of the arms remain pixel-perfect sharp, maintaining pixel art clarity and preventing muddiness.

---

## Complete Refinement Workflows

### Example 13: Draft to Polished Character

**User Request:**
> "Take my rough character sketch and apply professional techniques - shading, palette optimization, and AA"

**Approach:**
1. Start with flat-color draft
2. Optimize palette to organized scheme
3. Add cell shading with 3 tones per color
4. Apply subtle dithering in transitions
5. Add antialiasing to curves
6. Apply ambient occlusion at contacts

**Tool Calls:**
```javascript
// Step 1: Get current palette and optimize
const draftPalette = mcp__aseprite__get_palette()

mcp__aseprite__quantize_colors({
  colors: 24,  // Enough for 3 tones × 8 material types
  algorithm: "octree"
})

// Step 2: Reorganize palette by material and tone
mcp__aseprite__set_palette({
  colors: [
    // Skin: light, mid, dark
    { r: 255, g: 220, b: 177 },
    { r: 220, g: 180, b: 140 },
    { r: 185, g: 145, b: 105 },

    // Hair: light, mid, dark
    { r: 150, g: 100, b: 50 },
    { r: 110, g: 70, b: 30 },
    { r: 70, g: 40, b: 15 },

    // Clothing and so on...
  ]
})

// Step 3: Add cell shading (shadows on right, highlights on left)
mcp__aseprite__draw_pixels({
  pixels: [
    // Skin shadows
    { x: 18, y: 9, colorIndex: 2 },   // Dark skin on right face
    { x: 18, y: 10, colorIndex: 2 },
    // Skin highlights
    { x: 14, y: 9, colorIndex: 0 },   // Light skin on left face
    { x: 14, y: 10, colorIndex: 0 },
    // Hair shadows...
    // Clothing shadows...
  ]
})

// Step 4: Apply subtle dithering to smooth transitions
mcp__aseprite__apply_dithering({
  algorithm: "floyd-steinberg",
  matrix: "default"
})

// Step 5: Add antialiasing to curved edges
mcp__aseprite__draw_pixels({
  pixels: [
    // AA on head curves
    { x: 13, y: 8, colorIndex: 16 },  // Blend color
    { x: 19, y: 8, colorIndex: 16 },
    // AA on shoulders...
  ]
})

// Step 6: Add ambient occlusion
mcp__aseprite__draw_pixels({
  pixels: [
    // Dark pixels under chin, in armpits, where feet meet ground
    { x: 15, y: 11, colorIndex: 23 },  // AO color
    { x: 16, y: 11, colorIndex: 23 }
  ]
})
```

**Result:**
A polished character sprite with professional shading, optimized palette, smooth edges, and dimensional depth.

**Visual Description:**
The transformation is dramatic. The flat draft now has dimensional form with light from the upper-left creating clear highlights and shadows. Curves are smooth with antialiasing. Contact points have subtle darkening that grounds the character. The palette is organized and efficient. The sprite looks professional and game-ready.

---

### Example 14: Retro Game Sprite Enhancement

**User Request:**
> "Enhance my NES-style sprite with modern techniques while keeping the retro feel"

**Approach:**
1. Start with authentic NES palette (52 colors)
2. Add selective AA only on important elements
3. Use ordered dithering for textures
4. Enhance shading without adding colors
5. Keep that retro charm

**Tool Calls:**
```javascript
// Use authentic NES palette subset
mcp__aseprite__set_palette({
  colors: [
    { r: 124, g: 124, b: 124 },  // NES gray
    { r: 0, g: 0, b: 252 },      // NES blue
    { r: 0, g: 0, b: 188 },      // NES dark blue
    { r: 252, g: 0, b: 0 },      // NES red
    { r: 188, g: 0, b: 0 },      // NES dark red
    // ... more NES colors
  ]
})

// Apply ordered dithering for that authentic NES texture
mcp__aseprite__apply_dithering({
  algorithm: "ordered",
  matrix: "4x4"
})

// Add selective AA only on character face/important details
mcp__aseprite__draw_pixels({
  pixels: [
    // Very minimal AA - just on face curves
    { x: 14, y: 9, colorIndex: 8 },  // Subtle blend pixel
    { x: 18, y: 9, colorIndex: 8 }
  ]
})

// Enhance shading with existing palette
mcp__aseprite__draw_pixels({
  pixels: [
    // Use existing dark colors for better form definition
    { x: 17, y: 13, colorIndex: 4 },  // Existing dark red for shadow
    { x: 17, y: 14, colorIndex: 4 },
    { x: 17, y: 15, colorIndex: 4 }
  ]
})
```

**Result:**
An enhanced retro sprite that looks sharper and more dimensional while maintaining authentic NES aesthetic.

**Visual Description:**
The sprite still screams "NES game" with its authentic palette and ordered dithering patterns. However, the shading is more sophisticated, with better form definition and deeper shadows. Subtle antialiasing on the face makes the character more expressive without looking out of place. It feels like a high-quality NES game rather than a amateur homebrew project.

---

### Example 15: Modern Indie Game Polish

**User Request:**
> "Give my sprite a modern indie pixel art look - smooth, colorful, professional"

**Approach:**
1. Use expanded color palette (64+ colors)
2. Apply smooth gradient shading
3. Add antialiasing liberally
4. Include ambient occlusion
5. Add rim lighting for extra pop

**Tool Calls:**
```javascript
// Create rich palette with many shades
mcp__aseprite__set_palette({
  colors: [
    // Skin gradient (8 shades)
    { r: 255, g: 230, b: 200 },
    { r: 245, g: 215, b: 185 },
    { r: 235, g: 200, b: 170 },
    { r: 225, g: 185, b: 155 },
    { r: 210, g: 170, b: 140 },
    { r: 195, g: 155, b: 125 },
    { r: 180, g: 140, b: 110 },
    { r: 165, g: 125, b: 95 },

    // Hair gradient (8 shades)
    { r: 180, g: 140, b: 80 },
    { r: 160, g: 120, b: 65 },
    { r: 140, g: 100, b: 50 },
    { r: 120, g: 85, b: 40 },
    { r: 100, g: 70, b: 30 },
    { r: 80, g: 55, b: 20 },
    { r: 60, g: 40, b: 15 },
    { r: 40, g: 25, b: 10 },

    // Clothing with saturation gradient...
    // Plus AO color, rim light color...
  ]
})

// Apply smooth gradient shading
mcp__aseprite__draw_pixels({
  pixels: [
    // Face with smooth gradient left to right
    { x: 14, y: 9, colorIndex: 0 },  // Lightest
    { x: 15, y: 9, colorIndex: 1 },
    { x: 16, y: 9, colorIndex: 2 },
    { x: 17, y: 9, colorIndex: 3 },  // Mid
    { x: 18, y: 9, colorIndex: 4 },
    { x: 19, y: 9, colorIndex: 5 },  // Shadow
    // Continue for whole sprite...
  ]
})

// Add generous antialiasing
mcp__aseprite__draw_pixels({
  pixels: [
    // AA all around character outline
    // Many blend pixels creating smooth silhouette
  ]
})

// Add ambient occlusion
mcp__aseprite__draw_pixels({
  pixels: [
    // Dark pixels in all crevices and contact points
    { x: 15, y: 11, colorIndex: 60 },  // AO under chin
    // ... many more AO pixels
  ]
})

// Add rim lighting on left edge (opposite main light)
mcp__aseprite__draw_pixels({
  pixels: [
    // Bright pixels on left edge for rim light effect
    { x: 13, y: 9, colorIndex: 61 },   // Bright rim
    { x: 13, y: 10, colorIndex: 61 },
    { x: 13, y: 13, colorIndex: 62 },  // Rim on body
    { x: 13, y: 14, colorIndex: 62 }
  ]
})
```

**Result:**
A modern, polished indie game character with smooth shading, rich colors, and professional lighting.

**Visual Description:**
The sprite has a contemporary pixel art aesthetic like Celeste or Hyper Light Drifter. Smooth gradient shading creates realistic volume. Generous antialiasing makes all edges smooth. Ambient occlusion adds depth to every crevice. A subtle rim light on the left edge makes the character pop against backgrounds. The rich palette and professional techniques create that "modern indie" look.

---

## Summary

This examples collection demonstrates the pixel-art-professional skill's advanced techniques:

- **Dithering** (Examples 1-4): Floyd-Steinberg, Bayer, ordered patterns, and subtle applications
- **Palette optimization** (Examples 5-7): Color reduction, unification, and palette swapping setup
- **Shading** (Examples 8-10): Cell shading, soft gradients, and ambient occlusion
- **Antialiasing** (Examples 11-12): Edge smoothing and selective AA for readability
- **Complete workflows** (Examples 13-15): Draft-to-polish, retro enhancement, modern indie polish

Each example shows complete MCP tool call syntax with professional techniques that transform amateur pixel art into polished, professional assets.
