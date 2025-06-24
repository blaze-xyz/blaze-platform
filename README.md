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
# Clone the repository
git clone https://github.com/blaze-xyz/blaze-platform.git
cd blaze-platform

# Install dependencies across all projects
yarn install

# Start the full development stack
yarn dev:all
```

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

## 📞 Support

- **Documentation**: Comprehensive guides in each project directory
- **GitHub Issues**: For bug reports and feature requests
- **Internal Support**: Contact the development team for urgent issues

---

**Built with ❤️ by the Blaze team** | [Website](https://blaze.money) | [Documentation](https://docs.blaze.money)