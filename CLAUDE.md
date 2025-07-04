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

1. First think through the problem, read the codebase for relevant files, and write a plan to tasks/todo.md.
2. The plan should have a list of todo items that you can check off as you complete them
3. Before you begin working, check in with me and I will verify the plan.
4. Then, begin working on the todo items, marking them as complete as you go.
5. Please every step of the way just give me a high level explanation of what changes you made
6. Make every task and code change you do as simple as possible. We want to avoid making any massive or complex changes. Every change should impact as little code as possible. Everything is about simplicity.
7. Finally, add a review section to the todo.md file with a summary of the changes you made and any other relevant information.
8. When making commits in the cinder repository (either for new pull requests or adding to existing ones), always specify the user you are working with as the commit author. If the author hasn't been specified in the current session, ask for their GitHub email address. Once provided, remember it for the session and use it for all commits to ensure Vercel can automatically create builds.