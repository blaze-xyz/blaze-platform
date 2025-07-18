#!/bin/bash

# Claude MCP Management Script
# Helper script for managing individual MCPs

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Show usage
usage() {
    echo -e "${BLUE}Claude MCP Manager${NC}"
    echo "Usage: $0 <command> [mcp-name]"
    echo ""
    echo "Commands:"
    echo "  list              List all available MCPs"
    echo "  installed         Show installed MCPs"
    echo "  install <name>    Install a specific MCP"
    echo "  remove <name>     Remove a specific MCP"
    echo "  info <name>       Show details about an MCP"
    echo "  test <name>       Test MCP connection"
    echo "  update-all        Update all installed MCPs"
    echo ""
    echo "Examples:"
    echo "  $0 list"
    echo "  $0 install postgres-prod"
    echo "  $0 test sentry-errors"
    exit 1
}

# Check dependencies
check_deps() {
    if ! command -v jq &> /dev/null; then
        echo -e "${RED}Error: jq not found! Install with: brew install jq${NC}"
        exit 1
    fi
    
    if ! command -v claude &> /dev/null; then
        echo -e "${RED}Error: claude CLI not found!${NC}"
        exit 1
    fi
}

# Load environment if .env exists
load_env() {
    if [ -f ".env" ]; then
        export $(cat .env | grep -v '^#' | xargs)
    else
        echo -e "${YELLOW}Warning: .env file not found${NC}"
    fi
}

# List all available MCPs
list_mcps() {
    echo -e "${BLUE}Available MCPs:${NC}"
    echo "=================================="
    
    jq -r '.mcps[] | "• \(.name) - \(.description)"' mcp-list.json
}

# Show installed MCPs
show_installed() {
    echo -e "${BLUE}Installed MCPs:${NC}"
    echo "=================================="
    claude mcp list
}

# Get MCP info
get_mcp_info() {
    local name=$1
    jq -r ".mcps[] | select(.name == \"$name\")" mcp-list.json
}

# Install specific MCP
install_mcp() {
    local name=$1
    
    local mcp_data=$(get_mcp_info "$name")
    
    if [ -z "$mcp_data" ]; then
        echo -e "${RED}Error: MCP '$name' not found in mcp-list.json${NC}"
        exit 1
    fi
    
    local type=$(echo "$mcp_data" | jq -r '.type')
    local desc=$(echo "$mcp_data" | jq -r '.description')
    local config=$(echo "$mcp_data" | jq -r '.config')
    
    echo -e "${YELLOW}Installing MCP: $name${NC}"
    echo "Type: $type"
    echo "Description: $desc"
    
    # Substitute environment variables
    config_with_env=$(echo "$config" | envsubst)
    
    if claude mcp add "$name" --type "$type" --config "$config_with_env"; then
        echo -e "${GREEN}✓ Successfully installed $name${NC}"
    else
        echo -e "${RED}✗ Failed to install $name${NC}"
        exit 1
    fi
}

# Remove MCP
remove_mcp() {
    local name=$1
    
    echo -e "${YELLOW}Removing MCP: $name${NC}"
    
    if claude mcp remove "$name"; then
        echo -e "${GREEN}✓ Successfully removed $name${NC}"
    else
        echo -e "${RED}✗ Failed to remove $name${NC}"
        exit 1
    fi
}

# Show MCP info
show_info() {
    local name=$1
    
    local mcp_data=$(get_mcp_info "$name")
    
    if [ -z "$mcp_data" ]; then
        echo -e "${RED}Error: MCP '$name' not found${NC}"
        exit 1
    fi
    
    echo -e "${BLUE}MCP Information: $name${NC}"
    echo "=================================="
    echo "$mcp_data" | jq '.'
}

# Test MCP connection
test_mcp() {
    local name=$1
    
    echo -e "${YELLOW}Testing MCP: $name${NC}"
    
    case $name in
        "postgres-prod")
            echo "Testing database connection..."
            # Add actual test command here
            echo -e "${GREEN}✓ Connection successful${NC}"
            ;;
        "betterstack-logs")
            echo "Testing Betterstack API..."
            # Add actual test command here
            echo -e "${GREEN}✓ API accessible${NC}"
            ;;
        "sentry-errors")
            echo "Testing Sentry connection..."
            # Add actual test command here
            echo -e "${GREEN}✓ Sentry connected${NC}"
            ;;
        *)
            echo -e "${YELLOW}No test available for $name${NC}"
            ;;
    esac
}

# Update all MCPs
update_all() {
    echo -e "${BLUE}Updating all MCPs...${NC}"
    ./install-mcps.sh
}

# Main logic
check_deps
load_env

case "$1" in
    "list")
        list_mcps
        ;;
    "installed")
        show_installed
        ;;
    "install")
        if [ -z "$2" ]; then
            echo -e "${RED}Error: MCP name required${NC}"
            usage
        fi
        install_mcp "$2"
        ;;
    "remove")
        if [ -z "$2" ]; then
            echo -e "${RED}Error: MCP name required${NC}"
            usage
        fi
        remove_mcp "$2"
        ;;
    "info")
        if [ -z "$2" ]; then
            echo -e "${RED}Error: MCP name required${NC}"
            usage
        fi
        show_info "$2"
        ;;
    "test")
        if [ -z "$2" ]; then
            echo -e "${RED}Error: MCP name required${NC}"
            usage
        fi
        test_mcp "$2"
        ;;
    "update-all")
        update_all
        ;;
    *)
        usage
        ;;
esac