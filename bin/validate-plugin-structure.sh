#!/usr/bin/env bash
# Validate plugin directory structure and required files

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

ERRORS=0

echo "Validating Plugin Structure..."

# Required directories
REQUIRED_DIRS=(
    ".claude-plugin"
    "skills"
    "commands"
    "bin"
    "config"
    "docs"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    if [ -d "$PLUGIN_ROOT/$dir" ]; then
        echo -e "${GREEN}✓ Directory exists: $dir${NC}"
    else
        echo -e "${RED}✗ Missing directory: $dir${NC}"
        ERRORS=$((ERRORS + 1))
    fi
done

# Required files
REQUIRED_FILES=(
    ".claude-plugin/plugin.json"
    ".mcp.json"
    "README.md"
    "LICENSE"
    "CHANGELOG.md"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$PLUGIN_ROOT/$file" ]; then
        echo -e "${GREEN}✓ File exists: $file${NC}"
    else
        echo -e "${RED}✗ Missing file: $file${NC}"
        ERRORS=$((ERRORS + 1))
    fi
done

# Check Skills exist
SKILL_COUNT=$(find "$PLUGIN_ROOT/skills" -name "SKILL.md" 2>/dev/null | wc -l)
if [ "$SKILL_COUNT" -gt 0 ]; then
    echo -e "${GREEN}✓ Found $SKILL_COUNT Skill(s)${NC}"
else
    echo -e "${RED}✗ No Skills found${NC}"
    ERRORS=$((ERRORS + 1))
fi

# Check Commands exist
COMMAND_COUNT=$(find "$PLUGIN_ROOT/commands" -name "*.md" 2>/dev/null | wc -l)
if [ "$COMMAND_COUNT" -gt 0 ]; then
    echo -e "${GREEN}✓ Found $COMMAND_COUNT Command(s)${NC}"
else
    echo -e "${RED}✗ No Commands found${NC}"
    ERRORS=$((ERRORS + 1))
fi

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✓ Plugin structure valid${NC}"
    exit 0
else
    echo -e "${RED}✗ Found $ERRORS error(s)${NC}"
    exit 1
fi
