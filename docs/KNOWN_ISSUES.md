# Known Issues and Limitations

This document tracks known issues, limitations, and workarounds for the Aseprite Pixel Art Plugin.

**Version:** 0.1.0
**Last Updated:** [Date]

---

## Platform-Specific Issues

### macOS

**Issue:** Aseprite path detection may fail on non-standard installations
**Impact:** Low
**Workaround:** Use `/pixel-setup /path/to/aseprite` to specify path manually
**Status:** By design - user can configure manually

**Issue:** Permission errors when creating config directory on some macOS versions
**Impact:** Low
**Workaround:** Manually create `~/.config/aseprite-mcp/` directory first
**Status:** Investigating

### Linux

**Issue:** Snap-installed Aseprite may have sandbox restrictions
**Impact:** Medium
**Workaround:** Use traditional package installation or specify path manually
**Status:** Documented in setup instructions

### Windows

**Issue:** Path with spaces may require quoting in config
**Impact:** Low
**Workaround:** Escape backslashes in JSON: `"C:\\\\Program Files\\\\Aseprite\\\\Aseprite.exe"`
**Status:** Documented in config template

---

## Functional Limitations

### Canvas Size

**Limitation:** Maximum canvas size 65535x65535 pixels
**Reason:** Aseprite internal limit
**Workaround:** None - use smaller canvases
**Impact:** Low (rarely need canvases this large)

### Color Modes

**Limitation:** Indexed mode limited to 256 colors
**Reason:** Indexed color palette limitation
**Workaround:** Use RGB mode for unlimited colors
**Impact:** Low (retro palettes typically <256 colors)

### Animation

**Limitation:** Frame duration minimum 1ms, maximum 65535ms
**Reason:** Aseprite frame timing limits
**Workaround:** Use appropriate FPS (10-60 typical)
**Impact:** Low (range covers all practical uses)

### Export

**Limitation:** GIF export limited to 256 colors
**Reason:** GIF format limitation
**Workaround:** Reduce palette before export or use PNG sequence
**Impact:** Low (pixel art typically uses limited palettes)

**Limitation:** JSON metadata formats may not match all game engines
**Reason:** Different engines use different formats
**Workaround:** Manually adjust JSON or request new format support
**Impact:** Medium (affects game engine integration)

---

## Performance Considerations

### Large Sprites

**Issue:** Operations on >512x512 sprites may be slow
**Impact:** Low
**Mitigation:** Progress indication, recommend smaller sprites
**Status:** Acceptable for pixel art use case

### Many Frames

**Issue:** Animations with >100 frames may take time to process
**Impact:** Low
**Mitigation:** Batch operations, progress feedback
**Status:** Acceptable (most pixel art animations <50 frames)

### Dithering

**Issue:** Floyd-Steinberg dithering slower than Bayer
**Impact:** Low
**Explanation:** Algorithm complexity trade-off for quality
**Status:** Expected behavior

---

## Edge Cases

### Empty Sprites

**Issue:** Some operations fail on blank sprites
**Impact:** Low
**Workaround:** Draw something before exporting/processing
**Status:** Added validation and helpful errors

### Single Frame Animations

**Issue:** Exporting single-frame sprite as GIF may seem odd
**Impact:** Low
**Workaround:** Use PNG export for single frames
**Status:** Documented in export guide

### Very Small Canvases

**Issue:** Antialiasing and dithering may not work well on <16x16 sprites
**Impact:** Low
**Explanation:** Not enough pixels for techniques to apply
**Status:** Documented in professional Skill

---

## Tool Integration

### MCP Server Communication

**Issue:** Timeout errors on very slow systems
**Impact:** Low
**Workaround:** Increase timeout in config: `"timeout": 60`
**Status:** Configurable

### Aseprite CLI

**Issue:** Some Aseprite GUI features not available via CLI
**Impact:** Medium
**Explanation:** CLI has subset of GUI functionality
**Status:** Work within CLI capabilities

---

## Future Enhancements

Items not considered issues, but potential improvements:

- **More Palette Presets:** Additional retro console palettes
- **Custom Brush Support:** Drawing with custom brushes
- **Layer Effects:** Apply effects to specific layers
- **Batch Processing:** Process multiple sprites
- **Animation Curves:** Non-linear frame timing
- **Onion Skinning Hints:** Visual aids for animation

---

## Reporting New Issues

Found a bug not listed here?

1. Check if it's already reported: [GitHub Issues](https://github.com/willibrandon/pixel-plugin/issues)
2. Verify it's reproducible
3. Note your platform, Aseprite version, plugin version
4. Include steps to reproduce
5. Report at: https://github.com/willibrandon/pixel-plugin/issues/new

---

## Issue Resolution Workflow

1. Issue reported
2. Reproduced and confirmed
3. Added to this document if won't fix immediately
4. Fixed in code if critical
5. Verified fix with testing checklist
6. Removed from this document when released
7. Added to CHANGELOG.md

---

**Note:** This document reflects known issues at time of writing. Check repository for latest updates.
