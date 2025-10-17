# Skills

This directory contains Agent Skills that Claude automatically uses based on context. Skills are model-invoked - you don't call them explicitly like slash commands.

## Available Skills

### pixel-art-creator
Creates new pixel art sprites with canvas setup, layers, and basic drawing primitives.

**Triggers when user mentions:**
- "create a sprite", "new canvas", "make pixel art"
- Dimensions like "64x64", "32x32 sprite"
- Basic shapes: "circle", "rectangle", "line"
- Color modes: "RGB", "indexed", "grayscale"
- Retro systems: "Game Boy", "NES"

**Capabilities:**
- Canvas creation (1-65535 pixels, RGB/Grayscale/Indexed modes)
- Layer management (add, delete, organize)
- Drawing primitives (pixels, lines, rectangles, circles, polygons, flood fill)
- Color palette setup
- Batch pixel operations

**MCP Tools:** `create_canvas`, `add_layer`, `delete_layer`, `draw_pixels`, `draw_line`, `draw_rectangle`, `draw_circle`, `draw_contour`, `fill_area`, `set_palette`, `get_palette`, `get_sprite_info`

### pixel-art-animator
Manages sprite animations with frames, tags, timing, and cel operations.

**Triggers when user mentions:**
- "animate", "animation", "frames", "keyframes"
- "walk cycle", "run cycle", "idle animation"
- "frame rate", "FPS", "timing", "duration"
- "loop", "ping-pong", "forward"

**Capabilities:**
- Frame management (add, delete, duplicate, reorder)
- Animation tags for organizing sequences
- Frame timing control (per-frame or global)
- Linked cels for shared content across frames
- Preview and playback control

**MCP Tools:** `add_frame`, `delete_frame`, `duplicate_frame`, `get_frame_info`, `set_frame_duration`, `create_animation_tag`, `list_animation_tags`, `delete_animation_tag`, `create_linked_cel`

### pixel-art-professional
Applies advanced pixel art techniques like dithering, palette optimization, shading, and antialiasing.

**Triggers when user mentions:**
- "dithering", "dither", "Floyd-Steinberg", "Bayer"
- "palette", "colors", "reduce colors", "optimize palette"
- "shading", "shadows", "highlights", "gradient"
- "antialiasing", "smooth edges", "AA"
- "color theory", "hue shift", "saturation"

**Capabilities:**
- Dithering algorithms (Floyd-Steinberg, Atkinson, Bayer 2x2/4x4/8x8)
- Palette quantization and optimization
- Color reduction with algorithm selection
- Shading techniques (light direction, gradient application)
- Edge smoothing and antialiasing
- Layer flattening

**MCP Tools:** `apply_dithering`, `quantize_colors`, `get_palette`, `set_palette`, `draw_pixels`, `add_layer`, `flatten_layers`, `get_sprite_info`

### pixel-art-exporter
Exports sprites to PNG, GIF, spritesheets, and JSON metadata for game engines.

**Triggers when user mentions:**
- "export", "save", "output"
- File formats: "PNG", "GIF", "spritesheet"
- "Unity", "Godot", "Phaser", "game engine"
- "scale", "upscale", "2x", "4x"
- "metadata", "JSON"

**Capabilities:**
- PNG export (single frame or current frame)
- Animated GIF export (with FPS and loop control)
- Spritesheet generation (horizontal, vertical, grid, packed layouts)
- JSON metadata (Aseprite, TexturePacker, Unity, Godot formats)
- Pixel-perfect scaling (1x, 2x, 4x, 8x)
- Frame range selection

**MCP Tools:** `export_sprite`, `get_sprite_info`, `get_frame_info`, `list_animation_tags`

## Skill Structure

Each Skill is a directory containing:
- `SKILL.md` - Main instructions with YAML frontmatter (required)
- `reference.md` - Technical specifications (optional)
- `examples.md` - Concrete examples (optional)

Claude loads additional files only when needed (progressive disclosure).

## YAML Frontmatter

```yaml
---
name: Skill Display Name
description: What the Skill does and when Claude should use it. Include trigger keywords.
allowed-tools: Read, Bash, mcp__aseprite__*
---
```

The `description` field determines when Claude automatically loads the Skill. Include relevant keywords and phrases users might say.

## Skill Invocation

Skills are **model-invoked**, not user-invoked:
- ✅ Claude decides when to use them based on context
- ❌ Users cannot directly call Skills like slash commands
- Skills activate automatically when user requests match their description

## Integration

Skills work together:
- **pixel-art-creator** handles initial sprite creation
- **pixel-art-animator** adds animation when user mentions frames
- **pixel-art-professional** applies advanced techniques like dithering
- **pixel-art-exporter** saves final output to files

Claude transitions between Skills automatically based on user needs.

## MCP Server

All Skills use the bundled aseprite-mcp server to communicate with Aseprite. The server provides 40+ tools for pixel art operations. See [aseprite-mcp](https://github.com/willibrandon/aseprite-mcp) for tool documentation.
