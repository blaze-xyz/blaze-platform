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

All worktrees should be created in the `worktrees/` folder to keep the workspace organized and avoid conflicts.

### Worktree Commands
```bash
# Create a new worktree for a feature/issue in the dedicated worktrees folder
git worktree add worktrees/feature-name feature/branch-name

# List existing worktrees
git worktree list

# Remove a worktree when work is complete
git worktree remove worktrees/feature-name
git worktree prune
```

### Workflow Pattern
1. **Start new work**: Create a worktree for each new feature/issue
2. **Develop**: Work in the isolated worktree directory
3. **Complete**: Merge/submit PR from the worktree
4. **Cleanup**: Delete the worktree once work is finished

This allows multiple Claude Code instances to work on different issues simultaneously without branch conflicts.

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

1. **Create a worktree**: Start by creating a new git worktree for the feature/issue you're working on
2. **Plan the work**: Think through the problem, read the codebase for relevant files, and write a plan to tasks/todo.md
3. **Get approval**: The plan should have a list of todo items. Check in with me to verify the plan before beginning work
4. **Execute**: Work on the todo items in the isolated worktree, marking them as complete as you go
5. **Communicate progress**: Give high-level explanations of changes made at each step
6. **Keep it simple**: Make every task and code change as simple as possible, impacting as little code as possible
7. **Review and summarize**: Add a review section to the todo.md file with a summary of changes and relevant information
8. **Commit with proper attribution**: When making commits (especially in cinder), always specify the user as the commit author using their GitHub email
9. **Cleanup**: Once work is complete and merged, delete the worktree to keep the workspace clean

## Commit Attribution

When making commits in the cinder repository (either for new pull requests or adding to existing ones), always specify the user you are working with as the commit author. If the author hasn't been specified in the current session, ask for their GitHub email address. Once provided, remember it for the session and use it for all commits to ensure Vercel can automatically create builds.