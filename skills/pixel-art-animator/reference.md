# Pixel Art Animator - Technical Reference

## Frame Rate Conversions

| FPS | Frame Duration (ms) | Use Case |
|-----|-------------------|----------|
| 60 | 16-17 | Smooth modern games, very fast animation |
| 30 | 33 | Standard modern animation |
| 24 | 42 | Film-like animation |
| 20 | 50 | Smooth retro animation |
| 15 | 67 | Retro game animation |
| 12 | 83 | Traditional animation (on twos) |
| 10 | 100 | Classic pixel art animation |
| 8 | 125 | Slower animation |
| 6 | 167 | Very slow animation |
| 4 | 250 | Idle/breathing animations |
| 2 | 500 | Very slow idle effects |

## Classic Animation Cycles

### Walk Cycle (4 frames)
```
Frame 1: Contact (right foot forward)
Frame 2: Down (compression)
Frame 3: Pass (left foot passing)
Frame 4: Up (right foot pushes off)
```

### Run Cycle (8 frames)
```
Frame 1: Contact right
Frame 2: Down right
Frame 3: Pass
Frame 4: Up left
Frame 5: Contact left
Frame 6: Down left
Frame 7: Pass
Frame 8: Up right
```

### Idle Breathing (2-4 frames)
```
2-frame:
- Frame 1: Normal
- Frame 2: Slight rise (+1-2 pixels vertically)

4-frame:
- Frame 1: Normal
- Frame 2: Inhale (expand)
- Frame 3: Hold (peak)
- Frame 4: Exhale (contract)
```

## Animation Principles (applied to pixel art)

### 1. Timing
- Slow movements: more frames, longer durations
- Fast movements: fewer frames, shorter durations
- Impacts: very short duration (30-50ms)

### 2. Anticipation
- Windup before action (crouch before jump)
- 1-2 frames of preparation
- Makes action feel more powerful

### 3. Follow-through
- Continuation after main action
- Hair, clothes continue moving after body stops
- 1-2 frames of settling

### 4. Ease In/Ease Out
- Slow start, fast middle, slow end
- Variable frame durations:
  - Start: 150ms
  - Middle: 50ms
  - End: 150ms

### 5. Arcs
- Natural motion follows arcs, not straight lines
- Jumping: arc trajectory
- Swinging arms: arc motion

### 6. Squash and Stretch
- Exaggeration for impact
- Ball bouncing: squash on impact, stretch in air
- 1-2 pixels of deformation

## Retro Console Frame Limitations

### NES (Nintendo Entertainment System)
- Typical: 60 FPS engine, animations at 10-15 FPS
- Sprite flicker for >8 sprites/scanline
- Limited sprite sizes influenced animation

### Game Boy
- 60 FPS capability, animations at 8-15 FPS
- Simple animations due to small sprites
- 2-4 frame cycles common

### SNES (Super Nintendo)
- 60 FPS capable, smoother animations possible
- 8-16 frame animations for characters
- More detailed animation than NES

## Frame Count Guidelines

| Animation Type | Frame Count | Typical FPS | Notes |
|----------------|-------------|-------------|-------|
| Idle | 2-4 | 4-6 | Subtle, looping |
| Walk | 4-8 | 10-12 | Even, rhythmic |
| Run | 6-12 | 12-15 | Faster than walk |
| Jump | 4-8 | 12-15 | Arc motion |
| Attack | 3-8 | 12-20 | Fast strike, slow recovery |
| Death | 5-10 | 8-12 | Dramatic, doesn't loop |
| Spell Cast | 4-10 | 10-15 | Buildup, release, recovery |
| Item Use | 3-6 | 12-15 | Quick action |

## Animation Tag Best Practices

### Naming Conventions
- Lowercase, descriptive names
- Examples: "idle", "walk", "run", "attack", "jump", "death"
- Variations: "walk_left", "walk_right", "attack_1", "attack_2"

### Organization Strategies

**Sequential Layout:**
```
Frames 1-2: idle
Frames 3-6: walk
Frames 7-12: run
Frames 13-17: attack
```

**Grouped Layout:**
```
Frames 1-10: Player character animations
Frames 11-20: Enemy character animations
Frames 21-30: Special effects
```

### Playback Directions

**Forward:**
- Most animations (walk, run, attack)
- Plays once through, then loops

**Reverse:**
- Rare, for special effects
- Rewinding animations

**Ping-pong:**
- Idle breathing
- Flickering effects
- Oscillating animations
- Plays forward, then backward, then repeats

## Linked Cel Strategies

### When to Use
1. **Static backgrounds** across animated character
2. **Unchanged parts** of character (e.g., hat while body animates)
3. **Repeated frames** in cycle (exact duplicates)
4. **Memory optimization** for large sprites

### When NOT to Use
1. **Every frame is different** (no shared data)
2. **Small sprites** (minimal memory saved)
3. **Experimental animations** (may need to edit each frame)

### Workflow
1. Create frames
2. Identify repeated/static content
3. Link cels for that content
4. Edit linked cel once, updates all

## Performance Considerations

### Efficient Animation
- **Batch operations:** Add multiple frames at once when possible
- **Duplicate then edit:** Faster than creating from scratch
- **Link static content:** Saves memory and editing time

### Large Sprites
- 128x128+ sprites with many frames can be slow
- Consider breaking into smaller parts
- Use layers and linked cels strategically

## Common Timing Patterns

### Even Timing (simplest)
```
All frames: 100ms
```
Predictable, easy to edit.

### Hold First Frame
```
Frame 1: 200ms (starting pose)
Frames 2-4: 100ms (action)
```
Emphasizes starting position.

### Hold Last Frame
```
Frames 1-3: 100ms (action)
Frame 4: 200ms (ending pose)
```
Emphasizes ending position.

### Fast Action
```
Frame 1: 150ms (anticipation)
Frame 2: 30ms (strike)
Frame 3: 100ms (follow-through)
```
Creates snappy, impactful feel.

### Slow Buildup
```
Frame 1: 200ms
Frame 2: 150ms
Frame 3: 100ms
Frame 4: 50ms
```
Accelerating motion.

## Sprite Sheet Export Considerations

When planning animations for export:

1. **Frame Layout:**
   - Horizontal strip: all frames in one row
   - Vertical strip: all frames in one column
   - Grid: frames arranged in rows/columns

2. **Frame Dimensions:**
   - Keep all frames same size for easy parsing
   - Padding between frames if needed

3. **Animation Tags:**
   - Export tags separately or together
   - Game engines can reference tag names

4. **File Format:**
   - GIF for simple web animations (256 colors max)
   - PNG sequence for high quality
   - Sprite sheet for game engines

## Integration with Game Engines

### Unity
- Import sprite sheet
- Use Unity's animation system
- Reference animation tags (if exported in metadata)

### Godot
- SpriteFrames resource
- AnimationPlayer node
- Import PNG sequences or sprite sheets

### Phaser (JavaScript)
- Load sprite sheet
- Define animations with frame ranges
- Play animations by name

### GameMaker
- Import sprite strip
- Set frames per second
- Automatic loop on last frame
