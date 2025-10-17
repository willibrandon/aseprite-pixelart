# Export Formats Reference

This document provides comprehensive technical specifications for exporting pixel art in various formats, including static images, animated formats, spritesheets, and game engine-specific outputs.

## PNG Export Options

PNG (Portable Network Graphics) is the primary format for pixel art due to lossless compression and transparency support.

### Transparency Handling

**Full Alpha Channel:**
- 8-bit alpha channel (0-255 transparency levels)
- Preserves semi-transparent pixels from antialiasing or effects
- Essential for overlay sprites, particles, or UI elements
- File size increases with alpha complexity

**Binary Transparency:**
- Pixels are either fully opaque (255) or fully transparent (0)
- Smaller file size compared to full alpha
- Sufficient for most pixel art with hard edges
- Compatible with older systems

**No Transparency:**
- All pixels opaque
- Smallest file size for PNG
- Use when background is always solid
- Useful for tiles, backgrounds, or when transparency not needed

### Background Colors

**Transparent Background:**
- Default for sprites, characters, UI elements
- Allows compositing over any background
- Required for multi-layer game objects

**Solid Background:**
- Specify hex color (e.g., #FF00FF for magenta)
- Useful for preview/reference images
- Can use specific color for manual masking later
- Common for texture atlases with padding

**Checkerboard Pattern:**
- Not exported, but visible in editor
- Indicates transparent areas during editing
- Final export still uses true transparency

### Color Depth Options

**Indexed Color (8-bit):**
- Maximum 256 colors
- Smallest file size
- Perfect for retro pixel art
- Preserves exact palette
- Example: NES-style art (54 colors), Game Boy (4 colors)

**RGB (24-bit):**
- 16.7 million colors
- No transparency channel
- Use when alpha not needed
- Moderate file size

**RGBA (32-bit):**
- 16.7 million colors + alpha
- Full transparency support
- Largest file size
- Industry standard for modern games

### Compression Settings

**PNG Compression Levels:**
- Level 0: No compression (fastest, largest)
- Level 1-5: Low compression (fast encoding)
- Level 6: Default (balanced)
- Level 9: Maximum compression (slowest, smallest)

**Best Practices:**
- Use level 9 for final game assets (one-time cost)
- Use level 1-3 for rapid iteration/testing
- Compression is lossless at all levels
- File size varies by image complexity, not canvas size

## GIF Export

GIF format provides animation support with wide compatibility but limited color palette.

### Frame Timing Control

**Frame Duration:**
- Measured in centiseconds (100ths of a second)
- Minimum: 1cs (10ms) - browser limit typically 20ms
- Common values: 10cs (100ms), 5cs (50ms), 20cs (200ms)
- Per-frame timing allows variable animation speeds

**Timing Examples:**
```
Walking cycle: 10cs per frame (10 FPS)
Idle breathing: 30cs per frame (3.3 FPS)
Fast attack: 5cs per frame (20 FPS)
Slow blink: [50cs, 5cs, 50cs] (hold, blink, hold)
```

**Aseprite Frame Duration:**
- Set in timeline (milliseconds in Aseprite)
- Export converts to centiseconds
- Maintains exact timing in GIF output

### Looping Options

**Infinite Loop:**
- Default for game sprites
- NETSCAPE2.0 extension with loop count 0
- Plays continuously until stopped
- Standard for web animations

**Count-Based Looping:**
- Specify exact number of repetitions
- Example: Loop 3 times then stop
- Useful for intro animations, effects
- Browser support varies

**No Loop (Play Once):**
- Loop count set to 1
- Stops on final frame
- Good for cutscenes, transitions
- Fallback: some viewers may still loop

### Color Quantization for GIF

**256 Color Limitation:**
- GIF maximum palette size
- Quantization reduces full-color to 256 colors
- Critical consideration when exporting from 24-bit source

**Quantization Algorithms:**

**Global Palette:**
- Single 256-color palette for all frames
- Ensures color consistency across animation
- Analyze all frames to build optimal palette
- Best for most pixel art animations

**Local Palette:**
- Different palette per frame
- Allows more colors across animation
- Can cause color shifting/flickering
- Rarely appropriate for pixel art

**Dithering Options:**
- **None**: Hard color boundaries (best for pixel art)
- **Floyd-Steinberg**: Error diffusion, adds noise
- **Ordered**: Pattern-based, creates artifacts
- **Recommendation**: Disable dithering for pixel art

### Optimization Techniques

**Frame Disposal Methods:**
- **Restore to Background**: Clear before next frame
- **Do Not Dispose**: Keep previous frame
- **Restore to Previous**: Revert to prior state

**Delta Frame Encoding:**
- Only encode changed pixels between frames
- Significant size reduction for small changes
- Automatic in most GIF encoders
- Example: Idle animation (80% size reduction)

**Transparency Optimization:**
- Designate one color as transparent
- Reduce file size by not encoding unchanged areas
- Works with delta encoding
- Choose unused color for transparency index

**Size Reduction Checklist:**
- Use global palette
- Enable delta encoding
- Minimize frame dimensions (crop to animation bounds)
- Reduce frame count if possible
- Lower frame rate for slower animations

### File Size Considerations

**Size Factors:**
```
Small (1-50 KB):  16×16 sprite, 4-8 frames, simple movement
Medium (50-200 KB): 32×32 sprite, 10-20 frames, detailed animation
Large (200KB-1MB): 64×64+ sprite, 30+ frames, complex animation
```

**Optimization Trade-offs:**
- Frame count vs. smoothness
- Canvas size vs. detail
- Frame rate vs. file size
- Color count vs. palette accuracy

## Spritesheet Layouts

Spritesheets combine multiple frames or sprites into a single image for efficient loading and rendering.

### Horizontal Strip

All frames arranged in a single horizontal row.

```
+----+----+----+----+----+
| F1 | F2 | F3 | F4 | F5 |
+----+----+----+----+----+
```

**Use Cases:**
- Simple animations (walk, run, jump)
- Scrolling backgrounds
- UI button states

**Advantages:**
- Simple to parse (X offset only)
- Easy to calculate frame position: `frame_x = frame_index * frame_width`
- Good for texture atlases with power-of-2 heights

**Disadvantages:**
- Very wide images with many frames
- Inefficient for non-power-of-2 widths
- GPU texture size limits (typically 4096-8192px)

### Vertical Strip

All frames arranged in a single vertical column.

```
+----+
| F1 |
+----+
| F2 |
+----+
| F3 |
+----+
| F4 |
+----+
```

**Use Cases:**
- Mobile-optimized layouts
- Vertical scrolling effects
- Legacy systems preferring tall textures

**Advantages:**
- Simple to parse (Y offset only)
- Frame position: `frame_y = frame_index * frame_height`
- Better for portrait-oriented displays

**Disadvantages:**
- Very tall images
- Less common than horizontal
- Same texture size constraints

### Grid Layout

Frames arranged in rows and columns.

```
+----+----+----+----+
| F1 | F2 | F3 | F4 |
+----+----+----+----+
| F5 | F6 | F7 | F8 |
+----+----+----+----+
| F9 | 10 | 11 | 12 |
+----+----+----+----+
```

**Configuration:**
- Rows: Number of vertical divisions
- Columns: Number of horizontal divisions
- Example: 4 columns × 3 rows = 12 frames

**Frame Calculation:**
```python
frame_x = (frame_index % columns) * frame_width
frame_y = (frame_index // columns) * frame_height
```

**Use Cases:**
- Large animation sets (16+ frames)
- Multiple animations in one sheet
- Power-of-2 texture optimization

**Advantages:**
- Balanced dimensions (square or near-square)
- GPU-friendly (easier to fit power-of-2)
- Compact representation

**Best Practices:**
- Use power-of-2 dimensions: 256×256, 512×512, 1024×1024
- Add padding between frames (1-2px) to prevent bleeding
- Organize by animation (row per animation type)

### Packed Layout

Optimal space usage with variable frame positions.

```
+--------+----+----+
|        | F3 | F4 |
|   F1   +----+----+
|        | F5 | F6 |
+----+---+----+----+
| F2 | F7      | F8|
+----+---------+---+
```

**Characteristics:**
- Frames positioned to minimize whitespace
- Requires metadata for frame positions
- Non-uniform layout

**Algorithms:**
- **Maxrects**: Maximum rectangles bin packing
- **Skyline**: Skyline bottom-left heuristic
- **Guillotine**: Recursive subdivision

**Use Cases:**
- Variable-size sprites (UI elements, items)
- Texture atlases with many assets
- Maximizing GPU texture memory

**Advantages:**
- Smallest total texture size
- Efficient memory usage
- Professional game asset pipelines

**Disadvantages:**
- Requires JSON/XML metadata
- More complex to parse
- Not suitable for uniform animations

**Metadata Example:**
```json
{
  "frame1": {"x": 0, "y": 0, "w": 32, "h": 64},
  "frame2": {"x": 0, "y": 64, "w": 16, "h": 16},
  "frame3": {"x": 32, "y": 0, "w": 16, "h": 16}
}
```

## JSON Metadata Formats

JSON files provide frame data, animation metadata, and asset information for game engines.

### Aseprite JSON Format

Native format exported by Aseprite with comprehensive metadata.

```json
{
  "frames": {
    "sprite_0.aseprite": {
      "frame": {"x": 0, "y": 0, "w": 32, "h": 32},
      "rotated": false,
      "trimmed": false,
      "spriteSourceSize": {"x": 0, "y": 0, "w": 32, "h": 32},
      "sourceSize": {"w": 32, "h": 32},
      "duration": 100
    },
    "sprite_1.aseprite": {
      "frame": {"x": 32, "y": 0, "w": 32, "h": 32},
      "rotated": false,
      "trimmed": false,
      "spriteSourceSize": {"x": 0, "y": 0, "w": 32, "h": 32},
      "sourceSize": {"w": 32, "h": 32},
      "duration": 100
    }
  },
  "meta": {
    "app": "http://www.aseprite.org/",
    "version": "1.3.0",
    "image": "sprite.png",
    "format": "RGBA8888",
    "size": {"w": 128, "h": 32},
    "scale": "1",
    "frameTags": [
      {
        "name": "walk",
        "from": 0,
        "to": 3,
        "direction": "forward"
      }
    ],
    "layers": [
      {"name": "Layer 1", "opacity": 255, "blendMode": "normal"}
    ],
    "slices": []
  }
}
```

**Key Fields:**
- `frames`: Per-frame data with positions and durations
- `frameTags`: Animation sequences (walk, run, idle)
- `direction`: forward, reverse, pingpong
- `duration`: Frame duration in milliseconds

### TexturePacker JSON Format

Industry-standard format used by many tools and engines.

```json
{
  "frames": {
    "hero_walk_00.png": {
      "frame": {"x": 2, "y": 2, "w": 32, "h": 32},
      "rotated": false,
      "trimmed": true,
      "spriteSourceSize": {"x": 2, "y": 1, "w": 32, "h": 32},
      "sourceSize": {"w": 36, "h": 34},
      "pivot": {"x": 0.5, "y": 0.5}
    }
  },
  "meta": {
    "app": "https://www.codeandweb.com/texturepacker",
    "version": "1.0",
    "image": "spritesheet.png",
    "format": "RGBA8888",
    "size": {"w": 512, "h": 512},
    "scale": "1"
  }
}
```

**Key Features:**
- `trimmed`: Indicates if transparent pixels were removed
- `spriteSourceSize`: Position of trimmed sprite in original
- `pivot`: Rotation/scaling origin point (0-1 normalized)
- Widely supported by game frameworks

### Unity Sprite Atlas Format

Unity-specific JSON structure for sprite atlases.

```json
{
  "name": "PlayerAtlas",
  "spriteSheet": {
    "sprites": [
      {
        "name": "player_idle_0",
        "rect": {"x": 0, "y": 0, "width": 32, "height": 32},
        "pivot": {"x": 0.5, "y": 0},
        "border": {"x": 0, "y": 0, "z": 0, "w": 0},
        "alignment": 7,
        "pixelsPerUnit": 32
      },
      {
        "name": "player_idle_1",
        "rect": {"x": 32, "y": 0, "width": 32, "height": 32},
        "pivot": {"x": 0.5, "y": 0},
        "border": {"x": 0, "y": 0, "z": 0, "w": 0},
        "alignment": 7,
        "pixelsPerUnit": 32
      }
    ]
  }
}
```

**Unity-Specific Fields:**
- `pixelsPerUnit`: Sprite resolution (typically 32 or 100)
- `alignment`: Pivot preset (7 = bottom-center)
- `border`: 9-slice borders for UI scaling
- Compatible with Unity's SpriteAtlas system

### Godot SpriteFrames Format

Godot engine's resource format for AnimatedSprite nodes.

```json
{
  "frames": [
    {
      "name": "walk",
      "frames": [
        {"texture": "res://sprites/player_walk_0.png", "duration": 0.1},
        {"texture": "res://sprites/player_walk_1.png", "duration": 0.1},
        {"texture": "res://sprites/player_walk_2.png", "duration": 0.1},
        {"texture": "res://sprites/player_walk_3.png", "duration": 0.1}
      ]
    },
    {
      "name": "idle",
      "frames": [
        {"texture": "res://sprites/player_idle_0.png", "duration": 0.5},
        {"texture": "res://sprites/player_idle_1.png", "duration": 0.5}
      ]
    }
  ],
  "speed": 10.0,
  "loop": true
}
```

**Godot Features:**
- Animation-based organization (not single frames)
- Per-frame duration in seconds
- Global speed multiplier
- Directly compatible with AnimatedSprite node

## Scaling Considerations

Pixel art requires special handling when scaling to maintain crisp, pixel-perfect appearance.

### Nearest-Neighbor Algorithm

**How It Works:**
- Each output pixel uses value from closest input pixel
- No interpolation or blending
- Preserves hard edges and exact colors

**Mathematical Definition:**
```
output[x, y] = input[floor(x / scale), floor(y / scale)]
```

**Results:**
- Perfectly sharp pixels
- No color bleeding or artifacts
- Integer scales produce perfect results
- Non-integer scales may show uneven pixels

**Essential for Pixel Art:**
- Maintains artistic intent
- Preserves hand-placed pixels
- No blur or antialiasing
- Industry standard for retro aesthetics

### Why Other Algorithms Blur Pixels

**Bilinear Interpolation:**
- Averages 4 nearest pixels
- Creates smooth gradients
- **Problem**: Blurs pixel art edges
- Use case: Photography, 3D textures

**Bicubic Interpolation:**
- Averages 16 nearest pixels
- Even smoother than bilinear
- **Problem**: Severe blurring for pixel art
- Use case: High-quality photo scaling

**Lanczos Resampling:**
- Advanced algorithm, high quality
- **Problem**: Introduces ringing artifacts
- Use case: Photographic downscaling

**Visual Comparison:**
```
Original (8×8):          Nearest (16×16):        Bilinear (16×16):
████████                 ████████████████        ░░░░░░░░░░░░░░░░
██    ██                 ████        ████        ░░██        ██░░
██    ██    ------>      ████        ████        ░░██        ██░░
████████                 ████████████████        ░░░░░░░░░░░░░░░░
(Sharp edges)            (Sharp edges)           (Blurred edges)
```

### Common Scale Factors

**Integer Scales (Recommended):**
- **1x**: Native resolution (32×32 remains 32×32)
- **2x**: Double size (32×32 becomes 64×64)
- **4x**: Quad size (32×32 becomes 128×128)
- **8x**: Octo size (32×32 becomes 256×256)

**Benefits:**
- Perfect pixel mapping (1 source pixel → N×N output pixels)
- No distortion or uneven pixels
- Crisp, clean appearance

**Non-Integer Scales (Use with Caution):**
- **1.5x**: Some pixels larger than others
- **3x**: Still integer, good quality
- **2.5x**: Uneven pixel sizes, slight distortion

**Best Practices:**
- Prefer integer scales (2x, 3x, 4x)
- Design base sprites at smallest playable size
- Scale up for high-DPI displays
- Use viewport/camera scaling instead of asset scaling when possible

### Maintaining Pixel-Perfect Appearance

**Canvas Alignment:**
- Position sprites on integer coordinates
- Avoid sub-pixel positioning (0.5, 1.3, etc.)
- Round camera position to integers

**Viewport Scaling:**
- Scale entire game viewport, not individual sprites
- Maintain aspect ratio
- Use integer scale factors

**Export Settings:**
- Disable antialiasing
- Use nearest-neighbor filter
- Set texture filtering to "Point" or "Nearest"

**GPU Texture Settings:**
- Mag Filter: Nearest/Point
- Min Filter: Nearest/Point (not Mipmap)
- Wrap Mode: Clamp or Repeat as needed

## Game Engine Integration Examples

### Unity

**Import Settings:**
```
Texture Type: Sprite (2D and UI)
Sprite Mode: Multiple (for spritesheets)
Pixels Per Unit: 32 (or native sprite size)
Filter Mode: Point (no filter)
Compression: None
Format: RGBA 32 bit
```

**Sprite Atlas Usage:**
```csharp
using UnityEngine;

public class SpriteAnimator : MonoBehaviour
{
    public Sprite[] walkFrames;
    private SpriteRenderer spriteRenderer;
    private int currentFrame = 0;
    private float frameTimer = 0f;
    private float frameDuration = 0.1f;

    void Start()
    {
        spriteRenderer = GetComponent<SpriteRenderer>();
    }

    void Update()
    {
        frameTimer += Time.deltaTime;
        if (frameTimer >= frameDuration)
        {
            frameTimer = 0f;
            currentFrame = (currentFrame + 1) % walkFrames.Length;
            spriteRenderer.sprite = walkFrames[currentFrame];
        }
    }
}
```

### Godot

**SpriteFrames Setup:**
```gdscript
# Import spritesheet
var texture = preload("res://sprites/player.png")

# Create SpriteFrames resource
var sprite_frames = SpriteFrames.new()

# Add animation
sprite_frames.add_animation("walk")
sprite_frames.set_animation_speed("walk", 10.0)

# Add frames (assume 32×32 frames in horizontal strip)
for i in range(4):
    var atlas = AtlasTexture.new()
    atlas.atlas = texture
    atlas.region = Rect2(i * 32, 0, 32, 32)
    sprite_frames.add_frame("walk", atlas, i)
```

**AnimatedSprite Configuration:**
```gdscript
extends AnimatedSprite

func _ready():
    # Disable filtering for pixel-perfect
    texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST

    # Play animation
    play("walk")
```

**Project Settings:**
```
Rendering > Textures > Canvas Textures > Default Texture Filter: Nearest
Display > Window > Stretch > Mode: viewport
Display > Window > Stretch > Aspect: keep
```

### Phaser

**Loading Spritesheet:**
```javascript
class GameScene extends Phaser.Scene {
    preload() {
        // Load spritesheet
        this.load.spritesheet('player', 'assets/player.png', {
            frameWidth: 32,
            frameHeight: 32
        });
    }

    create() {
        // Create animation from frames 0-3
        this.anims.create({
            key: 'walk',
            frames: this.anims.generateFrameNumbers('player', {
                start: 0,
                end: 3
            }),
            frameRate: 10,
            repeat: -1
        });

        // Create sprite
        const player = this.add.sprite(100, 100, 'player');
        player.play('walk');

        // Disable texture smoothing for pixel-perfect
        player.setTexture('player').setOrigin(0.5, 0.5);
    }
}
```

**Game Configuration:**
```javascript
const config = {
    type: Phaser.AUTO,
    width: 800,
    height: 600,
    pixelArt: true, // Enables nearest-neighbor filtering
    render: {
        antialias: false,
        pixelArt: true
    },
    scene: [GameScene]
};

const game = new Phaser.Game(config);
```

### Generic Engine Patterns

**Frame-Based Animation Loop:**
```javascript
class Animation {
    constructor(frames, frameDuration) {
        this.frames = frames; // Array of frame data {x, y, w, h}
        this.frameDuration = frameDuration; // Milliseconds per frame
        this.currentFrame = 0;
        this.elapsedTime = 0;
    }

    update(deltaTime) {
        this.elapsedTime += deltaTime;
        if (this.elapsedTime >= this.frameDuration) {
            this.elapsedTime = 0;
            this.currentFrame = (this.currentFrame + 1) % this.frames.length;
        }
    }

    getCurrentFrame() {
        return this.frames[this.currentFrame];
    }
}
```

**Spritesheet Rendering:**
```javascript
function drawSprite(context, image, frame, x, y, scale) {
    // Use nearest-neighbor scaling
    context.imageSmoothingEnabled = false;

    context.drawImage(
        image,
        frame.x, frame.y, frame.w, frame.h, // Source
        Math.floor(x), Math.floor(y),       // Destination (integer coords)
        frame.w * scale, frame.h * scale    // Scaled size
    );
}
```

**JSON Metadata Parsing:**
```javascript
async function loadSpritesheet(imagePath, jsonPath) {
    const [image, metadata] = await Promise.all([
        loadImage(imagePath),
        fetch(jsonPath).then(r => r.json())
    ]);

    const animations = {};

    // Parse Aseprite JSON format
    for (const tag of metadata.meta.frameTags) {
        const frames = [];
        for (let i = tag.from; i <= tag.to; i++) {
            const frameKey = Object.keys(metadata.frames)[i];
            const frameData = metadata.frames[frameKey];
            frames.push({
                x: frameData.frame.x,
                y: frameData.frame.y,
                w: frameData.frame.w,
                h: frameData.frame.h,
                duration: frameData.duration
            });
        }
        animations[tag.name] = new Animation(frames, frames[0].duration);
    }

    return { image, animations };
}
```

**Best Practices Summary:**
- Always disable texture filtering (use nearest/point)
- Position sprites on integer pixel coordinates
- Use integer scale factors
- Set `imageSmoothingEnabled = false` for canvas
- Configure engine for pixel-perfect rendering
- Load metadata alongside spritesheet images
- Cache parsed animations for performance
