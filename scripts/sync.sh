#!/bin/bash

# Blaze Platform Monorepo Sync Script
# This script helps keep your monorepo and all submodules in sync with GitHub

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[SYNC]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if there are uncommitted changes
check_uncommitted_changes() {
    if [[ -n $(git status -s) ]]; then
        return 0
    else
        return 1
    fi
}

# Main sync function
sync_repo() {
    print_status "Starting repository synchronization..."

    # Check for uncommitted changes in parent repo
    if check_uncommitted_changes; then
        print_warning "You have uncommitted changes in the parent repository"
        read -p "Do you want to stash them? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            git stash push -m "Auto-stash before sync $(date)"
            STASHED=true
        else
            print_error "Cannot sync with uncommitted changes. Please commit or stash them first."
            exit 1
        fi
    fi

    # Check for uncommitted changes in submodules
    print_status "Checking submodules for uncommitted changes..."
    SUBMODULE_CHANGES=$(git submodule foreach 'git status -s' | grep -v "Entering" || true)
    if [[ -n "$SUBMODULE_CHANGES" ]]; then
        print_warning "Some submodules have uncommitted changes:"
        echo "$SUBMODULE_CHANGES"
        read -p "Continue anyway? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi

    # Fetch all updates
    print_status "Fetching updates from remotes..."
    git fetch --recurse-submodules

    # Pull parent repository
    print_status "Pulling parent repository..."
    git pull

    # Update submodules
    print_status "Updating all submodules..."
    git submodule update --init --recursive --remote --merge

    # Show status
    print_status "Current submodule status:"
    git submodule status --recursive

    # Restore stashed changes if any
    if [[ "${STASHED:-false}" == "true" ]]; then
        print_status "Restoring stashed changes..."
        git stash pop
    fi

    print_success "Repository synchronized successfully!"
}

# Push function
push_all() {
    print_status "Pushing changes to GitHub..."

    # Check if we need to push submodules
    SUBMODULES_TO_PUSH=$(git submodule foreach 'git status -sb' | grep "ahead" || true)
    if [[ -n "$SUBMODULES_TO_PUSH" ]]; then
        print_status "Pushing submodule changes..."
        git submodule foreach 'git push origin HEAD:$(git rev-parse --abbrev-ref HEAD)'
    fi

    # Push parent repository with submodules
    print_status "Pushing parent repository..."
    git push --recurse-submodules=on-demand

    print_success "All changes pushed successfully!"
}

# Status function
show_status() {
    print_status "Repository Status:"
    echo "===================="
    echo "Parent Repository:"
    git status -sb
    echo ""
    echo "Submodules:"
    git submodule status --recursive
    echo ""
    echo "Submodule Details:"
    git submodule foreach 'echo "=== $name ==="; git status -sb; echo'
}

# Full sync function (pull, update, commit, push)
full_sync() {
    sync_repo

    # Check if there are changes to commit
    if git diff --quiet && git diff --cached --quiet; then
        print_status "No changes to commit in parent repository"
    else
        print_status "Committing submodule updates..."
        git add .
        git commit -m "Update submodules $(date +%Y-%m-%d)"
    fi

    push_all
}

# Main script logic
case "${1:-sync}" in
    sync)
        sync_repo
        ;;
    push)
        push_all
        ;;
    status)
        show_status
        ;;
    full)
        full_sync
        ;;
    help)
        echo "Blaze Platform Monorepo Sync Script"
        echo ""
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  sync    - Pull latest changes and update all submodules (default)"
        echo "  push    - Push all changes including submodules"
        echo "  status  - Show status of parent repo and all submodules"
        echo "  full    - Full sync: pull, update, commit, and push"
        echo "  help    - Show this help message"
        ;;
    *)
        print_error "Unknown command: $1"
        echo "Use '$0 help' for usage information"
        exit 1
        ;;
esac