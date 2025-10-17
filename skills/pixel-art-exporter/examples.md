# Pixel Art Exporter Examples

This document provides concrete examples of how the pixel-art-exporter skill handles exporting pixel art from Aseprite to various formats. Each example shows the user's request, step-by-step approach, actual MCP tool calls with parameters, and expected results.

Examples are organized by export type: single images, animated GIFs, spritesheets, and game engine integration workflows.

---

## Single Image Exports

### Example 1: Simple PNG Export

**User Request:**
> "Export my sprite as a PNG file with transparency"

**Approach:**
1. Get current sprite information
2. Export as PNG with alpha channel
3. Specify output path
4. Maintain original dimensions

**Tool Calls:**
```javascript
// Get sprite info to confirm dimensions
mcp__aseprite__get_sprite_info()

// Export as PNG with transparency
mcp__aseprite__export_png({
  filename: "character-sprite.png",
  frame: "current",  // Export currently selected frame
  layer: "all",      // Include all layers
  alpha: true        // Preserve transparency
})
```

**Result:**
A PNG file with transparent background, ready to use in games or websites.

**Visual Description:**
The exported PNG shows the sprite with a checkered transparency background in image viewers. All colors are preserved exactly as they appear in Aseprite. The file can be placed over any background in a game engine or graphics program.

---

### Example 2: PNG with Specific Background Color

**User Request:**
> "Export my icon with a white background instead of transparency"

**Approach:**
1. Check sprite info
2. Export PNG with background color specified
3. Flatten transparency to solid color

**Tool Calls:**
```javascript
mcp__aseprite__get_sprite_info()

// Export PNG with white background
mcp__aseprite__export_png({
  filename: "icon-white-bg.png",
  frame: "current",
  layer: "all",
  alpha: false,  // No transparency
  background: { r: 255, g: 255, b: 255, a: 255 }  // White
})
```

**Result:**
A PNG with white background replacing all transparent areas.

**Visual Description:**
The exported image has a solid white background. All transparent pixels have been filled with white. This is useful for icons that will be displayed on light backgrounds or for printing.

---

### Example 3: Scaled Export for High-DPI Displays

**User Request:**
> "Export my 32x32 sprite at 4x scale for retina displays, without blur"

**Approach:**
1. Get original dimensions
2. Export with integer scaling (nearest neighbor)
3. Maintain pixel-perfect sharpness
4. Output at 128x128 pixels

**Tool Calls:**
```javascript
// Get sprite info
const spriteInfo = mcp__aseprite__get_sprite_info()
// Returns: { width: 32, height: 32, colorMode: "rgb", frames: 1 }

// Export at 4x scale with nearest neighbor
mcp__aseprite__export_png({
  filename: "character-4x.png",
  frame: "current",
  layer: "all",
  alpha: true,
  scale: 4,              // 4x larger
  scaleFilter: "nearest" // Pixel-perfect scaling (no blur)
})
```

**Result:**
A 128x128 PNG that looks identical to the original but 4x larger, with crisp pixel edges.

**Visual Description:**
The exported sprite is now 128x128 pixels. Each original pixel has become a 4x4 block of identical pixels. The image looks sharp and clear at large sizes with no blur or antialiasing artifacts. Perfect for high-DPI displays or large game sprites.

---

### Example 4: Export Specific Layer Only

**User Request:**
> "Export just the 'character' layer without the background"

**Approach:**
1. Identify layer name
2. Export only that layer
3. Maintain transparency from other layers

**Tool Calls:**
```javascript
// Get sprite info including layer information
mcp__aseprite__get_sprite_info()

// Export only the character layer
mcp__aseprite__export_png({
  filename: "character-only.png",
  frame: "current",
  layer: "character",  // Specific layer name
  alpha: true
})
```

**Result:**
A PNG containing only the character layer, with background layer excluded and transparent.

**Visual Description:**
The exported image shows only the character sprite without the background elements. Areas where the background layer was are now fully transparent. Useful for exporting game assets separately or creating variations.

---

## Animated GIF Exports

### Example 5: Basic Animated GIF

**User Request:**
> "Export my walk cycle animation as an animated GIF"

**Approach:**
1. Verify animation has multiple frames
2. Export all frames as GIF
3. Use frame durations from Aseprite
4. Enable looping

**Tool Calls:**
```javascript
// Get sprite info to check frames
const spriteInfo = mcp__aseprite__get_sprite_info()
// Returns: { width: 32, height: 32, frames: 4, ... }

// Export as animated GIF
mcp__aseprite__export_gif({
  filename: "walk-cycle.gif",
  fromFrame: 1,
  toFrame: 4,      // All frames
  loop: true,      // Infinite loop
  useOriginalDuration: true  // Use Aseprite frame timings
})
```

**Result:**
An animated GIF that plays the walk cycle continuously, preserving the timing from Aseprite.

**Visual Description:**
The GIF animates smoothly, cycling through all 4 walk frames indefinitely. Frame timings match what was set in Aseprite (e.g., 100ms per frame). The animation looks exactly as it did in the Aseprite editor.

---

### Example 6: Optimized GIF with Reduced Colors

**User Request:**
> "Export my animation as a small GIF file with reduced file size"

**Approach:**
1. Get animation info
2. Export with palette optimization
3. Reduce color count for smaller file
4. Maintain visual quality

**Tool Calls:**
```javascript
mcp__aseprite__get_sprite_info()

// Export GIF with optimized palette
mcp__aseprite__export_gif({
  filename: "optimized-animation.gif",
  fromFrame: 1,
  toFrame: 8,
  loop: true,
  useOriginalDuration: true,
  colorQuantization: true,  // Optimize palette
  maxColors: 64,            // Reduce from 256 to 64 colors
  dithering: "floyd-steinberg"  // Smooth color transitions
})
```

**Result:**
A smaller GIF file with optimized colors that looks nearly identical to the full-color version.

**Visual Description:**
The GIF plays the animation smoothly with slightly reduced color depth. Floyd-Steinberg dithering creates smooth transitions where colors were reduced. File size is significantly smaller (often 50-70% reduction) while maintaining good visual quality.

---

### Example 7: GIF with Specific Frame Range

**User Request:**
> "Export just frames 5-8 of my animation (the attack sequence) as a GIF"

**Approach:**
1. Identify frame range for specific animation
2. Export only that range
3. Set appropriate loop behavior

**Tool Calls:**
```javascript
mcp__aseprite__get_sprite_info()

// Export specific frame range
mcp__aseprite__export_gif({
  filename: "attack-animation.gif",
  fromFrame: 5,
  toFrame: 8,       // Just the attack frames
  loop: false,      // Play once (not infinite loop)
  useOriginalDuration: true
})
```

**Result:**
A GIF containing only the 4-frame attack sequence that plays once and stops.

**Visual Description:**
The GIF shows frames 5-8 of the original animation (the attack move). It plays through once and stops on the last frame rather than looping. Perfect for sharing a specific animation sequence or game move demonstrations.

---

## Spritesheet Exports

### Example 8: Horizontal Strip Spritesheet

**User Request:**
> "Export all my animation frames as a single horizontal strip for my game engine"

**Approach:**
1. Get frame count
2. Export as horizontal spritesheet
3. Frames arranged left to right
4. Include metadata about frame positions

**Tool Calls:**
```javascript
// Get sprite info
const spriteInfo = mcp__aseprite__get_sprite_info()
// Returns: { width: 32, height: 32, frames: 8, ... }

// Export as horizontal strip
mcp__aseprite__export_spritesheet({
  filename: "spritesheet-horizontal.png",
  sheetType: "horizontal",  // All frames in one row
  fromFrame: 1,
  toFrame: 8,
  padding: 0,               // No space between frames
  innerPadding: 0           // No padding inside frames
})
```

**Result:**
A 256x32 PNG (8 frames × 32px wide) with all frames arranged horizontally.

**Visual Description:**
The spritesheet is a wide horizontal image showing all 8 animation frames side by side. Frame 1 starts at x=0, frame 2 at x=32, frame 3 at x=64, and so on. Each frame is 32x32 pixels. The spritesheet is 256 pixels wide by 32 pixels tall.

---

### Example 9: Grid Spritesheet with JSON Data

**User Request:**
> "Export my sprites as a grid spritesheet with JSON metadata for frame positions"

**Approach:**
1. Arrange frames in a grid (e.g., 4x2)
2. Export PNG spritesheet
3. Export accompanying JSON with frame coordinates
4. Include frame durations

**Tool Calls:**
```javascript
// Get sprite info
const spriteInfo = mcp__aseprite__get_sprite_info()

// Export as grid with JSON
mcp__aseprite__export_spritesheet({
  filename: "spritesheet-grid.png",
  sheetType: "grid",
  columns: 4,               // 4 frames per row
  rows: 2,                  // 2 rows
  fromFrame: 1,
  toFrame: 8,
  padding: 1,               // 1px space between frames
  innerPadding: 0,
  jsonData: true,           // Export JSON metadata
  jsonFilename: "spritesheet-grid.json"
})
```

**Result:**
A 133x65 PNG grid (4×2 frames with padding) plus a JSON file with frame coordinates and timing data.

**Visual Description:**
The spritesheet shows 8 frames arranged in a 4×2 grid. Each frame is separated by 1 pixel of padding. The accompanying JSON file contains:
```json
{
  "frames": [
    {
      "frame": { "x": 0, "y": 0, "w": 32, "h": 32 },
      "duration": 100
    },
    {
      "frame": { "x": 33, "y": 0, "w": 32, "h": 32 },
      "duration": 100
    },
    // ... more frames
  ],
  "meta": {
    "size": { "w": 133, "h": 65 },
    "scale": "1"
  }
}
```

---

### Example 10: Packed Spritesheet for Efficiency

**User Request:**
> "Export my sprites as a tightly packed spritesheet to save texture memory"

**Approach:**
1. Analyze frame sizes
2. Use bin-packing algorithm
3. Arrange frames efficiently
4. Export with JSON coordinates

**Tool Calls:**
```javascript
// Export with automatic packing
mcp__aseprite__export_spritesheet({
  filename: "spritesheet-packed.png",
  sheetType: "packed",      // Bin-packing algorithm
  fromFrame: 1,
  toFrame: 8,
  padding: 2,               // 2px padding for safety
  powerOfTwo: true,         // Force dimensions to power of 2
  jsonData: true,
  jsonFilename: "spritesheet-packed.json"
})
```

**Result:**
An efficiently packed spritesheet (e.g., 64x64 or 128x64) with frames arranged to minimize wasted space, plus JSON coordinates.

**Visual Description:**
The spritesheet uses minimal texture space by packing frames tightly. Frames aren't in a regular grid - they're arranged optimally based on size and shape. The JSON file provides exact coordinates for each frame. The total image size is a power of 2 (64x64, 128x128, etc.) for GPU efficiency.

---

### Example 11: Spritesheet with Animation Tags

**User Request:**
> "Export a spritesheet with separate animations (idle, walk, attack) marked in the JSON"

**Approach:**
1. Create spritesheet with all frames
2. Export JSON including animation tag ranges
3. Organize by animation name

**Tool Calls:**
```javascript
// Get sprite info including tags
const spriteInfo = mcp__aseprite__get_sprite_info()
// Returns: { frames: 16, tags: ["idle", "walk", "attack"], ... }

// Export spritesheet with tag information
mcp__aseprite__export_spritesheet({
  filename: "character-all-animations.png",
  sheetType: "horizontal",
  fromFrame: 1,
  toFrame: 16,              // All frames
  padding: 1,
  jsonData: true,
  jsonFilename: "character-all-animations.json",
  includeTags: true         // Include animation tag data in JSON
})
```

**Result:**
A horizontal spritesheet with all 16 frames plus JSON with animation tag ranges.

**Visual Description:**
The spritesheet contains all animations in sequence: idle (frames 1-4), walk (frames 5-8), attack (frames 9-16). The JSON includes:
```json
{
  "frames": [ /* frame data */ ],
  "meta": {
    "frameTags": [
      { "name": "idle", "from": 0, "to": 3 },
      { "name": "walk", "from": 4, "to": 7 },
      { "name": "attack", "from": 8, "to": 15 }
    ]
  }
}
```

---

## Game Engine Integration

### Example 12: Unity Spritesheet Export

**User Request:**
> "Export my animation for Unity with the correct JSON format"

**Approach:**
1. Export spritesheet in Unity-compatible format
2. Use Unity's JSON structure
3. Include pivot points and frame data

**Tool Calls:**
```javascript
// Export Unity-compatible spritesheet
mcp__aseprite__export_spritesheet({
  filename: "unity-sprite.png",
  sheetType: "grid",
  columns: 4,
  rows: 2,
  fromFrame: 1,
  toFrame: 8,
  padding: 0,
  jsonData: true,
  jsonFilename: "unity-sprite.json",
  jsonFormat: "unity"       // Unity-specific format
})
```

**Result:**
A spritesheet PNG and JSON in Unity's sprite atlas format.

**Visual Description:**
The export creates files that Unity can import directly. The JSON uses Unity's expected structure with sprite names, rectangles, pivots, and borders. In Unity, you can drag the PNG into your project, set it as Multiple sprite mode, and use the JSON to slice it automatically.

---

### Example 13: Godot Spritesheet Export

**User Request:**
> "Export my sprites for Godot Engine with proper metadata"

**Approach:**
1. Export spritesheet
2. Use Godot-compatible JSON format
3. Include region and frame data

**Tool Calls:**
```javascript
// Export Godot-compatible spritesheet
mcp__aseprite__export_spritesheet({
  filename: "godot-sprite.png",
  sheetType: "packed",
  fromFrame: 1,
  toFrame: 8,
  padding: 1,
  jsonData: true,
  jsonFilename: "godot-sprite.json",
  jsonFormat: "godot"       // Godot-specific format
})
```

**Result:**
A packed spritesheet with Godot-compatible JSON metadata.

**Visual Description:**
The export creates files ready for Godot's AnimatedSprite or SpriteFrames resource. The JSON uses Godot's expected structure. In Godot, you can load this directly into a SpriteFrames resource and reference frames by name in your animations.

---

### Example 14: Phaser JSON Hash Export

**User Request:**
> "Export my spritesheet with Phaser 3 compatible JSON hash format"

**Approach:**
1. Export spritesheet
2. Use Phaser's JSON hash structure
3. Include all frame data with string keys

**Tool Calls:**
```javascript
// Export Phaser-compatible spritesheet
mcp__aseprite__export_spritesheet({
  filename: "phaser-sprite.png",
  sheetType: "grid",
  columns: 4,
  rows: 2,
  fromFrame: 1,
  toFrame: 8,
  padding: 0,
  jsonData: true,
  jsonFilename: "phaser-sprite.json",
  jsonFormat: "hash"        // Phaser JSON hash format
})
```

**Result:**
A spritesheet with Phaser 3 JSON hash format for easy loading.

**Visual Description:**
The JSON uses Phaser's hash format where each frame is a key-value pair:
```json
{
  "frames": {
    "frame0.png": {
      "frame": { "x": 0, "y": 0, "w": 32, "h": 32 },
      "rotated": false,
      "trimmed": false,
      "spriteSourceSize": { "x": 0, "y": 0, "w": 32, "h": 32 },
      "sourceSize": { "w": 32, "h": 32 }
    },
    // ... more frames
  }
}
```
In Phaser, load with: `this.load.atlas('sprite', 'phaser-sprite.png', 'phaser-sprite.json')`

---

### Example 15: Export Multiple Animations Separately

**User Request:**
> "Export each of my tagged animations as separate files for easier game engine management"

**Approach:**
1. Get list of animation tags
2. Export each tag as separate file
3. Create organized file structure

**Tool Calls:**
```javascript
// Get sprite info with tags
const spriteInfo = mcp__aseprite__get_sprite_info()
// Returns: { tags: ["idle", "walk", "attack"], ... }

// Export idle animation
mcp__aseprite__export_spritesheet({
  filename: "character-idle.png",
  sheetType: "horizontal",
  tag: "idle",              // Export only frames in this tag
  padding: 0,
  jsonData: true,
  jsonFilename: "character-idle.json"
})

// Export walk animation
mcp__aseprite__export_spritesheet({
  filename: "character-walk.png",
  sheetType: "horizontal",
  tag: "walk",              // Export only frames in this tag
  padding: 0,
  jsonData: true,
  jsonFilename: "character-walk.json"
})

// Export attack animation
mcp__aseprite__export_spritesheet({
  filename: "character-attack.png",
  sheetType: "horizontal",
  tag: "attack",            // Export only frames in this tag
  padding: 0,
  jsonData: true,
  jsonFilename: "character-attack.json"
})
```

**Result:**
Three separate spritesheet files, each containing one animation with its own JSON.

**Visual Description:**
The export creates:
- `character-idle.png`: 128x32 (4 frames)
- `character-walk.png`: 128x32 (4 frames)
- `character-attack.png`: 192x32 (6 frames)

Plus corresponding JSON files. This organization makes it easy to load only needed animations in game engines and manage animation states separately.

---

## Summary

This examples collection demonstrates the pixel-art-exporter skill's capabilities:

- **Single images** (Examples 1-4): PNG exports with various options (transparency, backgrounds, scaling, layers)
- **Animated GIFs** (Examples 5-7): Full animations, optimized versions, specific frame ranges
- **Spritesheets** (Examples 8-11): Horizontal strips, grids, packed layouts, with JSON metadata
- **Game engine integration** (Examples 12-15): Unity, Godot, Phaser formats, and organized multi-file exports

Each example shows complete MCP tool call syntax with practical export scenarios for web, games, and various platforms. The progression demonstrates flexibility from simple PNG exports to complex multi-format game engine pipelines.
