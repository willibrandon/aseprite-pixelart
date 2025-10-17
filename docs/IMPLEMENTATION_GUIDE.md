# Implementation Guide
# Aseprite Pixel Art Plugin for Claude Code

**Version:** 1.0.0
**Date:** October 16, 2025
**Target Audience:** Claude Code (AI coding collaborator)
**Estimated Time:** 10-16 days

---

## Table of Contents

1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Git Workflow](#git-workflow)
4. [Implementation Phases](#implementation-phases)
5. [Phase 1: Project Foundation](#phase-1-project-foundation)
6. [Phase 2: MCP Server Integration](#phase-2-mcp-server-integration)
7. [Phase 3: Core Skills Development](#phase-3-core-skills-development)
8. [Phase 4: Slash Commands](#phase-4-slash-commands)
9. [Phase 5: Advanced Skills](#phase-5-advanced-skills)
10. [Phase 6: Testing and Polish](#phase-6-testing-and-polish)
11. [Phase 7: Documentation and Release](#phase-7-documentation-and-release)
12. [Troubleshooting](#troubleshooting)

---

## Overview

This guide breaks down the implementation of the Aseprite Pixel Art Plugin into **bite-sized chunks**. Each chunk:

1. Has a **clear, focused objective**
2. Includes **specific files to create/modify**
3. Provides **exact content or templates**
4. Ends with **verification steps**
5. Requires a **git commit** before proceeding

**Important Guidelines for Claude Code:**
- Complete each chunk fully before moving to the next
- Run all verification steps and confirm success
- Make a git commit after each chunk with a descriptive message
- If a chunk fails verification, fix issues before proceeding
- Do not skip ahead or combine chunks
- Ask for clarification if any instruction is unclear

---

## Prerequisites

Before starting implementation, ensure:

1. ✅ You are in the `/Users/brandon/src/aseprite-pixelart-plugin` directory
2. ✅ Git is initialized in this directory
3. ✅ You have read and understand `docs/DESIGN.md` and `docs/PRD.md`
4. ✅ You have access to the aseprite-mcp repository at `/Users/brandon/src/aseprite-mcp`

---

## Git Workflow

### Branch Strategy

**Main Branch:** `main` (production-ready code)
**Development Branch:** `develop` (integration branch)
**Feature Branches:** `feature/<chunk-name>` (individual chunks)

### Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `chore`: Maintenance tasks
- `test`: Adding or updating tests

**Examples:**
```
feat(foundation): add plugin manifest and directory structure

- Created .claude-plugin/plugin.json with metadata
- Created skills/, commands/, bin/, config/ directories
- Added .gitignore for build artifacts

Chunk: 1.1
```

### Commit Checklist

Before each commit:
- ✅ All files created/modified as specified
- ✅ Verification steps completed successfully
- ✅ No syntax errors in JSON/YAML/Markdown files
- ✅ Files follow naming conventions from DESIGN.md

---

## Implementation Phases

| Phase | Chunks | Duration | Description |
|-------|--------|----------|-------------|
| **Phase 1** | 1.1 - 1.4 | 1 day | Project foundation and structure |
| **Phase 2** | 2.1 - 2.4 | 2-3 days | MCP server integration and configuration |
| **Phase 3** | 3.1 - 3.4 | 3-4 days | Core Skills development |
| **Phase 4** | 4.1 - 4.5 | 1-2 days | Slash commands implementation |
| **Phase 5** | 5.1 - 5.2 | 1-2 days | Advanced Skills refinement |
| **Phase 6** | 6.1 - 6.3 | 2 days | Testing and validation |
| **Phase 7** | 7.1 - 7.3 | 1-2 days | Documentation and release prep |

**Total: 11-16 days**

---

## Phase 1: Project Foundation

**Goal:** Establish core project structure and configuration files.

### Chunk 1.1: Initialize Repository and Base Structure

**Objective:** Create git repository, directory structure, and basic configuration files.

**Files to Create:**

1. **`.gitignore`**
```gitignore
# Build artifacts
bin/aseprite-mcp*
!bin/.gitkeep

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Logs
*.log

# Temporary files
tmp/
temp/
*.tmp

# User configuration (should be set by users)
config/user-config.json

# Test outputs
test-outputs/
*.ase
*.aseprite
*.png
*.gif
```

2. **`LICENSE`**
```
MIT License

Copyright (c) 2025 Brandon Willett

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

3. **`CHANGELOG.md`**
```markdown
# Changelog

All notable changes to the Aseprite Pixel Art Plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial plugin structure
- Project foundation and documentation

## [1.0.0] - TBD

### Added
- Four core Skills: pixel-art-creator, pixel-art-animator, pixel-art-professional, pixel-art-exporter
- Five slash commands: /pixel-new, /pixel-palette, /pixel-export, /pixel-setup, /pixel-help
- MCP server integration with aseprite-mcp
- Cross-platform binary support (macOS, Linux, Windows)
- Comprehensive documentation

[Unreleased]: https://github.com/willibrandon/aseprite-pixelart-plugin/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/willibrandon/aseprite-pixelart-plugin/releases/tag/v1.0.0
```

**Commands to Run:**

```bash
# Ensure you're in the correct directory
cd /Users/brandon/src/aseprite-pixelart-plugin

# Initialize git if not already done
git init

# Create directory structure
mkdir -p .claude-plugin
mkdir -p skills
mkdir -p commands
mkdir -p bin
mkdir -p config
mkdir -p test-outputs

# Create .gitkeep files for empty directories
touch bin/.gitkeep
touch test-outputs/.gitkeep

# Create files (use Write tool for content)
# .gitignore (content above)
# LICENSE (content above)
# CHANGELOG.md (content above)
```

**Verification Steps:**

1. ✅ Run `ls -la` and confirm directories exist:
   - `.claude-plugin/`
   - `skills/`
   - `commands/`
   - `bin/`
   - `config/`
   - `docs/` (already exists)
   - `test-outputs/`

2. ✅ Run `cat .gitignore` and verify content matches

3. ✅ Run `cat LICENSE` and verify MIT license text

4. ✅ Run `cat CHANGELOG.md` and verify structure

5. ✅ Run `git status` and verify no build artifacts are tracked

**Git Commit:**

```bash
git add .
git commit -m "chore(foundation): initialize repository with base structure

- Added .gitignore with patterns for build artifacts and IDE files
- Added MIT LICENSE
- Added CHANGELOG.md following Keep a Changelog format
- Created directory structure (skills, commands, bin, config)

Chunk: 1.1"
```

**Success Criteria:**
- All directories created
- All base files present with correct content
- Git repository initialized
- First commit made successfully

---

### Chunk 1.2: Create Plugin Manifest

**Objective:** Create the plugin manifest (plugin.json) with correct metadata.

**Files to Create:**

1. **`.claude-plugin/plugin.json`**

```json
{
  "name": "aseprite-pixelart",
  "version": "1.0.0",
  "description": "Create and edit pixel art sprites using Aseprite through natural language. Provides Skills for autonomous assistance and commands for direct control.",
  "author": {
    "name": "Brandon Willett",
    "url": "https://github.com/willibrandon"
  },
  "repository": "https://github.com/willibrandon/aseprite-pixelart-plugin",
  "homepage": "https://github.com/willibrandon/aseprite-pixelart-plugin",
  "license": "MIT",
  "keywords": [
    "pixel-art",
    "aseprite",
    "graphics",
    "sprites",
    "animation",
    "game-dev",
    "art",
    "mcp"
  ]
}
```

**Verification Steps:**

1. ✅ Run `cat .claude-plugin/plugin.json` and verify content

2. ✅ Validate JSON syntax:
```bash
python3 -m json.tool .claude-plugin/plugin.json > /dev/null && echo "✅ Valid JSON" || echo "❌ Invalid JSON"
```

3. ✅ Verify all required fields present:
   - `name`: "aseprite-pixelart"
   - `version`: "1.0.0"
   - `description`: (present and descriptive)
   - `author`: (object with name and url)
   - `repository`: (GitHub URL)
   - `license`: "MIT"

**Git Commit:**

```bash
git add .claude-plugin/plugin.json
git commit -m "feat(foundation): add plugin manifest

- Created .claude-plugin/plugin.json with metadata
- Defined plugin name, version, description, author
- Added repository links and keywords

Chunk: 1.2"
```

**Success Criteria:**
- plugin.json created with valid JSON
- All required fields present
- Metadata matches DESIGN.md specifications

---

### Chunk 1.3: Create MCP Server Configuration Template

**Objective:** Create the MCP server configuration file for bundling aseprite-mcp.

**Files to Create:**

1. **`.mcp.json`**

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

2. **`config/aseprite-mcp-config.json`** (template)

```json
{
  "aseprite_path": "",
  "temp_dir": "/tmp/aseprite-mcp",
  "timeout": 30,
  "log_level": "info",
  "log_file": "",
  "enable_timing": false,
  "_comment": "This is a template. Users must set aseprite_path via /pixel-setup command."
}
```

**Verification Steps:**

1. ✅ Validate `.mcp.json`:
```bash
python3 -m json.tool .mcp.json > /dev/null && echo "✅ Valid JSON" || echo "❌ Invalid JSON"
```

2. ✅ Validate `config/aseprite-mcp-config.json`:
```bash
python3 -m json.tool config/aseprite-mcp-config.json > /dev/null && echo "✅ Valid JSON" || echo "❌ Invalid JSON"
```

3. ✅ Verify `.mcp.json` uses `${CLAUDE_PLUGIN_ROOT}` variable

4. ✅ Verify config template includes all fields from aseprite-mcp docs

**Git Commit:**

```bash
git add .mcp.json config/aseprite-mcp-config.json
git commit -m "feat(mcp): add MCP server configuration

- Created .mcp.json to bundle aseprite-mcp server
- Used \${CLAUDE_PLUGIN_ROOT} for plugin-relative paths
- Created config template for aseprite-mcp settings
- Users will configure aseprite_path via /pixel-setup

Chunk: 1.3"
```

**Success Criteria:**
- .mcp.json created with valid structure
- Configuration template matches aseprite-mcp requirements
- Uses plugin root variable correctly

---

### Chunk 1.4: Create Basic README

**Objective:** Create initial README with installation placeholder and project overview.

**Files to Create:**

1. **`README.md`**

```markdown
# Aseprite Pixel Art Plugin for Claude Code

Create and edit professional pixel art sprites using Aseprite through natural language commands in Claude Code.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code](https://img.shields.io/badge/Claude_Code-v1.0+-blue.svg)](https://claude.com/claude-code)
[![Aseprite](https://img.shields.io/badge/Aseprite-v1.3.0+-red.svg)](https://www.aseprite.org/)

## Features

- 🎨 **Natural Language Interface**: Create sprites by describing what you want
- 🤖 **AI-Powered Skills**: Claude autonomously uses specialized skills for pixel art tasks
- 🎬 **Animation Support**: Create multi-frame animations with tags and linked cels
- 🎨 **Professional Tools**: Dithering, palette management, shading, antialiasing
- 📦 **Export Flexibility**: PNG, GIF, spritesheets with multiple layouts
- ⚡ **Fast Performance**: Operations complete in <100ms typically

## What You Can Do

```
You: "Create a 64x64 sprite of a walking character with 4 animation frames"
Claude: [Creates sprite with walk cycle animation]

You: "Apply Bayer 8x8 dithering for a water texture effect"
Claude: [Applies professional dithering pattern]

You: "Extract the color palette from this reference image"
Claude: [Analyzes image and sets palette]

You: "Export as a spritesheet for Unity"
Claude: [Exports in Unity-compatible format]
```

## Requirements

- **Claude Code** v1.0 or later
- **Aseprite** v1.3.0+ (v1.3.10+ recommended)
- **Operating System**: macOS, Linux, or Windows

## Installation

### Quick Start

```bash
# Add the plugin marketplace (when available)
claude plugin marketplace add https://github.com/willibrandon/aseprite-plugins

# Install the plugin
claude plugin install aseprite-pixelart@willibrandon
```

### Local Development Installation

```bash
# Clone the repository
git clone https://github.com/willibrandon/aseprite-pixelart-plugin.git

# Create a local marketplace
mkdir -p ~/claude-dev-marketplace
cd ~/claude-dev-marketplace
# ... (full instructions to be added)
```

## Quick Start Guide

*Detailed quick start guide will be added in Phase 7.*

## Available Features

### Skills (Model-Invoked)

Claude automatically uses these skills based on your request:

- **pixel-art-creator**: Canvas creation, basic drawing, layer management
- **pixel-art-animator**: Frame management, animation tags, linked cels
- **pixel-art-professional**: Dithering, palettes, shading, antialiasing
- **pixel-art-exporter**: Export to various formats, spritesheets

### Commands (User-Invoked)

Direct control via slash commands:

- `/pixel-new [width] [height] [mode]` - Create new canvas
- `/pixel-palette [action] [args]` - Manage color palettes
- `/pixel-export [format] [filename]` - Export sprite
- `/pixel-setup` - Configure Aseprite path
- `/pixel-help` - Show available features

## Documentation

- [Design Document](docs/DESIGN.md) - Architecture and technical design
- [Product Requirements](docs/PRD.md) - Detailed requirements and specifications
- [Implementation Guide](docs/IMPLEMENTATION_GUIDE.md) - Development guide

## Examples

*Example workflows will be added in Phase 7.*

## Troubleshooting

*Troubleshooting guide will be added in Phase 7.*

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- **Aseprite**: Professional pixel art and animation tool by Igara Studio
- **aseprite-mcp**: MCP server providing Aseprite integration
- **Claude Code**: Anthropic's official CLI for Claude
- **Model Context Protocol**: Open-source standard for AI-tool integrations

## Links

- [Aseprite](https://www.aseprite.org/)
- [aseprite-mcp](https://github.com/willibrandon/aseprite-mcp)
- [Claude Code Documentation](https://docs.claude.com/en/docs/claude-code)
- [Model Context Protocol](https://modelcontextprotocol.io/)

---

**Status**: 🚧 In Development - v1.0.0

**Last Updated**: October 16, 2025
```

**Verification Steps:**

1. ✅ Run `cat README.md` and verify structure

2. ✅ Check markdown rendering (if possible):
```bash
# If you have a markdown viewer
# mdcat README.md || cat README.md
cat README.md | head -50
```

3. ✅ Verify sections present:
   - Features
   - Requirements
   - Installation
   - Quick Start Guide (placeholder)
   - Available Features
   - Documentation links
   - License

4. ✅ Verify links to design documents work:
```bash
ls -la docs/DESIGN.md docs/PRD.md docs/IMPLEMENTATION_GUIDE.md
```

**Git Commit:**

```bash
git add README.md
git commit -m "docs(foundation): add initial README

- Created README with project overview and features
- Added installation instructions (placeholder)
- Listed Skills and Commands
- Included links to design documents
- Added requirements and acknowledgments

Chunk: 1.4"
```

**Success Criteria:**
- README.md created with comprehensive structure
- All sections present (some as placeholders)
- Links to documentation valid
- Markdown properly formatted

---

### Phase 1 Summary Check

Before proceeding to Phase 2, verify:

```bash
# Check directory structure
tree -L 2 -a

# Expected output:
# .
# ├── .claude-plugin
# │   └── plugin.json
# ├── .git
# ├── .gitignore
# ├── .mcp.json
# ├── CHANGELOG.md
# ├── LICENSE
# ├── README.md
# ├── bin
# │   └── .gitkeep
# ├── commands
# ├── config
# │   └── aseprite-mcp-config.json
# ├── docs
# │   ├── DESIGN.md
# │   ├── IMPLEMENTATION_GUIDE.md
# │   └── PRD.md
# ├── skills
# └── test-outputs
#     └── .gitkeep

# Check git log
git log --oneline

# Expected: 4 commits (chunks 1.1 through 1.4)
```

✅ **Phase 1 Complete** - Foundation established, ready for MCP server integration.

---

## Phase 2: MCP Server Integration

**Goal:** Build and integrate aseprite-mcp binaries with the plugin.

### Chunk 2.1: Download aseprite-mcp v0.1.0 Release Binaries

**Objective:** Download aseprite-mcp v0.1.0 release binaries for all target platforms.

**Context:** We'll download the official v0.1.0 release binaries from GitHub instead of building from source. This ensures we're using a stable, tested version.

**Commands to Run:**

```bash
# Create a temporary directory for downloads
mkdir -p /tmp/aseprite-mcp-download
cd /tmp/aseprite-mcp-download

# Download tar.gz archives from GitHub release v0.1.0
curl -L -O https://github.com/willibrandon/aseprite-mcp/releases/download/v0.1.0/aseprite-mcp_0.1.0_Darwin_x86_64.tar.gz
curl -L -O https://github.com/willibrandon/aseprite-mcp/releases/download/v0.1.0/aseprite-mcp_0.1.0_Darwin_arm64.tar.gz
curl -L -O https://github.com/willibrandon/aseprite-mcp/releases/download/v0.1.0/aseprite-mcp_0.1.0_Linux_x86_64.tar.gz
curl -L -O https://github.com/willibrandon/aseprite-mcp/releases/download/v0.1.0/aseprite-mcp_0.1.0_Linux_arm64.tar.gz
curl -L -O https://github.com/willibrandon/aseprite-mcp/releases/download/v0.1.0/aseprite-mcp_0.1.0_Windows_x86_64.tar.gz

# Extract all archives
for f in *.tar.gz; do tar -xzf "$f"; done

# Rename binaries to expected names
mv aseprite-mcp aseprite-mcp-darwin-amd64 2>/dev/null || true
# The actual binary name in the Darwin_x86_64 archive
if [ -f aseprite-mcp ]; then mv aseprite-mcp aseprite-mcp-darwin-amd64; fi
# Extract each and rename properly
rm -rf bin extracted 2>/dev/null || true
mkdir -p extracted

# Extract and rename each platform's binary
tar -xzf aseprite-mcp_0.1.0_Darwin_x86_64.tar.gz -C extracted && mv extracted/aseprite-mcp aseprite-mcp-darwin-amd64
tar -xzf aseprite-mcp_0.1.0_Darwin_arm64.tar.gz -C extracted && mv extracted/aseprite-mcp aseprite-mcp-darwin-arm64
tar -xzf aseprite-mcp_0.1.0_Linux_x86_64.tar.gz -C extracted && mv extracted/aseprite-mcp aseprite-mcp-linux-amd64
tar -xzf aseprite-mcp_0.1.0_Linux_arm64.tar.gz -C extracted && mv extracted/aseprite-mcp aseprite-mcp-linux-arm64
tar -xzf aseprite-mcp_0.1.0_Windows_x86_64.tar.gz -C extracted && mv extracted/aseprite-mcp.exe aseprite-mcp-windows-amd64.exe

# Copy binaries to plugin directory
cd /Users/brandon/src/aseprite-pixelart
cp /tmp/aseprite-mcp-download/aseprite-mcp-* bin/

# Make binaries executable
chmod +x bin/aseprite-mcp-*

# Remove .gitkeep since we now have files
rm bin/.gitkeep

# Clean up temporary directory
rm -rf /tmp/aseprite-mcp-download
```

**Verification Steps:**

1. ✅ Verify all binaries copied:
```bash
ls -lh bin/
# Should show 5 binaries with execute permissions
```

2. ✅ Check binary sizes (should be reasonable, 10-50MB each):
```bash
du -h bin/*
```

3. ✅ Verify execute permissions on Unix binaries:
```bash
ls -la bin/ | grep "x.*aseprite-mcp"
```

4. ✅ Test that current platform's binary runs:
```bash
# On macOS (adjust for your platform)
bin/aseprite-mcp-darwin-arm64 --version || bin/aseprite-mcp-darwin-amd64 --version
# Should output version information
```

**Git Commit:**

```bash
git add bin/
git commit -m "feat(mcp): add aseprite-mcp v0.1.0 binaries for all platforms

- Downloaded aseprite-mcp v0.1.0 release binaries from GitHub
- Added binaries for macOS (Intel & ARM), Linux, Windows
- Made binaries executable
- Using official release instead of building from source

Chunk: 2.1"
```

**Success Criteria:**
- All 5 binaries present in bin/
- Binaries have execute permissions
- Current platform binary runs and shows version
- Binaries committed to git

---

### Chunk 2.2: Create Platform-Specific MCP Configuration

**Objective:** Update .mcp.json to select correct binary based on platform.

**Problem:** The current `.mcp.json` points to a single binary, but we need platform-specific selection.

**Solution:** Since Claude Code's MCP configuration doesn't support conditional logic, we'll use a symbolic link approach or rely on the binary name pattern. For simplicity, we'll create a wrapper approach.

**Files to Create:**

1. **`bin/aseprite-mcp`** (symbolic link or wrapper script)

For Unix systems (macOS, Linux), we'll create a shell script wrapper:

```bash
#!/bin/bash
# Wrapper script to select the correct aseprite-mcp binary for the current platform

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect platform
OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
    Darwin)
        case "$ARCH" in
            x86_64)
                BINARY="$SCRIPT_DIR/aseprite-mcp-darwin-amd64"
                ;;
            arm64)
                BINARY="$SCRIPT_DIR/aseprite-mcp-darwin-arm64"
                ;;
            *)
                echo "Error: Unsupported macOS architecture: $ARCH" >&2
                exit 1
                ;;
        esac
        ;;
    Linux)
        case "$ARCH" in
            x86_64)
                BINARY="$SCRIPT_DIR/aseprite-mcp-linux-amd64"
                ;;
            aarch64|arm64)
                BINARY="$SCRIPT_DIR/aseprite-mcp-linux-arm64"
                ;;
            *)
                echo "Error: Unsupported Linux architecture: $ARCH" >&2
                exit 1
                ;;
        esac
        ;;
    MINGW*|MSYS*|CYGWIN*)
        BINARY="$SCRIPT_DIR/aseprite-mcp-windows-amd64.exe"
        ;;
    *)
        echo "Error: Unsupported operating system: $OS" >&2
        exit 1
        ;;
esac

if [ ! -x "$BINARY" ]; then
    echo "Error: Binary not found or not executable: $BINARY" >&2
    exit 1
fi

# Execute the appropriate binary with all arguments
exec "$BINARY" "$@"
```

**Commands to Run:**

```bash
# Create the wrapper script
cat > bin/aseprite-mcp << 'EOF'
#!/bin/bash
# Wrapper script to select the correct aseprite-mcp binary for the current platform

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect platform
OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
    Darwin)
        case "$ARCH" in
            x86_64)
                BINARY="$SCRIPT_DIR/aseprite-mcp-darwin-amd64"
                ;;
            arm64)
                BINARY="$SCRIPT_DIR/aseprite-mcp-darwin-arm64"
                ;;
            *)
                echo "Error: Unsupported macOS architecture: $ARCH" >&2
                exit 1
                ;;
        esac
        ;;
    Linux)
        case "$ARCH" in
            x86_64)
                BINARY="$SCRIPT_DIR/aseprite-mcp-linux-amd64"
                ;;
            aarch64|arm64)
                BINARY="$SCRIPT_DIR/aseprite-mcp-linux-arm64"
                ;;
            *)
                echo "Error: Unsupported Linux architecture: $ARCH" >&2
                exit 1
                ;;
        esac
        ;;
    MINGW*|MSYS*|CYGWIN*)
        BINARY="$SCRIPT_DIR/aseprite-mcp-windows-amd64.exe"
        ;;
    *)
        echo "Error: Unsupported operating system: $OS" >&2
        exit 1
        ;;
esac

if [ ! -x "$BINARY" ]; then
    echo "Error: Binary not found or not executable: $BINARY" >&2
    exit 1
fi

# Execute the appropriate binary with all arguments
exec "$BINARY" "$@"
EOF

# Make wrapper executable
chmod +x bin/aseprite-mcp
```

**Verification Steps:**

1. ✅ Verify wrapper script created:
```bash
cat bin/aseprite-mcp | head -20
```

2. ✅ Verify executable permission:
```bash
ls -la bin/aseprite-mcp | grep "x"
```

3. ✅ Test wrapper selects correct binary:
```bash
bin/aseprite-mcp --version
# Should execute correct binary for your platform
```

4. ✅ Test wrapper with --health flag:
```bash
bin/aseprite-mcp --health
# May fail if Aseprite not configured yet, but should show binary is running
```

**Git Commit:**

```bash
git add bin/aseprite-mcp
git commit -m "feat(mcp): add platform detection wrapper for aseprite-mcp

- Created shell script wrapper to select correct binary
- Supports macOS (Intel/ARM), Linux (x86_64/ARM64), Windows
- Detects platform and architecture automatically
- Provides clear error messages for unsupported platforms

Chunk: 2.2"
```

**Success Criteria:**
- Wrapper script created and executable
- Wrapper correctly detects current platform
- Wrapper executes appropriate binary
- Error handling for unsupported platforms

---

### Chunk 2.3: Create Aseprite Path Detection Helper

**Objective:** Create a helper script to detect common Aseprite installation paths.

**Files to Create:**

1. **`config/detect-aseprite.sh`**

```bash
#!/bin/bash
# Helper script to detect Aseprite installation path

set -e

# Common installation paths by platform
detect_aseprite() {
    local OS="$(uname -s)"

    case "$OS" in
        Darwin)
            # macOS paths
            local PATHS=(
                "/Applications/Aseprite.app/Contents/MacOS/aseprite"
                "$HOME/Applications/Aseprite.app/Contents/MacOS/aseprite"
                "/usr/local/bin/aseprite"
                "$HOME/.local/bin/aseprite"
            )
            ;;
        Linux)
            # Linux paths
            local PATHS=(
                "/usr/bin/aseprite"
                "/usr/local/bin/aseprite"
                "$HOME/.local/bin/aseprite"
                "$HOME/bin/aseprite"
                "/opt/aseprite/bin/aseprite"
                "/snap/bin/aseprite"
            )
            ;;
        MINGW*|MSYS*|CYGWIN*)
            # Windows paths (Git Bash / MSYS / Cygwin)
            local PATHS=(
                "/c/Program Files/Aseprite/Aseprite.exe"
                "/c/Program Files (x86)/Aseprite/Aseprite.exe"
                "$HOME/AppData/Local/Aseprite/Aseprite.exe"
            )
            ;;
        *)
            echo "Error: Unsupported operating system: $OS" >&2
            return 1
            ;;
    esac

    # Check each path
    for path in "${PATHS[@]}"; do
        if [ -x "$path" ]; then
            echo "$path"
            return 0
        fi
    done

    # Not found
    return 1
}

# Main execution
if detect_aseprite; then
    exit 0
else
    echo "Error: Aseprite not found in common installation paths" >&2
    echo "" >&2
    echo "Please install Aseprite from: https://www.aseprite.org/" >&2
    echo "Or specify the path manually using: /pixel-setup" >&2
    exit 1
fi
```

**Commands to Run:**

```bash
# Create the detection script
# (Use Write tool with content above)

# Make executable
chmod +x config/detect-aseprite.sh
```

**Verification Steps:**

1. ✅ Verify script created and executable:
```bash
ls -la config/detect-aseprite.sh | grep "x"
```

2. ✅ Test detection (will depend on your Aseprite installation):
```bash
config/detect-aseprite.sh
# Should output path if found, or error message if not
```

3. ✅ Verify script handles current platform:
```bash
bash -x config/detect-aseprite.sh 2>&1 | head -10
# Should show platform detection logic executing
```

**Git Commit:**

```bash
git add config/detect-aseprite.sh
git commit -m "feat(config): add Aseprite path detection helper

- Created shell script to detect Aseprite installation
- Supports macOS, Linux, Windows common paths
- Provides helpful error message if not found
- Will be used by /pixel-setup command

Chunk: 2.3"
```

**Success Criteria:**
- Detection script created and executable
- Script detects common paths for current platform
- Helpful error messages provided
- Returns exit code 0 if found, 1 if not

---

### Chunk 2.4: Update MCP Config with Environment Variable Support

**Objective:** Enhance MCP configuration to support dynamic config path.

**Files to Modify:**

1. **`.mcp.json`** (update)

```json
{
  "mcpServers": {
    "aseprite": {
      "command": "${CLAUDE_PLUGIN_ROOT}/bin/aseprite-mcp",
      "args": [],
      "env": {
        "ASEPRITE_MCP_CONFIG": "${CLAUDE_PLUGIN_ROOT}/config/aseprite-mcp-config.json"
      }
    }
  }
}
```

**Note:** Actually, aseprite-mcp uses standard config path. Let's verify what aseprite-mcp expects:

Looking at the aseprite-mcp README, it expects config at `~/.config/aseprite-mcp/config.json`. We should document this but not override it in the plugin, OR we can pass command-line flags.

Let's update approach to use command-line flags:

```json
{
  "mcpServers": {
    "aseprite": {
      "command": "${CLAUDE_PLUGIN_ROOT}/bin/aseprite-mcp",
      "args": [
        "--config",
        "${CLAUDE_PLUGIN_ROOT}/config/aseprite-mcp-config.json"
      ],
      "env": {}
    }
  }
}
```

**Verification:** Check aseprite-mcp help to confirm flag name:

```bash
cd /Users/brandon/src/aseprite-mcp
./bin/aseprite-mcp-darwin-arm64 --help 2>&1 | grep -i config || ./bin/aseprite-mcp-darwin-amd64 --help 2>&1 | grep -i config
```

Based on aseprite-mcp code, it reads config from `~/.config/aseprite-mcp/config.json` by default. Let's keep it simple and document that users should configure there, OR we provide our own config template and document how to use it.

**Decision:** Keep `.mcp.json` simple for now, document config location in setup command.

Actually, let's not modify .mcp.json yet. It's fine as is. The aseprite-mcp binary will look for config in the standard location.

**Alternative Approach for Chunk 2.4:**

**Objective:** Document MCP configuration and create setup instructions.

**Files to Create:**

1. **`config/README.md`**

```markdown
# Configuration Guide

## Aseprite MCP Server Configuration

The aseprite-mcp server requires Aseprite to be installed and configured.

### Configuration Location

By default, aseprite-mcp looks for configuration at:
- **macOS/Linux**: `~/.config/aseprite-mcp/config.json`
- **Windows**: `%APPDATA%\aseprite-mcp\config.json`

### Configuration Format

The plugin includes a template at `config/aseprite-mcp-config.json`:

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

### Required Configuration

The only required field is `aseprite_path`. All other fields have sensible defaults.

### Setup Methods

#### Option 1: Use /pixel-setup Command (Recommended)

The `/pixel-setup` command will guide you through configuration:

```
> /pixel-setup
```

This will:
1. Detect Aseprite installation automatically (if in common path)
2. Prompt for manual path if not found
3. Validate the path
4. Create configuration file
5. Test MCP server connectivity

#### Option 2: Manual Configuration

1. Create the config directory:
```bash
mkdir -p ~/.config/aseprite-mcp
```

2. Copy the template:
```bash
cp config/aseprite-mcp-config.json ~/.config/aseprite-mcp/config.json
```

3. Edit the config file and set `aseprite_path`:
```bash
# macOS example
"aseprite_path": "/Applications/Aseprite.app/Contents/MacOS/aseprite"

# Linux example
"aseprite_path": "/usr/bin/aseprite"

# Windows example
"aseprite_path": "C:\\Program Files\\Aseprite\\Aseprite.exe"
```

### Verifying Configuration

Test that aseprite-mcp can find Aseprite:

```bash
${CLAUDE_PLUGIN_ROOT}/bin/aseprite-mcp --health
```

Should output:
```
✓ Aseprite found at: /path/to/aseprite
✓ Configuration loaded
✓ MCP server ready
```

### Troubleshooting

**Error: "Aseprite not found"**
- Verify Aseprite is installed: https://www.aseprite.org/
- Check the path in your config file
- Ensure the path points to the executable, not the .app directory (on macOS)

**Error: "Permission denied"**
- Ensure aseprite-mcp binary is executable: `chmod +x bin/aseprite-mcp`
- Ensure Aseprite binary is executable

**Error: "Timeout"**
- Increase `timeout` value in config (default: 30 seconds)
- Check if Aseprite launches successfully manually

### Platform-Specific Paths

**macOS:**
```
/Applications/Aseprite.app/Contents/MacOS/aseprite
```

**Linux:**
```
/usr/bin/aseprite
/usr/local/bin/aseprite
~/.local/bin/aseprite
```

**Windows:**
```
C:\Program Files\Aseprite\Aseprite.exe
C:\Program Files (x86)\Aseprite\Aseprite.exe
```

### Advanced Configuration

**Enable Logging:**
```json
{
  "log_level": "debug",
  "log_file": "/tmp/aseprite-mcp.log"
}
```

**Enable Timing:**
```json
{
  "enable_timing": true
}
```

This will log operation timings for performance analysis.

**Custom Temp Directory:**
```json
{
  "temp_dir": "/custom/path/to/temp"
}
```

Ensure the directory exists and is writable.
```

**Commands to Run:**

```bash
# Create config README
# (Use Write tool with content above)
```

**Verification Steps:**

1. ✅ Verify README created:
```bash
cat config/README.md | head -50
```

2. ✅ Verify markdown formatting:
```bash
cat config/README.md | grep "^#" | head -10
```

3. ✅ Verify all sections present:
   - Configuration Location
   - Configuration Format
   - Setup Methods
   - Troubleshooting
   - Platform-Specific Paths

**Git Commit:**

```bash
git add config/README.md
git commit -m "docs(config): add MCP configuration guide

- Created comprehensive configuration documentation
- Documented setup methods (/pixel-setup vs manual)
- Added platform-specific Aseprite paths
- Included troubleshooting section
- Added advanced configuration options

Chunk: 2.4"
```

**Success Criteria:**
- Configuration README created
- All setup methods documented
- Platform-specific guidance provided
- Troubleshooting section complete

---

### Phase 2 Summary Check

Before proceeding to Phase 3, verify:

```bash
# Check bin/ directory
ls -lh bin/
# Should show:
# - aseprite-mcp (wrapper script)
# - aseprite-mcp-darwin-amd64
# - aseprite-mcp-darwin-arm64
# - aseprite-mcp-linux-amd64
# - aseprite-mcp-linux-arm64
# - aseprite-mcp-windows-amd64.exe

# Check config/ directory
ls -la config/
# Should show:
# - aseprite-mcp-config.json (template)
# - detect-aseprite.sh (executable)
# - README.md

# Test wrapper script
bin/aseprite-mcp --version || echo "Binary runs but may need Aseprite configured"

# Check git log
git log --oneline | head -8
# Should show 8 commits (Phase 1: 4, Phase 2: 4)
```

✅ **Phase 2 Complete** - MCP server integrated, ready for Skills development.

---

## Phase 3: Core Skills Development

**Goal:** Implement the four core Skills with SKILL.md files and supporting documentation.

### Chunk 3.1: Create pixel-art-creator Skill

**Objective:** Implement the pixel-art-creator Skill for basic sprite creation.

**Files to Create:**

1. **`skills/pixel-art-creator/SKILL.md`**

```markdown
---
name: Pixel Art Creator
description: Create new pixel art sprites from scratch with canvas creation, layer management, and basic drawing primitives. Use when the user wants to create a sprite, draw pixel art, make a new canvas, or mentions pixel dimensions like "64x64" or "32x32 sprite".
allowed-tools: Read, Bash, mcp__aseprite__create_canvas, mcp__aseprite__add_layer, mcp__aseprite__delete_layer, mcp__aseprite__get_sprite_info, mcp__aseprite__draw_pixels, mcp__aseprite__draw_line, mcp__aseprite__draw_rectangle, mcp__aseprite__draw_circle, mcp__aseprite__draw_contour, mcp__aseprite__fill_area, mcp__aseprite__set_palette, mcp__aseprite__get_palette
---

# Pixel Art Creator

## Overview

This Skill enables creation of new pixel art sprites with full control over canvas properties, layers, and basic drawing operations. It's the foundational Skill for all pixel art workflows.

## When to Use

Use this Skill when the user:
- Wants to "create a sprite" or "make pixel art"
- Mentions sprite dimensions (e.g., "64x64", "32 by 32", "128 pixels wide")
- Asks to "draw" basic shapes (pixels, lines, rectangles, circles)
- Needs to set up a canvas or layers
- Mentions color modes (RGB, Grayscale, Indexed)

**Trigger Keywords:** create, sprite, canvas, draw, pixel art, dimensions, layer, new sprite

## Instructions

### 1. Creating a Canvas

When the user requests a sprite, create the canvas first:

**Color Modes:**
- **RGB**: Full color (24-bit), best for modern pixel art
- **Grayscale**: Shades of gray only, for monochrome art
- **Indexed**: Limited palette (1-256 colors), for retro game art

**Recommended Sizes:**
- **Icons**: 16x16, 24x24, 32x32
- **Characters**: 32x32, 48x48, 64x64
- **Tiles**: 16x16, 32x32, 64x64
- **Scenes**: 128x128, 256x256, 320x240 (retro resolution)

Use `mcp__aseprite__create_canvas` with parameters:
- `width`: 1-65535 pixels
- `height`: 1-65535 pixels
- `color_mode`: "RGB", "Grayscale", or "Indexed"

### 2. Managing Layers

**Adding Layers:**
Use `mcp__aseprite__add_layer` to organize sprite elements:
- Background layer for solid colors or backgrounds
- Character layer for main subject
- Effects layer for highlights, shadows, outlines
- Detail layer for accessories or fine details

**Layer Workflow:**
1. Create canvas
2. Add named layers (e.g., "Background", "Character", "Effects")
3. Draw on specific layers
4. Use layers for organization and editing flexibility

**Important:** Cannot delete the last layer in a sprite.

### 3. Drawing Primitives

**Draw Individual Pixels:**
Use `mcp__aseprite__draw_pixels` for precise pixel placement:
- Supports batch operations (multiple pixels at once)
- Accepts colors in hex format (#RRGGBB) or palette indices
- Can snap to nearest palette color (for Indexed mode)

Example:
```
Draw pixels at coordinates:
- (10, 10) in red (#FF0000)
- (11, 10) in red (#FF0000)
- (12, 10) in red (#FF0000)
```

**Draw Lines:**
Use `mcp__aseprite__draw_line`:
- Straight lines between two points
- Useful for outlines, edges, connecting points

**Draw Rectangles:**
Use `mcp__aseprite__draw_rectangle`:
- Filled or outline mode
- Perfect for backgrounds, UI elements, platforms

**Draw Circles/Ellipses:**
Use `mcp__aseprite__draw_circle`:
- Filled or outline mode
- For round objects, planets, effects

**Draw Contours (Polylines/Polygons):**
Use `mcp__aseprite__draw_contour`:
- Connect multiple points
- Useful for complex shapes, terrain, irregular outlines

**Flood Fill:**
Use `mcp__aseprite__fill_area`:
- Fill connected pixels of the same color
- Like a paint bucket tool
- Great for filling large areas quickly

### 4. Working with Colors

**Setting Colors:**
- **Hex Format**: #RRGGBB (e.g., #FF0000 for red)
- **RGB**: Specify red, green, blue values (0-255)
- **Palette Index**: For Indexed mode (0-255)

**Common Colors:**
- Red: #FF0000
- Green: #00FF00
- Blue: #0000FF
- Yellow: #FFFF00
- Cyan: #00FFFF
- Magenta: #FF00FF
- Black: #000000
- White: #FFFFFF

**Color Palettes:**
For Indexed color mode, set the palette first:
- Use `mcp__aseprite__set_palette` with array of hex colors
- Example: ["#000000", "#FFFFFF", "#FF0000", "#00FF00"]

### 5. Workflow Best Practices

**Typical Creation Workflow:**
1. **Understand Requirements**
   - What size sprite?
   - What color mode?
   - What style (modern vs retro)?

2. **Create Canvas**
   - Choose appropriate dimensions
   - Select color mode (RGB for modern, Indexed for retro)

3. **Set Up Layers** (optional but recommended)
   - Add layers for organization
   - Name layers descriptively

4. **Set Palette** (for Indexed mode)
   - Define limited color palette
   - Use retro-appropriate palettes (NES: 16 colors, Game Boy: 4 colors)

5. **Draw Basic Shapes**
   - Start with outline
   - Fill with colors
   - Add details

6. **Verify Result**
   - Use `mcp__aseprite__get_sprite_info` to check properties
   - Describe what was created to user

7. **Prepare for Export** (if requested)
   - Hand off to pixel-art-exporter Skill

## Examples

### Example 1: Simple Sprite

**User Request:** "Create a 32x32 sprite with a red circle"

**Approach:**
1. Create 32x32 RGB canvas
2. Draw filled circle in center (radius 12) in red
3. Confirm creation

### Example 2: Layered Sprite

**User Request:** "Make a 64x64 sprite with a blue background and a yellow character"

**Approach:**
1. Create 64x64 RGB canvas
2. Add layer "Background"
3. Fill entire canvas with blue (#0000FF) on Background layer
4. Add layer "Character"
5. Draw yellow (#FFFF00) rectangle or shape on Character layer
6. Confirm layers and contents

### Example 3: Indexed Color Sprite

**User Request:** "Create a 48x48 Game Boy style sprite"

**Approach:**
1. Create 48x48 Indexed canvas
2. Set Game Boy palette: ["#0F380F", "#306230", "#8BAC0F", "#9BBC0F"]
3. Draw using 4-color palette
4. Use pixel-perfect drawing

### Example 4: Complex Shape

**User Request:** "Draw a pixelated tree on a 64x64 canvas"

**Approach:**
1. Create 64x64 RGB canvas
2. Draw brown (#8B4513) rectangle for trunk (using draw_rectangle)
3. Draw green (#228B22) irregular shape for foliage (using draw_contour or multiple rectangles)
4. Add details with individual pixels
5. Describe the tree to user

## Technical Details

### Canvas Properties
- **Width/Height**: 1-65535 pixels (practical limit usually <1024)
- **Color Modes**:
  - RGB: 24-bit color (16.7 million colors)
  - Grayscale: 8-bit (256 shades of gray)
  - Indexed: 1-256 colors from palette

### Drawing Coordinates
- Origin (0, 0) is top-left corner
- X increases rightward
- Y increases downward

### Performance
- Batch pixel operations when possible
- Drawing operations complete in <100ms typically
- Large canvases (>512x512) may take slightly longer

### Limitations
- Cannot create canvas smaller than 1x1
- Cannot create canvas larger than 65535x65535 (practical limit much lower)
- Cannot delete last layer
- Indexed mode palette limited to 256 colors maximum

## Common Patterns

### Pattern: Quick Sprite
For simple requests like "create a sprite":
- Default to 64x64 RGB canvas
- Add basic shape or placeholder
- Ask user for refinements

### Pattern: Retro Game Sprite
For retro-style requests:
- Use Indexed color mode
- Set appropriate palette (NES, Game Boy, C64, etc.)
- Use limited colors and pixel-perfect drawing

### Pattern: Icon Creation
For icon requests:
- Use 16x16, 24x24, or 32x32 dimensions
- RGB mode for modern icons
- Simple, recognizable shapes
- High contrast colors

## Integration with Other Skills

- **Hand off to pixel-art-animator** when user mentions "animation", "frames", or "movement"
- **Hand off to pixel-art-professional** when user asks for "dithering", "shading", or "palette refinement"
- **Hand off to pixel-art-exporter** when user asks to "export", "save", or mentions file formats

## Error Handling

**If canvas creation fails:**
- Check dimensions are valid (1-65535)
- Verify color mode is spelled correctly
- Suggest alternative dimensions if too large

**If drawing fails:**
- Verify coordinates are within canvas bounds
- Check color format is valid hex (#RRGGBB)
- For Indexed mode, ensure palette is set first

**If layer operations fail:**
- Cannot delete last layer (inform user)
- Layer names should be descriptive strings

## Success Indicators

You've successfully used this Skill when:
- Canvas created with correct dimensions and color mode
- Drawing operations complete without errors
- User can see or understand what was created
- Sprite is ready for next steps (animation, export, refinement)
```

2. **`skills/pixel-art-creator/reference.md`**

```markdown
# Pixel Art Creator - Technical Reference

## Color Mode Reference

### RGB Mode
- **Bits Per Pixel**: 24-bit (8 bits each for R, G, B)
- **Color Range**: 16,777,216 colors (256^3)
- **Use Cases**: Modern pixel art, unrestricted color palettes, photorealistic pixel art
- **Advantages**: No color limitations, easy to work with
- **Disadvantages**: Larger file sizes, not authentic to retro aesthetics

### Grayscale Mode
- **Bits Per Pixel**: 8-bit
- **Color Range**: 256 shades of gray (black to white)
- **Use Cases**: Monochrome art, vintage aesthetics, contrast studies
- **Advantages**: Simpler color management, smaller file sizes
- **Disadvantages**: No color information

### Indexed Mode
- **Bits Per Pixel**: 1-8 bit (depending on palette size)
- **Color Range**: 1-256 colors from defined palette
- **Use Cases**: Retro game art, limited palette challenges, authentic vintage look
- **Advantages**: Authentic retro aesthetic, enforced color constraints, smaller file sizes
- **Disadvantages**: Must define palette first, color substitution required

## Common Sprite Dimensions

### Game Console Standards

**Nintendo Entertainment System (NES)**
- Sprites: 8x8, 8x16 pixels
- Screen: 256x240 pixels
- Palette: 54 colors available, 4 colors per sprite

**Game Boy**
- Sprites: 8x8, 8x16 pixels
- Screen: 160x144 pixels
- Palette: 4 shades of green/gray

**Super Nintendo (SNES)**
- Sprites: 8x8 to 64x64 pixels (various sizes)
- Screen: 256x224 pixels
- Palette: 256 colors available, 15 colors per sprite

**Sega Genesis**
- Sprites: 8x8 to 32x32 pixels
- Screen: 320x224 pixels
- Palette: 512 colors available, 15 colors per sprite

### Modern Standards

**Mobile Icons**
- 16x16, 24x24, 32x32, 48x48, 64x64, 128x128

**Game Characters**
- Small: 32x32, 48x48
- Medium: 64x64, 96x96
- Large: 128x128, 256x256

**Tiles/Blocks**
- Standard: 16x16, 32x32
- Large: 64x64, 128x128

## Drawing Coordinate System

```
(0,0) ────────────► X
  │
  │
  │
  │
  ▼
  Y

Canvas Bounds:
- Top-Left: (0, 0)
- Top-Right: (width-1, 0)
- Bottom-Left: (0, height-1)
- Bottom-Right: (width-1, height-1)
```

## Color Format Specifications

### Hexadecimal Colors
Format: `#RRGGBB`
- RR: Red component (00-FF)
- GG: Green component (00-FF)
- BB: Blue component (00-FF)

Examples:
- Red: #FF0000
- Green: #00FF00
- Blue: #0000FF
- Cyan: #00FFFF
- Magenta: #FF00FF
- Yellow: #FFFF00
- Black: #000000
- White: #FFFFFF

### RGB Values
Format: (R, G, B)
- R: 0-255
- G: 0-255
- B: 0-255

Examples:
- Red: (255, 0, 0)
- Green: (0, 255, 0)
- Blue: (0, 0, 255)

## Tool Usage Patterns

### Batch Pixel Drawing
When drawing many pixels, batch them:

```
Good (batched):
draw_pixels([
  {x: 10, y: 10, color: "#FF0000"},
  {x: 11, y: 10, color: "#FF0000"},
  {x: 12, y: 10, color: "#FF0000"}
])

Less Efficient (individual):
draw_pixels({x: 10, y: 10, color: "#FF0000"})
draw_pixels({x: 11, y: 10, color: "#FF0000"})
draw_pixels({x: 12, y: 10, color: "#FF0000"})
```

### Shape Drawing Best Practices

**Rectangles:**
- Use for backgrounds, platforms, UI elements
- Filled mode: solid blocks
- Outline mode: frames, borders

**Circles:**
- Use for round objects, planets, bubbles
- Filled mode: solid circles
- Outline mode: rings, hoops

**Lines:**
- Use for edges, connections, rays
- Diagonal lines may have pixel stepping (antialiasing in professional Skill)

**Contours:**
- Use for irregular shapes, terrain, complex outlines
- Connect points in order
- Closed polygon: last point connects to first

## Performance Guidelines

### Operation Speeds (typical)
- Create canvas: <50ms
- Add layer: <20ms
- Draw pixels (batch of 100): <50ms
- Draw rectangle: <30ms
- Draw circle: <40ms
- Fill area: <100ms (depends on area size)

### Optimization Tips
1. Batch pixel operations when drawing many pixels
2. Use shapes instead of pixels when possible (faster)
3. Fill areas instead of drawing individual pixels
4. Use layers to organize work (not for performance, but workflow)

## Palette Examples

### Game Boy (4 colors)
```json
["#0F380F", "#306230", "#8BAC0F", "#9BBC0F"]
```
Darkest to lightest green

### NES (simplified 16-color palette)
```json
[
  "#000000", "#FCFCFC", "#F8F8F8", "#BCBCBC",
  "#7C7C7C", "#A4E4FC", "#3CBCFC", "#0078F8",
  "#0000FC", "#B8B8F8", "#6888FC", "#0058F8",
  "#0000BC", "#D8B8F8", "#9878F8", "#6844FC"
]
```

### Pico-8 (16-color palette)
```json
[
  "#000000", "#1D2B53", "#7E2553", "#008751",
  "#AB5236", "#5F574F", "#C2C3C7", "#FFF1E8",
  "#FF004D", "#FFA300", "#FFEC27", "#00E436",
  "#29ADFF", "#83769C", "#FF77A8", "#FFCCAA"
]
```

### C64 (Commodore 64, 16 colors)
```json
[
  "#000000", "#FFFFFF", "#880000", "#AAFFEE",
  "#CC44CC", "#00CC55", "#0000AA", "#EEEE77",
  "#DD8855", "#664400", "#FF7777", "#333333",
  "#777777", "#AAFF66", "#0088FF", "#BBBBBB"
]
```

## Layer Naming Conventions

**Descriptive Names:**
- "Background" - solid color or pattern behind main subject
- "Character" - main subject or character
- "Foreground" - objects in front of character
- "Effects" - highlights, shadows, particles
- "Outline" - borders or edge highlights
- "Details" - fine details, accessories

**Organization Tips:**
- Use consistent naming across projects
- Name layers by content, not by color
- Keep names short but descriptive
- Use layers even for simple sprites (good habit)

## Common Patterns

### Pixelated Circle (Manual)
For precise pixel placement in a circle:
- Radius 4: 5x5 bounding box, 13 pixels
- Radius 8: 9x9 bounding box, 57 pixels
- Use symmetry: draw quadrant, mirror to others

### Pixelated Line (Manual)
Bresenham's line algorithm (built into draw_line):
- Minimizes pixel stepping
- Creates clean diagonal lines
- No gaps or overlaps

### Color Ramps (Shading)
For smooth color transitions:
- 3-color ramp: shadow, base, highlight
- 5-color ramp: darkest, dark, base, light, lightest
- Use analogous colors for smooth transitions
```

3. **`skills/pixel-art-creator/examples.md`**

```markdown
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
```

**Commands to Run:**

```bash
# Create directory
mkdir -p skills/pixel-art-creator

# Create files (use Write tool for each)
# - skills/pixel-art-creator/SKILL.md
# - skills/pixel-art-creator/reference.md
# - skills/pixel-art-creator/examples.md
```

**Verification Steps:**

1. ✅ Verify all files created:
```bash
ls -la skills/pixel-art-creator/
# Should show: SKILL.md, reference.md, examples.md
```

2. ✅ Verify SKILL.md has valid frontmatter:
```bash
head -15 skills/pixel-art-creator/SKILL.md
# Should show YAML frontmatter with name, description, allowed-tools
```

3. ✅ Check YAML syntax:
```bash
# Extract and validate frontmatter (manual check)
sed -n '/^---$/,/^---$/p' skills/pixel-art-creator/SKILL.md
```

4. ✅ Verify allowed-tools includes MCP tools:
```bash
grep "mcp__aseprite__" skills/pixel-art-creator/SKILL.md | head -5
```

5. ✅ Verify description includes trigger keywords:
```bash
grep "description:" skills/pixel-art-creator/SKILL.md
```

6. ✅ Check file sizes are reasonable:
```bash
wc -l skills/pixel-art-creator/*
# SKILL.md: ~400-500 lines
# reference.md: ~200-300 lines
# examples.md: ~200-300 lines
```

**Git Commit:**

```bash
git add skills/pixel-art-creator/
git commit -m "feat(skills): add pixel-art-creator Skill

- Created SKILL.md with comprehensive instructions
- Added reference.md with technical specifications
- Added examples.md with 10 concrete examples
- Defined allowed-tools for canvas and drawing operations
- Included trigger keywords for autonomous invocation

Chunk: 3.1"
```

**Success Criteria:**
- All three files created in skills/pixel-art-creator/
- SKILL.md has valid YAML frontmatter
- Description includes specific trigger keywords
- Allowed-tools list includes all necessary MCP tools
- Examples cover common use cases
- Reference documentation is comprehensive

---

### Chunk 3.2: Create pixel-art-animator Skill

**Objective:** Implement the pixel-art-animator Skill for animation creation.

**Files to Create:**

1. **`skills/pixel-art-animator/SKILL.md`**

```markdown
---
name: Pixel Art Animator
description: Create and manage sprite animations with multiple frames, animation tags, frame durations, and linked cels. Use when the user wants to animate a sprite, mentions "animation", "frames", "walk cycle", "frame rate", or describes motion like "walking" or "running".
allowed-tools: Read, Bash, mcp__aseprite__add_frame, mcp__aseprite__delete_frame, mcp__aseprite__duplicate_frame, mcp__aseprite__set_frame_duration, mcp__aseprite__create_tag, mcp__aseprite__delete_tag, mcp__aseprite__link_cel, mcp__aseprite__get_sprite_info, mcp__aseprite__draw_pixels, mcp__aseprite__draw_line, mcp__aseprite__draw_rectangle, mcp__aseprite__draw_circle
---

# Pixel Art Animator

## Overview

This Skill handles all animation-related tasks for sprites, including frame management, timing, animation tags (sequences), and linked cels for efficient animation.

## When to Use

Use this Skill when the user:
- Wants to "animate" a sprite or "add animation"
- Mentions "frames", "keyframes", or "frame rate"
- Describes motion: "walk cycle", "run cycle", "idle animation", "attack animation"
- Asks about "animation tags", "loops", or "playback"
- Wants to create "sprite sheets" for animation (coordinate with exporter Skill)

**Trigger Keywords:** animate, animation, frames, walk cycle, run, idle, attack, loop, movement, motion

## Instructions

### 1. Understanding Animation Basics

**Frame**: A single image in an animation sequence. Sprites start with 1 frame.

**Frame Duration**: How long each frame displays (in milliseconds). Default: 100ms (10 FPS).

**Animation Tag**: Named sequence of frames (e.g., "walk" frames 1-4, "idle" frames 5-8).

**Linked Cel**: A cel that shares image data with another cel. Editing one updates all linked cels.

**Playback Direction**:
- **Forward**: Frames play 1 → 2 → 3 → 4, then loop
- **Reverse**: Frames play 4 → 3 → 2 → 1, then loop
- **Ping-pong**: Frames play 1 → 2 → 3 → 4 → 3 → 2 → 1, then loop

### 2. Creating Animation Frames

**Adding Frames:**
Use `mcp__aseprite__add_frame` to create new frames:
- Frames are numbered starting from 1
- New frames start as copies of the current frame (or blank)

**Common Frame Counts:**
- **Idle Animation**: 2-4 frames (subtle movement)
- **Walk Cycle**: 4-8 frames (legs alternate)
- **Run Cycle**: 6-8 frames (faster, exaggerated)
- **Attack Animation**: 3-6 frames (windup, strike, recovery)
- **Jump**: 4-6 frames (crouch, ascend, peak, descend, land)

**Duplicating Frames:**
Use `mcp__aseprite__duplicate_frame` to copy existing frames:
- Useful for creating variations
- Starting point for similar frames

**Deleting Frames:**
Use `mcp__aseprite__delete_frame` to remove frames:
- Cannot delete the last remaining frame
- Frames are renumbered after deletion

### 3. Setting Frame Timing

**Frame Duration:**
Use `mcp__aseprite__set_frame_duration`:
- Duration in milliseconds (ms)
- 100ms = 10 FPS
- 50ms = 20 FPS
- 33ms ≈ 30 FPS
- 16ms ≈ 60 FPS

**Common Timing Patterns:**

**Even Timing:**
All frames same duration. Simple and predictable.
- Walk cycle: all frames 100ms (smooth 10 FPS)

**Variable Timing:**
Different durations for emphasis.
- Idle: slow frames (150ms) for breathing effect
- Attack: fast strike (30ms), slower recovery (100ms)

**Hold Frames:**
Longer duration for dramatic effect.
- Jump peak: 200ms (hang time)
- Impact: 50ms (quick flash)

### 4. Creating Animation Tags

**Purpose:** Organize frames into named sequences.

Use `mcp__aseprite__create_tag`:
- Name: "walk", "idle", "attack", etc.
- From Frame: starting frame (1-indexed)
- To Frame: ending frame (inclusive)
- Direction: "forward", "reverse", or "ping-pong"

**Example Tags:**
- Tag "idle": frames 1-2, ping-pong direction
- Tag "walk": frames 3-6, forward direction
- Tag "attack": frames 7-10, forward direction

**Benefits:**
- Export specific animations separately
- Organize complex sprite sheets
- Game engines can reference tags

### 5. Using Linked Cels

**Purpose:** Share image data across frames to save memory and maintain consistency.

Use `mcp__aseprite__link_cel`:
- Useful when frame content doesn't change
- Example: background layer stays same across animation
- Editing one linked cel updates all

**When to Use:**
- Static background elements
- Character face in walk cycle (if body animates separately)
- Repeated frames in animation

**Workflow:**
1. Create frames with content
2. Link cels that should share data
3. Edit once, updates everywhere

### 6. Animation Workflows

**Workflow 1: Walk Cycle (4 frames)**

1. Create base sprite (or use existing)
2. Add 3 more frames (total 4)
3. Edit each frame for walk positions:
   - Frame 1: Left foot forward
   - Frame 2: Contact (both feet touching)
   - Frame 3: Right foot forward
   - Frame 4: Contact (both feet touching)
4. Set all frames to 100ms duration
5. Create tag "walk": frames 1-4, forward direction

**Workflow 2: Idle Animation (2 frames)**

1. Create base sprite
2. Add 1 more frame (total 2)
3. Slight variations:
   - Frame 1: Normal stance
   - Frame 2: Subtle movement (breathing, blinking)
4. Set frames to 500ms duration (slow, subtle)
5. Create tag "idle": frames 1-2, ping-pong direction

**Workflow 3: Complex Multi-Animation Sprite**

1. Create base sprite
2. Add enough frames for all animations:
   - Idle: 2 frames
   - Walk: 4 frames
   - Jump: 4 frames
   - Total: 10 frames
3. Arrange frames sequentially
4. Create separate tags:
   - Tag "idle": frames 1-2
   - Tag "walk": frames 3-6
   - Tag "jump": frames 7-10
5. Set appropriate frame durations per animation

## Examples

### Example 1: Simple 2-Frame Idle

**User Request:**
> "Add a simple idle animation to this sprite"

**Approach:**
1. Add 1 frame (now have frame 1 and 2)
2. On frame 2, make subtle change (move pixels up/down 1-2 pixels)
3. Set both frames to 500ms duration
4. Create tag "idle": frames 1-2, ping-pong direction
5. Result: gentle back-and-forth idle motion

### Example 2: 4-Frame Walk Cycle

**User Request:**
> "Create a walk cycle animation for this character"

**Approach:**
1. Add 3 frames (now have 1, 2, 3, 4)
2. Edit each frame for walk poses
3. Set all frames to 100ms duration
4. Create tag "walk": frames 1-4, forward direction
5. Result: looping walk animation at 10 FPS

### Example 3: Variable Timing Attack

**User Request:**
> "Add an attack animation with a fast strike"

**Approach:**
1. Add 5 frames (total 6 frames, assuming frame 1 exists)
2. Frame sequence:
   - Frame 2: Windup (slow)
   - Frame 3: Prepare (slow)
   - Frame 4: Strike (fast)
   - Frame 5: Follow-through (medium)
   - Frame 6: Recovery (slow)
3. Set durations:
   - Frames 2-3: 150ms (slow windup)
   - Frame 4: 30ms (fast strike)
   - Frame 5: 80ms (medium follow-through)
   - Frame 6: 120ms (slow recovery)
4. Create tag "attack": frames 2-6, forward direction

### Example 4: Linked Background

**User Request:**
> "Animate the character but keep the background static"

**Approach:**
1. Assume 2 layers: "Background", "Character"
2. Add frames for animation
3. Edit "Character" layer on each frame for animation
4. Link all cels on "Background" layer:
   - Link frame 2's background to frame 1
   - Link frame 3's background to frame 1
   - Link frame 4's background to frame 1
5. Background stays identical, character animates

## Technical Details

### Frame Numbering
- Frames are 1-indexed (first frame is frame 1)
- Adding frame at position N inserts at that position
- Deleting frame N renumbers subsequent frames

### Frame Duration Limits
- Minimum: 1ms (not recommended, too fast)
- Maximum: 65535ms (65.5 seconds)
- Practical range: 16ms (60 FPS) to 500ms (2 FPS)

### Animation Tag Limits
- No hard limit on number of tags
- Tags can overlap frames
- Tag names should be unique and descriptive

### Linked Cel Behavior
- Editing one linked cel updates all linked instances
- Unlinking creates independent copy
- Useful for memory optimization in large animations

### Performance
- Adding frame: <20ms
- Duplicating frame: <30ms
- Setting frame duration: <10ms
- Creating tag: <15ms
- Linking cel: <25ms

## Common Patterns

### Pattern: Breathing Idle
2 frames, ping-pong, slow timing (400-500ms)
- Frame 1: Normal
- Frame 2: Slight vertical shift (1-2 pixels)

### Pattern: Basic Walk
4 frames, forward, even timing (100ms)
- Frame 1: Left foot forward, right foot back
- Frame 2: Both feet together (contact)
- Frame 3: Right foot forward, left foot back
- Frame 4: Both feet together (contact)

### Pattern: Run Cycle
6-8 frames, forward, faster timing (60-80ms)
- More exaggerated poses than walk
- Longer strides
- Leaning forward

### Pattern: Jump Sequence
5-6 frames, forward, variable timing
- Frame 1: Crouch (100ms)
- Frame 2: Launch (50ms)
- Frame 3: Ascend (80ms)
- Frame 4: Peak (200ms) - hang time
- Frame 5: Descend (80ms)
- Frame 6: Land (100ms)

## Integration with Other Skills

- **Start with pixel-art-creator** to create base sprite before animating
- **Use pixel-art-professional** for polish (shading, antialiasing) after animation
- **Hand off to pixel-art-exporter** when user wants to export spritesheet or GIF

## Error Handling

**Cannot delete last frame:**
- Sprites must have at least 1 frame
- Inform user if they try to delete last frame

**Invalid frame numbers:**
- Frame numbers must be 1 to N (where N is total frames)
- Check bounds before operations

**Tag frame range errors:**
- "From" frame must be ≤ "To" frame
- Both must be valid frame numbers

## Success Indicators

You've successfully used this Skill when:
- Frames added/modified correctly
- Frame durations set appropriately for desired FPS
- Animation tags created with correct ranges
- User understands animation will loop or play as specified
- Animation is ready for export or further refinement
```

2. **`skills/pixel-art-animator/reference.md`**

```markdown
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
```

**Commands to Run:**

```bash
# Create directory
mkdir -p skills/pixel-art-animator

# Create files (use Write tool for each)
# - skills/pixel-art-animator/SKILL.md
# - skills/pixel-art-animator/reference.md
```

**Verification Steps:**

1. ✅ Verify files created:
```bash
ls -la skills/pixel-art-animator/
```

2. ✅ Verify SKILL.md frontmatter:
```bash
head -10 skills/pixel-art-animator/SKILL.md
```

3. ✅ Verify allowed-tools includes animation tools:
```bash
grep "mcp__aseprite__.*frame" skills/pixel-art-animator/SKILL.md
```

4. ✅ Check description has trigger keywords:
```bash
grep "description:" skills/pixel-art-animator/SKILL.md | grep -i "animate"
```

**Git Commit:**

```bash
git add skills/pixel-art-animator/
git commit -m "feat(skills): add pixel-art-animator Skill

- Created SKILL.md with animation instructions
- Added reference.md with frame rates and animation cycles
- Defined allowed-tools for frame and tag operations
- Included animation principles and best practices
- Added game engine integration guidance

Chunk: 3.2"
```

**Success Criteria:**
- Animator Skill files created
- SKILL.md covers frame management, timing, tags, linked cels
- Reference includes frame rate conversions and classic cycles
- Trigger keywords for autonomous invocation present

---

**Due to message length constraints, I'll note that the full implementation guide continues with:**

- Chunk 3.3: pixel-art-professional Skill (dithering, palettes, shading, antialiasing)
- Chunk 3.4: pixel-art-exporter Skill (export formats, spritesheets)
- Phase 4: All five slash commands
- Phase 5: Advanced refinements
- Phase 6: Testing procedures
- Phase 7: Documentation and release

**Each chunk follows the same pattern:**
1. Clear objective
2. Specific files to create
3. Exact content or detailed specifications
4. Verification steps
5. Git commit with descriptive message

Would you like me to continue with the remaining chunks in the next file, or would you prefer I complete this guide in a different format?

---

**End of Part 1 - Continue to IMPLEMENTATION_GUIDE_PART2.md for remaining chunks**
