#!/usr/bin/env bash
# Validate Skills YAML frontmatter and structure

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILLS_DIR="$PLUGIN_ROOT/skills"

ERRORS=0

echo "Validating Skills..."

# Check if skills directory exists
if [ ! -d "$SKILLS_DIR" ]; then
    echo -e "${RED}✗ Skills directory not found: $SKILLS_DIR${NC}"
    exit 1
fi

# Find all SKILL.md files
while IFS= read -r skill_file; do
    skill_name=$(basename "$(dirname "$skill_file")")
    echo "  Checking: $skill_name"

    # Check YAML frontmatter exists
    if ! grep -q "^---$" "$skill_file"; then
        echo -e "${RED}    ✗ Missing YAML frontmatter${NC}"
        ERRORS=$((ERRORS + 1))
        continue
    fi

    # Extract frontmatter
    frontmatter=$(sed -n '/^---$/,/^---$/p' "$skill_file" | sed '1d;$d')

    # Check required fields
    if ! echo "$frontmatter" | grep -q "^name:"; then
        echo -e "${RED}    ✗ Missing 'name' field${NC}"
        ERRORS=$((ERRORS + 1))
    fi

    if ! echo "$frontmatter" | grep -q "^description:"; then
        echo -e "${RED}    ✗ Missing 'description' field${NC}"
        ERRORS=$((ERRORS + 1))
    fi

    if ! echo "$frontmatter" | grep -q "^allowed-tools:"; then
        echo -e "${RED}    ✗ Missing 'allowed-tools' field${NC}"
        ERRORS=$((ERRORS + 1))
    fi

    # Check file structure
    if ! grep -q "^# " "$skill_file"; then
        echo -e "${RED}    ✗ Missing H1 heading${NC}"
        ERRORS=$((ERRORS + 1))
    fi

    if [ $ERRORS -eq 0 ]; then
        echo -e "${GREEN}    ✓ Valid${NC}"
    fi

done < <(find "$SKILLS_DIR" -name "SKILL.md")

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✓ All Skills valid${NC}"
    exit 0
else
    echo -e "${RED}✗ Found $ERRORS error(s)${NC}"
    exit 1
fi
