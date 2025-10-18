#!/usr/bin/env bash
# Test runner for pixel-plugin
# Runs all validation scripts and reports results

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Pixel Plugin Test Suite${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo ""

# Track results
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Function to run a test script
run_test() {
    local test_name="$1"
    local test_script="$2"

    TOTAL_TESTS=$((TOTAL_TESTS + 1))

    echo -e "${YELLOW}▶ Running: ${test_name}${NC}"

    if "$test_script"; then
        echo -e "${GREEN}✓ ${test_name} passed${NC}"
        PASSED_TESTS=$((PASSED_TESTS + 1))
        echo ""
        return 0
    else
        echo -e "${RED}✗ ${test_name} failed${NC}"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        echo ""
        return 1
    fi
}

# Change to plugin root
cd "$PLUGIN_ROOT"

# Run all validation tests
run_test "Plugin Structure Validation" "$SCRIPT_DIR/validate-plugin-structure.sh" || true
run_test "Skills Validation" "$SCRIPT_DIR/validate-skills.sh" || true
run_test "Commands Validation" "$SCRIPT_DIR/validate-commands.sh" || true
run_test "Documentation Validation" "$SCRIPT_DIR/validate-docs.sh" || true
run_test "MCP Integration Test" "$SCRIPT_DIR/test-mcp.sh" || true

# Print summary
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  Test Summary${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "Total Tests:  ${TOTAL_TESTS}"
echo -e "${GREEN}Passed:       ${PASSED_TESTS}${NC}"
echo -e "${RED}Failed:       ${FAILED_TESTS}${NC}"
echo ""

if [ "$FAILED_TESTS" -eq 0 ]; then
    echo -e "${GREEN}✓ All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}✗ Some tests failed${NC}"
    exit 1
fi
