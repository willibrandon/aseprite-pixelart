# Aseprite Pixel Art Plugin for Claude Code - Design Document

**Version:** 1.0.0
**Date:** October 16, 2025
**Status:** Design Phase

## Table of Contents

1. [Overview](#overview)
2. [Project Goals](#project-goals)
3. [Architecture](#architecture)
4. [Plugin Components](#plugin-components)
5. [Integration Strategy](#integration-strategy)
6. [Directory Structure](#directory-structure)
7. [Implementation Plan](#implementation-plan)
8. [Technical Specifications](#technical-specifications)
9. [Distribution and Installation](#distribution-and-installation)
10. [Future Enhancements](#future-enhancements)

---

## Overview

This design document outlines the development of a Claude Code plugin that integrates Aseprite pixel art capabilities through the existing `aseprite-mcp` MCP server. The plugin will enable Claude Code users to create, edit, and export pixel art using natural language commands.

### What is Claude Code?

Claude Code is Anthropic's official CLI tool for Claude, providing an interactive environment for software development tasks. It supports extensibility through:
- **Plugins**: Bundled extensions containing commands, agents, skills, and MCP servers
- **Skills**: Model-invoked capabilities that Claude loads autonomously based on task context
- **Slash Commands**: User-invoked custom prompts
- **Subagents**: Specialized AI assistants with separate context windows
- **Hooks**: Event-driven automation
- **MCP Integration**: Connection to external tools via Model Context Protocol

### What is aseprite-mcp?

`aseprite-mcp` is a Model Context Protocol server (written in Go) that exposes Aseprite's pixel art and animation capabilities to AI assistants. It provides 40+ tools for:
- Canvas and layer management
- Drawing primitives (pixels, lines, rectangles, circles, flood fill)
- Professional pixel art tools (dithering, palette management, shading, antialiasing)
- Animation tools
- Export capabilities (PNG, GIF, spritesheet)

---

## Project Goals

### Primary Goals

1. **Seamless Integration**: Bundle the aseprite-mcp server with a Claude Code plugin for easy installation
2. **Natural Language Interface**: Enable pixel art creation through conversational commands
3. **Rich Skill Set**: Provide Claude with specialized skills for pixel art workflows
4. **Professional Tools**: Expose advanced features like palette management, dithering, and animation
5. **User Experience**: Make pixel art creation accessible to both beginners and professionals

### Non-Goals

- Reimplementing aseprite-mcp functionality (we leverage the existing MCP server)
- Creating a GUI interface (Claude Code is CLI-based)
- Supporting pixel art tools other than Aseprite

---

## Architecture

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Claude Code CLI                       │
│  (User interacts via natural language)                   │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│              Aseprite Plugin                             │
│  ┌──────────────┬──────────────┬────────────────────┐  │
│  │   Skills     │   Commands   │   MCP Server       │  │
│  │  (model-     │  (user-      │   (.mcp.json)      │  │
│  │  invoked)    │  invoked)    │                    │  │
│  └──────────────┴──────────────┴────────────────────┘  │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│              aseprite-mcp Server                         │
│  (Go binary, stdio transport)                            │
│  - Manages Aseprite CLI interactions                     │
│  - Provides 40+ MCP tools                                │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│              Aseprite Application                        │
│  (v1.3.0+, pixel art editor)                            │
└─────────────────────────────────────────────────────────┘
```

### Component Interaction Flow

1. **User Input**: User types natural language or slash command
2. **Skill Discovery**: Claude autonomously identifies relevant pixel art skills
3. **Tool Invocation**: Skills/commands invoke MCP tools from aseprite-mcp
4. **MCP Execution**: aseprite-mcp server executes Aseprite CLI commands
5. **Result Return**: Output (file paths, metadata) returned to Claude
6. **User Feedback**: Claude presents results and next steps

---

## Plugin Components

According to the Claude Code plugin reference, our plugin will include:

### 1. Skills (Model-Invoked)

**Location**: `skills/` directory at plugin root

Skills are the primary interface for pixel art creation. Claude autonomously loads these based on task context.

#### Proposed Skills:

##### `pixel-art-creator/`
- **Purpose**: Create new pixel art sprites from scratch
- **Triggers**: "create sprite", "draw pixel art", "new canvas"
- **Capabilities**:
  - Canvas creation (RGB, Grayscale, Indexed modes)
  - Layer management
  - Basic drawing primitives
  - Color palette setup

##### `pixel-art-animator/`
- **Purpose**: Create and manage animations
- **Triggers**: "animate", "add frames", "animation tags"
- **Capabilities**:
  - Frame management (add, delete, duplicate)
  - Frame duration settings
  - Animation tags with playback direction
  - Linked cels for efficiency

##### `pixel-art-professional/`
- **Purpose**: Advanced pixel art techniques
- **Triggers**: "dithering", "palette", "shading", "antialiasing"
- **Capabilities**:
  - Palette extraction and management
  - 15 dithering patterns
  - Palette-constrained shading
  - Antialiasing suggestions
  - Reference image analysis

##### `pixel-art-exporter/`
- **Purpose**: Export sprites in various formats
- **Triggers**: "export", "save as PNG", "create spritesheet"
- **Capabilities**:
  - Single image export (PNG, GIF, JPG, BMP)
  - Spritesheet generation (various layouts)
  - Batch export operations

### 2. Slash Commands (User-Invoked)

**Location**: `commands/` directory at plugin root

Commands provide quick access to common workflows.

#### Proposed Commands:

##### `/pixel-new`
```markdown
---
argument-hint: [width] [height] [mode]
description: Create a new pixel art canvas with specified dimensions
---
Create a new Aseprite sprite with dimensions $1x$2 in $3 color mode (default: RGB).
```

##### `/pixel-palette`
```markdown
---
argument-hint: [action] [args...]
description: Manage sprite color palettes (set, sort, analyze)
---
Manage the current sprite's color palette: $ARGUMENTS
Actions: set, sort, analyze, extract-from-reference
```

##### `/pixel-export`
```markdown
---
argument-hint: [format] [filename]
description: Export current sprite to file
---
Export the current sprite as $1 format to file: $2
```

### 3. MCP Server Configuration

**Location**: `.mcp.json` at plugin root

Bundles the aseprite-mcp server with the plugin.

```json
{
  "mcpServers": {
    "aseprite": {
      "command": "${CLAUDE_PLUGIN_ROOT}/bin/aseprite-mcp",
      "env": {
        "ASEPRITE_PATH": "/Applications/Aseprite.app/Contents/MacOS/aseprite"
      }
    }
  }
}
```

**Note**: The `ASEPRITE_PATH` will need to be configured by users during setup, as paths vary by platform and installation.

### 4. Plugin Manifest

**Location**: `.claude-plugin/plugin.json`

```json
{
  "name": "aseprite-pixelart",
  "version": "1.0.0",
  "description": "Create and edit pixel art sprites using Aseprite through natural language",
  "author": {
    "name": "Brandon Willett",
    "url": "https://github.com/willibrandon/aseprite-pixelart-plugin"
  },
  "repository": "https://github.com/willibrandon/aseprite-pixelart-plugin",
  "license": "MIT",
  "keywords": ["pixel-art", "aseprite", "graphics", "sprites", "animation"]
}
```

---

## Integration Strategy

### MCP Server Integration

The plugin bundles the aseprite-mcp binary (compiled for target platforms) and configures it automatically:

1. **Binary Distribution**: Include pre-compiled binaries for:
   - macOS (darwin/amd64, darwin/arm64)
   - Linux (linux/amd64, linux/arm64)
   - Windows (windows/amd64)

2. **Platform Detection**: Use platform-specific configuration or post-install script to select correct binary

3. **Configuration Management**:
   - Plugin provides default `.mcp.json` configuration
   - Users configure Aseprite path via setup command
   - Configuration stored in `${CLAUDE_PLUGIN_ROOT}/config/aseprite.json`

### Skill Integration

According to the Skills documentation:

- Skills are **model-invoked** - Claude decides when to use them based on:
  - Task description in user request
  - `description` field in SKILL.md frontmatter
  - Current context and available tools

- Skills use **progressive disclosure** - Claude loads information only as needed

- Skills can include:
  - `SKILL.md` (required): Instructions and examples
  - Supporting files: Reference docs, scripts, templates
  - `allowed-tools` restriction (optional): Limit tool access

**Best Practices**:
- Write specific descriptions with trigger keywords
- Include "use when" guidance in descriptions
- Provide concrete examples in SKILL.md
- Keep skills focused on single capabilities

---

## Directory Structure

Based on Claude Code plugin specifications:

```
aseprite-pixelart-plugin/
├── .claude-plugin/
│   └── plugin.json              # Plugin manifest (required)
│
├── skills/                       # Agent Skills (model-invoked)
│   ├── pixel-art-creator/
│   │   ├── SKILL.md
│   │   ├── reference.md         # Canvas modes, color depths
│   │   └── examples.md          # Common sprite sizes, use cases
│   ├── pixel-art-animator/
│   │   ├── SKILL.md
│   │   └── reference.md         # Frame timing, animation principles
│   ├── pixel-art-professional/
│   │   ├── SKILL.md
│   │   ├── dithering-patterns.md
│   │   └── palette-theory.md
│   └── pixel-art-exporter/
│       ├── SKILL.md
│       └── export-formats.md
│
├── commands/                     # Slash commands (user-invoked)
│   ├── pixel-new.md
│   ├── pixel-palette.md
│   ├── pixel-export.md
│   └── pixel-help.md
│
├── bin/                          # MCP server binaries
│   ├── aseprite-mcp-darwin-amd64
│   ├── aseprite-mcp-darwin-arm64
│   ├── aseprite-mcp-linux-amd64
│   ├── aseprite-mcp-linux-arm64
│   └── aseprite-mcp-windows-amd64.exe
│
├── config/                       # Configuration templates
│   └── aseprite-template.json
│
├── .mcp.json                     # MCP server configuration
├── README.md                     # Installation and usage guide
├── LICENSE                       # MIT License
└── CHANGELOG.md                  # Version history
```

**Important**: All component directories (`skills/`, `commands/`) must be at plugin root, NOT inside `.claude-plugin/` directory.

---

## Implementation Plan

### Phase 1: Core Plugin Structure
**Duration**: 1-2 days

- [ ] Create plugin directory structure
- [ ] Write plugin.json manifest
- [ ] Set up basic .mcp.json configuration
- [ ] Create README with installation instructions

### Phase 2: MCP Server Integration
**Duration**: 2-3 days

- [ ] Build aseprite-mcp for all target platforms
- [ ] Test binary execution on each platform
- [ ] Create platform-specific MCP configuration
- [ ] Implement Aseprite path configuration workflow
- [ ] Test MCP server connectivity

### Phase 3: Skills Development
**Duration**: 3-4 days

- [ ] Create pixel-art-creator skill with SKILL.md
- [ ] Create pixel-art-animator skill
- [ ] Create pixel-art-professional skill
- [ ] Create pixel-art-exporter skill
- [ ] Write supporting documentation for each skill
- [ ] Test skill invocation and tool access

### Phase 4: Slash Commands
**Duration**: 1-2 days

- [ ] Implement /pixel-new command
- [ ] Implement /pixel-palette command
- [ ] Implement /pixel-export command
- [ ] Implement /pixel-help command
- [ ] Test command execution and argument handling

### Phase 5: Testing and Documentation
**Duration**: 2-3 days

- [ ] Test plugin installation via local marketplace
- [ ] Test all skills with various prompts
- [ ] Test all slash commands
- [ ] Verify MCP server integration
- [ ] Write comprehensive user documentation
- [ ] Create example workflows and tutorials

### Phase 6: Distribution
**Duration**: 1-2 days

- [ ] Create GitHub repository
- [ ] Set up CI/CD for binary builds
- [ ] Create release process
- [ ] Publish to community marketplace (if available)

**Total Estimated Duration**: 10-16 days

---

## Technical Specifications

### Requirements

#### System Requirements
- Claude Code v1.0 or later
- Aseprite v1.3.0+ (v1.3.10+ recommended)
- Go 1.23+ (for building aseprite-mcp from source, if needed)

#### Supported Platforms
- macOS (Intel and Apple Silicon)
- Linux (x86_64 and ARM64)
- Windows (x86_64)

### MCP Server Configuration

#### Default Configuration Template
```json
{
  "aseprite_path": "/path/to/aseprite",
  "temp_dir": "/tmp/aseprite-mcp",
  "timeout": 30,
  "log_level": "info",
  "log_file": "",
  "enable_timing": false
}
```

#### Platform-Specific Defaults
- **macOS**: `/Applications/Aseprite.app/Contents/MacOS/aseprite`
- **Linux**: `/usr/bin/aseprite` or `~/bin/aseprite`
- **Windows**: `C:\Program Files\Aseprite\Aseprite.exe`

### Skill Specifications

#### SKILL.md Format
Each skill follows this structure:

```markdown
---
name: skill-name
description: What this skill does and when Claude should use it. Include specific trigger keywords.
allowed-tools: Read, Bash, mcp__aseprite__*
---

# Skill Name

## Overview
Brief description of the skill's purpose.

## When to Use
Specific scenarios where this skill should be invoked.

## Instructions
Step-by-step guidance for Claude on using this skill.

## Examples
Concrete examples of common tasks.

## Reference
Technical details and parameter descriptions.
```

#### Tool Access Patterns
Skills will specify `allowed-tools` to restrict access:
```yaml
allowed-tools: Read, Bash, mcp__aseprite__create_canvas, mcp__aseprite__draw_pixels, mcp__aseprite__export_sprite
```

This ensures skills only use relevant MCP tools from aseprite-mcp.

### Performance Considerations

According to aseprite-mcp benchmarks:
- All operations complete in <100ms typically
- Complete workflows: 280-840ms
- Batch operations supported for efficiency

Skills should leverage batch operations where possible (e.g., `draw_pixels` supports batch pixel drawing).

---

## Distribution and Installation

### Installation Methods

#### Method 1: Via Plugin Marketplace (Recommended)

Once published to a marketplace:

```bash
# Add marketplace
claude mcp add marketplace https://github.com/willibrandon/aseprite-plugins

# Install plugin
claude plugin install aseprite-pixelart@willibrandon
```

#### Method 2: Local Installation (Development)

For testing during development:

```bash
# Create local marketplace
mkdir -p ~/claude-dev-marketplace
cd ~/claude-dev-marketplace

# Clone plugin repository
git clone https://github.com/willibrandon/aseprite-pixelart-plugin

# Create marketplace.json
cat > .claude-plugin/marketplace.json << 'EOF'
{
  "name": "dev-marketplace",
  "owner": {"name": "Developer"},
  "plugins": [
    {
      "name": "aseprite-pixelart",
      "source": "./aseprite-pixelart-plugin",
      "description": "Pixel art creation with Aseprite"
    }
  ]
}
EOF

# Add marketplace to Claude Code
claude plugin marketplace add ~/claude-dev-marketplace

# Install plugin
claude plugin install aseprite-pixelart@dev-marketplace
```

### Post-Installation Configuration

Users must configure Aseprite path:

```bash
# Interactive configuration
claude config set aseprite.path /path/to/aseprite

# Or edit configuration directly
~/.config/aseprite-mcp/config.json
```

The plugin should provide a `/pixel-setup` command to guide users through this process.

### Version Management

Following semantic versioning (semver):
- **Major**: Breaking changes to skill interfaces or MCP server updates
- **Minor**: New skills, commands, or backward-compatible features
- **Patch**: Bug fixes, documentation updates

---

## Future Enhancements

### Short-term (v1.1 - v1.2)

1. **Additional Skills**
   - `pixel-art-transformer`: Scaling, rotation, flipping operations
   - `pixel-art-inspector`: Analyze existing sprites

2. **Enhanced Commands**
   - `/pixel-batch`: Batch export multiple sprites
   - `/pixel-template`: Create from templates (character, tile, UI)

3. **Workflow Automation**
   - Hooks for auto-export on save
   - Integration with git workflows

### Medium-term (v2.0)

1. **AI-Assisted Features**
   - Palette suggestion based on reference images
   - Automatic antialiasing application
   - Smart dithering recommendations

2. **Collaboration Features**
   - Multi-sprite project management
   - Asset library integration

3. **Extended Export Options**
   - Texture atlas generation
   - Game engine format exports (Unity, Godot)

### Long-term (v3.0+)

1. **Advanced Automation**
   - Subagent for autonomous sprite creation
   - Batch processing pipelines

2. **Integration Ecosystem**
   - Integration with design tools (Figma via MCP)
   - Direct game engine deployment

3. **Community Features**
   - Shared skill marketplace
   - Template library

---

## Security Considerations

### MCP Server Security

1. **Binary Verification**: Include checksums for distributed binaries
2. **Sandboxing**: aseprite-mcp only accesses Aseprite and temp directories
3. **Input Validation**: All MCP server inputs are validated

### Plugin Security

1. **Tool Restrictions**: Skills use `allowed-tools` to limit capabilities
2. **Path Validation**: Prevent directory traversal in file operations
3. **User Confirmation**: Critical operations should request user approval

### Best Practices

- Review all skill descriptions for clear intent
- Monitor MCP server logs for unusual activity
- Use project-scoped installations for team environments
- Regular updates to address security patches

---

## References

### Anthropic Documentation

- [Claude Code Plugins](https://docs.claude.com/en/docs/claude-code/plugins)
- [Agent Skills](https://docs.claude.com/en/docs/claude-code/skills)
- [Plugins Reference](https://docs.claude.com/en/docs/claude-code/plugins-reference)
- [MCP Integration](https://docs.claude.com/en/docs/claude-code/mcp)
- [Slash Commands](https://docs.claude.com/en/docs/claude-code/slash-commands)

### Related Projects

- [aseprite-mcp](https://github.com/willibrandon/aseprite-mcp) - MCP server for Aseprite
- [Aseprite](https://www.aseprite.org/) - Animated sprite editor and pixel art tool
- [Model Context Protocol](https://modelcontextprotocol.io/) - MCP specification

---

## Conclusion

This design document provides a comprehensive blueprint for creating an Aseprite pixel art plugin for Claude Code. By leveraging the existing aseprite-mcp MCP server and following Anthropic's plugin specifications, we can deliver a powerful, user-friendly pixel art creation experience through natural language interaction.

The plugin architecture emphasizes:
- **Modularity**: Skills, commands, and MCP integration are cleanly separated
- **Discoverability**: Model-invoked skills allow Claude to autonomously assist users
- **Flexibility**: User-invoked commands provide direct control when needed
- **Best Practices**: Follows all Anthropic documentation and recommendations

The implementation plan provides a realistic timeline for development, testing, and distribution, with clear phases and deliverables.

---

**Document Version**: 1.0.0
**Last Updated**: October 16, 2025
**Author**: Brandon Willett
**License**: MIT
