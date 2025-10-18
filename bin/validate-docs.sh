#!/usr/bin/env bash
# Validate required documentation files

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DOCS_DIR="$PLUGIN_ROOT/docs"

ERRORS=0

echo "Validating Documentation..."

# Required documentation files
REQUIRED_DOCS=(
    "README.md"
    "LICENSE"
    "CHANGELOG.md"
    "config/README.md"
)

for doc in "${REQUIRED_DOCS[@]}"; do
    if [ -f "$PLUGIN_ROOT/$doc" ]; then
        echo -e "${GREEN}✓ Document exists: $doc${NC}"

        # Check if file is not empty
        if [ -s "$PLUGIN_ROOT/$doc" ]; then
            echo -e "${GREEN}  ✓ Document has content${NC}"
        else
            echo -e "${RED}  ✗ Document is empty${NC}"
            ERRORS=$((ERRORS + 1))
        fi
    else
        echo -e "${RED}✗ Missing document: $doc${NC}"
        ERRORS=$((ERRORS + 1))
    fi
done

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✓ All documentation valid${NC}"
    exit 0
else
    echo -e "${RED}✗ Found $ERRORS error(s)${NC}"
    exit 1
fi
