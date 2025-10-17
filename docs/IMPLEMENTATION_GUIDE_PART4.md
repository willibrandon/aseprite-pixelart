# Aseprite Pixel Art Plugin - Implementation Guide (Part 4)

**Continuation of IMPLEMENTATION_GUIDE_PART3.md**

This document contains Phase 5 chunks (Advanced Skills refinement).

- **Part 1**: Chunks 1.1-3.2 (Foundation, MCP Integration, Creator & Animator Skills)
- **Part 2**: Chunks 3.3-4.1 (Professional & Exporter Skills, /pixel-new command)
- **Part 3**: Chunks 4.2-4.5 (Remaining Slash Commands)
- **Part 4** (This Document): Phase 5 (Advanced Skills Refinement)
- **Part 5**: Phase 6 (Testing and Polish)
- **Part 6**: Phase 7 (Documentation and Release)

---

## Phase 5: Advanced Skills Refinement

### Chunk 5.1: Add examples.md files to all Skills

**Objective**: Enhance all Skills with comprehensive example files showing concrete use cases and workflows.

**Files to Create**:
1. `skills/pixel-art-creator/examples.md`
2. `skills/pixel-art-animator/examples.md`
3. `skills/pixel-art-professional/examples.md`
4. `skills/pixel-art-exporter/examples.md`

---

#### File 1: `skills/pixel-art-creator/examples.md`

Create file with 200-300 lines containing:

**Structure:**
- Introduction explaining example format
- 10-15 concrete examples organized by complexity
- Each example includes:
  - User request (quoted)
  - Step-by-step approach
  - Actual tool calls with parameters
  - Expected output description
  - Screenshot description (what user would see)

**Example Categories:**
1. **Basic Shapes** (3-4 examples)
   - Simple geometric sprites
   - Icons and symbols
   - Single-color designs

2. **Layered Sprites** (2-3 examples)
   - Character with background
   - Multi-layer composition
   - Organized workflow

3. **Indexed Color** (2-3 examples)
   - Retro game sprites
   - Limited palette work
   - Game Boy style

4. **Complex Scenes** (2-3 examples)
   - Tile creation
   - Small scenes
   - Detailed sprites

**Example Format:**
```markdown
### Example 3: Game Boy Character Sprite

**User Request:**
> "Create a 48x48 Game Boy style character sprite"

**Approach:**
1. Create 48x48 Indexed canvas
2. Set Game Boy 4-color palette
3. Draw character outline with darkest color
4. Fill character with mid-tones
5. Add details with lightest color

**Tool Calls:**
```javascript
mcp__aseprite__create_canvas({
  width: 48,
  height: 48,
  color_mode: "Indexed"
})

mcp__aseprite__set_palette({
  colors: ["#0f380f", "#306230", "#8bac0f", "#9bbc0f"]
})

// Draw outline
mcp__aseprite__draw_pixels({
  pixels: [
    {x: 20, y: 10, color: "#0f380f"},
    {x: 21, y: 10, color: "#0f380f"},
    // ... outline pixels
  ]
})

// Fill body
mcp__aseprite__fill_area({
  x: 24,
  y: 20,
  color: "#306230"
})
```

**Result:**
48x48 sprite using only 4 Game Boy colors, character has clear outline and proper shading within palette constraints.

**Visual Description:**
Sprite shows character centered in canvas, using darkest green for outline, medium greens for body, and lightest green for highlights. Classic Game Boy aesthetic achieved.
```

---

#### File 2: `skills/pixel-art-animator/examples.md`

Create file with 250-350 lines containing:

**Example Categories:**
1. **Simple Idle Animations** (2-3 examples)
   - 2-frame breathing
   - Subtle movement
   - Ping-pong timing

2. **Walk Cycles** (3-4 examples)
   - 4-frame basic walk
   - 8-frame smooth walk
   - Different character styles
   - Variable timing

3. **Complex Animations** (2-3 examples)
   - Jump sequence
   - Attack animation
   - Multi-animation sprite

4. **Linked Cels** (1-2 examples)
   - Background layer optimization
   - Repeated frames

5. **Animation Tags** (1-2 examples)
   - Multiple tagged sequences
   - Game engine integration

**Example Format:**
```markdown
### Example 5: 4-Frame Walk Cycle

**User Request:**
> "Create a walk cycle animation for this 32x32 character"

**Approach:**
1. Sprite already exists (32x32)
2. Add 3 more frames (total 4 frames)
3. Frame 1: Left foot forward (already drawn)
4. Frame 2: Contact pose
5. Frame 3: Right foot forward
6. Frame 4: Contact pose
7. Set all frames to 100ms (10 FPS)
8. Create "walk" animation tag

**Tool Calls:**
```javascript
// Add 3 frames
mcp__aseprite__add_frame({ frame_number: 2 })
mcp__aseprite__add_frame({ frame_number: 3 })
mcp__aseprite__add_frame({ frame_number: 4 })

// Edit frame 2 (contact pose)
// [draw_pixels calls for contact pose]

// Edit frame 3 (right foot forward)
// [draw_pixels calls for opposite pose]

// Edit frame 4 (contact pose - mirror of frame 2)
// [draw_pixels calls]

// Set timing
mcp__aseprite__set_frame_duration({ frame_number: 1, duration_ms: 100 })
mcp__aseprite__set_frame_duration({ frame_number: 2, duration_ms: 100 })
mcp__aseprite__set_frame_duration({ frame_number: 3, duration_ms: 100 })
mcp__aseprite__set_frame_duration({ frame_number: 4, duration_ms: 100 })

// Create animation tag
mcp__aseprite__create_tag({
  name: "walk",
  from_frame: 1,
  to_frame: 4,
  direction: "forward"
})
```

**Result:**
Smooth 4-frame walk cycle at 10 FPS (100ms per frame), character alternates feet naturally, tagged as "walk" for game engine export.

**Visual Description:**
When played back, character appears to walk smoothly in place. Legs alternate convincingly, body bobs subtly, arms swing in opposition to legs.
```

---

#### File 3: `skills/pixel-art-professional/examples.md`

Create file with 250-350 lines containing:

**Example Categories:**
1. **Dithering Applications** (3-4 examples)
   - Smooth gradients with Floyd-Steinberg
   - Texture creation with Bayer
   - Retro dithering patterns

2. **Palette Optimization** (2-3 examples)
   - Color reduction workflows
   - Quantization with quality preservation
   - Retro palette conversions

3. **Shading Techniques** (3-4 examples)
   - Adding shading to flat sprite
   - Cell shading
   - Soft dithered shading
   - Multiple light sources

4. **Antialiasing** (1-2 examples)
   - Edge smoothing
   - Selective AA application

5. **Complete Refinement** (2-3 examples)
   - Taking sprite from draft to polished
   - Full professional workflow

**Example Format:**
```markdown
### Example 4: Adding Shading to Flat Sprite

**User Request:**
> "Add shading to this flat red circle sprite, light from top-left"

**Approach:**
1. Get current sprite palette
2. Analyze base red color (#ff0000)
3. Create shadow color (darker, hue-shifted toward purple: #8a0020)
4. Create highlight color (lighter, hue-shifted toward orange: #ff6a40)
5. Add shadow pixels to bottom-right
6. Add highlight pixels to top-left
7. Add subtle reflected light in deepest shadows

**Tool Calls:**
```javascript
// Get current colors
mcp__aseprite__get_palette()

// Update palette with new colors
mcp__aseprite__set_palette({
  colors: [
    "#000000",      // black background
    "#8a0020",      // shadow (new)
    "#ff0000",      // base red (existing)
    "#ff6a40",      // highlight (new)
    "#ff9a70"       // bright highlight (new)
  ]
})

// Draw shadows (bottom-right area)
mcp__aseprite__draw_pixels({
  pixels: [
    {x: 25, y: 25, color: "#8a0020"},
    {x: 26, y: 25, color: "#8a0020"},
    {x: 24, y: 26, color: "#8a0020"},
    // ... more shadow pixels
  ]
})

// Draw highlights (top-left area)
mcp__aseprite__draw_pixels({
  pixels: [
    {x: 18, y: 18, color: "#ff6a40"},
    {x: 19, y: 18, color: "#ff6a40"},
    // ... more highlight pixels
  ]
})

// Add specular highlight (brightest spot)
mcp__aseprite__draw_pixels({
  pixels: [
    {x: 20, y: 19, color: "#ff9a70"}
  ]
})
```

**Result:**
Circle sprite now has depth and dimension. Light appears to come from top-left, with smooth gradation from highlight to shadow. Hue shifting makes colors vibrant rather than muddy.

**Visual Description:**
Red circle looks three-dimensional. Top-left area glows with warm orange highlights. Bottom-right area recedes with cool purple-red shadows. Smooth color transitions create spherical appearance.
```

---

#### File 4: `skills/pixel-art-exporter/examples.md`

Create file with 200-300 lines containing:

**Example Categories:**
1. **Single Image Exports** (2-3 examples)
   - PNG with transparency
   - PNG with background
   - Scaled exports

2. **Animated GIF Exports** (2-3 examples)
   - Simple animation GIF
   - Optimized GIF
   - Custom timing

3. **Spritesheet Exports** (3-4 examples)
   - Horizontal strip for web
   - Grid layout for games
   - Packed layout for optimization
   - With JSON metadata

4. **Game Engine Integration** (3-4 examples)
   - Unity export workflow
   - Godot export workflow
   - Phaser export workflow
   - Generic engine export

**Example Format:**
```markdown
### Example 6: Unity Export with JSON Metadata

**User Request:**
> "Export this animation for Unity with sprite atlas metadata"

**Approach:**
1. Get sprite info (frame count, dimensions)
2. Export spritesheet as PNG (grid layout)
3. Generate Unity-compatible JSON metadata
4. Include frame positions, pivot points, sprite names
5. Save both spritesheet.png and spritesheet.json

**Tool Calls:**
```javascript
// Get sprite information
mcp__aseprite__get_sprite_info()
// Returns: {width: 32, height: 32, frames: 8, ...}

// Export spritesheet
mcp__aseprite__export_spritesheet({
  output_path: "character-walk.png",
  layout: "grid",
  padding: 1,
  scale: 2  // 2x for better visibility
})

// Generate JSON metadata (Unity format)
// JSON structure:
{
  "sprites": [
    {
      "name": "character-walk_0",
      "rect": {"x": 0, "y": 0, "width": 64, "height": 64},
      "pivot": {"x": 0.5, "y": 0},
      "border": {"x": 0, "y": 0, "z": 0, "w": 0}
    },
    {
      "name": "character-walk_1",
      "rect": {"x": 65, "y": 0, "width": 64, "height": 64},
      "pivot": {"x": 0.5, "y": 0}
    },
    // ... remaining frames
  ],
  "meta": {
    "image": "character-walk.png",
    "size": {"w": 256, "h": 128},
    "scale": "2"
  }
}
```

**Result:**
Two files created:
1. `character-walk.png`: 256x128 spritesheet with 8 frames in grid, 2x scaled
2. `character-walk.json`: Unity Sprite Atlas metadata with frame positions and pivots

**Unity Import Steps:**
1. Import both files into Unity Assets folder
2. Select character-walk.png in Project window
3. Set Texture Type to "Sprite (2D and UI)"
4. Set Sprite Mode to "Multiple"
5. Click "Sprite Editor"
6. Use "Slice" → "Grid By Cell Size" or import JSON
7. Each frame becomes individual sprite in Unity

**Visual Description:**
Spritesheet shows all 8 walk cycle frames arranged in 2 rows of 4 frames each. 1-pixel padding between frames prevents bleeding. JSON file contains precise pixel coordinates for Unity's sprite slicer.
```

---

### Verification Steps

```bash
# 1. Verify all examples files created
ls -la skills/*/examples.md

# Should show examples.md in all 4 skill directories

# 2. Check file sizes
wc -l skills/*/examples.md

# pixel-art-creator/examples.md: 200-300 lines
# pixel-art-animator/examples.md: 250-350 lines
# pixel-art-professional/examples.md: 250-350 lines
# pixel-art-exporter/examples.md: 200-300 lines

# 3. Verify example format consistency
grep "^### Example" skills/*/examples.md

# Should show numbered examples in each file

# 4. Check for tool call examples
grep "mcp__aseprite__" skills/*/examples.md | head -20

# Should show actual MCP tool calls
```

### Git Commit

```bash
git add skills/*/examples.md
git commit -m "feat(skills): add comprehensive examples to all Skills

- Create examples.md for pixel-art-creator Skill
- Create examples.md for pixel-art-animator Skill
- Create examples.md for pixel-art-professional Skill
- Create examples.md for pixel-art-exporter Skill
- Include 10-15 examples per Skill covering various use cases
- Show concrete tool calls and expected results
- Organize by complexity and category
- Provide visual descriptions of outputs

Chunk: 5.1"
```

### Success Criteria

- [ ] All 4 Skills have `examples.md` files
- [ ] Each examples file has 10-15 comprehensive examples
- [ ] Examples show actual MCP tool calls with parameters
- [ ] Examples organized by category and complexity
- [ ] Each example includes user request, approach, tool calls, results
- [ ] Visual descriptions help users understand outputs
- [ ] Examples follow consistent format across all Skills
- [ ] Verification steps pass
- [ ] Git commit with "Chunk: 5.1" footer

---

### Chunk 5.2: Enhance Skill descriptions for better triggering

**Objective**: Refine Skill YAML frontmatter descriptions to improve automatic Skill triggering based on user requests.

**Files to Modify**:
1. `skills/pixel-art-creator/SKILL.md`
2. `skills/pixel-art-animator/SKILL.md`
3. `skills/pixel-art-professional/SKILL.md`
4. `skills/pixel-art-exporter/SKILL.md`

---

#### Modifications

For each Skill, enhance the `description` field in YAML frontmatter to include:
- More trigger keywords and phrases
- Common user phrasings
- Related terminology
- Edge cases and variations

**Important**: Only modify the `description` field. Do NOT change `name` or `allowed-tools`.

---

#### Enhancement 1: pixel-art-creator/SKILL.md

**Current description:**
```yaml
description: Create new pixel art sprites from scratch with canvas creation, layer management, and basic drawing primitives. Use when the user wants to create a sprite, draw pixel art, make a new canvas, or mentions pixel dimensions like "64x64" or "32x32 sprite".
```

**Enhanced description:**
```yaml
description: Create new pixel art sprites from scratch with canvas creation, layer management, and basic drawing primitives. Use when the user wants to create a sprite, draw pixel art, make a new canvas, start a new image, begin a new project, or mentions pixel dimensions like "64x64", "32x32 sprite", "128 by 128", "16 pixel icon". Trigger on: "create", "new", "make", "draw", "sprite", "canvas", "image", "icon", "tile", "character", "background", dimensions (WxH), "from scratch", "blank canvas", "empty sprite", "Game Boy", "NES", "retro", color mode mentions ("RGB", "indexed", "grayscale"). Also use for drawing basic shapes like "circle", "rectangle", "line", "pixel", "fill", "outline".
```

**Rationale**: Adds common variations like "start", "begin", "empty", dimension formats, platform names, and basic drawing operations.

---

#### Enhancement 2: pixel-art-animator/SKILL.md

**Current description:**
```yaml
description: Create and manage sprite animations with multiple frames, animation tags, frame durations, and linked cels. Use when the user wants to animate a sprite, mentions "animation", "frames", "walk cycle", "frame rate", or describes motion like "walking" or "running".
```

**Enhanced description:**
```yaml
description: Create and manage sprite animations with multiple frames, animation tags, frame durations, and linked cels. Use when the user wants to animate a sprite, add animation, create movement, make it move, mentions "animation", "animated", "frames", "keyframes", "frame rate", "FPS", "timing", "duration", "walk cycle", "run cycle", "idle animation", "attack animation", "jump", "movement", "motion", or describes actions like "walking", "running", "jumping", "attacking", "breathing", "bobbing", "bouncing". Trigger on animation tags, loops, playback, sequences, "add frames", "duplicate frame", "frame timing", "ping-pong", "loop", "sequence". Also for linked cels, static backgrounds, and frame optimization.
```

**Rationale**: Adds action verbs, animation types, technical terms (FPS, keyframes, loop), and cel management.

---

#### Enhancement 3: pixel-art-professional/SKILL.md

**Current description:**
```yaml
description: Apply advanced pixel art techniques including dithering, palette optimization, shading, antialiasing, and color theory. Use when the user mentions "dithering", "palette", "shading", "antialiasing", "smoothing", "color ramp", "gradients", or wants to refine/polish existing pixel art.
```

**Enhanced description:**
```yaml
description: Apply advanced pixel art techniques including dithering, palette optimization, shading, antialiasing, and color theory. Use when the user mentions "dithering", "dither", "Bayer", "Floyd-Steinberg", "palette", "colors", "reduce colors", "optimize palette", "color limit", "shading", "shadows", "highlights", "lighting", "light source", "antialiasing", "smooth", "smoothing", "anti-alias", "AA", "color ramp", "gradient", "hue shifting", "saturation", "value", "contrast", or wants to "refine", "polish", "improve", "enhance", "make better", "add depth", "add dimension" to existing pixel art. Trigger on retro palette names (NES, Game Boy, C64, PICO-8), texture terms ("metal", "fabric", "stone", "wood"), and visual quality terms ("professional", "clean", "smooth", "vibrant").
```

**Rationale**: Adds algorithm names, color theory terms, retro palettes, texture types, and quality descriptors.

---

#### Enhancement 4: pixel-art-exporter/SKILL.md

**Current description:**
```yaml
description: Export sprites to PNG, GIF, or spritesheet formats with JSON metadata. Use when the user wants to export, save, or mentions file formats like PNG, GIF, spritesheet, or game engine integration.
```

**Enhanced description:**
```yaml
description: Export sprites to PNG, GIF, or spritesheet formats with JSON metadata for game engines. Use when the user wants to "export", "save", "output", "render", "generate", "create file", mentions file formats like "PNG", "GIF", "animated GIF", "spritesheet", "sprite sheet", "texture atlas", "tile sheet", or game engine integration with "Unity", "Godot", "Phaser", "Unreal", "GameMaker". Trigger on layout terms ("horizontal", "vertical", "grid", "packed", "strip"), scaling ("2x", "4x", "upscale", "pixel-perfect"), file operations ("save as", "export to", "output to"), metadata formats ("JSON", "XML", "metadata", "atlas data"), and delivery terms ("for web", "for game", "for Twitter", "for itch.io", "optimized").
```

**Rationale**: Adds file operation verbs, game engine names, layout types, scaling terms, and platform targets.

---

### Implementation Notes

**For each Skill:**
1. Read current SKILL.md file
2. Locate YAML frontmatter (between `---` markers)
3. Replace only the `description:` line with enhanced version
4. Preserve all other frontmatter fields exactly
5. Preserve all content after frontmatter exactly
6. Verify YAML frontmatter is still valid after edit

**Edit Pattern:**
```
OLD:
description: [old description text]

NEW:
description: [enhanced description text with more trigger keywords]
```

---

### Verification Steps

```bash
# 1. Verify frontmatter syntax is valid in all Skills
for skill in pixel-art-creator pixel-art-animator pixel-art-professional pixel-art-exporter; do
  echo "Checking $skill..."
  head -n 10 skills/$skill/SKILL.md | grep -A 2 "^---$"
done

# Should show valid YAML frontmatter for each

# 2. Check description field contains more keywords
grep "description:" skills/*/SKILL.md

# Should show longer, more detailed descriptions

# 3. Verify no other fields changed
grep "^name:" skills/*/SKILL.md
grep "^allowed-tools:" skills/*/SKILL.md

# Should match original values

# 4. Count description length increase
for skill in pixel-art-creator pixel-art-animator pixel-art-professional pixel-art-exporter; do
  desc=$(grep "^description:" skills/$skill/SKILL.md)
  echo "$skill: ${#desc} characters"
done

# Should show increased character counts
```

### Git Commit

```bash
git add skills/*/SKILL.md
git commit -m "feat(skills): enhance Skill descriptions for better triggering

- Expand pixel-art-creator description with more create/draw keywords
- Enhance pixel-art-animator description with animation action terms
- Improve pixel-art-professional description with technique keywords
- Refine pixel-art-exporter description with format and engine terms
- Add common user phrasings and variations
- Include platform names, technical terms, and quality descriptors
- Preserve all other frontmatter fields and content

Chunk: 5.2"
```

### Success Criteria

- [ ] All 4 Skills have enhanced `description` fields
- [ ] Descriptions include significantly more trigger keywords
- [ ] Common user phrasings and variations added
- [ ] Technical terms and platform names included
- [ ] `name` and `allowed-tools` fields unchanged
- [ ] YAML frontmatter remains valid
- [ ] Content after frontmatter unchanged
- [ ] Verification steps pass
- [ ] Git commit with "Chunk: 5.2" footer

---

**End of Part 4**

Continue to IMPLEMENTATION_GUIDE_PART5.md for Phase 6 (Testing and Polish).
