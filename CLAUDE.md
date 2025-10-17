# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Claude Code plugin that integrates Aseprite pixel art capabilities through the aseprite-mcp Model Context Protocol server. The plugin enables pixel art creation, editing, and export using natural language commands.

**Plugin Name:** aseprite-pixelart
**Type:** Claude Code Plugin (Skills + Commands + MCP Integration)
**Dependencies:** aseprite-mcp server (Go binary), Aseprite v1.3.0+

## Architecture

The plugin follows a layered architecture:

1. **User Layer**: Natural language or slash commands in Claude Code
2. **Plugin Layer**: Skills (model-invoked) and Commands (user-invoked)
3. **MCP Layer**: aseprite-mcp server (40+ tools)
4. **Application Layer**: Aseprite CLI interactions

**Key Integration Point:** The plugin bundles pre-compiled aseprite-mcp binaries and provides a platform-detection wrapper (`bin/aseprite-mcp`) that selects the correct binary for macOS, Linux, or Windows.

## Development Workflow

### Using Custom Commands

This project uses three custom slash commands for chunk-based implementation:

- **`/next`** - Identifies the next implementation chunk based on git history
- **`/proceed`** - Implements the entire chunk following the Implementation Guide
- **`/commit`** - Validates and commits staged changes with proper formatting

**Workflow:**
```
1. /next      # Find next chunk
2. /proceed   # Implement chunk completely
3. /commit    # Verify and commit with "Chunk: X.Y" footer
```

### Implementation Guide

Follow `docs/IMPLEMENTATION_GUIDE.md` strictly. The guide is organized into 7 phases with bite-sized chunks (1.1, 1.2, 2.1, etc.). Each chunk:
- Has a focused objective
- Provides exact file contents
- Includes verification steps
- Requires a git commit before proceeding

**Important:** Complete chunks sequentially. Do not skip ahead or combine chunks.

### Git Commit Format

```
<type>(<scope>): <subject>

<body with bulleted changes>

Chunk: X.Y
```

**Types:** feat, fix, docs, chore, test
**Scopes:** foundation, mcp, skills, commands, config, docs

The "Chunk: X.Y" footer is required for progress tracking.

## Directory Structure

```
aseprite-pixelart-plugin/
├── .claude-plugin/
│   └── plugin.json                 # Plugin manifest
├── .claude/
│   └── commands/                   # Custom slash commands
│       ├── next.md
│       ├── proceed.md
│       └── commit.md
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
│   ├── aseprite-mcp               # Platform detection wrapper
│   ├── aseprite-mcp-darwin-amd64
│   ├── aseprite-mcp-darwin-arm64
│   ├── aseprite-mcp-linux-amd64
│   ├── aseprite-mcp-linux-arm64
│   └── aseprite-mcp-windows-amd64.exe
├── config/
│   ├── aseprite-mcp-config.json   # Template for users
│   ├── detect-aseprite.sh         # Path detection helper
│   └── README.md                  # Configuration guide
├── .mcp.json                       # MCP server integration
└── docs/
    ├── DESIGN.md                   # Architecture blueprint
    ├── PRD.md                      # Product requirements
    └── IMPLEMENTATION_GUIDE.md     # Chunk-based impl guide
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

### MCP Server Integration

`.mcp.json` configures the bundled aseprite-mcp server:

```json
{
  "mcpServers": {
    "aseprite": {
      "command": "${CLAUDE_PLUGIN_ROOT}/bin/aseprite-mcp",
      "args": [],
      "env": {
        "CONFIG_PATH": "${CLAUDE_PLUGIN_ROOT}/config/aseprite-mcp-config.json"
      }
    }
  }
}
```

**Platform Detection:** The `bin/aseprite-mcp` wrapper script detects OS and architecture, then executes the appropriate binary.

## File Validation

### JSON Files
```bash
python3 -m json.tool <file>.json > /dev/null && echo "✅ Valid" || echo "❌ Invalid"
```

### YAML Frontmatter
Extract and manually verify:
```bash
sed -n '/^---$/,/^---$/p' skills/<skill-name>/SKILL.md
```

### Shell Scripts
Ensure executable:
```bash
chmod +x config/detect-aseprite.sh
```

## Building MCP Binaries

Located at `/Users/brandon/src/aseprite-mcp`:

```bash
cd /Users/brandon/src/aseprite-mcp
make clean
make release

# Binaries created in bin/:
# - aseprite-mcp-darwin-amd64
# - aseprite-mcp-darwin-arm64
# - aseprite-mcp-linux-amd64
# - aseprite-mcp-linux-arm64
# - aseprite-mcp-windows-amd64.exe

# Copy to plugin:
cp bin/aseprite-mcp-* /Users/brandon/src/aseprite-pixelart-plugin/bin/
```

## Key Design Principles

1. **Sequential Implementation**: Follow Implementation Guide chunks in order (1.1 → 1.2 → 2.1 → 2.2, etc.)

2. **Chunk Isolation**: Each chunk is self-contained with verification gates before proceeding

3. **No Wandering**: Chunks have single, focused objectives to prevent scope creep

4. **Model-Invoked Skills**: Skills trigger automatically based on trigger keywords in descriptions

5. **User-Invoked Commands**: Commands require explicit `/command` invocation

6. **Progressive Disclosure**: Skills load supporting files (reference.md, examples.md) only when needed

7. **Platform Awareness**: Plugin supports macOS (Intel/ARM), Linux (x86_64/ARM64), Windows (x86_64)

8. **MCP Tools**: All aseprite-mcp tools prefixed with `mcp__aseprite__*` (e.g., `mcp__aseprite__create_canvas`)

## Common Tasks

### Finding Current Progress
```bash
git log --oneline --grep="Chunk:" | head -10
```

### Validating Plugin Structure
```bash
ls -la .claude-plugin/plugin.json    # Must exist
ls -la .mcp.json                     # Must exist
ls -la skills/                       # Must be at root
ls -la commands/                     # Must be at root
ls -la bin/aseprite-mcp              # Must be executable
```

### Testing MCP Server
```bash
bin/aseprite-mcp --version          # Should show version
bin/aseprite-mcp --health            # May fail without Aseprite configured
```

### Checking Chunk Progress
Use the custom commands:
```bash
/next      # Shows next chunk to implement
/proceed   # Implements the chunk
/commit    # Commits with proper format
```

## Reference Documentation

- **DESIGN.md**: Complete architecture, component specifications, directory structure
- **PRD.md**: User stories, requirements, success metrics
- **IMPLEMENTATION_GUIDE.md**: Step-by-step chunk-based implementation (phases 1-7)

## External Dependencies

- **aseprite-mcp**: Go-based MCP server at `/Users/brandon/src/aseprite-mcp`
  - Provides 40+ tools for pixel art operations
  - Built with Go 1.23+
  - Communicates with Aseprite via CLI

- **Aseprite**: v1.3.0+ pixel art editor
  - Not bundled with plugin
  - Users configure path via `/pixel-setup` command
  - Platform-specific paths documented in `config/README.md`

## Important Notes

- **Never skip chunks** - Each builds on previous work
- **All Skills need SKILL.md** with valid YAML frontmatter
- **Commit messages must include "Chunk: X.Y"** for tracking
- **Use ${CLAUDE_PLUGIN_ROOT}** in .mcp.json for plugin-relative paths
- **Skills at root, not in .claude-plugin/** - Common mistake to avoid
- **Test verification steps before committing** - Required for each chunk
