#!/usr/bin/env bash
# Test MCP server integration and binary availability

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
BIN_DIR="$PLUGIN_ROOT/bin"

ERRORS=0

echo "Testing MCP Integration..."

# Check .mcp.json exists
if [ ! -f "$PLUGIN_ROOT/.mcp.json" ]; then
    echo -e "${RED}✗ .mcp.json not found${NC}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✓ .mcp.json exists${NC}"

    # Validate JSON
    if python3 -m json.tool "$PLUGIN_ROOT/.mcp.json" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ .mcp.json is valid JSON${NC}"
    else
        echo -e "${RED}✗ .mcp.json is invalid JSON${NC}"
        ERRORS=$((ERRORS + 1))
    fi
fi

# Check pixel-mcp wrapper exists
if [ ! -f "$BIN_DIR/pixel-mcp" ]; then
    echo -e "${RED}✗ pixel-mcp wrapper not found${NC}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✓ pixel-mcp wrapper exists${NC}"

    # Check if executable
    if [ -x "$BIN_DIR/pixel-mcp" ]; then
        echo -e "${GREEN}✓ pixel-mcp is executable${NC}"
    else
        echo -e "${RED}✗ pixel-mcp is not executable${NC}"
        ERRORS=$((ERRORS + 1))
    fi
fi

# Detect platform
OS="unknown"
ARCH="unknown"

case "$(uname -s)" in
    Darwin*)
        OS="darwin"
        ;;
    Linux*)
        OS="linux"
        ;;
    MINGW*|MSYS*|CYGWIN*)
        OS="windows"
        ;;
esac

case "$(uname -m)" in
    x86_64|amd64)
        ARCH="amd64"
        ;;
    arm64|aarch64)
        ARCH="arm64"
        ;;
esac

echo "  Platform: $OS-$ARCH"

# Check platform-specific binary exists
BINARY_NAME="pixel-mcp-${OS}-${ARCH}"
if [ "$OS" = "windows" ]; then
    BINARY_NAME="${BINARY_NAME}.exe"
fi

if [ ! -f "$BIN_DIR/$BINARY_NAME" ]; then
    echo -e "${RED}✗ Platform binary not found: $BINARY_NAME${NC}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✓ Platform binary exists: $BINARY_NAME${NC}"

    # Check if executable (not on Windows)
    if [ "$OS" != "windows" ]; then
        if [ -x "$BIN_DIR/$BINARY_NAME" ]; then
            echo -e "${GREEN}✓ Binary is executable${NC}"
        else
            echo -e "${RED}✗ Binary is not executable${NC}"
            ERRORS=$((ERRORS + 1))
        fi
    fi
fi

# Check config directory
if [ ! -d "$PLUGIN_ROOT/config" ]; then
    echo -e "${RED}✗ config directory not found${NC}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✓ config directory exists${NC}"
fi

# Check config template
if [ ! -f "$PLUGIN_ROOT/config/pixel-mcp-config.json" ]; then
    echo -e "${RED}✗ pixel-mcp-config.json template not found${NC}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✓ pixel-mcp-config.json template exists${NC}"

    # Validate JSON
    if python3 -m json.tool "$PLUGIN_ROOT/config/pixel-mcp-config.json" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ Config template is valid JSON${NC}"
    else
        echo -e "${RED}✗ Config template is invalid JSON${NC}"
        ERRORS=$((ERRORS + 1))
    fi
fi

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✓ MCP integration valid${NC}"
    exit 0
else
    echo -e "${RED}✗ Found $ERRORS error(s)${NC}"
    exit 1
fi
