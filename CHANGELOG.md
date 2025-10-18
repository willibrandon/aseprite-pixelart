# Changelog

All notable changes to the Pixel Plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.0] - 2025-10-17

### Changed
- Updated pixel-mcp dependency to v0.3.0
- Refreshed all platform binaries (macOS Intel/ARM, Linux x86_64/ARM64, Windows x86_64)

## [0.1.0] - 2025-01-16

### Added

#### Core Skills
- **pixel-art-creator** - Canvas creation, layers, and basic drawing
- **pixel-art-animator** - Frame management and animation
- **pixel-art-professional** - Dithering, palettes, shading, and antialiasing
- **pixel-art-exporter** - PNG, GIF, spritesheet, and JSON export

#### Slash Commands
- `/pixel-new` - Quick sprite creation with size and palette presets
- `/pixel-palette` - Palette management (set, optimize, show, export)
- `/pixel-export` - Multi-format export with options
- `/pixel-setup` - One-time plugin configuration
- `/pixel-help` - Help system

#### Features
- Natural language sprite creation and editing
- 12+ retro palette presets (NES, Game Boy, C64, PICO-8, etc.)
- Dithering support (Floyd-Steinberg, Bayer matrices)
- Animation with frame management, tags, and timing
- Spritesheet layouts (horizontal, vertical, grid, packed)
- JSON metadata export for Unity, Godot, Phaser, TexturePacker
- Pixel-perfect scaling (1x, 2x, 4x, 8x)
- Cross-platform support (macOS, Linux, Windows)

#### Infrastructure
- MCP server integration with pixel-mcp
- Pre-compiled binaries for all platforms
- Automated test suite with validation scripts
- Testing checklist with 45+ tests
- Known issues documentation

[Unreleased]: https://github.com/willibrandon/pixel-plugin/compare/v0.3.0...HEAD
[0.3.0]: https://github.com/willibrandon/pixel-plugin/compare/v0.1.0...v0.3.0
[0.1.0]: https://github.com/willibrandon/pixel-plugin/releases/tag/v0.1.0
