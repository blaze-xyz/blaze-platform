# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Blaze Platform is a comprehensive financial technology stack for global payments, built for modern nomads and businesses operating across borders. This is an Nx-managed monorepo using git submodules to manage individual projects.

## Architecture

The monorepo consists of these key projects:

- **spark/** - Backend API (NestJS, GraphQL, PostgreSQL, Prisma)
- **app/** - Mobile app (React Native, Expo)
- **cinder/** - Admin dashboard (Next.js, TypeScript, Tailwind)
- **website/** - Marketing website (Next.js, TypeScript)
- **kindling/** - Shared utilities (@blaze-money/kindling on NPM)
- **deploy-notes-action/** - GitHub Action for deploy notes
- **dlocal-signature/** - Evervault cage function for payment security

## Git Worktree Workflow

**Always use git worktrees when working on new features or issues.** This ensures clean separation between different development tasks and prevents branch conflicts when working on multiple issues simultaneously.

### Important: Worktree Location Strategy

**Worktrees should be created as sibling directories to the main blaze repository**, using the `../` pattern. This approach:
- Provides complete separation from the main repository
- Makes it easier for IDEs and Claude Code to work with isolated contexts
- Prevents any conflicts or confusion with the main repository structure
- Allows multiple worktrees to exist independently without cluttering the main repo

### Worktree Commands

```bash
# Create a new worktree as a sibling directory to blaze
git worktree add ../feature-name feature/branch-name

# Examples:
git worktree add ../fix-payment-bug fix/payment-processing
git worktree add ../virtual-accounts feat/virtual-accounts
git worktree add ../update-ui feat/new-dashboard

# List all worktrees
git worktree list

# Remove a worktree when work is complete
git worktree remove ../feature-name
git worktree prune
```

### Example Directory Structure

```
Projects/
├── blaze/                      # Main repository
│   ├── spark/
│   ├── app/
│   ├── cinder/
│   └── website/
├── fix-payment-bug/            # Worktree for payment bug fix
│   ├── spark/
│   ├── app/
│   ├── cinder/
│   └── website/
├── virtual-accounts/           # Worktree for virtual accounts feature
│   ├── spark/
│   ├── app/
│   ├── cinder/
│   └── website/
└── update-ui/                  # Worktree for UI updates
    ├── spark/
    ├── app/
    ├── cinder/
    └── website/
```

### Working with Submodules in Worktrees

When you create a worktree at the parent level, remember that submodules need to be initialized:

```bash
# After creating a worktree
cd ../feature-name

# Initialize and update submodules
git submodule update --init --recursive

# Navigate to the specific submodule you want to work on
cd spark  # or app, cinder, website, etc.

# Create and checkout your feature branch in the submodule
git checkout -b feature/your-feature
```

### Workflow Pattern

1. **Create worktree**: From the main blaze directory, create a sibling worktree using `../worktree-name`
2. **Initialize submodules**: Run `git submodule update --init --recursive` in the new worktree
3. **Navigate to submodule**: Go to the specific project you're working on (spark, app, etc.)
4. **Create feature branch**: Checkout your feature branch within the submodule
5. **Develop**: Work in the completely isolated worktree environment
6. **Complete**: Merge/submit PR from the worktree
7. **Cleanup**: Remove the worktree and prune references when done

This allows multiple Claude Code instances or IDEs to work on different issues simultaneously without any conflicts, with each worktree completely isolated as a sibling directory.

## Common Commands

### Backend (Spark)

```bash
cd spark
yarn build              # Build application
yarn start              # Start dev server
yarn test               # Run unit tests
yarn test:integration   # Run integration tests
yarn lint               # ESLint with fix
```

### Mobile (App)

```bash
cd app
yarn start              # Start Expo dev server
yarn ios                # Run iOS simulator
yarn android            # Run Android emulator
yarn test               # Run Jest tests
yarn lint:fix           # ESLint with fix
yarn test:e2e           # Maestro E2E tests
```

### Admin (Cinder)

```bash
cd cinder
yarn dev                # Start Next.js dev (port 3001)
yarn build              # Production build
yarn lint               # Next.js lint
yarn graphql:generate   # Generate GraphQL types
```

### Website

```bash
cd website
yarn dev                # Start Next.js dev (port 3001)
yarn build              # Production build
yarn lint               # Next.js lint
yarn graphql:generate   # Generate GraphQL types
```

### Monorepo-wide (Nx)

```bash
npx nx run-many -t build    # Build all projects
npx nx run-many -t test     # Test all projects
npx nx run-many -t lint     # Lint all projects
npx nx affected -t test     # Test affected projects
npx nx graph                # View dependency graph
```

## Key Architectural Patterns

1. **Payment Provider Integration**: Spark integrates 10+ payment providers (Bridge, Coinflow, Checkbook, Bitso, DLocal, Shift4, etc.) through a unified interface pattern in `spark/src/payment-providers/`

2. **GraphQL API**: All client apps communicate with Spark via GraphQL. Schema is in `spark/src/graphql/` with generated types shared across projects.

3. **Authentication**: JWT-based auth with phone/email verification. Implementation in `spark/src/auth/` with shared patterns across mobile and web apps.

4. **Queue System**: BullMQ/Redis for async processing in Spark (`spark/src/queues/`). Critical for payment processing and notifications.

5. **Blockchain Integration**: Stellar network integration for crypto transactions in `spark/src/blockchain/`

6. **Shared Utilities**: @blaze-money/kindling provides common utilities. Always check if functionality exists there before implementing new utilities.

## Development Guidelines

1. **TypeScript**: Strict TypeScript across all projects. Follow existing patterns for type definitions.

2. **Testing**:

   - Unit tests required for new features
   - Integration tests for API endpoints
   - E2E tests for critical user flows

3. **Error Handling**: Centralized error handling in Spark. Custom error classes in `spark/src/errors/`

4. **Currency Handling**: Use established patterns for multi-currency support. Never use floating point for money calculations.

5. **Environment Variables**: Each project has environment-specific configs. Check `.env.example` files for required variables.

6. **Git Submodules**: Remember to run `git submodule update --init --recursive` after cloning. Each submodule maintains its own git history.

## Important Files to Review

- `.cursor/rules/` - AI development guidelines for each project
- `spark/prisma/schema.prisma` - Database schema
- `spark/src/payment-providers/` - Payment integration patterns
- `app/src/navigation/` - Mobile app navigation structure
- `cinder/src/components/` - Reusable admin components
- `kindling/src/` - Shared utilities to avoid duplication

## Standard Workflow

1. **Create a worktree**: Start by creating a new git worktree in the relevant submodule for the feature/issue you're working on
2. **Plan the work**: Think through the problem, read the codebase for relevant files, and write a plan to tasks/todo.md
3. **Get approval**: The plan should have a list of todo items that you can check off as you complete them. Check in with me to verify the plan before beginning work
4. **Execute**: Work on the todo items in the isolated worktree, marking them as complete as you go
5. **Communicate progress**: Give high-level explanations of changes made at each step
6. **Keep it simple**: Make every task and code change as simple as possible, impacting as little code as possible. Everything is about simplicity
7. **Clean up code**: After completing all tasks, analyze the modified files and related modules for unused methods or dead code, and clean them up to maintain code quality
8. **Review and summarize**: Add a review section to the todo.md file with a summary of the changes you made and any other relevant information
9. **Commit with proper attribution**: When making commits (especially in cinder), always specify the user as the commit author using their GitHub email
10. **Cleanup**: Once work is complete and merged, delete the worktree to keep the workspace clean
