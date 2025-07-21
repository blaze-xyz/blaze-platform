#!/bin/bash

# Claude MCP Installation Script
# This script reads the MCP list and installs them using the Claude CLI

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo -e "${RED}Error: .env file not found!${NC}"
    echo "Please copy .env.example to .env and fill in your credentials."
    exit 1
fi

# Load environment variables
export $(cat .env | grep -v '^#' | xargs)

# Check if claude CLI is installed
if ! command -v claude &> /dev/null; then
    echo -e "${RED}Error: claude CLI not found!${NC}"
    echo "Please install the Claude CLI first."
    exit 1
fi

# Check if jq is installed for JSON parsing
if ! command -v jq &> /dev/null; then
    echo -e "${RED}Error: jq not found!${NC}"
    echo "Please install jq first: brew install jq"
    exit 1
fi

echo -e "${GREEN}Installing Claude MCPs for Blaze...${NC}"
echo "=================================="

# Read MCPs from JSON file
MCPS=$(cat mcp-list.json | jq -r '.mcps[] | @base64')

# Counter for tracking
TOTAL=0
SUCCESS=0
FAILED=0

# Process each MCP
for mcp in $MCPS; do
    # Decode the MCP data
    MCP_DATA=$(echo "$mcp" | base64 --decode)
    
    # Extract MCP details
    NAME=$(echo "$MCP_DATA" | jq -r '.name')
    TYPE=$(echo "$MCP_DATA" | jq -r '.type')
    DESCRIPTION=$(echo "$MCP_DATA" | jq -r '.description')
    CONFIG=$(echo "$MCP_DATA" | jq -r '.config')
    
    TOTAL=$((TOTAL + 1))
    
    echo ""
    echo -e "${YELLOW}Installing MCP: $NAME${NC}"
    echo "Type: $TYPE"
    echo "Description: $DESCRIPTION"
    
    # Substitute environment variables in config
    CONFIG_WITH_ENV=$(echo "$CONFIG" | envsubst)
    
    # Install the MCP using claude CLI
    if claude mcp add "$NAME" --type "$TYPE" --config "$CONFIG_WITH_ENV" 2>/dev/null; then
        echo -e "${GREEN}✓ Successfully installed $NAME${NC}"
        SUCCESS=$((SUCCESS + 1))
    else
        echo -e "${RED}✗ Failed to install $NAME${NC}"
        FAILED=$((FAILED + 1))
        
        # Try to provide helpful error message
        if [ -z "${!NAME}" ]; then
            echo -e "${RED}  Hint: Environment variable for $NAME might be missing${NC}"
        fi
    fi
done

echo ""
echo "=================================="
echo -e "${GREEN}Installation Summary:${NC}"
echo "Total MCPs: $TOTAL"
echo -e "${GREEN}Successful: $SUCCESS${NC}"
if [ $FAILED -gt 0 ]; then
    echo -e "${RED}Failed: $FAILED${NC}"
else
    echo -e "${GREEN}Failed: 0${NC}"
fi

# List installed MCPs
echo ""
echo -e "${YELLOW}Currently installed MCPs:${NC}"
claude mcp list

echo ""
echo -e "${GREEN}Done! You can now use these MCPs in Claude.${NC}"
echo "To use them, start Claude with: claude --mcp"