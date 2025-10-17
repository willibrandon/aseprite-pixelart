# Aseprite Pixel Art Plugin - Implementation Guide (Part 5)

**Continuation of IMPLEMENTATION_GUIDE_PART4.md**

This document contains Phase 6 chunks (Testing and Polish).

- **Part 1**: Chunks 1.1-3.2 (Foundation, MCP Integration, Creator & Animator Skills)
- **Part 2**: Chunks 3.3-4.1 (Professional & Exporter Skills, /pixel-new command)
- **Part 3**: Chunks 4.2-4.5 (Remaining Slash Commands)
- **Part 4**: Phase 5 (Advanced Skills Refinement)
- **Part 5** (This Document): Phase 6 (Testing and Polish)
- **Part 6**: Phase 7 (Documentation and Release)

---

## Phase 6: Testing and Polish

### Chunk 6.1: Create test suite and validation scripts

**Objective**: Implement comprehensive testing for plugin components including Skills, Commands, and MCP server integration.

**Files to Create**:
1. `test-outputs/.gitkeep` (ensure directory tracked)
2. `bin/test-plugin.sh` (main test runner)
3. `bin/validate-skills.sh` (Skill validation)
4. `bin/validate-commands.sh` (Command validation)
5. `bin/test-mcp.sh` (MCP integration tests)

---

#### File 1: `bin/test-plugin.sh`

```bash
#!/bin/bash
# Main test runner for Aseprite Pixel Art Plugin

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "========================================="
echo "Aseprite Pixel Art Plugin - Test Suite"
echo "========================================="
echo

# Color output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

TESTS_PASSED=0
TESTS_FAILED=0

# Function to run test and track results
run_test() {
    local test_name="$1"
    local test_script="$2"

    echo -n "Running: $test_name... "

    if "$test_script"; then
        echo -e "${GREEN}PASS${NC}"
        ((TESTS_PASSED++))
        return 0
    else
        echo -e "${RED}FAIL${NC}"
        ((TESTS_FAILED++))
        return 1
    fi
}

# Test 1: Validate plugin structure
echo "Test Suite 1: Plugin Structure"
echo "-------------------------------"
run_test "Plugin manifest exists" "$SCRIPT_DIR/validate-plugin-structure.sh"
echo

# Test 2: Validate Skills
echo "Test Suite 2: Skills Validation"
echo "--------------------------------"
run_test "Skills YAML frontmatter" "$SCRIPT_DIR/validate-skills.sh"
echo

# Test 3: Validate Commands
echo "Test Suite 3: Commands Validation"
echo "----------------------------------"
run_test "Commands YAML frontmatter" "$SCRIPT_DIR/validate-commands.sh"
echo

# Test 4: MCP Server Integration
echo "Test Suite 4: MCP Integration"
echo "------------------------------"
run_test "MCP server binary" "$SCRIPT_DIR/test-mcp.sh"
echo

# Test 5: Documentation
echo "Test Suite 5: Documentation"
echo "---------------------------"
run_test "Required docs exist" "$SCRIPT_DIR/validate-docs.sh"
echo

# Summary
echo "========================================="
echo "Test Summary"
echo "========================================="
echo -e "Tests Passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "Tests Failed: ${RED}$TESTS_FAILED${NC}"
echo "========================================="

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}Some tests failed.${NC}"
    exit 1
fi
```

---

#### File 2: `bin/validate-skills.sh`

```bash
#!/bin/bash
# Validate all Skills have correct structure and valid YAML

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")\" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILLS_DIR="$PLUGIN_ROOT/skills"

ERRORS=0

echo "Validating Skills..."

# Check skills directory exists
if [ ! -d "$SKILLS_DIR" ]; then
    echo "ERROR: skills/ directory not found"
    exit 1
fi

# Get all skill directories
SKILL_DIRS=("$SKILLS_DIR"/*)

if [ ${#SKILL_DIRS[@]} -eq 0 ]; then
    echo "ERROR: No skills found in skills/"
    exit 1
fi

for skill_dir in "${SKILL_DIRS[@]}"; do
    if [ ! -d "$skill_dir" ]; then
        continue
    fi

    skill_name=$(basename "$skill_dir")
    echo "  Checking $skill_name..."

    # Check SKILL.md exists
    if [ ! -f "$skill_dir/SKILL.md" ]; then
        echo "    ERROR: SKILL.md not found"
        ((ERRORS++))
        continue
    fi

    # Extract and validate YAML frontmatter
    if ! head -n 20 "$skill_dir/SKILL.md" | grep -q "^---$"; then
        echo "    ERROR: YAML frontmatter not found"
        ((ERRORS++))
        continue
    fi

    # Extract frontmatter
    frontmatter=$(sed -n '/^---$/,/^---$/p' "$skill_dir/SKILL.md" | sed '1d;$d')

    # Check required fields
    if ! echo "$frontmatter" | grep -q "^name:"; then
        echo "    ERROR: 'name' field missing in frontmatter"
        ((ERRORS++))
    fi

    if ! echo "$frontmatter" | grep -q "^description:"; then
        echo "    ERROR: 'description' field missing in frontmatter"
        ((ERRORS++))
    fi

    if ! echo "$frontmatter" | grep -q "^allowed-tools:"; then
        echo "    ERROR: 'allowed-tools' field missing in frontmatter"
        ((ERRORS++))
    fi

    # Check description has reasonable length (at least 100 chars for good triggering)
    desc_length=$(echo "$frontmatter" | grep "^description:" | wc -c)
    if [ "$desc_length" -lt 100 ]; then
        echo "    WARNING: description seems short ($desc_length chars)"
    fi

    # Check for supporting files
    if [ -f "$skill_dir/reference.md" ]; then
        echo "    ✓ reference.md found"
    fi

    if [ -f "$skill_dir/examples.md" ]; then
        echo "    ✓ examples.md found"
    fi

    echo "    ✓ $skill_name validated"
done

if [ $ERRORS -eq 0 ]; then
    echo "All Skills validated successfully!"
    exit 0
else
    echo "Validation failed with $ERRORS errors"
    exit 1
fi
```

---

#### File 3: `bin/validate-commands.sh`

```bash
#!/bin/bash
# Validate all Commands have correct structure and valid YAML

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")\" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
COMMANDS_DIR="$PLUGIN_ROOT/commands"

ERRORS=0

echo "Validating Commands..."

# Check commands directory exists
if [ ! -d "$COMMANDS_DIR" ]; then
    echo "WARNING: commands/ directory not found (optional)"
    exit 0
fi

# Get all command files
COMMAND_FILES=("$COMMANDS_DIR"/*.md)

if [ ${#COMMAND_FILES[@]} -eq 0 ]; then
    echo "WARNING: No commands found in commands/"
    exit 0
fi

for cmd_file in "${COMMAND_FILES[@]}"; do
    if [ ! -f "$cmd_file" ]; then
        continue
    fi

    cmd_name=$(basename "$cmd_file" .md)
    echo "  Checking $cmd_name..."

    # Extract and validate YAML frontmatter
    if ! head -n 10 "$cmd_file" | grep -q "^---$"; then
        echo "    ERROR: YAML frontmatter not found"
        ((ERRORS++))
        continue
    fi

    # Extract frontmatter
    frontmatter=$(sed -n '/^---$/,/^---$/p' "$cmd_file" | sed '1d;$d')

    # Check required fields
    if ! echo "$frontmatter" | grep -q "^description:"; then
        echo "    ERROR: 'description' field missing in frontmatter"
        ((ERRORS++))
    fi

    # Check optional but recommended fields
    if echo "$frontmatter" | grep -q "^argument-hint:"; then
        echo "    ✓ argument-hint provided"
    fi

    if echo "$frontmatter" | grep -q "^allowed-tools:"; then
        echo "    ✓ allowed-tools specified"
    fi

    echo "    ✓ $cmd_name validated"
done

if [ $ERRORS -eq 0 ]; then
    echo "All Commands validated successfully!"
    exit 0
else
    echo "Validation failed with $ERRORS errors"
    exit 1
fi
```

---

#### File 4: `bin/test-mcp.sh`

```bash
#!/bin/bash
# Test MCP server integration

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")\" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
MCP_BINARY="$PLUGIN_ROOT/bin/aseprite-mcp"

ERRORS=0

echo "Testing MCP Server..."

# Test 1: Check MCP wrapper exists
if [ ! -f "$MCP_BINARY" ]; then
    echo "  ERROR: aseprite-mcp wrapper not found at bin/aseprite-mcp"
    ((ERRORS++))
else
    echo "  ✓ MCP wrapper exists"
fi

# Test 2: Check wrapper is executable
if [ -f "$MCP_BINARY" ] && [ ! -x "$MCP_BINARY" ]; then
    echo "  ERROR: aseprite-mcp wrapper is not executable"
    echo "    Run: chmod +x $MCP_BINARY"
    ((ERRORS++))
else
    echo "  ✓ MCP wrapper is executable"
fi

# Test 3: Check platform-specific binary exists
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
                echo "  ERROR: Unsupported macOS architecture: $ARCH"
                ((ERRORS++))
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
                echo "  ERROR: Unsupported Linux architecture: $ARCH"
                ((ERRORS++))
                ;;
        esac
        ;;
    MINGW*|MSYS*|CYGWIN*)
        BINARY="$SCRIPT_DIR/aseprite-mcp-windows-amd64.exe"
        ;;
    *)
        echo "  ERROR: Unsupported operating system: $OS"
        ((ERRORS++))
        ;;
esac

if [ -n "$BINARY" ]; then
    if [ ! -f "$BINARY" ]; then
        echo "  ERROR: Platform binary not found: $BINARY"
        ((ERRORS++))
    else
        echo "  ✓ Platform binary exists: $(basename "$BINARY")"
    fi

    if [ -f "$BINARY" ] && [ ! -x "$BINARY" ]; then
        echo "  ERROR: Platform binary is not executable"
        ((ERRORS++))
    else
        echo "  ✓ Platform binary is executable"
    fi
fi

# Test 4: Check .mcp.json exists
if [ ! -f "$PLUGIN_ROOT/.mcp.json" ]; then
    echo "  ERROR: .mcp.json configuration not found"
    ((ERRORS++))
else
    echo "  ✓ .mcp.json exists"

    # Validate JSON syntax
    if command -v python3 &> /dev/null; then
        if python3 -m json.tool "$PLUGIN_ROOT/.mcp.json" > /dev/null 2>&1; then
            echo "  ✓ .mcp.json is valid JSON"
        else
            echo "  ERROR: .mcp.json has invalid JSON syntax"
            ((ERRORS++))
        fi
    fi
fi

# Test 5: Attempt version check (may fail if Aseprite not configured)
echo "  Attempting version check..."
if "$MCP_BINARY" --version 2>/dev/null; then
    echo "  ✓ MCP server version check succeeded"
else
    echo "  WARNING: MCP server version check failed (Aseprite may not be configured)"
    echo "    This is expected if /pixel-setup has not been run yet"
fi

if [ $ERRORS -eq 0 ]; then
    echo "MCP Server tests passed!"
    exit 0
else
    echo "MCP Server tests failed with $ERRORS errors"
    exit 1
fi
```

---

#### File 5: `bin/validate-plugin-structure.sh`

```bash
#!/bin/bash
# Validate plugin directory structure

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")\" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

ERRORS=0

echo "Validating plugin structure..."

# Required files
required_files=(
    ".claude-plugin/plugin.json"
    ".mcp.json"
    "CLAUDE.md"
    "README.md"
    "LICENSE"
)

for file in "${required_files[@]}"; do
    if [ ! -f "$PLUGIN_ROOT/$file" ]; then
        echo "  ERROR: Missing required file: $file"
        ((ERRORS++))
    else
        echo "  ✓ $file exists"
    fi
done

# Required directories
required_dirs=(
    "skills"
    "bin"
    "config"
    "docs"
)

for dir in "${required_dirs[@]}"; do
    if [ ! -d "$PLUGIN_ROOT/$dir" ]; then
        echo "  ERROR: Missing required directory: $dir/"
        ((ERRORS++))
    else
        echo "  ✓ $dir/ exists"
    fi
done

# Validate plugin.json
if [ -f "$PLUGIN_ROOT/.claude-plugin/plugin.json" ]; then
    if command -v python3 &> /dev/null; then
        if python3 -m json.tool "$PLUGIN_ROOT/.claude-plugin/plugin.json" > /dev/null 2>&1; then
            echo "  ✓ plugin.json is valid JSON"
        else
            echo "  ERROR: plugin.json has invalid JSON syntax"
            ((ERRORS++))
        fi
    fi
fi

# Check for at least 4 skills
skill_count=$(find "$PLUGIN_ROOT/skills" -maxdepth 1 -type d -not -name "skills" | wc -l)
if [ "$skill_count" -lt 4 ]; then
    echo "  WARNING: Expected 4 skills, found $skill_count"
else
    echo "  ✓ Found $skill_count skills"
fi

if [ $ERRORS -eq 0 ]; then
    echo "Plugin structure validation passed!"
    exit 0
else
    echo "Plugin structure validation failed with $ERRORS errors"
    exit 1
fi
```

---

#### File 6: `bin/validate-docs.sh`

```bash
#!/bin/bash
# Validate required documentation exists

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")\" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DOCS_DIR="$PLUGIN_ROOT/docs"

ERRORS=0

echo "Validating documentation..."

# Required docs
required_docs=(
    "DESIGN.md"
    "PRD.md"
    "IMPLEMENTATION_GUIDE.md"
)

for doc in "${required_docs[@]}"; do
    if [ ! -f "$DOCS_DIR/$doc" ]; then
        echo "  ERROR: Missing required doc: docs/$doc"
        ((ERRORS++))
    else
        echo "  ✓ $doc exists"
    fi
done

# Check README.md
if [ -f "$PLUGIN_ROOT/README.md" ]; then
    echo "  ✓ README.md exists"

    # Check README has reasonable content (at least 500 chars)
    readme_size=$(wc -c < "$PLUGIN_ROOT/README.md")
    if [ "$readme_size" -lt 500 ]; then
        echo "  WARNING: README.md seems short ($readme_size bytes)"
    fi
fi

# Check CLAUDE.md
if [ -f "$PLUGIN_ROOT/CLAUDE.md" ]; then
    echo "  ✓ CLAUDE.md exists"
fi

if [ $ERRORS -eq 0 ]; then
    echo "Documentation validation passed!"
    exit 0
else
    echo "Documentation validation failed with $ERRORS errors"
    exit 1
fi
```

---

### Verification Steps

```bash
# 1. Make all test scripts executable
chmod +x bin/*.sh

# 2. Run main test suite
./bin/test-plugin.sh

# Should show test results for all suites

# 3. Run individual test scripts
./bin/validate-skills.sh
./bin/validate-commands.sh
./bin/test-mcp.sh

# Each should pass

# 4. Verify test-outputs directory tracked
ls -la test-outputs/.gitkeep

# Should exist
```

### Git Commit

```bash
git add bin/*.sh test-outputs/.gitkeep
git commit -m "feat(testing): add comprehensive test suite

- Create main test runner (test-plugin.sh)
- Add Skills validation script
- Add Commands validation script
- Add MCP integration tests
- Add plugin structure validation
- Add documentation validation
- Ensure test-outputs directory tracked
- Make all scripts executable
- Implement colored output for test results

Chunk: 6.1"
```

### Success Criteria

- [ ] `bin/test-plugin.sh` main test runner created
- [ ] `bin/validate-skills.sh` validates all Skills
- [ ] `bin/validate-commands.sh` validates all Commands
- [ ] `bin/test-mcp.sh` tests MCP server integration
- [ ] `bin/validate-plugin-structure.sh` checks required files
- [ ] `bin/validate-docs.sh` validates documentation
- [ ] All scripts are executable
- [ ] `test-outputs/.gitkeep` ensures directory tracking
- [ ] Tests provide clear pass/fail output
- [ ] Verification steps pass
- [ ] Git commit with "Chunk: 6.1" footer

---

### Chunk 6.2: Polish plugin metadata and configuration

**Objective**: Refine plugin.json, .mcp.json, and other configuration files for production quality.

**Files to Modify**:
1. `.claude-plugin/plugin.json`
2. `.mcp.json`
3. `config/aseprite-mcp-config.json` (template)

**Files to Create**:
4. `.claude-plugin/icon.png` (plugin icon, 256x256)

---

#### Enhancement 1: `.claude-plugin/plugin.json`

**Current state**: Basic structure with minimal metadata

**Enhanced version:**
```json
{
  "name": "aseprite-pixelart",
  "displayName": "Aseprite Pixel Art",
  "version": "1.0.0",
  "description": "Create, animate, and export pixel art using Aseprite through natural language and commands. Supports retro palettes, animation, dithering, and game engine export.",
  "author": "Your Name",
  "license": "MIT",
  "homepage": "https://github.com/yourusername/aseprite-pixelart-plugin",
  "repository": {
    "type": "git",
    "url": "https://github.com/yourusername/aseprite-pixelart-plugin.git"
  },
  "bugs": {
    "url": "https://github.com/yourusername/aseprite-pixelart-plugin/issues"
  },
  "keywords": [
    "pixel art",
    "aseprite",
    "sprite",
    "animation",
    "game dev",
    "retro",
    "8-bit",
    "16-bit",
    "graphics",
    "tileset"
  ],
  "engines": {
    "claude-code": ">=1.0.0"
  },
  "categories": [
    "Graphics",
    "Game Development",
    "Creative Tools"
  ],
  "icon": "icon.png"
}
```

**Changes:**
- Added comprehensive description
- Added repository and bug tracking URLs
- Added keywords for discoverability
- Added categories
- Added icon reference
- Added engine requirements

---

#### Enhancement 2: `.mcp.json`

**Current state**: Basic MCP server configuration

**Enhanced version:**
```json
{
  "mcpServers": {
    "aseprite": {
      "command": "${CLAUDE_PLUGIN_ROOT}/bin/aseprite-mcp",
      "args": [],
      "env": {
        "ASEPRITE_MCP_CONFIG": "${HOME}/.config/aseprite-mcp/config.json"
      },
      "disabled": false,
      "alwaysAllow": [],
      "description": "Aseprite MCP Server - Provides pixel art creation, animation, and export capabilities"
    }
  }
}
```

**Changes:**
- Added `disabled` flag for easy toggle
- Added `alwaysAllow` for future tool permissions
- Added `description` for clarity
- Use `$HOME` for cross-platform config path

---

#### Enhancement 3: `config/aseprite-mcp-config.json`

**Enhanced template:**
```json
{
  "aseprite_path": "",
  "temp_dir": "",
  "timeout": 30,
  "log_level": "info",
  "log_file": "",
  "enable_timing": false,
  "_comments": {
    "aseprite_path": "REQUIRED: Path to Aseprite executable. Use /pixel-setup to configure automatically.",
    "temp_dir": "Optional: Temporary directory for MCP operations. Defaults to system temp if empty.",
    "timeout": "Optional: Command timeout in seconds. Default: 30.",
    "log_level": "Optional: Logging verbosity (debug, info, warn, error). Default: info.",
    "log_file": "Optional: Path to log file. Leave empty for no file logging.",
    "enable_timing": "Optional: Log operation timings for performance analysis. Default: false."
  },
  "_examples": {
    "aseprite_path_macos": "/Applications/Aseprite.app/Contents/MacOS/aseprite",
    "aseprite_path_linux": "/usr/bin/aseprite",
    "aseprite_path_windows": "C:\\\\Program Files\\\\Aseprite\\\\Aseprite.exe",
    "temp_dir_example": "/tmp/aseprite-mcp",
    "log_file_example": "/tmp/aseprite-mcp.log"
  }
}
```

**Changes:**
- Added inline documentation via `_comments`
- Added platform-specific examples via `_examples`
- Clarified required vs optional fields

---

#### Creation 4: `.claude-plugin/icon.png`

**Specifications:**
- Size: 256x256 pixels
- Format: PNG with transparency
- Style: Pixel art aesthetic
- Content: Aseprite logo + pixel art brush/palette imagery
- Colors: Vibrant, recognizable (blues, purples, yellows)

**Instructions:**
Since we cannot create actual image files in this implementation guide, include instructions:

```markdown
Create plugin icon (256x256 PNG):

1. Use Aseprite itself to create the icon (meta!)
2. Create 256x256 RGB canvas
3. Design icon featuring:
   - Aseprite-inspired colors (blues/purples)
   - Pixel art aesthetic (chunky pixels, dithering)
   - Recognizable imagery (paintbrush, palette, grid)
4. Export as PNG with transparency
5. Save to .claude-plugin/icon.png

Alternatively:
- Use provided icon template from repository
- Commission pixel artist for professional icon
- Generate with AI tools and pixelate/downscale
```

**Placeholder creation:**
For now, create a text file documenting icon requirements:

`.claude-plugin/ICON_REQUIREMENTS.txt`:
```
Plugin Icon Requirements
========================

Specifications:
- Dimensions: 256x256 pixels
- Format: PNG with transparency
- File: .claude-plugin/icon.png

Design Guidelines:
- Pixel art style (matching plugin theme)
- Aseprite brand colors (optional, if permitted)
- Recognizable at small sizes (64x64, 32x32)
- Clear, simple design
- High contrast for visibility

Suggested Elements:
- Paint brush or pencil
- Color palette
- Pixel grid
- Sprite silhouette
- Animation frames hint

Creation Tools:
- Aseprite (recommended, meta approach)
- GIMP or Photoshop with pixel art brushes
- Online pixel art tools (Piskel, Pixilart)
- Commission from pixel artist

Once created, replace this file with actual icon.png
```

---

### Verification Steps

```bash
# 1. Validate plugin.json
python3 -m json.tool .claude-plugin/plugin.json > /dev/null && echo "✓ plugin.json valid"

# 2. Validate .mcp.json
python3 -m json.tool .mcp.json > /dev/null && echo "✓ .mcp.json valid"

# 3. Validate config template
python3 -m json.tool config/aseprite-mcp-config.json > /dev/null && echo "✓ config template valid"

# 4. Check icon placeholder
ls -la .claude-plugin/ICON_REQUIREMENTS.txt

# Should exist (will be replaced with actual icon.png later)

# 5. Check all required fields in plugin.json
grep -q '"name"' .claude-plugin/plugin.json && echo "✓ name field present"
grep -q '"version"' .claude-plugin/plugin.json && echo "✓ version field present"
grep -q '"description"' .claude-plugin/plugin.json && echo "✓ description field present"
```

### Git Commit

```bash
git add .claude-plugin/ .mcp.json config/aseprite-mcp-config.json
git commit -m "feat(config): polish plugin metadata and configuration

- Enhance plugin.json with comprehensive metadata
- Add repository, homepage, and bug tracking URLs
- Include keywords and categories for discoverability
- Polish .mcp.json with description and flags
- Improve config template with inline documentation
- Add platform-specific configuration examples
- Create icon requirements placeholder
- Validate all JSON files

Chunk: 6.2"
```

### Success Criteria

- [ ] `plugin.json` has complete metadata
- [ ] Repository and homepage URLs added (update with actual values)
- [ ] Keywords and categories improve discoverability
- [ ] `.mcp.json` has clear description
- [ ] Config template has inline documentation
- [ ] Platform-specific examples provided
- [ ] Icon requirements documented
- [ ] All JSON files are valid
- [ ] Verification steps pass
- [ ] Git commit with "Chunk: 6.2" footer

---

### Chunk 6.3: Final integration testing and bug fixes

**Objective**: Perform end-to-end testing of complete plugin, identify and fix any issues.

**Files to Create**:
1. `docs/TESTING_CHECKLIST.md` - Comprehensive testing checklist
2. `docs/KNOWN_ISSUES.md` - Document any known limitations

---

#### File 1: `docs/TESTING_CHECKLIST.md`

```markdown
# Testing Checklist

Comprehensive testing checklist for Aseprite Pixel Art Plugin.

## Pre-Testing Setup

- [ ] Aseprite installed and accessible
- [ ] Run `/pixel-setup` to configure plugin
- [ ] Verify MCP server health check passes
- [ ] Confirm all test scripts pass: `./bin/test-plugin.sh`

## Skill Testing

### pixel-art-creator Skill

- [ ] **Test 1: Basic sprite creation**
  - Request: "Create a 64x64 sprite"
  - Expected: 64x64 RGB canvas created
  - Verify: Canvas size correct, color mode RGB

- [ ] **Test 2: Indexed color sprite**
  - Request: "Create a 32x32 Game Boy sprite"
  - Expected: 32x32 Indexed canvas with GB palette
  - Verify: Palette has 4 Game Boy colors

- [ ] **Test 3: Drawing shapes**
  - Request: "Draw a red circle in the center"
  - Expected: Red circle drawn at canvas center
  - Verify: Circle is properly formed, correct color

- [ ] **Test 4: Layer management**
  - Request: "Create a sprite with background and character layers"
  - Expected: Canvas with 2 named layers
  - Verify: Layers exist and are named correctly

- [ ] **Test 5: Complex shape**
  - Request: "Draw a pixelated tree"
  - Expected: Tree-like shape drawn
  - Verify: Recognizable as tree, appropriate colors

### pixel-art-animator Skill

- [ ] **Test 6: Add frames**
  - Request: "Add 3 frames"
  - Expected: Total frames increases by 3
  - Verify: Frame count correct

- [ ] **Test 7: Walk cycle**
  - Request: "Create a 4-frame walk cycle"
  - Expected: 4 frames with walk animation
  - Verify: Frames show walking motion

- [ ] **Test 8: Frame timing**
  - Request: "Set all frames to 100ms duration"
  - Expected: All frames have 100ms timing
  - Verify: Frame durations updated

- [ ] **Test 9: Animation tag**
  - Request: "Create animation tag 'walk' for frames 1-4"
  - Expected: Tag created with correct range
  - Verify: Tag exists with proper settings

- [ ] **Test 10: Linked cels**
  - Request: "Link the background layer across all frames"
  - Expected: Background cels linked
  - Verify: Editing one cel updates all

### pixel-art-professional Skill

- [ ] **Test 11: Apply dithering**
  - Request: "Apply Floyd-Steinberg dithering"
  - Expected: Sprite shows dithering pattern
  - Verify: Visual quality maintained

- [ ] **Test 12: Palette optimization**
  - Request: "Reduce to 16 colors"
  - Expected: Palette reduced to 16 colors
  - Verify: Color count correct, quality acceptable

- [ ] **Test 13: Add shading**
  - Request: "Add shading with light from top-left"
  - Expected: Shadows on bottom-right, highlights on top-left
  - Verify: Shading direction correct, looks three-dimensional

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
```

---

#### File 2: `docs/KNOWN_ISSUES.md`

```markdown
# Known Issues and Limitations

This document tracks known issues, limitations, and workarounds for the Aseprite Pixel Art Plugin.

**Version:** 1.0.0
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

1. Check if it's already reported: [GitHub Issues](https://github.com/yourusername/aseprite-pixelart-plugin/issues)
2. Verify it's reproducible
3. Note your platform, Aseprite version, plugin version
4. Include steps to reproduce
5. Report at: https://github.com/yourusername/aseprite-pixelart-plugin/issues/new

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
```

---

### Verification Steps

```bash
# 1. Review testing checklist
wc -l docs/TESTING_CHECKLIST.md

# Should be comprehensive (400+ lines)

# 2. Run through critical tests manually
# (Execute tests 1, 6, 11, 16, 21 from checklist)

# 3. Verify known issues documented
grep "##" docs/KNOWN_ISSUES.md

# Should show organized sections

# 4. Run full test suite
./bin/test-plugin.sh

# Should pass all automated tests

# 5. Check for undocumented issues
# (Manual review of functionality)
```

### Git Commit

```bash
git add docs/TESTING_CHECKLIST.md docs/KNOWN_ISSUES.md
git commit -m "feat(testing): add testing checklist and known issues

- Create comprehensive testing checklist
- Document all Skills tests (20 tests)
- Document all Commands tests (18 tests)
- Include integration and workflow tests
- Add error handling tests
- Document cross-platform testing requirements
- Create known issues tracker
- Document platform-specific limitations
- List functional limitations and workarounds
- Provide issue reporting workflow

Chunk: 6.3"
```

### Success Criteria

- [ ] `TESTING_CHECKLIST.md` comprehensive (45+ tests)
- [ ] All Skill tests documented
- [ ] All Command tests documented
- [ ] Integration workflows included
- [ ] Error handling tests specified
- [ ] Cross-platform testing covered
- [ ] `KNOWN_ISSUES.md` documents limitations
- [ ] Platform-specific issues listed
- [ ] Workarounds provided where possible
- [ ] Issue reporting process documented
- [ ] Verification steps pass
- [ ] Git commit with "Chunk: 6.3" footer

---

**End of Part 5**

Continue to IMPLEMENTATION_GUIDE_PART6.md for Phase 7 (Documentation and Release).
