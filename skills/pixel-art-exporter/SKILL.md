---
name: Pixel Art Exporter
description: Export sprites to PNG, GIF, or spritesheet formats with JSON metadata for game engines. Use when the user wants to "export", "save", "output", "render", "generate", "create file", mentions file formats like "PNG", "GIF", "animated GIF", "spritesheet", "sprite sheet", "texture atlas", "tile sheet", or game engine integration with "Unity", "Godot", "Phaser", "Unreal", "GameMaker". Trigger on layout terms ("horizontal", "vertical", "grid", "packed", "strip"), scaling ("2x", "4x", "upscale", "pixel-perfect"), file operations ("save as", "export to", "output to"), metadata formats ("JSON", "XML", "metadata", "atlas data"), and delivery terms ("for web", "for game", "for Twitter", "for itch.io", "optimized").
allowed-tools: Read, Bash, mcp__aseprite__export_png, mcp__aseprite__export_gif, mcp__aseprite__export_spritesheet, mcp__aseprite__get_sprite_info
---

# Pixel Art Exporter

## Overview

The Pixel Art Exporter Skill enables exporting pixel art sprites from Aseprite to various formats optimized for different use cases. This includes single images (PNG), animated GIFs, spritesheets, and JSON metadata for game engines.

**Core Capabilities:**
- Export single frames or entire animations as PNG images
- Generate animated GIFs with customizable timing and looping
- Create spritesheets in multiple layouts (horizontal, vertical, grid, packed)
- Generate JSON metadata for game engines (Unity, Godot, Phaser, generic)
- Scale exports with pixel-perfect upscaling (1x, 2x, 4x, etc.)
- Handle transparency, background colors, and frame-specific exports

**Export Formats Supported:**
- **PNG**: Single images or frame sequences with transparency
- **GIF**: Animated GIFs with frame timing and loop control
- **Spritesheet**: Texture atlases with various packing algorithms
- **JSON**: Frame metadata, animation tags, layer information

This Skill works with the pixel-mcp server tools to produce production-ready assets for web, games, and applications.

## When to Use

Invoke this Skill when the user:

- **Wants to export or save**: "export this sprite", "save as PNG", "generate a spritesheet"
- **Mentions file formats**: "PNG", "GIF", "spritesheet", "sprite sheet", "texture atlas", "JSON"
- **Prepares for game engines**: "export for Unity", "Godot spritesheet", "Phaser animation"
- **Needs specific outputs**: "export just frame 3", "create a tileset", "save each layer separately"
- **Requests scaling**: "export at 2x size", "scale up 4x", "upscale for retina displays"
- **Wants animation exports**: "make this into a GIF", "export the animation", "save all frames"
- **Needs metadata**: "include JSON data", "export with coordinates", "frame information"

**Example Triggers:**
- "Can you export this character sprite as a PNG?"
- "I need a spritesheet for my game engine"
- "Save this animation as an animated GIF"
- "Export at 4x scale for high-resolution displays"
- "Generate a texture atlas with JSON metadata"
- "Export just the 'run' animation tag"

## Instructions

### 1. Exporting Single Images (PNG)

**For static sprites or single frames:**

1. **Get Sprite Information First**
   ```
   Use mcp__aseprite__get_sprite_info to understand:
   - Current dimensions
   - Number of frames
   - Available layers
   - Color mode and transparency settings
   ```

2. **Export PNG with Transparency**
   ```
   Use mcp__aseprite__export_png:
   - file_path: Absolute path (e.g., "/path/to/output/sprite.png")
   - frame_number: Specific frame (0-indexed) or omit for current frame
   - layer: Specific layer name or omit for merged output
   - scale: Scaling factor (1, 2, 4, etc.) - default is 1
   ```

3. **Export Options**
   - **Transparent background**: Default behavior, preserves alpha channel
   - **Specific background**: Use layer visibility or flatten before export
   - **Single frame from animation**: Specify frame_number parameter
   - **Specific layer only**: Provide layer name to export just that layer

**Example Workflow:**
```
1. Get sprite info to verify dimensions and frame count
2. Export PNG: mcp__aseprite__export_png with desired frame and scale
3. Confirm file creation and report dimensions to user
```

### 2. Exporting Animated GIFs

**For animations intended for web or presentations:**

1. **Verify Animation Setup**
   ```
   Use mcp__aseprite__get_sprite_info to check:
   - Frame count (needs 2+ frames)
   - Frame durations (timing information)
   - Animation tags (if specific tag requested)
   - Sprite dimensions
   ```

2. **Export GIF**
   ```
   Use mcp__aseprite__export_gif:
   - file_path: Output path (e.g., "/path/to/animation.gif")
   - animation_tag: Optional - specific tag name to export
   - loop: true (infinite loop) or false (play once)
   - scale: Upscaling factor if needed
   ```

3. **GIF Optimization Considerations**
   - GIF format has 256-color limit - ensure palette is optimized
   - Frame timing is preserved from Aseprite frame durations
   - Transparency is supported but may have edge artifacts
   - File size increases with dimensions and frame count

**Example Workflow:**
```
1. Verify sprite has multiple frames
2. Export GIF with appropriate loop setting
3. Report file size and frame count to user
4. Suggest optimization if file is large (>1MB)
```

### 3. Creating Spritesheets

**For game engines and texture atlases:**

1. **Understand Layout Requirements**

   **Layout Types:**
   - **Horizontal**: All frames in a single row (good for scrolling animations)
   - **Vertical**: All frames in a single column (good for CSS animations)
   - **Grid**: Frames arranged in rows and columns (balanced dimensions)
   - **Packed**: Optimized packing to minimize texture size (engine-specific)

2. **Export Spritesheet**
   ```
   Use mcp__aseprite__export_spritesheet:
   - file_path: Output PNG path (e.g., "/path/to/spritesheet.png")
   - layout: "horizontal", "vertical", "grid", or "packed"
   - animation_tag: Optional - export specific animation only
   - scale: Upscaling factor
   - padding: Pixels between frames (default 0, common: 1-2)
   - include_json: true to generate metadata file
   ```

3. **JSON Metadata Structure**

   When `include_json: true`, creates a .json file with:
   ```json
   {
     "frames": [
       {
         "filename": "frame_0.png",
         "frame": {"x": 0, "y": 0, "w": 32, "h": 32},
         "spriteSourceSize": {"x": 0, "y": 0, "w": 32, "h": 32},
         "sourceSize": {"w": 32, "h": 32},
         "duration": 100
       }
     ],
     "meta": {
       "app": "Aseprite",
       "version": "1.3.x",
       "format": "RGBA8888",
       "size": {"w": 256, "h": 32},
       "scale": "1"
     }
   }
   ```

4. **Layout Selection Guidelines**
   - **Horizontal**: Best for web/CSS sprite animations, simple scrolling
   - **Vertical**: Mobile-friendly, vertical scrolling animations
   - **Grid**: Unity, Godot - balanced texture dimensions (power-of-2)
   - **Packed**: Advanced engines with atlas support (Phaser, LibGDX)

**Example Workflow:**
```
1. Ask user about target platform if not specified
2. Recommend layout based on use case
3. Export spritesheet with JSON metadata
4. Report texture dimensions and frame count
5. Provide integration code sample for their engine
```

### 4. Generating JSON Metadata

**For game engine integration:**

1. **Metadata Formats by Engine**

   **Unity:**
   - Use "grid" layout for Unity's Sprite Editor
   - JSON provides frame coordinates for slicing
   - Include padding to prevent texture bleeding

   **Godot:**
   - Use "horizontal" or "grid" layout
   - JSON maps to AnimatedSprite frames
   - Frame duration converts to FPS

   **Phaser:**
   - Use "packed" layout for optimal performance
   - JSON follows Texture Packer format
   - Supports trimmed sprites and rotation

   **Generic/Custom:**
   - Standard frame array with x, y, w, h coordinates
   - Duration in milliseconds per frame
   - Animation tag groupings

2. **Export with Metadata**
   ```
   Always include JSON when exporting for game engines:
   - Set include_json: true in export_spritesheet
   - JSON file created with same name as PNG (different extension)
   - Contains frame positions, durations, and sprite metadata
   ```

3. **Metadata Usage Examples**

   **Parsing in JavaScript (Phaser):**
   ```javascript
   this.load.atlas('sprite', 'spritesheet.png', 'spritesheet.json');
   this.add.sprite(x, y, 'sprite', 'frame_0.png');
   ```

   **Parsing in C# (Unity):**
   ```csharp
   // Import spritesheet.png with Multiple sprite mode
   // Use JSON to set sprite rectangles in Sprite Editor
   ```

### 5. Scaling Exports

**Pixel-perfect upscaling for high-resolution displays:**

1. **When to Scale**
   - Retina/HiDPI displays: Use 2x or 4x
   - Modern game engines: Export at native size, let engine scale
   - Web: Export 2x and use CSS to scale down (sharper rendering)
   - Print/marketing: Use 4x or higher

2. **Scaling Best Practices**
   - Always use integer scaling (1x, 2x, 3x, 4x, not 1.5x)
   - Maintain pixel-perfect sharpness with nearest-neighbor
   - Scale before export, not after (prevents blurring)
   - Consider file size vs. quality tradeoffs

3. **Apply Scaling**
   ```
   Add scale parameter to any export:
   - mcp__aseprite__export_png: scale: 2
   - mcp__aseprite__export_gif: scale: 4
   - mcp__aseprite__export_spritesheet: scale: 2
   ```

4. **Resolution Recommendations**
   - **1x**: Original pixel art size, retro aesthetic
   - **2x**: Standard for modern displays, good balance
   - **4x**: High-resolution, marketing materials
   - **8x+**: Ultra-high-resolution, print, large displays

## Export Workflows for Different Use Cases

### Static Sprite for Web

```
1. Get sprite info to verify single frame
2. Export PNG at 2x scale with transparency
3. Optimize PNG with compression tools if needed
4. Provide HTML/CSS example for display
```

### Character Animation for Game

```
1. Verify animation has multiple frames and tags
2. Export spritesheet with "grid" layout
3. Include JSON metadata (include_json: true)
4. Set appropriate padding (1-2 pixels)
5. Scale if needed (typically 1x for engines)
6. Provide code snippet for target engine
```

### Icon Set Export

```
1. If multiple layers, export each separately
2. Use PNG format with transparency
3. Scale to multiple sizes (16x16, 32x32, 64x64)
4. Batch export all sizes
5. Organize in output directory structure
```

### Social Media GIF

```
1. Verify frame timing is appropriate (100-200ms typical)
2. Export GIF with loop: true
3. Scale to 2x or 4x for visibility
4. Check file size (optimize if >2MB)
5. Suggest hosting platforms if needed
```

### Tileset for Game Engine

```
1. Verify tiles are uniform size (e.g., 16x16, 32x32)
2. Export as grid spritesheet
3. Set padding to 0 or 1 (depends on engine)
4. Include JSON for tile coordinates
5. Provide tile size and grid dimensions
```

## Game Engine Integration

### Unity Integration

**Export Settings:**
- Layout: "grid"
- Include JSON: true
- Padding: 1-2 pixels (prevents bleeding)
- Scale: 1x (Unity handles scaling)

**Import Steps:**
1. Import spritesheet.png into Assets
2. Set Texture Type to "Sprite (2D and UI)"
3. Set Sprite Mode to "Multiple"
4. Open Sprite Editor and use JSON coordinates to slice
5. Create Animator Controller with sprite animation

**Code Example:**
```csharp
SpriteRenderer renderer = GetComponent<SpriteRenderer>();
renderer.sprite = sprites[frameIndex];
```

### Godot Integration

**Export Settings:**
- Layout: "horizontal" or "grid"
- Include JSON: true
- Scale: 1x
- Padding: 0-1 pixels

**Import Steps:**
1. Import spritesheet.png to project
2. Create AnimatedSprite node
3. Create SpriteFrames resource
4. Add frames from spritesheet
5. Use JSON durations to set FPS

**Code Example:**
```gdscript
$AnimatedSprite.play("run")
$AnimatedSprite.speed_scale = 1.0
```

### Phaser Integration

**Export Settings:**
- Layout: "packed" or "horizontal"
- Include JSON: true (Texture Packer format)
- Scale: 1x or 2x depending on game resolution

**Import Steps:**
1. Place spritesheet.png and .json in assets
2. Load as atlas in preload()
3. Create sprite with atlas key
4. Create animations from frame names

**Code Example:**
```javascript
this.load.atlas('player', 'spritesheet.png', 'spritesheet.json');

this.anims.create({
  key: 'run',
  frames: this.anims.generateFrameNames('player', {
    prefix: 'frame_',
    suffix: '.png',
    start: 0,
    end: 7
  }),
  frameRate: 10,
  repeat: -1
});
```

### Generic/Custom Engine

**Export Settings:**
- Layout: Based on engine capabilities
- Include JSON: true
- Provide simple frame array format

**JSON Structure:**
```json
{
  "frames": [
    {"x": 0, "y": 0, "w": 32, "h": 32, "duration": 100}
  ],
  "meta": {
    "frameWidth": 32,
    "frameHeight": 32,
    "frameCount": 8
  }
}
```

**Integration Pattern:**
1. Load PNG texture
2. Parse JSON to get frame rectangles
3. Create sub-textures/sprites from coordinates
4. Use duration for animation timing

## Technical Details

### PNG Export Format

**Specifications:**
- Color Mode: RGBA (8-bit per channel)
- Transparency: Full alpha channel support
- Compression: PNG lossless compression
- Color Space: sRGB
- Bit Depth: 32-bit (8-bit per channel RGBA)

**When to Use:**
- Static sprites with transparency
- Individual frames from animations
- High-quality source files
- Layer-specific exports

### GIF Export Format

**Specifications:**
- Color Palette: Maximum 256 colors
- Transparency: Binary (on/off), no partial alpha
- Animation: Frame-based with per-frame timing
- Loop Control: Infinite or play-once
- Compression: LZW compression

**Limitations:**
- Color limit may require palette optimization
- No partial transparency (alpha is binary)
- Larger file sizes than video formats
- Limited to 8-bit color depth

**When to Use:**
- Web animations without video player
- Social media posts
- Email-compatible animations
- Simple looping animations

### Spritesheet Layouts

**Horizontal Layout:**
```
[Frame0][Frame1][Frame2][Frame3]...
```
- Dimensions: width = frameWidth * frameCount, height = frameHeight
- Best for: CSS animations, simple scrolling

**Vertical Layout:**
```
[Frame0]
[Frame1]
[Frame2]
[Frame3]
...
```
- Dimensions: width = frameWidth, height = frameHeight * frameCount
- Best for: Mobile-optimized, vertical scrolling

**Grid Layout:**
```
[Frame0][Frame1][Frame2][Frame3]
[Frame4][Frame5][Frame6][Frame7]
[Frame8][Frame9][Frame10][Frame11]
```
- Dimensions: Balanced to create near-square texture
- Best for: Game engines, power-of-2 textures, Unity, Godot

**Packed Layout:**
```
[Frame0][Frame2][Frame5]
[Frame1][Frame3][Frame6]
    [Frame4][Frame7]
```
- Dimensions: Optimally packed to minimize wasted space
- Best for: Advanced engines with atlas support (Phaser, LibGDX)
- Requires JSON metadata for frame positions

### Metadata Structures

**Standard Frame Format:**
```json
{
  "filename": "frame_0.png",
  "frame": {"x": 0, "y": 0, "w": 32, "h": 32},
  "rotated": false,
  "trimmed": false,
  "spriteSourceSize": {"x": 0, "y": 0, "w": 32, "h": 32},
  "sourceSize": {"w": 32, "h": 32},
  "duration": 100
}
```

**Fields Explained:**
- `filename`: Logical frame identifier
- `frame`: Position and size in spritesheet (pixels)
- `rotated`: Whether frame is rotated 90° (packed layouts)
- `trimmed`: Whether transparent pixels were removed
- `spriteSourceSize`: Position within original canvas if trimmed
- `sourceSize`: Original canvas size before trimming
- `duration`: Frame duration in milliseconds

**Meta Information:**
```json
{
  "app": "Aseprite",
  "version": "1.3.x",
  "format": "RGBA8888",
  "size": {"w": 256, "h": 128},
  "scale": "1",
  "frameTags": [
    {"name": "idle", "from": 0, "to": 3, "direction": "forward"},
    {"name": "run", "from": 4, "to": 11, "direction": "forward"}
  ]
}
```

## Common Export Patterns

### Pattern 1: Single Frame Export

**Scenario:** User wants just one frame as PNG

```
1. mcp__aseprite__get_sprite_info (verify frame exists)
2. mcp__aseprite__export_png:
   - file_path: "/output/frame.png"
   - frame_number: 0 (or user-specified)
   - scale: 1 (or user-specified)
3. Confirm export with dimensions
```

### Pattern 2: Full Animation GIF

**Scenario:** User wants animated GIF of entire sprite

```
1. mcp__aseprite__get_sprite_info (verify frames > 1)
2. mcp__aseprite__export_gif:
   - file_path: "/output/animation.gif"
   - loop: true
   - scale: 2
3. Report frame count and file size
```

### Pattern 3: Game-Ready Spritesheet

**Scenario:** User wants spritesheet for Unity/Godot

```
1. mcp__aseprite__get_sprite_info (check dimensions and frames)
2. Ask about target engine if not specified
3. mcp__aseprite__export_spritesheet:
   - file_path: "/output/spritesheet.png"
   - layout: "grid"
   - include_json: true
   - padding: 1
   - scale: 1
4. Provide integration instructions for target engine
```

### Pattern 4: Specific Animation Tag

**Scenario:** User wants to export just one animation (e.g., "run")

```
1. mcp__aseprite__get_sprite_info (verify tag exists)
2. mcp__aseprite__export_spritesheet or export_gif:
   - animation_tag: "run"
   - Other settings as appropriate
3. Confirm only tagged frames exported
```

### Pattern 5: Multi-Resolution Export

**Scenario:** User wants multiple scales (1x, 2x, 4x)

```
1. Export PNG/spritesheet at scale: 1
2. Export PNG/spritesheet at scale: 2
3. Export PNG/spritesheet at scale: 4
4. Organize files: sprite_1x.png, sprite_2x.png, sprite_4x.png
5. Report all outputs with dimensions
```

### Pattern 6: Layer-Specific Export

**Scenario:** User wants individual layers as separate files

```
1. mcp__aseprite__get_sprite_info (get layer names)
2. For each layer:
   - mcp__aseprite__export_png:
     - layer: "LayerName"
     - file_path: "/output/layerName.png"
3. Report all exported layers
```

## Integration with Other Skills

### Pixel Art Creator Integration

**Workflow:** Create → Export
```
1. User creates sprite with Pixel Art Creator Skill
2. Automatically offer export options when creation complete
3. Suggest appropriate format based on sprite type (static vs animated)
4. Use this Skill to handle export
```

### Pixel Art Animator Integration

**Workflow:** Animate → Export
```
1. User creates animation with Pixel Art Animator Skill
2. When animation complete, offer export formats:
   - GIF for web/social
   - Spritesheet for games
3. Use this Skill for export with animation metadata
```

### Pixel Art Professional Integration

**Workflow:** Optimize → Export
```
1. User applies professional techniques (dithering, palette optimization)
2. Export with optimized settings:
   - Preserve palette for GIF export
   - Use appropriate compression for PNG
3. This Skill handles format-specific optimization
```

## Error Handling

### File Path Issues

**Problem:** Invalid or inaccessible output path

**Solution:**
```
1. Verify directory exists (create if needed using Bash)
2. Check write permissions
3. Use absolute paths, not relative
4. Suggest valid path if user provides invalid one
```

### Missing Frames or Tags

**Problem:** User requests frame/tag that doesn't exist

**Solution:**
```
1. Use get_sprite_info to verify available frames and tags
2. List available options to user
3. Ask user to clarify which frame/tag they want
4. Don't attempt export until valid selection made
```

### Large File Warnings

**Problem:** Export will create very large file (GIF >5MB, PNG >10MB)

**Solution:**
```
1. Calculate approximate size based on dimensions and frame count
2. Warn user before export if size exceeds thresholds
3. Suggest alternatives:
   - Reduce scale factor
   - Export fewer frames
   - Use spritesheet instead of GIF
   - Optimize palette
```

### Format Limitations

**Problem:** User requests feature not supported by format (e.g., GIF transparency)

**Solution:**
```
1. Explain format limitation clearly
2. Suggest alternative format or approach
3. Proceed with export noting the limitation
4. Examples:
   - GIF binary transparency → suggest PNG for partial alpha
   - GIF 256-color limit → suggest palette optimization first
```

### Scale Factor Issues

**Problem:** Non-integer scale or excessive scaling

**Solution:**
```
1. Only accept integer scale factors (1, 2, 3, 4, etc.)
2. Warn if scale >4 (may create very large files)
3. Explain pixel-perfect scaling benefits
4. Suggest appropriate scale for user's use case
```

## Success Indicators

**Export completed successfully when:**

1. **File Created**: Output file exists at specified path
2. **Correct Format**: File extension matches requested format (.png, .gif)
3. **Expected Dimensions**: Scaled dimensions are correct (originalSize * scale)
4. **Frame Count Match**: Spritesheet or GIF contains expected number of frames
5. **JSON Generated**: Metadata file created if include_json was true
6. **User Confirmation**: User can open and verify exported file

**Report to User:**
```
✓ Export complete: /path/to/output.png
  - Format: PNG with transparency
  - Dimensions: 64x64 (2x scale from 32x32 original)
  - Frames: 1 (static image)
  - File size: ~8KB

[For spritesheets, also include:]
  - Layout: Grid (4x2)
  - Frame dimensions: 32x32 each
  - Total frames: 8
  - JSON metadata: /path/to/output.json
  - Integration: Ready for Unity/Godot import

[Provide relevant integration code snippet if applicable]
```

**Post-Export Guidance:**
- Suggest next steps (import to engine, optimize file size, create additional scales)
- Offer integration code for target platform
- Explain how to use JSON metadata
- Recommend testing in target environment
