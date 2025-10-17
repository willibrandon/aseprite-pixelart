#!/usr/bin/env bash
# Validate Commands YAML frontmatter and structure

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
COMMANDS_DIR="$PLUGIN_ROOT/commands"

ERRORS=0

echo "Validating Commands..."

# Check if commands directory exists
if [ ! -d "$COMMANDS_DIR" ]; then
    echo -e "${RED}✗ Commands directory not found: $COMMANDS_DIR${NC}"
    exit 1
fi

# Find all command markdown files
while IFS= read -r command_file; do
    command_name=$(basename "$command_file" .md)
    echo "  Checking: $command_name"

    # Check YAML frontmatter exists
    if ! grep -q "^---$" "$command_file"; then
        echo -e "${RED}    ✗ Missing YAML frontmatter${NC}"
        ERRORS=$((ERRORS + 1))
        continue
    fi

    # Extract frontmatter
    frontmatter=$(sed -n '/^---$/,/^---$/p' "$command_file" | sed '1d;$d')

    # Check required fields
    if ! echo "$frontmatter" | grep -q "^description:"; then
        echo -e "${RED}    ✗ Missing 'description' field${NC}"
        ERRORS=$((ERRORS + 1))
    fi

    if ! echo "$frontmatter" | grep -q "^allowed-tools:"; then
        echo -e "${RED}    ✗ Missing 'allowed-tools' field${NC}"
        ERRORS=$((ERRORS + 1))
    fi

    if [ $ERRORS -eq 0 ]; then
        echo -e "${GREEN}    ✓ Valid${NC}"
    fi

done < <(find "$COMMANDS_DIR" -name "*.md")

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✓ All Commands valid${NC}"
    exit 0
else
    echo -e "${RED}✗ Found $ERRORS error(s)${NC}"
    exit 1
fi
