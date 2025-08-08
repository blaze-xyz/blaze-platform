# Blaze Platform Monorepo

> **The complete financial technology stack for global payments**

Welcome to the Blaze Platform monorepo - a comprehensive fintech ecosystem built for modern nomads and businesses operating across borders. This repository houses all of Blaze's core applications and services, managed with [Nx](https://nx.dev) for optimal development experience.

## 🏗️ Architecture Overview

```
blaze-platform/
├── spark/          # Backend API & Services
├── app/            # React Native Mobile App  
├── cinder/         # Admin Dashboard (Next.js)
├── website/        # Marketing Website (Next.js)
├── kindling/       # Shared Utility Library
└── tasks/          # Development Tasks & Scripts
```

## 🚀 Core Applications

### ⚡ Spark - Backend API
**The heart of Blaze's financial infrastructure**

- **Framework**: NestJS with TypeScript & GraphQL
- **Database**: PostgreSQL with Prisma ORM
- **Key Features**:
  - Multi-provider payment processing (10+ providers)
  - Cross-border transaction support
  - JWT authentication with phone/email verification
  - Real-time communication (push, SMS, email)
  - Blockchain integration (Stellar network)
  - Advanced queue system with BullMQ

```bash
cd spark
yarn start:dev      # Development server
yarn test           # Run tests
yarn test:integration # Integration tests
```

**Payment Providers**: Bridge, Coinflow, Checkbook, Bitso, DLocal, Shift4, AuthorizeNet, Astra, Plaid

### 📱 App - Mobile Application
**React Native app for iOS and Android**

- **Framework**: React Native with Expo
- **Key Features**:
  - Cross-platform payment interface
  - Real-time transaction tracking
  - Multi-currency support
  - Biometric authentication
  - Push notifications

```bash
cd app
yarn start          # Start Expo dev server
yarn ios            # Run on iOS simulator
yarn android        # Run on Android emulator
yarn test           # Run tests
```

### 🔥 Cinder - Admin Dashboard
**Next.js-powered administrative interface**

- **Framework**: Next.js with TypeScript
- **UI**: Tailwind CSS with shadcn/ui components
- **Key Features**:
  - Transaction monitoring and analytics
  - User management and KYC
  - Payment provider configuration
  - Business operations dashboard

```bash
cd cinder
yarn dev            # Development server
yarn build          # Production build
yarn test           # Run tests
```

### 🌐 Website - Marketing Site
**Public-facing website and landing pages**

- **Framework**: Next.js with TypeScript
- **Key Features**:
  - Multi-language support (i18n)
  - SEO optimized
  - Payment link generation
  - User onboarding flows

```bash
cd website
yarn dev            # Development server (port 3001)
yarn build          # Production build
```

## 🛠️ Shared Utilities

### 🔥 Kindling - Utility Library
**Shared utilities and common functionality**

- Published to NPM as `@blaze/kindling`
- Used across Spark and App
- Automated semantic versioning via GitHub Actions
- Contains logging, validation, and common helpers

## 🚀 Getting Started

### Prerequisites
- **Node.js** 18+ with Yarn
- **Docker** (for local database)
- **iOS/Android SDK** (for mobile development)

### Quick Setup
```bash
# Clone the repository with all submodules
git clone --recurse-submodules https://github.com/blaze-xyz/blaze-platform.git
cd blaze-platform

# If already cloned without submodules, initialize them:
# git submodule update --init --recursive

# Install dependencies across all projects
yarn install

# Start the full development stack
yarn dev:all
```

> **⚠️ Important**: This repository uses git submodules. Always use `--recurse-submodules` when cloning, or run `git submodule update --init --recursive` if already cloned.

### Individual Project Setup
Each project can be developed independently:

```bash
# Backend API
cd spark && yarn && yarn start:dev

# Mobile App  
cd app && yarn && yarn start

# Admin Dashboard
cd cinder && yarn && yarn dev

# Marketing Website
cd website && yarn && yarn dev
```

## 🔄 Submodule Synchronization

This monorepo uses git submodules to manage individual projects. We provide convenient scripts to keep everything in sync with GitHub.

### Using NPM/Yarn Scripts
```bash
# Pull latest changes and update all submodules
yarn sync

# Push all changes (submodules first, then parent)
yarn sync:push

# Check status of all submodules
yarn sync:status

# Full sync cycle: pull, update, commit, and push
yarn sync:full

# Other useful commands
yarn sync:update    # Initialize/update submodules
yarn sync:fetch     # Fetch changes without merging
yarn sync:checkout  # Checkout main/master in all submodules
yarn sync:pull      # Pull in all submodules
```

### Using the Sync Shell Script
For more control and safety features, use the provided shell script:

```bash
# Basic sync (pull + update)
./scripts/sync.sh

# Push all changes
./scripts/sync.sh push

# Show detailed status
./scripts/sync.sh status

# Full sync with auto-commit
./scripts/sync.sh full

# Show help
./scripts/sync.sh help
```

The shell script includes:
- ✅ Automatic stashing of uncommitted changes
- ✅ Safety checks before operations
- ✅ Colored output for better visibility
- ✅ Detailed status reporting

### Common Workflows

**Daily sync routine:**
```bash
# Start your day by syncing everything
yarn sync
```

**After making changes:**
```bash
# Commit your changes in submodules first
cd spark && git add . && git commit -m "Your changes"
cd ..

# Then sync everything to GitHub
yarn sync:push
```

**Quick full sync:**
```bash
# One command to sync everything
yarn sync:full
# or
./scripts/sync.sh full
```

## 🔧 Development with Nx

This monorepo uses [Nx](https://nx.dev) for enhanced development experience:

```bash
# Run tasks across all projects
npx nx run-many -t build

# Run tasks for affected projects only
npx nx affected -t test

# View project dependency graph
npx nx graph

# Cache management
npx nx reset
```

### Available Commands
```bash
# Build all projects
npx nx run-many -t build

# Test all projects
npx nx run-many -t test

# Lint all projects
npx nx run-many -t lint

# Run specific project task
npx nx run spark:build
npx nx run app:test
npx nx run cinder:dev
```

## 🌍 Deployment

### Staging Environment
- **API**: Deployed via Porter/Docker
- **Mobile**: Expo updates and TestFlight/Firebase
- **Web Apps**: Deployed on Vercel

### Production Environment
- **API**: Multi-region deployment with load balancing
- **Mobile**: App Store and Google Play Store
- **Web Apps**: Global CDN distribution

## 🧪 Testing Strategy

### Unit Tests
```bash
# Run all unit tests
npx nx run-many -t test

# Test specific project
npx nx run spark:test
```

### Integration Tests
```bash
# Backend integration tests
cd spark && yarn test:integration

# E2E mobile tests (Maestro)
cd app && yarn test:e2e
```

### Test Coverage
- **Spark**: Comprehensive service and controller tests
- **App**: Component and integration tests with Jest
- **Cinder**: Unit and integration tests
- **Website**: Component tests

## 🔐 Security & Compliance

- **Authentication**: Multi-factor JWT authentication
- **Data Protection**: End-to-end encryption for sensitive data
- **Compliance**: PCI DSS and international banking regulations
- **Monitoring**: Sentry error tracking and security monitoring

## 📊 Tech Stack Summary

| Component | Technology | Purpose |
|-----------|------------|---------|
| **Backend** | NestJS + GraphQL + PostgreSQL | API services and data management |
| **Mobile** | React Native + Expo | Cross-platform mobile application |
| **Admin** | Next.js + Tailwind + shadcn/ui | Administrative interface |
| **Website** | Next.js + i18n | Public marketing and user onboarding |
| **Database** | PostgreSQL + Prisma | Data persistence and migrations |
| **Queue** | BullMQ + Redis | Background job processing |
| **Blockchain** | Stellar SDK | Cryptocurrency transactions |
| **Monitoring** | Sentry + DataDog | Error tracking and performance monitoring |

## 🤝 Contributing

1. **Clone the repository** and create a feature branch
2. **Follow coding standards** defined in each project's documentation
3. **Write tests** for new features and bug fixes
4. **Update documentation** for significant changes
5. **Submit a pull request** with clear description of changes

### Code Standards
- **TypeScript** for all projects with strict type checking
- **ESLint + Prettier** for consistent code formatting
- **Conventional Commits** for clear commit messages
- **Comprehensive testing** with high coverage requirements

## 📚 Documentation

Each project contains detailed documentation:

- **[Spark Documentation](spark/docs/README.md)** - API architecture and development
- **[App Documentation](app/docs/README.md)** - Mobile development guide
- **[Cinder Documentation](cinder/docs/)** - Admin dashboard setup
- **[Website Documentation](website/README.md)** - Marketing site development

## 🌟 Key Features

### 💳 Multi-Provider Payment Processing
Support for 10+ payment providers across multiple countries and currencies

### 🌍 Cross-Border Transactions  
Seamless international payments with competitive exchange rates

### 📱 Mobile-First Experience
Native iOS and Android apps with biometric authentication

### 🏢 Business Operations
Comprehensive admin tools for payment monitoring and user management

### 🔗 Developer-Friendly APIs
GraphQL APIs with comprehensive documentation and type safety

## 🚀 Migration to True Monorepo

### Current Status
This repository currently uses **git submodules** to manage individual projects. This preserves each project's independent history and CI/CD pipelines while providing monorepo benefits through Nx.

### Migration Strategy
When ready to convert to a true monorepo (removing nested `.git` directories), follow this phased approach:

#### **Phase 1: Preparation**
```bash
# Create migration branch
git checkout -b migration/true-monorepo

# Document current CI/CD workflows
# Backup important branches from each submodule
# Test Nx commands work with current setup
```

#### **Phase 2: CI/CD Path-Based Migration**
Update existing workflows to work with monorepo paths:

```yaml
# .github/workflows/spark-ci.yml (example)
name: Spark CI
on:
  push:
    paths: ['spark/**']
    branches: [main, develop]
  pull_request:
    paths: ['spark/**']

jobs:
  test:
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: ./spark
    # ... rest of existing workflow
```

#### **Phase 3: History Consolidation**
```bash
# Option A: Preserve history with git subtree
git subtree add --prefix=spark-backup spark/ main --squash

# Option B: Clean migration (simpler, loses individual history)
# Remove .git directories and commit as unified repo
```

#### **Phase 4: Nx Optimization**
```bash
# Use Nx affected detection for efficiency
npx nx affected -t test,build,lint

# Implement unified workflows where beneficial
npx nx run-many -t build
```

### **Key Benefits of Migration**
- ✅ **Unified versioning** across all projects
- ✅ **Atomic commits** spanning multiple projects
- ✅ **Simplified dependency management**
- ✅ **Enhanced Nx caching** and affected detection
- ✅ **Streamlined CI/CD** with better build optimization

### **Migration Considerations**
- **React Native**: Expo builds need careful working directory handling
- **Backend**: Docker contexts and database migrations require path updates
- **Web Apps**: Build configurations and deployment paths need adjustment
- **Gradual Adoption**: Teams can migrate CI/CD at their own pace

### **Recommended Order**
1. **Website** (simplest deployment)
2. **Cinder** (admin dashboard)
3. **Spark** (backend API)
4. **App** (most complex with mobile-specific CI/CD)

## 📞 Support

- **Documentation**: Comprehensive guides in each project directory
- **GitHub Issues**: For bug reports and feature requests
- **Internal Support**: Contact the development team for urgent issues

---

**Built with ❤️ by the Blaze team** | [Website](https://blaze.money) | [Documentation](https://docs.blaze.money)