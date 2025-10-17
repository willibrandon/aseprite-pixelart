# Pixel Art Creator - Examples

## Example 1: Simple Icon

**User Request:**
> "Create a 16x16 red heart icon"

**Skill Usage:**

1. Create 16x16 RGB canvas
2. Draw heart shape using pixels or contour:
   ```
   Row 4:  (5,4), (6,4), (9,4), (10,4)
   Row 5:  (4,5) to (11,5) (8 pixels)
   Row 6:  (4,6) to (11,6) (8 pixels)
   Row 7:  (5,7) to (10,7) (6 pixels)
   Row 8:  (6,8) to (9,8) (4 pixels)
   Row 9:  (7,9), (8,9) (2 pixels)
   ```
3. Color: #FF0000 (red)

**Result:** Pixelated heart icon centered in 16x16 canvas

---

## Example 2: Simple Character

**User Request:**
> "Make a 32x32 sprite of a simple smiley face"

**Skill Usage:**

1. Create 32x32 RGB canvas
2. Draw filled circle (radius 14, center 16,16) in yellow (#FFFF00)
3. Draw two small filled circles for eyes:
   - Left eye: center (11, 13), radius 2, black (#000000)
   - Right eye: center (21, 13), radius 2, black (#000000)
4. Draw arc or curve for smile using contour or pixels:
   - Points from (11, 20) to (21, 20) curving down
   - Color: black (#000000)

**Result:** Simple smiley face emoji-style sprite

---

## Example 3: Retro Game Character

**User Request:**
> "Create a 64x64 Game Boy style character sprite"

**Skill Usage:**

1. Create 64x64 Indexed canvas
2. Set Game Boy palette: ["#0F380F", "#306230", "#8BAC0F", "#9BBC0F"]
3. Add layer "Character"
4. Draw character outline in darkest color (#0F380F)
5. Fill body with medium colors (#306230, #8BAC0F)
6. Add highlights with lightest color (#9BBC0F)

**Result:** Authentic Game Boy aesthetic character sprite

---

## Example 4: Tile with Layers

**User Request:**
> "Create a 32x32 grass tile with background and foreground layers"

**Skill Usage:**

1. Create 32x32 RGB canvas
2. Add layer "Background"
3. Fill Background with green (#228B22) using fill_area
4. Add layer "Grass Blades"
5. Draw individual grass blade shapes using draw_contour or pixels
6. Use darker green (#006400) for blades

**Result:** Layered grass tile ready for animation or variation

---

## Example 5: Platform Tile

**User Request:**
> "Make a 16x16 platform tile for a platformer game"

**Skill Usage:**

1. Create 16x16 RGB canvas
2. Draw filled rectangle for platform:
   - Top surface: gray (#808080), 2 pixels tall
   - Sides: darker gray (#404040)
3. Add pixel details for texture
4. Optional: add outline in black for definition

**Result:** Game-ready platform tile

---

## Example 6: Procedural Sprite

**User Request:**
> "Create a 48x48 sprite of a simple tree"

**Skill Usage:**

1. Create 48x48 RGB canvas
2. Add layer "Tree"
3. Draw trunk:
   - Rectangle from (20, 28) to (28, 47), brown (#8B4513)
4. Draw foliage:
   - Large circle centered at (24, 20), radius 12, green (#228B22)
   - Add smaller circles overlapping for detail
5. Add trunk outline for definition

**Result:** Simple pixel art tree sprite

---

## Example 7: Multi-Layer Character

**User Request:**
> "Create a 64x64 character with separate layers for body, clothes, and accessories"

**Skill Usage:**

1. Create 64x64 RGB canvas
2. Add layer "Body" - draw character base (skin tone)
3. Add layer "Clothes" - draw shirt, pants
4. Add layer "Accessories" - draw hat, items
5. Each layer allows independent editing

**Result:** Organized character sprite with editable layers

---

## Example 8: Pixel Art Circle

**User Request:**
> "Draw a perfect pixel circle, 128x128 canvas"

**Skill Usage:**

1. Create 128x128 RGB canvas
2. Use draw_circle:
   - Center: (64, 64)
   - Radius: 50
   - Filled: true
   - Color: blue (#0000FF)

**Result:** Algorithmically perfect pixel circle

---

## Example 9: Custom Palette Sprite

**User Request:**
> "Create a 32x32 sprite using only black, white, and red"

**Skill Usage:**

1. Create 32x32 Indexed canvas
2. Set palette: ["#000000", "#FFFFFF", "#FF0000"]
3. Draw sprite using only these 3 colors
4. All drawing operations snap to nearest palette color

**Result:** Limited palette sprite with artistic constraints

---

## Example 10: Scene Background

**User Request:**
> "Create a 256x240 pixel art background for a game scene"

**Skill Usage:**

1. Create 256x240 RGB canvas (NES resolution)
2. Add layer "Sky" - fill with gradient or solid color (blue)
3. Add layer "Ground" - draw ground/terrain (brown, green)
4. Add layer "Details" - trees, clouds, mountains
5. Use rectangles, fills, and contours for shapes

**Result:** Layered scene background ready for parallax or game use

---

## Common Request Patterns

### "Make a sprite"
- Default to 64x64 RGB
- Create simple placeholder shape
- Ask user for specifics

### "Create [object] icon"
- Use icon dimensions (16, 24, 32)
- High contrast colors
- Simple, recognizable shape

### "Draw [shape]"
- Use appropriate tool (circle, rectangle, etc.)
- Default to RGB mode unless retro mentioned
- Medium size canvas (64x64 or 128x128)

### "Retro/Game Boy/NES style"
- Use Indexed mode
- Set appropriate retro palette
- Use period-appropriate dimensions

### "[Dimension] sprite"
- Use specified dimensions exactly
- Default to RGB unless style specified
- Create basic shape or ask for subject
