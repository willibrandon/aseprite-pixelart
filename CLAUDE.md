# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Claude Code plugin that integrates Aseprite pixel art capabilities through the pixel-mcp Model Context Protocol server. The plugin enables pixel art creation, editing, and export using natural language commands.

**Plugin Name:** pixel-plugin
**Version:** 0.1.0
**Type:** Claude Code Plugin (Skills + Commands + MCP Integration)
**Dependencies:** pixel-mcp server (Go binary), Aseprite v1.3.0+

## Architecture

The plugin follows a layered architecture:

1. **User Layer**: Natural language or slash commands in Claude Code
2. **Plugin Layer**: Skills (model-invoked) and Commands (user-invoked)
3. **MCP Layer**: pixel-mcp server (40+ tools)
4. **Application Layer**: Aseprite CLI interactions

**Key Integration Point:** The plugin bundles pre-compiled pixel-mcp binaries and provides a platform-detection wrapper (`bin/pixel-mcp`) that selects the correct binary for macOS, Linux, or Windows.

## Directory Structure

```
pixel-plugin-plugin/
├── .claude-plugin/
│   └── plugin.json                 # Plugin manifest
├── skills/                         # Model-invoked Skills
│   ├── pixel-art-creator/
│   │   ├── SKILL.md               # Required: frontmatter + instructions
│   │   ├── reference.md           # Technical specs
│   │   └── examples.md            # Concrete examples
│   ├── pixel-art-animator/
│   ├── pixel-art-professional/
│   └── pixel-art-exporter/
├── commands/                       # User-invoked slash commands
│   ├── pixel-new.md
│   ├── pixel-palette.md
│   ├── pixel-export.md
│   ├── pixel-setup.md
│   └── pixel-help.md
├── bin/                            # MCP server binaries
│   ├── pixel-mcp               # Platform detection wrapper
│   ├── pixel-mcp-darwin-amd64
│   ├── pixel-mcp-darwin-arm64
│   ├── pixel-mcp-linux-amd64
│   ├── pixel-mcp-linux-arm64
│   └── pixel-mcp-windows-amd64.exe
├── config/
│   ├── pixel-mcp-config.json   # Template for users
│   ├── detect-aseprite.sh         # Path detection helper
│   └── README.md                  # Configuration guide
├── .mcp.json                       # MCP server integration
├── docs/
│   ├── KNOWN_ISSUES.md            # Known issues and limitations
│   └── TESTING_CHECKLIST.md       # Validation checklist
├── test-outputs/                   # Test output directory
├── CHANGELOG.md                    # Version history
├── CONTRIBUTING.md                 # Contribution guidelines
├── LICENSE                         # MIT License
└── README.md                       # User documentation
```

**Critical:** Skills and commands must be at plugin root, NOT inside `.claude-plugin/`.

## Plugin Component Specifications

### Skills (Model-Invoked)

Skills are stored in `skills/<skill-name>/SKILL.md` with YAML frontmatter:

```markdown
---
name: Skill Display Name
description: Detailed description with trigger keywords. Use when the user mentions X, Y, or Z.
allowed-tools: Read, Bash, mcp__aseprite__create_canvas, mcp__aseprite__draw_pixels
---

# Skill Name

## Overview
[Purpose and capabilities]

## When to Use
[Specific trigger scenarios]

## Instructions
[Step-by-step guidance for Claude]

## Examples
[Concrete use cases]
```

**Four Core Skills:**
1. **pixel-art-creator**: Canvas creation, layers, basic drawing
2. **pixel-art-animator**: Frames, animation tags, timing, linked cels
3. **pixel-art-professional**: Dithering, palettes, shading, antialiasing
4. **pixel-art-exporter**: Export formats, spritesheets

**Trigger Mechanism:** Claude autonomously loads skills based on:
- User's natural language request
- Keywords in the `description` field
- Current conversation context

### Slash Commands (User-Invoked)

Commands are markdown files in `commands/` with YAML frontmatter:

```markdown
---
description: Brief description shown in /help
argument-hint: [arg1] [arg2]
allowed-tools: Bash(git:*), Read, Write
---

## Instructions

Command behavior using $1, $2, or $ARGUMENTS for parameters.
Can include bash execution: !`git status`
```

**Five User Commands:**
1. **pixel-new**: Quick sprite creation with size and palette presets
2. **pixel-palette**: Palette management (set, optimize, show, export)
3. **pixel-export**: Multi-format export with options
4. **pixel-setup**: One-time plugin configuration
5. **pixel-help**: Help system

### MCP Server Integration

`.mcp.json` configures the bundled pixel-mcp server:

```json
{
  "mcpServers": {
    "aseprite": {
      "command": "${CLAUDE_PLUGIN_ROOT}/bin/pixel-mcp",
      "args": [],
      "env": {
        "CONFIG_PATH": "${CLAUDE_PLUGIN_ROOT}/config/pixel-mcp-config.json"
      }
    }
  }
}
```

**Platform Detection:** The `bin/pixel-mcp` wrapper script detects OS and architecture, then executes the appropriate binary.

## Development Guidelines

### Git Commit Format

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<body with bulleted changes>
```

**Types:** feat, fix, docs, chore, test, refactor
**Scopes:** skills, commands, mcp, config, docs, testing

### File Validation

#### JSON Files
```bash
python3 -m json.tool <file>.json > /dev/null && echo "✅ Valid" || echo "❌ Invalid"
```

#### YAML Frontmatter
Extract and manually verify:
```bash
sed -n '/^---$/,/^---$/p' skills/<skill-name>/SKILL.md
```

#### Shell Scripts
Ensure executable:
```bash
chmod +x config/detect-aseprite.sh
```

### Testing

Run the full test suite:
```bash
./bin/test-plugin.sh
```

Individual test suites:
- `./bin/validate-skills.sh` - Skills validation
- `./bin/validate-commands.sh` - Commands validation
- `./bin/test-mcp.sh` - MCP integration test

## Building MCP Binaries

Located at `/Users/brandon/src/pixel-mcp`:

```bash
cd /Users/brandon/src/pixel-mcp
make clean
make release

# Binaries created in bin/:
# - pixel-mcp-darwin-amd64
# - pixel-mcp-darwin-arm64
# - pixel-mcp-linux-amd64
# - pixel-mcp-linux-arm64
# - pixel-mcp-windows-amd64.exe

# Copy to plugin:
cp bin/pixel-mcp-* /Users/brandon/src/pixel-plugin-plugin/bin/
```

## Key Design Principles

1. **Model-Invoked Skills**: Skills trigger automatically based on trigger keywords in descriptions

2. **User-Invoked Commands**: Commands require explicit `/command` invocation

3. **Progressive Disclosure**: Skills load supporting files (reference.md, examples.md) only when needed

4. **Platform Awareness**: Plugin supports macOS (Intel/ARM), Linux (x86_64/ARM64), Windows (x86_64)

5. **MCP Tools**: All pixel-mcp tools prefixed with `mcp__aseprite__*` (e.g., `mcp__aseprite__create_canvas`)

6. **Natural Language First**: Users can create pixel art through conversational requests

7. **Retro Gaming Focus**: Supports classic console palettes and pixel art techniques

## Common Tasks

### Validating Plugin Structure
```bash
ls -la .claude-plugin/plugin.json    # Must exist
ls -la .mcp.json                     # Must exist
ls -la skills/                       # Must be at root
ls -la commands/                     # Must be at root
ls -la bin/pixel-mcp              # Must be executable
```

### Testing MCP Server
```bash
bin/pixel-mcp --version          # Should show version
bin/pixel-mcp --health            # May fail without Aseprite configured
```

### Running Validation Tests
```bash
./bin/test-plugin.sh                # Run all tests
./bin/validate-skills.sh            # Validate Skills only
./bin/validate-commands.sh          # Validate commands only
```

## External Dependencies

- **pixel-mcp**: Go-based MCP server at `/Users/brandon/src/pixel-mcp`
  - Provides 40+ tools for pixel art operations
  - Built with Go 1.23+
  - Communicates with Aseprite via CLI

- **Aseprite**: v1.3.0+ pixel art editor
  - Not bundled with plugin
  - Users configure path via `/pixel-setup` command
  - Platform-specific paths documented in `config/README.md`

## Important Notes

- **All Skills need SKILL.md** with valid YAML frontmatter
- **Use ${CLAUDE_PLUGIN_ROOT}** in .mcp.json for plugin-relative paths
- **Skills at root, not in .claude-plugin/** - Common mistake to avoid
- **Test before releasing** - Run full test suite
- **Version management** - Update plugin.json, CHANGELOG.md together
- **Platform binaries** - Rebuild all architectures when updating pixel-mcp

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development setup, coding guidelines, and submission process.

## Version History

See [CHANGELOG.md](CHANGELOG.md) for detailed version history and release notes.
