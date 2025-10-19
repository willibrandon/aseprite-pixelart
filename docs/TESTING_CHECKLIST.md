# Testing Checklist

Comprehensive testing checklist for Aseprite Pixel Art Plugin.

## Pre-Testing Setup

- [ ] Aseprite installed and accessible
- [ ] Run `/pixel-setup` to configure plugin
- [ ] Verify MCP server health check passes
- [ ] Confirm all test scripts pass: `./bin/test-plugin.sh`

## Skill Testing

### pixel-art-creator Skill

- [x] **Test 1: Basic sprite creation**
  - Request: "Create a 64x64 sprite"
  - Expected: 64x64 RGB canvas created
  - Verify: Canvas size correct, color mode RGB
  - Result: PASSED - test1-64x64.aseprite (64x64 RGB, valid)

- [x] **Test 2: Indexed color sprite**
  - Request: "Create a 32x32 Game Boy sprite"
  - Expected: 32x32 Indexed canvas with GB palette
  - Verify: Palette has 4 Game Boy colors
  - Result: PASSED - test2-32x32-gameboy.aseprite (32x32 Indexed, 4-color GB palette)

- [x] **Test 3: Drawing shapes**
  - Request: "Draw a red circle in the center"
  - Expected: Red circle drawn at canvas center
  - Verify: Circle is properly formed, correct color
  - Result: PASSED - test3a-red-circle.aseprite (32x32, red circle centered at 16,16, radius 10px)

- [x] **Test 4: Layer management**
  - Request: "Create a sprite with background and character layers"
  - Expected: Canvas with 2 named layers
  - Verify: Layers exist and are named correctly
  - Result: PASSED - test4-layers.aseprite (64x64 RGB, 2 layers: Background, Character)

- [x] **Test 5: Complex shape**
  - Request: "Draw a pixelated tree"
  - Expected: Tree-like shape drawn
  - Verify: Recognizable as tree, appropriate colors
  - Result: PASSED - test5-tree.aseprite (32x32, brown trunk + green foliage, clearly recognizable)

### pixel-art-animator Skill

- [x] **Test 6: Add frames**
  - Request: "Add 3 frames"
  - Expected: Total frames increases by 3
  - Verify: Frame count correct
  - Result: PASSED - test6-frames.aseprite (32x32, 4 frames total: 1 original + 3 added)

- [x] **Test 7: Walk cycle**
  - Request: "Create a 4-frame walk cycle"
  - Expected: 4 frames with walk animation
  - Verify: Frames show walking motion
  - Result: PASSED - test7-walk-cycle.aseprite (48x48, 4-frame walk with bobbing motion, alternating limbs, 150ms/frame)

- [x] **Test 8: Frame timing**
  - Request: "Set all frames to 100ms duration"
  - Expected: All frames have 100ms timing
  - Verify: Frame durations updated
  - Result: PASSED - test8-frame-duration.aseprite (32x32, 4 frames, all set to 100ms from varying durations)

- [x] **Test 9: Animation tag**
  - Request: "Create animation tag 'walk' for frames 1-4"
  - Expected: Tag created with correct range
  - Verify: Tag exists with proper settings
  - Result: PASSED - test9-animation-tag.aseprite (32x32, 4 frames, tag 'walk' frames 1-4 forward direction)

- [x] **Test 10: Linked cels**
  - Request: "Link the background layer across all frames"
  - Expected: Background cels linked
  - Verify: Editing one cel updates all
  - Result: PASSED - test10-linked-cels.aseprite (32x32, 4 frames, Background layer linked, sky blue fill across all frames)

### pixel-art-professional Skill

- [x] **Test 11: Apply dithering**
  - Request: "Apply Floyd-Steinberg dithering"
  - Expected: Sprite shows dithering pattern
  - Verify: Visual quality maintained
  - Result: PASSED - Floyd-Steinberg error diffusion applied successfully, smooth gradient pattern with organic noise, visual quality excellent

- [x] **Test 12: Palette optimization**
  - Request: "Load the tree sprite from test-outputs/test5-tree.aseprite and reduce its palette to 16 colors while maintaining visual quality"
  - Expected: Palette reduced to 16 colors (or optimized to fewer if original has less)
  - Verify: Color count correct, quality acceptable
  - Result: PASSED - test12-tree-16colors.aseprite (optimized to 4 colors from 3+transparency, median_cut algorithm, indexed mode, visual quality fully preserved)

- [x] **Test 13: Add shading**
  - Request: "Load the tree sprite from test-outputs/test5-tree.aseprite and add shading with light from top-left"
  - Expected: Shadows on bottom-right, highlights on top-left
  - Verify: Shading direction correct, looks three-dimensional
  - Result: FAILED - test13-tree-shaded.aseprite. Tool executed and added shading, but colors inverted (brown foliage, green trunk). Bug in pixel-mcp v0.5.0 apply_auto_shading when converting RGB shaded image back to indexed mode. See https://github.com/willibrandon/pixel-mcp/issues/11. Opportunities for future improvements in artistic quality and region detection.

- [ ] **Test 14: Apply retro palette**
  - Request: "Convert to NES palette"
  - Expected: Sprite uses only NES colors
  - Verify: Colors match NES palette

- [ ] **Test 15: Antialiasing**
  - Request: "Smooth the edges"
  - Expected: Jagged edges smoothed
  - Verify: Edges look smoother, not blurry

### pixel-art-exporter Skill

- [ ] **Test 16: Export PNG**
  - Request: "Export as PNG"
  - Expected: PNG file created
  - Verify: File exists, correct size, transparency preserved

- [ ] **Test 17: Export GIF**
  - Request: "Export as animated GIF"
  - Expected: GIF file with animation
  - Verify: File exists, animates correctly, loops

- [ ] **Test 18: Export spritesheet**
  - Request: "Export as horizontal spritesheet"
  - Expected: Spritesheet with frames in row
  - Verify: All frames present, layout correct

- [ ] **Test 19: Scaled export**
  - Request: "Export at 4x scale"
  - Expected: Export 4 times larger
  - Verify: Size correct, pixel-perfect scaling

- [ ] **Test 20: JSON metadata**
  - Request: "Export with Unity JSON metadata"
  - Expected: PNG + JSON files
  - Verify: JSON format correct, frame data accurate

## Command Testing

### /pixel-new

- [ ] **Test 21: Default creation**
  - Command: `/pixel-new`
  - Expected: 64x64 RGB sprite
  - Verify: Default size and color mode

- [ ] **Test 22: Size preset**
  - Command: `/pixel-new icon`
  - Expected: 32x32 RGB sprite
  - Verify: Preset size applied

- [ ] **Test 23: Palette preset**
  - Command: `/pixel-new 64x64 gameboy`
  - Expected: 64x64 indexed with GB palette
  - Verify: Palette set correctly

- [ ] **Test 24: Custom dimensions**
  - Command: `/pixel-new 128x96`
  - Expected: 128x96 sprite
  - Verify: Custom size correct

### /pixel-palette

- [ ] **Test 25: Set palette**
  - Command: `/pixel-palette set nes`
  - Expected: NES palette applied
  - Verify: Palette matches NES colors

- [ ] **Test 26: Optimize palette**
  - Command: `/pixel-palette optimize 16`
  - Expected: Colors reduced to 16
  - Verify: Optimization successful

- [ ] **Test 27: Show palette**
  - Command: `/pixel-palette show`
  - Expected: Palette colors displayed
  - Verify: Output readable, colors listed

- [ ] **Test 28: Custom palette**
  - Command: `/pixel-palette set custom #000,#fff,#f00`
  - Expected: 3-color custom palette
  - Verify: Colors match input

### /pixel-export

- [ ] **Test 29: PNG export**
  - Command: `/pixel-export png output.png`
  - Expected: PNG file created
  - Verify: File exists at specified path

- [ ] **Test 30: GIF with options**
  - Command: `/pixel-export gif anim.gif fps=12`
  - Expected: GIF with 12 FPS
  - Verify: Frame rate correct

- [ ] **Test 31: Spritesheet layout**
  - Command: `/pixel-export sheet sprite.png layout=grid`
  - Expected: Grid layout spritesheet
  - Verify: Layout correct

- [ ] **Test 32: JSON export**
  - Command: `/pixel-export json sprite.json format=unity`
  - Expected: Unity format JSON
  - Verify: JSON structure correct

### /pixel-setup

- [ ] **Test 33: Auto-detection**
  - Command: `/pixel-setup`
  - Expected: Aseprite path detected
  - Verify: Configuration created

- [ ] **Test 34: Manual path**
  - Command: `/pixel-setup /path/to/aseprite`
  - Expected: Manual path used
  - Verify: Config uses specified path

- [ ] **Test 35: Health check**
  - Command: `/pixel-setup` (after config)
  - Expected: Health check passes
  - Verify: MCP server ready

### /pixel-help

- [ ] **Test 36: General help**
  - Command: `/pixel-help`
  - Expected: Overview and command list
  - Verify: All commands listed

- [ ] **Test 37: Command help**
  - Command: `/pixel-help pixel-new`
  - Expected: Detailed help for /pixel-new
  - Verify: Usage and examples shown

- [ ] **Test 38: Topic help**
  - Command: `/pixel-help palettes`
  - Expected: Palette information
  - Verify: Palette list and usage shown

## Integration Testing

### End-to-End Workflows

- [ ] **Workflow 1: Simple sprite creation**
  1. `/pixel-new icon gameboy`
  2. "Draw a character"
  3. `/pixel-export png character.png`
  - Verify: Complete workflow succeeds

- [ ] **Workflow 2: Animated sprite**
  1. `/pixel-new 64x64`
  2. "Create a 4-frame walk cycle"
  3. `/pixel-export gif walk.gif fps=10`
  - Verify: Animated GIF plays correctly

- [ ] **Workflow 3: Game export**
  1. Create and animate sprite
  2. `/pixel-export json game-sprite.json format=unity`
  3. Import into game engine
  - Verify: Import succeeds, metadata correct

- [ ] **Workflow 4: Retro sprite**
  1. `/pixel-new tile nes`
  2. "Draw a brick wall tile"
  3. "Apply Bayer dithering"
  4. `/pixel-export png tile.png scale=4`
  - Verify: Retro aesthetic achieved

## Error Handling

- [ ] **Test 39: Invalid dimensions**
  - Request: "Create a 0x0 sprite"
  - Expected: Error message, no crash
  - Verify: Helpful error shown

- [ ] **Test 40: Missing Aseprite**
  - Setup: Remove Aseprite config
  - Request: Any creation command
  - Expected: Clear error about setup needed
  - Verify: Directs to /pixel-setup

- [ ] **Test 41: Invalid palette**
  - Command: `/pixel-palette set nonexistent`
  - Expected: Error about unknown palette
  - Verify: Lists available palettes

- [ ] **Test 42: Export without sprite**
  - Command: `/pixel-export png output.png` (no sprite open)
  - Expected: Error about no sprite
  - Verify: Helpful error message

## Performance Testing

- [ ] **Test 43: Large canvas**
  - Request: "Create a 512x512 sprite"
  - Expected: Creates successfully
  - Verify: No timeout, reasonable performance

- [ ] **Test 44: Many frames**
  - Request: "Add 30 frames"
  - Expected: 30 frames added
  - Verify: Completes in reasonable time

- [ ] **Test 45: Complex export**
  - Setup: 64 frame animation
  - Command: `/pixel-export sheet large.png`
  - Expected: Spritesheet created
  - Verify: No timeout, file correct

## Cross-Platform Testing

### macOS
- [ ] All above tests pass on macOS Intel
- [ ] All above tests pass on macOS Apple Silicon

### Linux
- [ ] All above tests pass on Linux x86_64
- [ ] All above tests pass on Linux ARM64

### Windows
- [ ] All above tests pass on Windows 10/11

## Regression Testing

After any bug fixes:
- [ ] Re-run full test suite
- [ ] Verify fix doesn't break other features
- [ ] Update KNOWN_ISSUES.md if needed

## Sign-Off

Testing completed by: _______________
Date: _______________
Version tested: _______________

All critical tests passed: [ ] Yes [ ] No
Known issues documented: [ ] Yes [ ] No
Ready for release: [ ] Yes [ ] No
