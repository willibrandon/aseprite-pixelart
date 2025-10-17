# Pixel Art Creator Examples

This document provides concrete examples of how the pixel-art-creator skill handles various pixel art creation tasks. Each example shows the user's request, the step-by-step approach, actual MCP tool calls with parameters, and the expected results.

Examples are organized by complexity, from basic shapes to complex layered scenes.

---

## Basic Shapes

### Example 1: Simple 8x8 Heart Icon

**User Request:**
> "Create a simple red heart icon, 8x8 pixels"

**Approach:**
1. Create a small 8x8 canvas in indexed color mode
2. Set up a simple palette with red and black
3. Draw the heart shape pixel by pixel
4. Save the file

**Tool Calls:**
```javascript
mcp__aseprite__create_canvas({
  width: 8,
  height: 8,
  colorMode: "indexed",
  name: "heart-icon"
})

mcp__aseprite__set_palette({
  colors: [
    { r: 0, g: 0, b: 0 },      // Index 0: Black (transparent)
    { r: 255, g: 0, b: 0 }     // Index 1: Red
  ]
})

mcp__aseprite__draw_pixels({
  pixels: [
    { x: 1, y: 1, colorIndex: 1 }, { x: 2, y: 1, colorIndex: 1 },
    { x: 5, y: 1, colorIndex: 1 }, { x: 6, y: 1, colorIndex: 1 },
    { x: 0, y: 2, colorIndex: 1 }, { x: 1, y: 2, colorIndex: 1 },
    { x: 2, y: 2, colorIndex: 1 }, { x: 3, y: 2, colorIndex: 1 },
    { x: 4, y: 2, colorIndex: 1 }, { x: 5, y: 2, colorIndex: 1 },
    { x: 6, y: 2, colorIndex: 1 }, { x: 7, y: 2, colorIndex: 1 },
    { x: 0, y: 3, colorIndex: 1 }, { x: 1, y: 3, colorIndex: 1 },
    { x: 2, y: 3, colorIndex: 1 }, { x: 3, y: 3, colorIndex: 1 },
    { x: 4, y: 3, colorIndex: 1 }, { x: 5, y: 3, colorIndex: 1 },
    { x: 6, y: 3, colorIndex: 1 }, { x: 7, y: 3, colorIndex: 1 },
    { x: 1, y: 4, colorIndex: 1 }, { x: 2, y: 4, colorIndex: 1 },
    { x: 3, y: 4, colorIndex: 1 }, { x: 4, y: 4, colorIndex: 1 },
    { x: 5, y: 4, colorIndex: 1 }, { x: 6, y: 4, colorIndex: 1 },
    { x: 2, y: 5, colorIndex: 1 }, { x: 3, y: 5, colorIndex: 1 },
    { x: 4, y: 5, colorIndex: 1 }, { x: 5, y: 5, colorIndex: 1 },
    { x: 3, y: 6, colorIndex: 1 }, { x: 4, y: 6, colorIndex: 1 }
  ]
})
```

**Result:**
A classic 8x8 pixel heart icon in pure red, suitable for UI elements or game items.

**Visual Description:**
The Aseprite canvas shows a small red heart with a symmetrical shape. The heart has two rounded lobes at the top, tapering to a point at the bottom, all rendered in solid red pixels against a transparent background.

---

### Example 2: 16x16 Star Icon

**User Request:**
> "Make a yellow star icon, 16x16 pixels with a dark blue background"

**Approach:**
1. Create 16x16 canvas with indexed color mode
2. Set palette with yellow, dark blue, and transparent
3. Fill background with dark blue
4. Draw star shape on top

**Tool Calls:**
```javascript
mcp__aseprite__create_canvas({
  width: 16,
  height: 16,
  colorMode: "indexed",
  name: "star-icon"
})

mcp__aseprite__set_palette({
  colors: [
    { r: 0, g: 0, b: 0 },        // Index 0: Transparent
    { r: 20, g: 30, b: 80 },     // Index 1: Dark blue
    { r: 255, g: 220, b: 0 }     // Index 2: Yellow
  ]
})

// Fill background with dark blue
mcp__aseprite__fill_area({
  x: 0,
  y: 0,
  colorIndex: 1
})

// Draw star shape
mcp__aseprite__draw_pixels({
  pixels: [
    // Top point
    { x: 7, y: 1, colorIndex: 2 }, { x: 8, y: 1, colorIndex: 2 },
    { x: 7, y: 2, colorIndex: 2 }, { x: 8, y: 2, colorIndex: 2 },
    // Upper left and right arms
    { x: 5, y: 3, colorIndex: 2 }, { x: 6, y: 3, colorIndex: 2 },
    { x: 7, y: 3, colorIndex: 2 }, { x: 8, y: 3, colorIndex: 2 },
    { x: 9, y: 3, colorIndex: 2 }, { x: 10, y: 3, colorIndex: 2 },
    { x: 3, y: 4, colorIndex: 2 }, { x: 4, y: 4, colorIndex: 2 },
    { x: 5, y: 4, colorIndex: 2 }, { x: 6, y: 4, colorIndex: 2 },
    { x: 7, y: 4, colorIndex: 2 }, { x: 8, y: 4, colorIndex: 2 },
    { x: 9, y: 4, colorIndex: 2 }, { x: 10, y: 4, colorIndex: 2 },
    { x: 11, y: 4, colorIndex: 2 }, { x: 12, y: 4, colorIndex: 2 },
    // Middle section
    { x: 5, y: 5, colorIndex: 2 }, { x: 6, y: 5, colorIndex: 2 },
    { x: 7, y: 5, colorIndex: 2 }, { x: 8, y: 5, colorIndex: 2 },
    { x: 9, y: 5, colorIndex: 2 }, { x: 10, y: 5, colorIndex: 2 },
    { x: 6, y: 6, colorIndex: 2 }, { x: 7, y: 6, colorIndex: 2 },
    { x: 8, y: 6, colorIndex: 2 }, { x: 9, y: 6, colorIndex: 2 },
    // Lower left and right points
    { x: 2, y: 7, colorIndex: 2 }, { x: 3, y: 7, colorIndex: 2 },
    { x: 6, y: 7, colorIndex: 2 }, { x: 7, y: 7, colorIndex: 2 },
    { x: 8, y: 7, colorIndex: 2 }, { x: 9, y: 7, colorIndex: 2 },
    { x: 12, y: 7, colorIndex: 2 }, { x: 13, y: 7, colorIndex: 2 },
    { x: 1, y: 8, colorIndex: 2 }, { x: 2, y: 8, colorIndex: 2 },
    { x: 6, y: 8, colorIndex: 2 }, { x: 7, y: 8, colorIndex: 2 },
    { x: 8, y: 8, colorIndex: 2 }, { x: 9, y: 8, colorIndex: 2 },
    { x: 13, y: 8, colorIndex: 2 }, { x: 14, y: 8, colorIndex: 2 },
    { x: 5, y: 9, colorIndex: 2 }, { x: 6, y: 9, colorIndex: 2 },
    { x: 7, y: 9, colorIndex: 2 }, { x: 8, y: 9, colorIndex: 2 },
    { x: 9, y: 9, colorIndex: 2 }, { x: 10, y: 9, colorIndex: 2 },
    // Bottom points
    { x: 5, y: 10, colorIndex: 2 }, { x: 6, y: 10, colorIndex: 2 },
    { x: 7, y: 10, colorIndex: 2 }, { x: 8, y: 10, colorIndex: 2 },
    { x: 9, y: 10, colorIndex: 2 }, { x: 10, y: 10, colorIndex: 2 },
    { x: 6, y: 11, colorIndex: 2 }, { x: 7, y: 11, colorIndex: 2 },
    { x: 8, y: 11, colorIndex: 2 }, { x: 9, y: 11, colorIndex: 2 },
    { x: 7, y: 12, colorIndex: 2 }, { x: 8, y: 12, colorIndex: 2 },
    { x: 7, y: 13, colorIndex: 2 }, { x: 8, y: 13, colorIndex: 2 },
    { x: 7, y: 14, colorIndex: 2 }
  ]
})
```

**Result:**
A bright yellow five-pointed star on a dark blue background, ideal for collectible items or achievement icons.

**Visual Description:**
The canvas displays a yellow star with five distinct points against a dark blue background. The star has a classic silhouette with sharp points extending outward from the center.

---

### Example 3: Simple Sword Sprite

**User Request:**
> "Create a basic 16x16 sword sprite, gray blade with brown handle"

**Approach:**
1. Create 16x16 indexed canvas
2. Set palette with gray, brown, and black for outlines
3. Draw the blade vertically
4. Add handle at bottom
5. Add black outline for definition

**Tool Calls:**
```javascript
mcp__aseprite__create_canvas({
  width: 16,
  height: 16,
  colorMode: "indexed",
  name: "sword-sprite"
})

mcp__aseprite__set_palette({
  colors: [
    { r: 0, g: 0, b: 0 },        // Index 0: Transparent
    { r: 40, g: 40, b: 40 },     // Index 1: Dark outline
    { r: 180, g: 180, b: 190 },  // Index 2: Gray blade
    { r: 139, g: 90, b: 43 }     // Index 3: Brown handle
  ]
})

mcp__aseprite__draw_pixels({
  pixels: [
    // Blade point
    { x: 8, y: 0, colorIndex: 2 },
    { x: 7, y: 1, colorIndex: 1 }, { x: 8, y: 1, colorIndex: 2 }, { x: 9, y: 1, colorIndex: 1 },
    // Main blade
    { x: 7, y: 2, colorIndex: 1 }, { x: 8, y: 2, colorIndex: 2 }, { x: 9, y: 2, colorIndex: 1 },
    { x: 7, y: 3, colorIndex: 1 }, { x: 8, y: 3, colorIndex: 2 }, { x: 9, y: 3, colorIndex: 1 },
    { x: 7, y: 4, colorIndex: 1 }, { x: 8, y: 4, colorIndex: 2 }, { x: 9, y: 4, colorIndex: 1 },
    { x: 7, y: 5, colorIndex: 1 }, { x: 8, y: 5, colorIndex: 2 }, { x: 9, y: 5, colorIndex: 1 },
    { x: 7, y: 6, colorIndex: 1 }, { x: 8, y: 6, colorIndex: 2 }, { x: 9, y: 6, colorIndex: 1 },
    { x: 7, y: 7, colorIndex: 1 }, { x: 8, y: 7, colorIndex: 2 }, { x: 9, y: 7, colorIndex: 1 },
    { x: 7, y: 8, colorIndex: 1 }, { x: 8, y: 8, colorIndex: 2 }, { x: 9, y: 8, colorIndex: 1 },
    // Guard (crossguard)
    { x: 5, y: 9, colorIndex: 1 }, { x: 6, y: 9, colorIndex: 1 },
    { x: 7, y: 9, colorIndex: 1 }, { x: 8, y: 9, colorIndex: 1 },
    { x: 9, y: 9, colorIndex: 1 }, { x: 10, y: 9, colorIndex: 1 },
    { x: 11, y: 9, colorIndex: 1 },
    // Handle
    { x: 7, y: 10, colorIndex: 1 }, { x: 8, y: 10, colorIndex: 3 }, { x: 9, y: 10, colorIndex: 1 },
    { x: 7, y: 11, colorIndex: 1 }, { x: 8, y: 11, colorIndex: 3 }, { x: 9, y: 11, colorIndex: 1 },
    { x: 7, y: 12, colorIndex: 1 }, { x: 8, y: 12, colorIndex: 3 }, { x: 9, y: 12, colorIndex: 1 },
    { x: 7, y: 13, colorIndex: 1 }, { x: 8, y: 13, colorIndex: 3 }, { x: 9, y: 13, colorIndex: 1 },
    // Pommel
    { x: 7, y: 14, colorIndex: 1 }, { x: 8, y: 14, colorIndex: 1 }, { x: 9, y: 14, colorIndex: 1 },
    { x: 7, y: 15, colorIndex: 1 }, { x: 8, y: 15, colorIndex: 1 }, { x: 9, y: 15, colorIndex: 1 }
  ]
})
```

**Result:**
A classic RPG-style sword sprite with clear blade, guard, handle, and pommel sections.

**Visual Description:**
The sprite shows a vertical sword with a pointed gray blade, a dark crossguard, brown handle grip, and a square pommel at the bottom. Black outlines define each section clearly.

---

### Example 4: Geometric Diamond Gem

**User Request:**
> "Make a shiny diamond gem sprite, 24x24, with cyan and white highlights"

**Approach:**
1. Create 24x24 canvas
2. Set palette with cyan shades and white
3. Draw diamond outline
4. Fill with gradient of cyan colors
5. Add white highlights for shine effect

**Tool Calls:**
```javascript
mcp__aseprite__create_canvas({
  width: 24,
  height: 24,
  colorMode: "indexed",
  name: "diamond-gem"
})

mcp__aseprite__set_palette({
  colors: [
    { r: 0, g: 0, b: 0 },        // Index 0: Transparent
    { r: 30, g: 30, b: 50 },     // Index 1: Dark outline
    { r: 0, g: 150, b: 200 },    // Index 2: Dark cyan
    { r: 0, g: 200, b: 240 },    // Index 3: Medium cyan
    { r: 100, g: 230, b: 255 },  // Index 4: Light cyan
    { r: 255, g: 255, b: 255 }   // Index 5: White highlight
  ]
})

mcp__aseprite__draw_pixels({
  pixels: [
    // Top facet (outline)
    { x: 11, y: 3, colorIndex: 1 }, { x: 12, y: 3, colorIndex: 1 },
    { x: 9, y: 4, colorIndex: 1 }, { x: 10, y: 4, colorIndex: 5 },
    { x: 11, y: 4, colorIndex: 5 }, { x: 12, y: 4, colorIndex: 5 },
    { x: 13, y: 4, colorIndex: 5 }, { x: 14, y: 4, colorIndex: 1 },
    // Upper facets
    { x: 7, y: 5, colorIndex: 1 }, { x: 8, y: 5, colorIndex: 4 },
    { x: 9, y: 5, colorIndex: 4 }, { x: 10, y: 5, colorIndex: 5 },
    { x: 11, y: 5, colorIndex: 5 }, { x: 12, y: 5, colorIndex: 5 },
    { x: 13, y: 5, colorIndex: 4 }, { x: 14, y: 5, colorIndex: 4 },
    { x: 15, y: 5, colorIndex: 4 }, { x: 16, y: 5, colorIndex: 1 },
    // Middle section with gradient
    { x: 5, y: 6, colorIndex: 1 }, { x: 6, y: 6, colorIndex: 3 },
    { x: 7, y: 6, colorIndex: 3 }, { x: 8, y: 6, colorIndex: 4 },
    { x: 9, y: 6, colorIndex: 4 }, { x: 10, y: 6, colorIndex: 5 },
    { x: 11, y: 6, colorIndex: 5 }, { x: 12, y: 6, colorIndex: 4 },
    { x: 13, y: 6, colorIndex: 4 }, { x: 14, y: 6, colorIndex: 3 },
    { x: 15, y: 6, colorIndex: 3 }, { x: 16, y: 6, colorIndex: 3 },
    { x: 17, y: 6, colorIndex: 3 }, { x: 18, y: 6, colorIndex: 1 },
    // Continue middle facets
    { x: 4, y: 7, colorIndex: 1 }, { x: 5, y: 7, colorIndex: 2 },
    { x: 6, y: 7, colorIndex: 3 }, { x: 7, y: 7, colorIndex: 3 },
    { x: 8, y: 7, colorIndex: 3 }, { x: 9, y: 7, colorIndex: 4 },
    { x: 10, y: 7, colorIndex: 4 }, { x: 11, y: 7, colorIndex: 4 },
    { x: 12, y: 7, colorIndex: 3 }, { x: 13, y: 7, colorIndex: 3 },
    { x: 14, y: 7, colorIndex: 3 }, { x: 15, y: 7, colorIndex: 3 },
    { x: 16, y: 7, colorIndex: 3 }, { x: 17, y: 7, colorIndex: 2 },
    { x: 18, y: 7, colorIndex: 2 }, { x: 19, y: 7, colorIndex: 1 },
    // Lower facets tapering down
    { x: 5, y: 8, colorIndex: 1 }, { x: 6, y: 8, colorIndex: 2 },
    { x: 7, y: 8, colorIndex: 2 }, { x: 8, y: 8, colorIndex: 3 },
    { x: 9, y: 8, colorIndex: 3 }, { x: 10, y: 8, colorIndex: 3 },
    { x: 11, y: 8, colorIndex: 3 }, { x: 12, y: 8, colorIndex: 3 },
    { x: 13, y: 8, colorIndex: 3 }, { x: 14, y: 8, colorIndex: 3 },
    { x: 15, y: 8, colorIndex: 2 }, { x: 16, y: 8, colorIndex: 2 },
    { x: 17, y: 8, colorIndex: 2 }, { x: 18, y: 8, colorIndex: 1 },
    // Bottom point progression
    { x: 6, y: 9, colorIndex: 1 }, { x: 7, y: 9, colorIndex: 2 },
    { x: 8, y: 9, colorIndex: 2 }, { x: 9, y: 9, colorIndex: 2 },
    { x: 10, y: 9, colorIndex: 3 }, { x: 11, y: 9, colorIndex: 3 },
    { x: 12, y: 9, colorIndex: 2 }, { x: 13, y: 9, colorIndex: 2 },
    { x: 14, y: 9, colorIndex: 2 }, { x: 15, y: 9, colorIndex: 2 },
    { x: 16, y: 9, colorIndex: 2 }, { x: 17, y: 9, colorIndex: 1 },
    { x: 7, y: 10, colorIndex: 1 }, { x: 8, y: 10, colorIndex: 2 },
    { x: 9, y: 10, colorIndex: 2 }, { x: 10, y: 10, colorIndex: 2 },
    { x: 11, y: 10, colorIndex: 2 }, { x: 12, y: 10, colorIndex: 2 },
    { x: 13, y: 10, colorIndex: 2 }, { x: 14, y: 10, colorIndex: 2 },
    { x: 15, y: 10, colorIndex: 2 }, { x: 16, y: 10, colorIndex: 1 },
    { x: 8, y: 11, colorIndex: 1 }, { x: 9, y: 11, colorIndex: 2 },
    { x: 10, y: 11, colorIndex: 2 }, { x: 11, y: 11, colorIndex: 2 },
    { x: 12, y: 11, colorIndex: 2 }, { x: 13, y: 11, colorIndex: 2 },
    { x: 14, y: 11, colorIndex: 2 }, { x: 15, y: 11, colorIndex: 1 },
    { x: 9, y: 12, colorIndex: 1 }, { x: 10, y: 12, colorIndex: 2 },
    { x: 11, y: 12, colorIndex: 2 }, { x: 12, y: 12, colorIndex: 2 },
    { x: 13, y: 12, colorIndex: 2 }, { x: 14, y: 12, colorIndex: 1 },
    { x: 10, y: 13, colorIndex: 1 }, { x: 11, y: 13, colorIndex: 2 },
    { x: 12, y: 13, colorIndex: 2 }, { x: 13, y: 13, colorIndex: 1 },
    { x: 11, y: 14, colorIndex: 1 }, { x: 12, y: 14, colorIndex: 1 }
  ]
})
```

**Result:**
A faceted diamond gem with cyan coloring, white highlights at the top for sparkle, and darker shades toward the bottom.

**Visual Description:**
The gem has a classic diamond cut appearance with a bright white highlight at the very top, transitioning through light cyan in the upper facets to darker cyan shades in the lower portions, creating a three-dimensional effect.

---

## Layered Sprites

### Example 5: Character with Background

**User Request:**
> "Create a simple 32x32 character sprite on a grass background, use separate layers"

**Approach:**
1. Create 32x32 RGB canvas
2. Create background layer and draw grass
3. Create character layer
4. Draw simple stick figure character
5. Keep layers separate for easy editing

**Tool Calls:**
```javascript
mcp__aseprite__create_canvas({
  width: 32,
  height: 32,
  colorMode: "rgb",
  name: "character-on-grass"
})

// Create background layer
mcp__aseprite__add_layer({
  name: "background"
})

// Draw grass background
mcp__aseprite__draw_pixels({
  layer: "background",
  pixels: Array.from({ length: 32 * 32 }, (_, i) => ({
    x: i % 32,
    y: Math.floor(i / 32),
    color: { r: 34, g: 139, b: 34, a: 255 }  // Forest green
  }))
})

// Add some grass detail
mcp__aseprite__draw_pixels({
  layer: "background",
  pixels: [
    // Lighter grass blades scattered
    { x: 5, y: 28, color: { r: 50, g: 180, b: 50, a: 255 } },
    { x: 12, y: 29, color: { r: 50, g: 180, b: 50, a: 255 } },
    { x: 18, y: 27, color: { r: 50, g: 180, b: 50, a: 255 } },
    { x: 24, y: 30, color: { r: 50, g: 180, b: 50, a: 255 } }
  ]
})

// Create character layer
mcp__aseprite__add_layer({
  name: "character"
})

// Draw character - head, body, arms, legs
mcp__aseprite__draw_pixels({
  layer: "character",
  pixels: [
    // Head outline (brown circle)
    { x: 14, y: 8, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 15, y: 8, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 16, y: 8, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 17, y: 8, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 13, y: 9, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 18, y: 9, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 13, y: 10, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 18, y: 10, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 14, y: 11, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 15, y: 11, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 16, y: 11, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 17, y: 11, color: { r: 139, g: 90, b: 43, a: 255 } },
    // Eyes
    { x: 14, y: 9, color: { r: 0, g: 0, b: 0, a: 255 } },
    { x: 17, y: 9, color: { r: 0, g: 0, b: 0, a: 255 } },
    // Body (blue shirt)
    { x: 15, y: 12, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 16, y: 12, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 14, y: 13, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 15, y: 13, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 16, y: 13, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 17, y: 13, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 14, y: 14, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 15, y: 14, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 16, y: 14, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 17, y: 14, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 15, y: 15, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 16, y: 15, color: { r: 50, g: 100, b: 200, a: 255 } },
    // Arms
    { x: 13, y: 13, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 18, y: 13, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 12, y: 14, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 19, y: 14, color: { r: 139, g: 90, b: 43, a: 255 } },
    // Legs (brown pants)
    { x: 15, y: 16, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 16, y: 16, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 15, y: 17, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 16, y: 17, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 14, y: 18, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 17, y: 18, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 14, y: 19, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 17, y: 19, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 14, y: 20, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 17, y: 20, color: { r: 101, g: 67, b: 33, a: 255 } },
    // Feet (black shoes)
    { x: 13, y: 21, color: { r: 40, g: 40, b: 40, a: 255 } },
    { x: 14, y: 21, color: { r: 40, g: 40, b: 40, a: 255 } },
    { x: 17, y: 21, color: { r: 40, g: 40, b: 40, a: 255 } },
    { x: 18, y: 21, color: { r: 40, g: 40, b: 40, a: 255 } }
  ]
})
```

**Result:**
A simple character sprite standing on grass, with two separate layers allowing independent editing of character and background.

**Visual Description:**
The background layer shows solid green grass with lighter green accent pixels. The character layer displays a simple humanoid figure with a brown head, blue shirt, brown arms and pants, and black shoes. The character appears to be standing on the grass.

---

### Example 6: Coin with Shadow

**User Request:**
> "Make a gold coin sprite with a shadow layer underneath, 16x16"

**Approach:**
1. Create 16x16 indexed canvas
2. Create shadow layer with semi-transparent shadow
3. Create coin layer with gold gradient
4. Add highlight details

**Tool Calls:**
```javascript
mcp__aseprite__create_canvas({
  width: 16,
  height: 16,
  colorMode: "indexed",
  name: "gold-coin"
})

mcp__aseprite__set_palette({
  colors: [
    { r: 0, g: 0, b: 0 },          // Index 0: Transparent
    { r: 100, g: 80, b: 0 },       // Index 1: Dark gold
    { r: 180, g: 140, b: 0 },      // Index 2: Medium gold
    { r: 255, g: 215, b: 0 },      // Index 3: Bright gold
    { r: 255, g: 255, b: 200 },    // Index 4: Highlight
    { r: 50, g: 50, b: 50 }        // Index 5: Shadow
  ]
})

// Create shadow layer
mcp__aseprite__add_layer({
  name: "shadow"
})

// Draw shadow
mcp__aseprite__draw_pixels({
  layer: "shadow",
  pixels: [
    { x: 6, y: 13, colorIndex: 5 }, { x: 7, y: 13, colorIndex: 5 },
    { x: 8, y: 13, colorIndex: 5 }, { x: 9, y: 13, colorIndex: 5 },
    { x: 5, y: 14, colorIndex: 5 }, { x: 6, y: 14, colorIndex: 5 },
    { x: 7, y: 14, colorIndex: 5 }, { x: 8, y: 14, colorIndex: 5 },
    { x: 9, y: 14, colorIndex: 5 }, { x: 10, y: 14, colorIndex: 5 }
  ]
})

// Create coin layer
mcp__aseprite__add_layer({
  name: "coin"
})

// Draw coin with gradient
mcp__aseprite__draw_pixels({
  layer: "coin",
  pixels: [
    // Top edge (bright highlight)
    { x: 6, y: 3, colorIndex: 3 }, { x: 7, y: 3, colorIndex: 3 },
    { x: 8, y: 3, colorIndex: 3 }, { x: 9, y: 3, colorIndex: 3 },
    // Upper section with bright spot
    { x: 5, y: 4, colorIndex: 3 }, { x: 6, y: 4, colorIndex: 4 },
    { x: 7, y: 4, colorIndex: 4 }, { x: 8, y: 4, colorIndex: 3 },
    { x: 9, y: 4, colorIndex: 3 }, { x: 10, y: 4, colorIndex: 3 },
    { x: 4, y: 5, colorIndex: 3 }, { x: 5, y: 5, colorIndex: 3 },
    { x: 6, y: 5, colorIndex: 4 }, { x: 7, y: 5, colorIndex: 3 },
    { x: 8, y: 5, colorIndex: 3 }, { x: 9, y: 5, colorIndex: 2 },
    { x: 10, y: 5, colorIndex: 2 }, { x: 11, y: 5, colorIndex: 2 },
    // Middle section
    { x: 3, y: 6, colorIndex: 3 }, { x: 4, y: 6, colorIndex: 3 },
    { x: 5, y: 6, colorIndex: 3 }, { x: 6, y: 6, colorIndex: 3 },
    { x: 7, y: 6, colorIndex: 2 }, { x: 8, y: 6, colorIndex: 2 },
    { x: 9, y: 6, colorIndex: 2 }, { x: 10, y: 6, colorIndex: 2 },
    { x: 11, y: 6, colorIndex: 2 }, { x: 12, y: 6, colorIndex: 2 },
    { x: 3, y: 7, colorIndex: 2 }, { x: 4, y: 7, colorIndex: 2 },
    { x: 5, y: 7, colorIndex: 2 }, { x: 6, y: 7, colorIndex: 2 },
    { x: 7, y: 7, colorIndex: 2 }, { x: 8, y: 7, colorIndex: 2 },
    { x: 9, y: 7, colorIndex: 2 }, { x: 10, y: 7, colorIndex: 1 },
    { x: 11, y: 7, colorIndex: 1 }, { x: 12, y: 7, colorIndex: 1 },
    // Lower section (darker)
    { x: 3, y: 8, colorIndex: 2 }, { x: 4, y: 8, colorIndex: 2 },
    { x: 5, y: 8, colorIndex: 2 }, { x: 6, y: 8, colorIndex: 2 },
    { x: 7, y: 8, colorIndex: 1 }, { x: 8, y: 8, colorIndex: 1 },
    { x: 9, y: 8, colorIndex: 1 }, { x: 10, y: 8, colorIndex: 1 },
    { x: 11, y: 8, colorIndex: 1 }, { x: 12, y: 8, colorIndex: 1 },
    { x: 4, y: 9, colorIndex: 2 }, { x: 5, y: 9, colorIndex: 1 },
    { x: 6, y: 9, colorIndex: 1 }, { x: 7, y: 9, colorIndex: 1 },
    { x: 8, y: 9, colorIndex: 1 }, { x: 9, y: 9, colorIndex: 1 },
    { x: 10, y: 9, colorIndex: 1 }, { x: 11, y: 9, colorIndex: 1 },
    // Bottom edge
    { x: 5, y: 10, colorIndex: 1 }, { x: 6, y: 10, colorIndex: 1 },
    { x: 7, y: 10, colorIndex: 1 }, { x: 8, y: 10, colorIndex: 1 },
    { x: 9, y: 10, colorIndex: 1 }, { x: 10, y: 10, colorIndex: 1 },
    { x: 6, y: 11, colorIndex: 1 }, { x: 7, y: 11, colorIndex: 1 },
    { x: 8, y: 11, colorIndex: 1 }, { x: 9, y: 11, colorIndex: 1 }
  ]
})
```

**Result:**
A shiny gold coin with a gradient from bright at top-left to dark at bottom-right, positioned above a subtle shadow.

**Visual Description:**
The sprite shows a circular gold coin with a bright highlight in the upper-left creating a metallic shine effect. A dark shadow appears below and slightly offset from the coin, giving depth. The layers panel shows "shadow" and "coin" as separate layers.

---

## Indexed Color & Retro Styles

### Example 7: Game Boy Style Sprite

**User Request:**
> "Make a Game Boy style character sprite, using only the 4 original Game Boy colors"

**Approach:**
1. Create 32x32 indexed canvas
2. Set authentic Game Boy palette (4 greens)
3. Draw character using only those 4 colors
4. Create retro aesthetic with limited palette

**Tool Calls:**
```javascript
mcp__aseprite__create_canvas({
  width: 32,
  height: 32,
  colorMode: "indexed",
  name: "gameboy-character"
})

// Authentic Game Boy DMG-01 palette
mcp__aseprite__set_palette({
  colors: [
    { r: 15, g: 56, b: 15 },      // Index 0: Darkest green (almost black)
    { r: 48, g: 98, b: 48 },      // Index 1: Dark green
    { r: 139, g: 172, b: 15 },    // Index 2: Light green
    { r: 155, g: 188, b: 15 }     // Index 3: Lightest green (almost white)
  ]
})

mcp__aseprite__draw_pixels({
  pixels: [
    // Character head (lightest color)
    { x: 13, y: 8, colorIndex: 3 }, { x: 14, y: 8, colorIndex: 3 },
    { x: 15, y: 8, colorIndex: 3 }, { x: 16, y: 8, colorIndex: 3 },
    { x: 17, y: 8, colorIndex: 3 }, { x: 18, y: 8, colorIndex: 3 },
    { x: 12, y: 9, colorIndex: 3 }, { x: 13, y: 9, colorIndex: 3 },
    { x: 14, y: 9, colorIndex: 0 }, { x: 15, y: 9, colorIndex: 3 },  // Left eye
    { x: 16, y: 9, colorIndex: 3 }, { x: 17, y: 9, colorIndex: 0 },  // Right eye
    { x: 18, y: 9, colorIndex: 3 }, { x: 19, y: 9, colorIndex: 3 },
    { x: 12, y: 10, colorIndex: 3 }, { x: 13, y: 10, colorIndex: 3 },
    { x: 14, y: 10, colorIndex: 3 }, { x: 15, y: 10, colorIndex: 3 },
    { x: 16, y: 10, colorIndex: 3 }, { x: 17, y: 10, colorIndex: 3 },
    { x: 18, y: 10, colorIndex: 3 }, { x: 19, y: 10, colorIndex: 3 },
    { x: 13, y: 11, colorIndex: 3 }, { x: 14, y: 11, colorIndex: 3 },
    { x: 15, y: 11, colorIndex: 3 }, { x: 16, y: 11, colorIndex: 3 },
    { x: 17, y: 11, colorIndex: 3 }, { x: 18, y: 11, colorIndex: 3 },
    // Body (light green shirt)
    { x: 14, y: 12, colorIndex: 2 }, { x: 15, y: 12, colorIndex: 2 },
    { x: 16, y: 12, colorIndex: 2 }, { x: 17, y: 12, colorIndex: 2 },
    { x: 12, y: 13, colorIndex: 2 }, { x: 13, y: 13, colorIndex: 2 },
    { x: 14, y: 13, colorIndex: 2 }, { x: 15, y: 13, colorIndex: 2 },
    { x: 16, y: 13, colorIndex: 2 }, { x: 17, y: 13, colorIndex: 2 },
    { x: 18, y: 13, colorIndex: 2 }, { x: 19, y: 13, colorIndex: 2 },
    { x: 12, y: 14, colorIndex: 2 }, { x: 13, y: 14, colorIndex: 2 },
    { x: 14, y: 14, colorIndex: 2 }, { x: 15, y: 14, colorIndex: 2 },
    { x: 16, y: 14, colorIndex: 2 }, { x: 17, y: 14, colorIndex: 2 },
    { x: 18, y: 14, colorIndex: 2 }, { x: 19, y: 14, colorIndex: 2 },
    { x: 14, y: 15, colorIndex: 2 }, { x: 15, y: 15, colorIndex: 2 },
    { x: 16, y: 15, colorIndex: 2 }, { x: 17, y: 15, colorIndex: 2 },
    // Pants (dark green)
    { x: 14, y: 16, colorIndex: 1 }, { x: 15, y: 16, colorIndex: 1 },
    { x: 16, y: 16, colorIndex: 1 }, { x: 17, y: 16, colorIndex: 1 },
    { x: 14, y: 17, colorIndex: 1 }, { x: 15, y: 17, colorIndex: 1 },
    { x: 16, y: 17, colorIndex: 1 }, { x: 17, y: 17, colorIndex: 1 },
    { x: 13, y: 18, colorIndex: 1 }, { x: 14, y: 18, colorIndex: 1 },
    { x: 17, y: 18, colorIndex: 1 }, { x: 18, y: 18, colorIndex: 1 },
    { x: 13, y: 19, colorIndex: 1 }, { x: 14, y: 19, colorIndex: 1 },
    { x: 17, y: 19, colorIndex: 1 }, { x: 18, y: 19, colorIndex: 1 },
    { x: 13, y: 20, colorIndex: 1 }, { x: 14, y: 20, colorIndex: 1 },
    { x: 17, y: 20, colorIndex: 1 }, { x: 18, y: 20, colorIndex: 1 },
    // Feet (darkest)
    { x: 12, y: 21, colorIndex: 0 }, { x: 13, y: 21, colorIndex: 0 },
    { x: 14, y: 21, colorIndex: 0 }, { x: 17, y: 21, colorIndex: 0 },
    { x: 18, y: 21, colorIndex: 0 }, { x: 19, y: 21, colorIndex: 0 }
  ]
})
```

**Result:**
An authentic Game Boy DMG-01 style character using the original 4-color green palette.

**Visual Description:**
The sprite has the characteristic monochrome green look of original Game Boy games. The character has a pale green head with black dot eyes, a mid-tone green shirt, darker green pants, and nearly black shoes. The limited palette creates a nostalgic retro gaming aesthetic.

---

### Example 8: NES Style Enemy Sprite

**User Request:**
> "Create a retro NES enemy sprite like a slime monster, 16x16, limited color palette"

**Approach:**
1. Create 16x16 indexed canvas
2. Use NES-style limited palette (5-6 colors)
3. Draw simple enemy design
4. Add basic shading with palette

**Tool Calls:**
```javascript
mcp__aseprite__create_canvas({
  width: 16,
  height: 16,
  colorMode: "indexed",
  name: "nes-slime-enemy"
})

// NES-style palette (limited colors)
mcp__aseprite__set_palette({
  colors: [
    { r: 0, g: 0, b: 0 },          // Index 0: Transparent
    { r: 0, g: 128, b: 0 },        // Index 1: Dark green
    { r: 0, g: 200, b: 0 },        // Index 2: Medium green
    { r: 100, g: 255, b: 100 },    // Index 3: Light green
    { r: 255, g: 255, b: 255 },    // Index 4: White (highlights)
    { r: 50, g: 50, b: 50 }        // Index 5: Dark gray (outline)
  ]
})

mcp__aseprite__draw_pixels({
  pixels: [
    // Outline and shape
    { x: 4, y: 6, colorIndex: 5 }, { x: 5, y: 6, colorIndex: 5 },
    { x: 6, y: 6, colorIndex: 5 }, { x: 7, y: 6, colorIndex: 5 },
    { x: 8, y: 6, colorIndex: 5 }, { x: 9, y: 6, colorIndex: 5 },
    { x: 10, y: 6, colorIndex: 5 }, { x: 11, y: 6, colorIndex: 5 },
    // Upper body with highlights
    { x: 3, y: 7, colorIndex: 5 }, { x: 4, y: 7, colorIndex: 3 },
    { x: 5, y: 7, colorIndex: 4 }, { x: 6, y: 7, colorIndex: 3 },
    { x: 7, y: 7, colorIndex: 3 }, { x: 8, y: 7, colorIndex: 3 },
    { x: 9, y: 7, colorIndex: 3 }, { x: 10, y: 7, colorIndex: 3 },
    { x: 11, y: 7, colorIndex: 3 }, { x: 12, y: 7, colorIndex: 5 },
    { x: 2, y: 8, colorIndex: 5 }, { x: 3, y: 8, colorIndex: 3 },
    { x: 4, y: 8, colorIndex: 3 }, { x: 5, y: 8, colorIndex: 3 },
    { x: 6, y: 8, colorIndex: 2 }, { x: 7, y: 8, colorIndex: 2 },
    { x: 8, y: 8, colorIndex: 2 }, { x: 9, y: 8, colorIndex: 2 },
    { x: 10, y: 8, colorIndex: 3 }, { x: 11, y: 8, colorIndex: 3 },
    { x: 12, y: 8, colorIndex: 3 }, { x: 13, y: 8, colorIndex: 5 },
    // Eyes
    { x: 2, y: 9, colorIndex: 5 }, { x: 3, y: 9, colorIndex: 2 },
    { x: 4, y: 9, colorIndex: 5 }, { x: 5, y: 9, colorIndex: 4 },
    { x: 6, y: 9, colorIndex: 2 }, { x: 7, y: 9, colorIndex: 2 },
    { x: 8, y: 9, colorIndex: 2 }, { x: 9, y: 9, colorIndex: 2 },
    { x: 10, y: 9, colorIndex: 5 }, { x: 11, y: 9, colorIndex: 4 },
    { x: 12, y: 9, colorIndex: 2 }, { x: 13, y: 9, colorIndex: 5 },
    // Middle body
    { x: 1, y: 10, colorIndex: 5 }, { x: 2, y: 10, colorIndex: 2 },
    { x: 3, y: 10, colorIndex: 2 }, { x: 4, y: 10, colorIndex: 2 },
    { x: 5, y: 10, colorIndex: 2 }, { x: 6, y: 10, colorIndex: 2 },
    { x: 7, y: 10, colorIndex: 1 }, { x: 8, y: 10, colorIndex: 1 },
    { x: 9, y: 10, colorIndex: 2 }, { x: 10, y: 10, colorIndex: 2 },
    { x: 11, y: 10, colorIndex: 2 }, { x: 12, y: 10, colorIndex: 2 },
    { x: 13, y: 10, colorIndex: 2 }, { x: 14, y: 10, colorIndex: 5 },
    // Lower body with shading
    { x: 1, y: 11, colorIndex: 5 }, { x: 2, y: 11, colorIndex: 2 },
    { x: 3, y: 11, colorIndex: 2 }, { x: 4, y: 11, colorIndex: 1 },
    { x: 5, y: 11, colorIndex: 1 }, { x: 6, y: 11, colorIndex: 1 },
    { x: 7, y: 11, colorIndex: 1 }, { x: 8, y: 11, colorIndex: 1 },
    { x: 9, y: 11, colorIndex: 1 }, { x: 10, y: 11, colorIndex: 1 },
    { x: 11, y: 11, colorIndex: 1 }, { x: 12, y: 11, colorIndex: 2 },
    { x: 13, y: 11, colorIndex: 2 }, { x: 14, y: 11, colorIndex: 5 },
    // Bottom edge
    { x: 2, y: 12, colorIndex: 5 }, { x: 3, y: 12, colorIndex: 1 },
    { x: 4, y: 12, colorIndex: 1 }, { x: 5, y: 12, colorIndex: 1 },
    { x: 6, y: 12, colorIndex: 1 }, { x: 7, y: 12, colorIndex: 1 },
    { x: 8, y: 12, colorIndex: 1 }, { x: 9, y: 12, colorIndex: 1 },
    { x: 10, y: 12, colorIndex: 1 }, { x: 11, y: 12, colorIndex: 1 },
    { x: 12, y: 12, colorIndex: 1 }, { x: 13, y: 12, colorIndex: 5 },
    // Base
    { x: 3, y: 13, colorIndex: 5 }, { x: 4, y: 13, colorIndex: 5 },
    { x: 5, y: 13, colorIndex: 5 }, { x: 6, y: 13, colorIndex: 5 },
    { x: 7, y: 13, colorIndex: 5 }, { x: 8, y: 13, colorIndex: 5 },
    { x: 9, y: 13, colorIndex: 5 }, { x: 10, y: 13, colorIndex: 5 },
    { x: 11, y: 13, colorIndex: 5 }, { x: 12, y: 13, colorIndex: 5 }
  ]
})
```

**Result:**
A retro NES-style slime enemy with simple shading, using a limited color palette typical of 8-bit games.

**Visual Description:**
The slime has a rounded blob shape with a light green top (with white highlight spot), medium green middle section showing simple dot eyes, and darker green lower body. A dark outline defines the entire shape. The style evokes classic Dragon Quest or early Final Fantasy enemies.

---

## Complex Scenes

### Example 9: Grass Tile for Tileset

**User Request:**
> "Create a seamless grass tile, 16x16, that can repeat to make a continuous ground texture"

**Approach:**
1. Create 16x16 indexed canvas
2. Set grass color palette
3. Draw base grass color
4. Add detail ensuring edges match for seamless tiling
5. Test seamless edges

**Tool Calls:**
```javascript
mcp__aseprite__create_canvas({
  width: 16,
  height: 16,
  colorMode: "indexed",
  name: "grass-tile"
})

mcp__aseprite__set_palette({
  colors: [
    { r: 0, g: 0, b: 0 },          // Index 0: Transparent
    { r: 34, g: 139, b: 34 },      // Index 1: Base grass green
    { r: 50, g: 180, b: 50 },      // Index 2: Light grass
    { r: 20, g: 100, b: 20 }       // Index 3: Dark grass
  ]
})

// Fill with base grass color
mcp__aseprite__fill_area({
  x: 0,
  y: 0,
  colorIndex: 1
})

// Add grass blade details that tile seamlessly
mcp__aseprite__draw_pixels({
  pixels: [
    // Light grass blades (placed to tile on edges)
    { x: 0, y: 2, colorIndex: 2 }, { x: 1, y: 2, colorIndex: 2 },
    { x: 3, y: 5, colorIndex: 2 },
    { x: 7, y: 3, colorIndex: 2 }, { x: 8, y: 3, colorIndex: 2 },
    { x: 11, y: 7, colorIndex: 2 },
    { x: 14, y: 1, colorIndex: 2 }, { x: 15, y: 1, colorIndex: 2 },
    { x: 5, y: 10, colorIndex: 2 },
    { x: 9, y: 12, colorIndex: 2 }, { x: 10, y: 12, colorIndex: 2 },
    { x: 13, y: 14, colorIndex: 2 },
    { x: 1, y: 15, colorIndex: 2 }, { x: 2, y: 15, colorIndex: 2 },
    { x: 15, y: 8, colorIndex: 2 }, { x: 0, y: 8, colorIndex: 2 },
    // Dark grass shadows
    { x: 2, y: 3, colorIndex: 3 },
    { x: 6, y: 6, colorIndex: 3 },
    { x: 10, y: 4, colorIndex: 3 },
    { x: 4, y: 11, colorIndex: 3 },
    { x: 12, y: 9, colorIndex: 3 },
    { x: 8, y: 13, colorIndex: 3 },
    { x: 14, y: 15, colorIndex: 3 },
    { x: 0, y: 0, colorIndex: 3 },
    { x: 15, y: 0, colorIndex: 3 },
    { x: 0, y: 15, colorIndex: 3 },
    { x: 15, y: 15, colorIndex: 3 }
  ]
})
```

**Result:**
A seamless 16x16 grass tile with varied grass blade details that repeat perfectly when placed adjacent to copies.

**Visual Description:**
The tile shows green grass with lighter and darker blade variations distributed across the surface. The detail pixels are positioned so that when the tile repeats horizontally or vertically, the pattern appears continuous without visible seams.

---

### Example 10: Treasure Chest Sprite

**User Request:**
> "Create a treasure chest sprite, 24x24, closed, with metal bands and a keyhole"

**Approach:**
1. Create 24x24 indexed canvas
2. Set palette with browns, metals, and highlights
3. Draw chest body with wood grain
4. Add metal bands and keyhole details
5. Add shading for depth

**Tool Calls:**
```javascript
mcp__aseprite__create_canvas({
  width: 24,
  height: 24,
  colorMode: "indexed",
  name: "treasure-chest"
})

mcp__aseprite__set_palette({
  colors: [
    { r: 0, g: 0, b: 0 },          // Index 0: Transparent/black outline
    { r: 101, g: 67, b: 33 },      // Index 1: Dark wood
    { r: 139, g: 90, b: 43 },      // Index 2: Medium wood
    { r: 160, g: 120, b: 60 },     // Index 3: Light wood
    { r: 80, g: 80, b: 90 },       // Index 4: Dark metal
    { r: 140, g: 140, b: 150 },    // Index 5: Light metal
    { r: 200, g: 180, b: 50 }      // Index 6: Gold keyhole
  ]
})

mcp__aseprite__draw_pixels({
  pixels: [
    // Top lid outline
    { x: 5, y: 5, colorIndex: 0 }, { x: 6, y: 5, colorIndex: 0 },
    { x: 7, y: 5, colorIndex: 0 }, { x: 8, y: 5, colorIndex: 0 },
    { x: 9, y: 5, colorIndex: 0 }, { x: 10, y: 5, colorIndex: 0 },
    { x: 11, y: 5, colorIndex: 0 }, { x: 12, y: 5, colorIndex: 0 },
    { x: 13, y: 5, colorIndex: 0 }, { x: 14, y: 5, colorIndex: 0 },
    { x: 15, y: 5, colorIndex: 0 }, { x: 16, y: 5, colorIndex: 0 },
    { x: 17, y: 5, colorIndex: 0 }, { x: 18, y: 5, colorIndex: 0 },
    // Top lid wood
    { x: 4, y: 6, colorIndex: 0 }, { x: 5, y: 6, colorIndex: 2 },
    { x: 6, y: 6, colorIndex: 3 }, { x: 7, y: 6, colorIndex: 3 },
    { x: 8, y: 6, colorIndex: 2 }, { x: 9, y: 6, colorIndex: 2 },
    { x: 10, y: 6, colorIndex: 2 }, { x: 11, y: 6, colorIndex: 3 },
    { x: 12, y: 6, colorIndex: 3 }, { x: 13, y: 6, colorIndex: 2 },
    { x: 14, y: 6, colorIndex: 2 }, { x: 15, y: 6, colorIndex: 3 },
    { x: 16, y: 6, colorIndex: 3 }, { x: 17, y: 6, colorIndex: 2 },
    { x: 18, y: 6, colorIndex: 2 }, { x: 19, y: 6, colorIndex: 0 },
    // Continue lid
    { x: 3, y: 7, colorIndex: 0 }, { x: 4, y: 7, colorIndex: 2 },
    { x: 5, y: 7, colorIndex: 3 }, { x: 6, y: 7, colorIndex: 3 },
    { x: 7, y: 7, colorIndex: 2 }, { x: 8, y: 7, colorIndex: 2 },
    { x: 9, y: 7, colorIndex: 2 }, { x: 10, y: 7, colorIndex: 3 },
    { x: 11, y: 7, colorIndex: 3 }, { x: 12, y: 7, colorIndex: 2 },
    { x: 13, y: 7, colorIndex: 2 }, { x: 14, y: 7, colorIndex: 2 },
    { x: 15, y: 7, colorIndex: 3 }, { x: 16, y: 7, colorIndex: 3 },
    { x: 17, y: 7, colorIndex: 2 }, { x: 18, y: 7, colorIndex: 2 },
    { x: 19, y: 7, colorIndex: 2 }, { x: 20, y: 7, colorIndex: 0 },
    // Metal band on lid
    { x: 3, y: 8, colorIndex: 0 }, { x: 4, y: 8, colorIndex: 4 },
    { x: 5, y: 8, colorIndex: 5 }, { x: 6, y: 8, colorIndex: 5 },
    { x: 7, y: 8, colorIndex: 4 }, { x: 8, y: 8, colorIndex: 4 },
    { x: 9, y: 8, colorIndex: 4 }, { x: 10, y: 8, colorIndex: 5 },
    { x: 11, y: 8, colorIndex: 5 }, { x: 12, y: 8, colorIndex: 4 },
    { x: 13, y: 8, colorIndex: 4 }, { x: 14, y: 8, colorIndex: 4 },
    { x: 15, y: 8, colorIndex: 5 }, { x: 16, y: 8, colorIndex: 5 },
    { x: 17, y: 8, colorIndex: 4 }, { x: 18, y: 8, colorIndex: 4 },
    { x: 19, y: 8, colorIndex: 4 }, { x: 20, y: 8, colorIndex: 0 },
    // Main body - upper section
    { x: 4, y: 9, colorIndex: 0 }, { x: 5, y: 9, colorIndex: 2 },
    { x: 6, y: 9, colorIndex: 2 }, { x: 7, y: 9, colorIndex: 2 },
    { x: 8, y: 9, colorIndex: 2 }, { x: 9, y: 9, colorIndex: 2 },
    { x: 10, y: 9, colorIndex: 2 }, { x: 11, y: 9, colorIndex: 2 },
    { x: 12, y: 9, colorIndex: 2 }, { x: 13, y: 9, colorIndex: 2 },
    { x: 14, y: 9, colorIndex: 2 }, { x: 15, y: 9, colorIndex: 2 },
    { x: 16, y: 9, colorIndex: 2 }, { x: 17, y: 9, colorIndex: 2 },
    { x: 18, y: 9, colorIndex: 2 }, { x: 19, y: 9, colorIndex: 0 },
    // Body with wood grain
    { x: 5, y: 10, colorIndex: 0 }, { x: 6, y: 10, colorIndex: 3 },
    { x: 7, y: 10, colorIndex: 2 }, { x: 8, y: 10, colorIndex: 2 },
    { x: 9, y: 10, colorIndex: 1 }, { x: 10, y: 10, colorIndex: 2 },
    { x: 11, y: 10, colorIndex: 3 }, { x: 12, y: 10, colorIndex: 3 },
    { x: 13, y: 10, colorIndex: 2 }, { x: 14, y: 10, colorIndex: 1 },
    { x: 15, y: 10, colorIndex: 2 }, { x: 16, y: 10, colorIndex: 3 },
    { x: 17, y: 10, colorIndex: 2 }, { x: 18, y: 10, colorIndex: 0 },
    // Keyhole area
    { x: 5, y: 11, colorIndex: 0 }, { x: 6, y: 11, colorIndex: 2 },
    { x: 7, y: 11, colorIndex: 2 }, { x: 8, y: 11, colorIndex: 1 },
    { x: 9, y: 11, colorIndex: 1 }, { x: 10, y: 11, colorIndex: 6 },
    { x: 11, y: 11, colorIndex: 6 }, { x: 12, y: 11, colorIndex: 6 },
    { x: 13, y: 11, colorIndex: 6 }, { x: 14, y: 11, colorIndex: 1 },
    { x: 15, y: 11, colorIndex: 1 }, { x: 16, y: 11, colorIndex: 2 },
    { x: 17, y: 11, colorIndex: 2 }, { x: 18, y: 11, colorIndex: 0 },
    { x: 5, y: 12, colorIndex: 0 }, { x: 6, y: 12, colorIndex: 2 },
    { x: 7, y: 12, colorIndex: 1 }, { x: 8, y: 12, colorIndex: 1 },
    { x: 9, y: 12, colorIndex: 1 }, { x: 10, y: 12, colorIndex: 6 },
    { x: 11, y: 12, colorIndex: 0 }, { x: 12, y: 12, colorIndex: 0 },
    { x: 13, y: 12, colorIndex: 6 }, { x: 14, y: 12, colorIndex: 1 },
    { x: 15, y: 12, colorIndex: 1 }, { x: 16, y: 12, colorIndex: 1 },
    { x: 17, y: 12, colorIndex: 2 }, { x: 18, y: 12, colorIndex: 0 },
    { x: 5, y: 13, colorIndex: 0 }, { x: 6, y: 13, colorIndex: 2 },
    { x: 7, y: 13, colorIndex: 1 }, { x: 8, y: 13, colorIndex: 1 },
    { x: 9, y: 13, colorIndex: 1 }, { x: 10, y: 13, colorIndex: 1 },
    { x: 11, y: 13, colorIndex: 0 }, { x: 12, y: 13, colorIndex: 0 },
    { x: 13, y: 13, colorIndex: 1 }, { x: 14, y: 13, colorIndex: 1 },
    { x: 15, y: 13, colorIndex: 1 }, { x: 16, y: 13, colorIndex: 1 },
    { x: 17, y: 13, colorIndex: 2 }, { x: 18, y: 13, colorIndex: 0 },
    // Lower body
    { x: 5, y: 14, colorIndex: 0 }, { x: 6, y: 14, colorIndex: 2 },
    { x: 7, y: 14, colorIndex: 1 }, { x: 8, y: 14, colorIndex: 1 },
    { x: 9, y: 14, colorIndex: 1 }, { x: 10, y: 14, colorIndex: 1 },
    { x: 11, y: 14, colorIndex: 1 }, { x: 12, y: 14, colorIndex: 1 },
    { x: 13, y: 14, colorIndex: 1 }, { x: 14, y: 14, colorIndex: 1 },
    { x: 15, y: 14, colorIndex: 1 }, { x: 16, y: 14, colorIndex: 1 },
    { x: 17, y: 14, colorIndex: 2 }, { x: 18, y: 14, colorIndex: 0 },
    // Bottom metal band
    { x: 5, y: 15, colorIndex: 0 }, { x: 6, y: 15, colorIndex: 4 },
    { x: 7, y: 15, colorIndex: 5 }, { x: 8, y: 15, colorIndex: 4 },
    { x: 9, y: 15, colorIndex: 4 }, { x: 10, y: 15, colorIndex: 4 },
    { x: 11, y: 15, colorIndex: 5 }, { x: 12, y: 15, colorIndex: 5 },
    { x: 13, y: 15, colorIndex: 4 }, { x: 14, y: 15, colorIndex: 4 },
    { x: 15, y: 15, colorIndex: 4 }, { x: 16, y: 15, colorIndex: 5 },
    { x: 17, y: 15, colorIndex: 4 }, { x: 18, y: 15, colorIndex: 0 },
    // Base
    { x: 6, y: 16, colorIndex: 0 }, { x: 7, y: 16, colorIndex: 1 },
    { x: 8, y: 16, colorIndex: 1 }, { x: 9, y: 16, colorIndex: 1 },
    { x: 10, y: 16, colorIndex: 1 }, { x: 11, y: 16, colorIndex: 1 },
    { x: 12, y: 16, colorIndex: 1 }, { x: 13, y: 16, colorIndex: 1 },
    { x: 14, y: 16, colorIndex: 1 }, { x: 15, y: 16, colorIndex: 1 },
    { x: 16, y: 16, colorIndex: 1 }, { x: 17, y: 16, colorIndex: 0 },
    { x: 7, y: 17, colorIndex: 0 }, { x: 8, y: 17, colorIndex: 0 },
    { x: 9, y: 17, colorIndex: 0 }, { x: 10, y: 17, colorIndex: 0 },
    { x: 11, y: 17, colorIndex: 0 }, { x: 12, y: 17, colorIndex: 0 },
    { x: 13, y: 17, colorIndex: 0 }, { x: 14, y: 17, colorIndex: 0 },
    { x: 15, y: 17, colorIndex: 0 }, { x: 16, y: 17, colorIndex: 0 }
  ]
})
```

**Result:**
A detailed treasure chest with wooden texture, metal reinforcement bands, and a prominent gold keyhole.

**Visual Description:**
The chest shows a curved lid at the top with wood grain texture, two metal bands (one on the lid, one on the body), and a central gold keyhole. The wood uses three shades for depth, while the metal bands have highlights. Dark outlines define the structure clearly.

---

## Summary

This examples collection demonstrates the pixel-art-creator skill's capabilities across various complexity levels:

- **Basic shapes** (Examples 1-4): Simple geometric sprites and icons with clear tool call patterns
- **Layered compositions** (Examples 5-6): Multi-layer sprites with separate editable components
- **Retro/indexed styles** (Examples 7-8): Period-accurate color palettes (Game Boy, NES)
- **Complex scenes** (Examples 9-10): Tiles and detailed objects with intricate pixel work

Each example provides complete MCP tool call syntax that can be adapted for similar projects. The progression from simple to complex helps users understand how to build up sophisticated pixel art using the available tools.
