# Pixel Art Animator Examples

This document provides concrete examples of how the pixel-art-animator skill handles animation tasks in Aseprite. Each example shows the user's request, step-by-step approach, actual MCP tool calls with parameters, and expected results.

Examples are organized by animation complexity, from simple idle animations to complex multi-tag sequences.

---

## Simple Idle Animations

### Example 1: Basic 2-Frame Breathing Animation

**User Request:**
> "Create a simple breathing animation for a character, just 2 frames, 32x32"

**Approach:**
1. Create 32x32 canvas
2. Draw base character on frame 1
3. Create frame 2 with slight body movement
4. Set frame durations for smooth breathing
5. Loop animation

**Tool Calls:**
```javascript
// Create canvas with initial frame
mcp__aseprite__create_canvas({
  width: 32,
  height: 32,
  colorMode: "rgb",
  name: "breathing-idle"
})

// Draw character on frame 1 (base pose)
mcp__aseprite__draw_pixels({
  frame: 1,
  pixels: [
    // Head
    { x: 14, y: 8, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 15, y: 8, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 16, y: 8, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 17, y: 8, color: { r: 139, g: 90, b: 43, a: 255 } },
    // Body (lower position - inhale)
    { x: 15, y: 12, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 16, y: 12, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 14, y: 13, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 15, y: 13, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 16, y: 13, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 17, y: 13, color: { r: 50, g: 100, b: 200, a: 255 } }
  ]
})

// Add frame 2
mcp__aseprite__add_frame({
  duration: 500  // 500ms
})

// Draw slightly raised body on frame 2 (exhale)
mcp__aseprite__draw_pixels({
  frame: 2,
  pixels: [
    // Head (same position)
    { x: 14, y: 8, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 15, y: 8, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 16, y: 8, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 17, y: 8, color: { r: 139, g: 90, b: 43, a: 255 } },
    // Body (raised 1 pixel - exhale)
    { x: 15, y: 11, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 16, y: 11, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 14, y: 12, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 15, y: 12, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 16, y: 12, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 17, y: 12, color: { r: 50, g: 100, b: 200, a: 255 } }
  ]
})

// Set frame durations for breathing rhythm
mcp__aseprite__set_frame_duration({
  frame: 1,
  duration: 500  // Hold inhale
})

mcp__aseprite__set_frame_duration({
  frame: 2,
  duration: 500  // Hold exhale
})
```

**Result:**
A simple 2-frame breathing animation where the character's body rises and falls subtly.

**Visual Description:**
When played, the animation shows a gentle breathing effect. Frame 1 shows the body in a lower position (inhaled), frame 2 shows it raised slightly (exhaled). The loop creates a continuous, calm breathing rhythm.

---

### Example 2: Bobbing Coin Animation

**User Request:**
> "Make a collectible coin that bobs up and down, 3 frames, 16x16"

**Approach:**
1. Create 16x16 indexed canvas
2. Draw coin at middle height (frame 1)
3. Draw coin at top position (frame 2)
4. Draw coin at bottom position (frame 3)
5. Set smooth frame timing

**Tool Calls:**
```javascript
mcp__aseprite__create_canvas({
  width: 16,
  height: 16,
  colorMode: "indexed",
  name: "bobbing-coin"
})

mcp__aseprite__set_palette({
  colors: [
    { r: 0, g: 0, b: 0 },          // Index 0: Transparent
    { r: 180, g: 140, b: 0 },      // Index 1: Gold
    { r: 255, g: 215, b: 0 },      // Index 2: Bright gold
    { r: 255, g: 255, b: 200 }     // Index 3: Highlight
  ]
})

// Frame 1: Middle position
mcp__aseprite__draw_pixels({
  frame: 1,
  pixels: [
    { x: 6, y: 7, colorIndex: 2 }, { x: 7, y: 7, colorIndex: 2 },
    { x: 8, y: 7, colorIndex: 2 }, { x: 9, y: 7, colorIndex: 2 },
    { x: 5, y: 8, colorIndex: 2 }, { x: 6, y: 8, colorIndex: 3 },
    { x: 7, y: 8, colorIndex: 2 }, { x: 8, y: 8, colorIndex: 2 },
    { x: 9, y: 8, colorIndex: 1 }, { x: 10, y: 8, colorIndex: 1 }
  ]
})

// Frame 2: Top position (2 pixels up)
mcp__aseprite__add_frame({ duration: 150 })

mcp__aseprite__draw_pixels({
  frame: 2,
  pixels: [
    { x: 6, y: 5, colorIndex: 2 }, { x: 7, y: 5, colorIndex: 2 },
    { x: 8, y: 5, colorIndex: 2 }, { x: 9, y: 5, colorIndex: 2 },
    { x: 5, y: 6, colorIndex: 2 }, { x: 6, y: 6, colorIndex: 3 },
    { x: 7, y: 6, colorIndex: 2 }, { x: 8, y: 6, colorIndex: 2 },
    { x: 9, y: 6, colorIndex: 1 }, { x: 10, y: 6, colorIndex: 1 }
  ]
})

// Frame 3: Bottom position (2 pixels down)
mcp__aseprite__add_frame({ duration: 150 })

mcp__aseprite__draw_pixels({
  frame: 3,
  pixels: [
    { x: 6, y: 9, colorIndex: 2 }, { x: 7, y: 9, colorIndex: 2 },
    { x: 8, y: 9, colorIndex: 2 }, { x: 9, y: 9, colorIndex: 2 },
    { x: 5, y: 10, colorIndex: 2 }, { x: 6, y: 10, colorIndex: 3 },
    { x: 7, y: 10, colorIndex: 2 }, { x: 8, y: 10, colorIndex: 2 },
    { x: 9, y: 10, colorIndex: 1 }, { x: 10, y: 10, colorIndex: 1 }
  ]
})

// Set consistent frame timing
mcp__aseprite__set_frame_duration({ frame: 1, duration: 150 })
mcp__aseprite__set_frame_duration({ frame: 2, duration: 150 })
mcp__aseprite__set_frame_duration({ frame: 3, duration: 150 })
```

**Result:**
A 3-frame bobbing animation where the coin floats up and down smoothly.

**Visual Description:**
The coin appears to float in midair with a smooth up-down motion. The animation cycles through middle → top → bottom → middle, creating a continuous hovering effect typical of collectible items in games.

---

### Example 3: Blinking Character

**User Request:**
> "Add a blinking animation to my character sprite, eyes should close for one frame"

**Approach:**
1. Assume canvas exists with character
2. Frame 1: Eyes open (existing)
3. Frame 2: Same as frame 1 (hold open eyes)
4. Frame 3: Eyes closed
5. Frame 4: Eyes open again
6. Set longer duration for open eyes, short for blink

**Tool Calls:**
```javascript
// Add frame 2 (duplicate frame 1 to hold open eyes)
mcp__aseprite__duplicate_frame({
  sourceFrame: 1,
  duration: 2000  // Hold eyes open for 2 seconds
})

// Add frame 3 (blink - eyes closed)
mcp__aseprite__add_frame({ duration: 100 })

mcp__aseprite__draw_pixels({
  frame: 3,
  pixels: [
    // Draw closed eyes (horizontal lines instead of dots)
    { x: 12, y: 9, color: { r: 0, g: 0, b: 0, a: 255 } },
    { x: 13, y: 9, color: { r: 0, g: 0, b: 0, a: 255 } },
    { x: 18, y: 9, color: { r: 0, g: 0, b: 0, a: 255 } },
    { x: 19, y: 9, color: { r: 0, g: 0, b: 0, a: 255 } }
  ]
})

// Add frame 4 (duplicate frame 1 for eyes open again)
mcp__aseprite__duplicate_frame({
  sourceFrame: 1,
  duration: 100  // Brief open before loop
})

// Create animation tag for blinking cycle
mcp__aseprite__create_tag({
  name: "blink_cycle",
  fromFrame: 1,
  toFrame: 4,
  direction: "forward"
})
```

**Result:**
A 4-frame blinking animation with natural timing - eyes stay open long, blink quickly, return to open.

**Visual Description:**
The character's eyes remain open for most of the animation (frames 1-2), quickly close (frame 3), then immediately reopen (frame 4). The timing creates a natural blink that doesn't interrupt the character's idle state.

---

## Walk Cycles

### Example 4: Basic 4-Frame Walk Cycle

**User Request:**
> "Create a simple side-view walk cycle for a character, 4 frames, 32x32"

**Approach:**
1. Create canvas
2. Frame 1: Contact pose (left foot forward)
3. Frame 2: Passing pose (legs together, body high)
4. Frame 3: Contact pose (right foot forward)
5. Frame 4: Passing pose (return)
6. Set frame durations for walk speed

**Tool Calls:**
```javascript
mcp__aseprite__create_canvas({
  width: 32,
  height: 32,
  colorMode: "rgb",
  name: "walk-cycle"
})

// Frame 1: Left foot forward contact
mcp__aseprite__draw_pixels({
  frame: 1,
  pixels: [
    // Head
    { x: 15, y: 6, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 16, y: 6, color: { r: 139, g: 90, b: 43, a: 255 } },
    // Body
    { x: 15, y: 10, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 16, y: 10, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 15, y: 11, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 16, y: 11, color: { r: 50, g: 100, b: 200, a: 255 } },
    // Left leg forward
    { x: 13, y: 12, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 13, y: 13, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 12, y: 14, color: { r: 101, g: 67, b: 33, a: 255 } },
    // Right leg back
    { x: 18, y: 12, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 18, y: 13, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 19, y: 14, color: { r: 101, g: 67, b: 33, a: 255 } }
  ]
})

// Frame 2: Passing pose (legs together, body raised)
mcp__aseprite__add_frame({ duration: 100 })

mcp__aseprite__draw_pixels({
  frame: 2,
  pixels: [
    // Head (raised 1 pixel)
    { x: 15, y: 5, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 16, y: 5, color: { r: 139, g: 90, b: 43, a: 255 } },
    // Body (raised)
    { x: 15, y: 9, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 16, y: 9, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 15, y: 10, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 16, y: 10, color: { r: 50, g: 100, b: 200, a: 255 } },
    // Legs together, vertical
    { x: 15, y: 11, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 15, y: 12, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 15, y: 13, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 16, y: 11, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 16, y: 12, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 16, y: 13, color: { r: 101, g: 67, b: 33, a: 255 } }
  ]
})

// Frame 3: Right foot forward contact
mcp__aseprite__add_frame({ duration: 100 })

mcp__aseprite__draw_pixels({
  frame: 3,
  pixels: [
    // Head
    { x: 15, y: 6, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 16, y: 6, color: { r: 139, g: 90, b: 43, a: 255 } },
    // Body
    { x: 15, y: 10, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 16, y: 10, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 15, y: 11, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 16, y: 11, color: { r: 50, g: 100, b: 200, a: 255 } },
    // Right leg forward (mirrored from frame 1)
    { x: 18, y: 12, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 18, y: 13, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 19, y: 14, color: { r: 101, g: 67, b: 33, a: 255 } },
    // Left leg back
    { x: 13, y: 12, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 13, y: 13, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 12, y: 14, color: { r: 101, g: 67, b: 33, a: 255 } }
  ]
})

// Frame 4: Passing pose again (duplicate frame 2)
mcp__aseprite__duplicate_frame({
  sourceFrame: 2,
  duration: 100
})

// Set consistent walk timing
mcp__aseprite__set_frame_duration({ frame: 1, duration: 100 })
mcp__aseprite__set_frame_duration({ frame: 2, duration: 100 })
mcp__aseprite__set_frame_duration({ frame: 3, duration: 100 })
mcp__aseprite__set_frame_duration({ frame: 4, duration: 100 })

// Create walk cycle tag
mcp__aseprite__create_tag({
  name: "walk",
  fromFrame: 1,
  toFrame: 4,
  direction: "forward"
})
```

**Result:**
A smooth 4-frame walk cycle with proper contact and passing poses.

**Visual Description:**
The character walks smoothly from left to right. Frame 1 shows left foot forward, frame 2 shows legs together with body raised, frame 3 shows right foot forward, frame 4 returns to legs together. The cycle creates natural walking motion.

---

### Example 5: 8-Frame Smooth Walk

**User Request:**
> "Create a more detailed walk cycle with 8 frames for smoother animation"

**Approach:**
1. Create canvas
2. Add breakdown frames between contact and passing poses
3. Include anticipation and follow-through
4. Add subtle body bounce and arm swing
5. Set faster frame rate for smoothness

**Tool Calls:**
```javascript
mcp__aseprite__create_canvas({
  width: 48,
  height: 48,
  colorMode: "rgb",
  name: "smooth-walk"
})

// Frame 1: Contact - left foot forward
mcp__aseprite__draw_pixels({
  frame: 1,
  pixels: [
    // Character at lowest point, left foot planted
    { x: 23, y: 10, color: { r: 139, g: 90, b: 43, a: 255 } },  // Head
    { x: 24, y: 10, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 23, y: 16, color: { r: 50, g: 100, b: 200, a: 255 } },  // Body
    { x: 24, y: 16, color: { r: 50, g: 100, b: 200, a: 255 } },
    // Left arm back, right arm forward
    { x: 21, y: 17, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 26, y: 17, color: { r: 139, g: 90, b: 43, a: 255 } },
    // Left leg forward, right leg back extended
    { x: 20, y: 20, color: { r: 101, g: 67, b: 33, a: 255 } },  // Left
    { x: 27, y: 21, color: { r: 101, g: 67, b: 33, a: 255 } }   // Right
  ]
})

// Frame 2: Recoil - absorbing impact
mcp__aseprite__add_frame({ duration: 75 })
// ... (slight compression, legs slightly bent)

// Frame 3: Passing 1 - beginning to rise
mcp__aseprite__add_frame({ duration: 75 })
// ... (body starting to rise, legs coming together)

// Frame 4: High point - apex of motion
mcp__aseprite__add_frame({ duration: 75 })
// ... (body at highest, legs nearly together, vertical)

// Frame 5: Contact - right foot forward
mcp__aseprite__add_frame({ duration: 75 })
// ... (mirror of frame 1, right foot now forward)

// Frame 6: Recoil - absorbing impact (right side)
mcp__aseprite__add_frame({ duration: 75 })
// ... (slight compression on right side)

// Frame 7: Passing 2 - beginning to rise
mcp__aseprite__add_frame({ duration: 75 })
// ... (body rising again, legs coming together)

// Frame 8: High point - apex returning to start
mcp__aseprite__add_frame({ duration: 75 })
// ... (body at high point, completing cycle)

// Set consistent smooth timing
for (let i = 1; i <= 8; i++) {
  mcp__aseprite__set_frame_duration({ frame: i, duration: 75 })
}

mcp__aseprite__create_tag({
  name: "smooth_walk",
  fromFrame: 1,
  toFrame: 8,
  direction: "forward"
})
```

**Result:**
A fluid 8-frame walk cycle with smooth weight transfer and natural body movement.

**Visual Description:**
The animation shows detailed walking mechanics with the body rising and falling naturally. Arms swing opposite to legs, the torso compresses slightly on foot contact, and rises smoothly during passing poses. The extra frames create very smooth motion at 75ms per frame.

---

## Complex Animations

### Example 6: Jump Sequence

**User Request:**
> "Create a jump animation - anticipation, takeoff, air, landing"

**Approach:**
1. Frame 1-2: Crouch (anticipation)
2. Frame 3: Takeoff push
3. Frame 4-6: Rising (different heights)
4. Frame 7-8: Falling
5. Frame 9: Land (compression)
6. Frame 10: Return to idle

**Tool Calls:**
```javascript
mcp__aseprite__create_canvas({
  width: 32,
  height: 48,
  colorMode: "rgb",
  name: "jump-animation"
})

// Frame 1: Start crouch anticipation
mcp__aseprite__draw_pixels({
  frame: 1,
  pixels: [
    // Character in normal standing position
    { x: 15, y: 20, color: { r: 139, g: 90, b: 43, a: 255 } },  // Head
    { x: 16, y: 20, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 15, y: 24, color: { r: 50, g: 100, b: 200, a: 255 } },  // Body
    { x: 16, y: 24, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 15, y: 28, color: { r: 101, g: 67, b: 33, a: 255 } },  // Legs
    { x: 16, y: 28, color: { r: 101, g: 67, b: 33, a: 255 } }
  ]
})

// Frame 2: Deep crouch
mcp__aseprite__add_frame({ duration: 150 })

mcp__aseprite__draw_pixels({
  frame: 2,
  pixels: [
    // Character crouched lower (head down 4 pixels, legs compressed)
    { x: 15, y: 24, color: { r: 139, g: 90, b: 43, a: 255 } },  // Head lower
    { x: 16, y: 24, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 15, y: 27, color: { r: 50, g: 100, b: 200, a: 255 } },  // Body lower
    { x: 16, y: 27, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 14, y: 30, color: { r: 101, g: 67, b: 33, a: 255 } },  // Legs bent wide
    { x: 15, y: 30, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 16, y: 30, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 17, y: 30, color: { r: 101, g: 67, b: 33, a: 255 } }
  ]
})

// Frame 3: Takeoff extension
mcp__aseprite__add_frame({ duration: 100 })

mcp__aseprite__draw_pixels({
  frame: 3,
  pixels: [
    // Character extending upward, arms down
    { x: 15, y: 22, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 16, y: 22, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 15, y: 25, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 16, y: 25, color: { r: 50, g: 100, b: 200, a: 255 } },
    // Legs extended downward, pushing off
    { x: 15, y: 28, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 16, y: 28, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 15, y: 29, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 16, y: 29, color: { r: 101, g: 67, b: 33, a: 255 } }
  ]
})

// Frame 4: Rising - low air
mcp__aseprite__add_frame({ duration: 100 })

mcp__aseprite__draw_pixels({
  frame: 4,
  pixels: [
    // Character rising, arms starting to go up
    { x: 15, y: 16, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 16, y: 16, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 15, y: 19, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 16, y: 19, color: { r: 50, g: 100, b: 200, a: 255 } },
    // Arms raised halfway
    { x: 13, y: 19, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 18, y: 19, color: { r: 139, g: 90, b: 43, a: 255 } },
    // Legs tucked
    { x: 15, y: 22, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 16, y: 22, color: { r: 101, g: 67, b: 33, a: 255 } }
  ]
})

// Frame 5: Apex - highest point
mcp__aseprite__add_frame({ duration: 150 })

mcp__aseprite__draw_pixels({
  frame: 5,
  pixels: [
    // Character at peak, arms fully raised
    { x: 15, y: 10, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 16, y: 10, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 15, y: 13, color: { r: 50, g: 100, b: 200, a: 255 } },
    { x: 16, y: 13, color: { r: 50, g: 100, b: 200, a: 255 } },
    // Arms up
    { x: 14, y: 9, color: { r: 139, g: 90, b: 43, a: 255 } },
    { x: 17, y: 9, color: { r: 139, g: 90, b: 43, a: 255 } },
    // Legs tucked compact
    { x: 15, y: 16, color: { r: 101, g: 67, b: 33, a: 255 } },
    { x: 16, y: 16, color: { r: 101, g: 67, b: 33, a: 255 } }
  ]
})

// Frame 6: Falling - beginning descent
mcp__aseprite__add_frame({ duration: 100 })

// Frame 7: Falling - mid descent
mcp__aseprite__add_frame({ duration: 100 })

// Frame 8: Landing preparation
mcp__aseprite__add_frame({ duration: 100 })

// Frame 9: Impact compression
mcp__aseprite__add_frame({ duration: 100 })

// Frame 10: Recovery to idle
mcp__aseprite__add_frame({ duration: 150 })

// Create jump animation tag
mcp__aseprite__create_tag({
  name: "jump",
  fromFrame: 1,
  toFrame: 10,
  direction: "forward"
})
```

**Result:**
A complete jump animation with anticipation, aerial phase, and landing recovery.

**Visual Description:**
The character crouches down in preparation (frames 1-2), explosively extends upward (frame 3), rises into the air with arms moving up (frames 4-5), hangs at the apex (frame 5), falls back down (frames 6-7), prepares for landing (frame 8), compresses on impact (frame 9), and recovers to standing (frame 10).

---

## Linked Cels

### Example 7: Walking with Static Background

**User Request:**
> "Create a walk cycle but keep the background layer the same across all frames"

**Approach:**
1. Create background layer
2. Draw static background on frame 1
3. Link background cel across all frames
4. Create character layer
5. Animate character walk on character layer only

**Tool Calls:**
```javascript
mcp__aseprite__create_canvas({
  width: 64,
  height: 48,
  colorMode: "rgb",
  name: "walk-with-background"
})

// Create background layer
mcp__aseprite__add_layer({
  name: "background"
})

// Draw static background on frame 1
mcp__aseprite__draw_pixels({
  layer: "background",
  frame: 1,
  pixels: [
    // Sky - fill top half with blue
    ...Array.from({ length: 64 * 20 }, (_, i) => ({
      x: i % 64,
      y: Math.floor(i / 64),
      color: { r: 135, g: 206, b: 235, a: 255 }
    })),
    // Ground - fill bottom with green
    ...Array.from({ length: 64 * 28 }, (_, i) => ({
      x: i % 64,
      y: 20 + Math.floor(i / 64),
      color: { r: 34, g: 139, b: 34, a: 255 }
    }))
  ]
})

// Add frames for walk cycle
mcp__aseprite__add_frame({ duration: 100 })
mcp__aseprite__add_frame({ duration: 100 })
mcp__aseprite__add_frame({ duration: 100 })

// Link background cel across all frames (background stays static)
mcp__aseprite__link_cel({
  layer: "background",
  frame: 1,
  targetFrames: [2, 3, 4]
})

// Create character layer for animation
mcp__aseprite__add_layer({
  name: "character"
})

// Animate character walk on character layer
// Frame 1: Contact
mcp__aseprite__draw_pixels({
  layer: "character",
  frame: 1,
  pixels: [/* character pose 1 */]
})

// Frame 2: Passing
mcp__aseprite__draw_pixels({
  layer: "character",
  frame: 2,
  pixels: [/* character pose 2 */]
})

// Frame 3: Contact
mcp__aseprite__draw_pixels({
  layer: "character",
  frame: 3,
  pixels: [/* character pose 3 */]
})

// Frame 4: Passing
mcp__aseprite__draw_pixels({
  layer: "character",
  frame: 4,
  pixels: [/* character pose 4 */]
})

mcp__aseprite__create_tag({
  name: "walk_with_bg",
  fromFrame: 1,
  toFrame: 4,
  direction: "forward"
})
```

**Result:**
A walk cycle animation where the background remains static while the character animates.

**Visual Description:**
The background layer (sky and ground) remains identical across all frames thanks to linked cels. Only the character layer changes, showing the walk cycle. This is memory-efficient and typical for game animations.

---

## Multiple Animation Tags

### Example 8: Character with Idle, Walk, and Attack

**User Request:**
> "Create a character spritesheet with separate idle, walk, and attack animations"

**Approach:**
1. Create canvas
2. Frames 1-4: Idle animation
3. Frames 5-8: Walk animation
4. Frames 9-14: Attack animation
5. Tag each animation sequence
6. Set appropriate durations

**Tool Calls:**
```javascript
mcp__aseprite__create_canvas({
  width: 32,
  height: 32,
  colorMode: "rgb",
  name: "character-animations"
})

// === IDLE ANIMATION (Frames 1-4) ===
// Frame 1: Idle base
mcp__aseprite__draw_pixels({
  frame: 1,
  pixels: [/* idle pose 1 */]
})

// Frame 2: Idle breath
mcp__aseprite__add_frame({ duration: 500 })
mcp__aseprite__draw_pixels({
  frame: 2,
  pixels: [/* idle pose 2 - slight body rise */]
})

// Frame 3: Hold
mcp__aseprite__duplicate_frame({ sourceFrame: 2, duration: 300 })

// Frame 4: Return
mcp__aseprite__duplicate_frame({ sourceFrame: 1, duration: 200 })

// Tag idle animation
mcp__aseprite__create_tag({
  name: "idle",
  fromFrame: 1,
  toFrame: 4,
  direction: "forward"
})

// === WALK ANIMATION (Frames 5-8) ===
// Frame 5: Left foot forward
mcp__aseprite__add_frame({ duration: 100 })
mcp__aseprite__draw_pixels({
  frame: 5,
  pixels: [/* walk pose 1 */]
})

// Frame 6: Passing
mcp__aseprite__add_frame({ duration: 100 })
mcp__aseprite__draw_pixels({
  frame: 6,
  pixels: [/* walk pose 2 */]
})

// Frame 7: Right foot forward
mcp__aseprite__add_frame({ duration: 100 })
mcp__aseprite__draw_pixels({
  frame: 7,
  pixels: [/* walk pose 3 */]
})

// Frame 8: Passing
mcp__aseprite__add_frame({ duration: 100 })
mcp__aseprite__draw_pixels({
  frame: 8,
  pixels: [/* walk pose 4 */]
})

// Tag walk animation
mcp__aseprite__create_tag({
  name: "walk",
  fromFrame: 5,
  toFrame: 8,
  direction: "forward"
})

// === ATTACK ANIMATION (Frames 9-14) ===
// Frame 9: Wind up
mcp__aseprite__add_frame({ duration: 150 })
mcp__aseprite__draw_pixels({
  frame: 9,
  pixels: [/* attack windup */]
})

// Frame 10: Anticipation
mcp__aseprite__add_frame({ duration: 100 })

// Frame 11: Strike start
mcp__aseprite__add_frame({ duration: 50 })

// Frame 12: Strike peak
mcp__aseprite__add_frame({ duration: 50 })

// Frame 13: Follow through
mcp__aseprite__add_frame({ duration: 100 })

// Frame 14: Recovery
mcp__aseprite__add_frame({ duration: 150 })

// Tag attack animation
mcp__aseprite__create_tag({
  name: "attack",
  fromFrame: 9,
  toFrame: 14,
  direction: "forward"
})
```

**Result:**
A complete character animation set with three distinct, tagged animations that can be called independently.

**Visual Description:**
The sprite file contains three separate animation sequences: frames 1-4 show idle breathing, frames 5-8 show walking, frames 9-14 show an attack. Each animation is tagged so game engines can play "idle", "walk", or "attack" on demand.

---

## Summary

This examples collection demonstrates the pixel-art-animator skill's capabilities:

- **Simple idle animations** (Examples 1-3): Basic 2-3 frame loops for breathing, bobbing, blinking
- **Walk cycles** (Examples 4-5): Both simple 4-frame and detailed 8-frame walks
- **Complex animations** (Example 6): Multi-phase sequences like jumping
- **Linked cels** (Example 7): Efficient background management
- **Multiple animations** (Example 8): Complete character animation sets with tags

Each example shows complete MCP tool call syntax with frame-by-frame breakdowns, timing considerations, and tagging strategies for game-ready animations.
