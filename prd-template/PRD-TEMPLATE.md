# [Feature Name] - Product Requirements Document

**Author**: [Your Name]  
**Date**: [Date]  
**Status**: [Draft | In Review | Approved]  
**Stakeholders**: [List key stakeholders]

---

## Table of Contents
1. [Overview](#overview)
2. [Problem Statement](#problem-statement)
3. [Visuals](#visuals)
4. [Requirements](#requirements)
5. [User Stories](#user-stories)
6. [Communications](#communications)
7. [Analytics](#analytics)
8. [Testing Plan](#testing-plan)
9. [Phases](#phases)
10. [Success Metrics](#success-metrics)
11. [Backend Specs](#backend-specs)
12. [Frontend Specs](#frontend-specs)
13. [Todo List](#todo-list)
14. [Custom Specs](#custom-specs)

---

## Overview

[Provide a high-level summary of the feature. Include what it is, who it's for, and why we're building it.]

**Key Benefits:**
- [Benefit 1]
- [Benefit 2]
- [Benefit 3]

**Target Users:**
- [Primary user persona]
- [Secondary user persona]

---

## Problem Statement

### Current State
[Describe the current situation]

### Pain Points
1. **[Pain Point 1]**: [Description and impact]
2. **[Pain Point 2]**: [Description and impact]

### Why Now?
- [Market conditions or business reasons]
- [Technical readiness]

---

## Visuals

[Include all design mockups, user flows, and technical diagrams as PNG exports]

### User Flow
![User Flow](./visuals/user-flow.png)

### UI Mockups
![Main Screen](./visuals/main-screen.png)

---

## Requirements

### Functional Requirements

#### Core Features
1. **[Feature Name]**
   - Description: [What it does]
   - Acceptance Criteria:
     - [ ] [Criterion 1]
     - [ ] [Criterion 2]
   - Priority: [Must Have | Should Have | Nice to Have]

### Non-Functional Requirements

#### Performance
- **Response Time**: [Target]
- **Throughput**: [Target]

#### Security
- **Authentication**: [Requirements]
- **Data Protection**: [Requirements]

---

## User Stories

### Primary User Stories

#### Story 1: [Title]
**As a** [user type]  
**I want** [capability]  
**So that** [benefit]

**Acceptance Criteria:**
- Given [context], when [action], then [outcome]

---

## Communications

### Email Templates

#### [Email Name]
**Trigger**: [When sent]  
**Subject**: [Subject line]  

**Content**:
```
[Email template with {{variables}}]
```

### Push Notifications

#### [Notification Name]
**Trigger**: [When sent]  
**Title**: [Title]  
**Body**: [Message]

---

## Analytics

### Core Events

#### [event.name.pattern]
**Trigger**: [When fired]  
**Properties**:
```typescript
{
  userId: string
  timestamp: string
  // custom properties
}
```

### Key Metrics
- **[Metric Name]**: [How to calculate]
- **[Metric Name]**: [How to calculate]

---

## Testing Plan

### Unit Testing
- [ ] [Component/Service to test]
- [ ] [Component/Service to test]

### Integration Testing
- [ ] [Integration point]
- [ ] [User flow]

### Manual Testing
- [ ] [Test scenario]
- [ ] [Edge case]

---

## Phases

### Phase Overview
| Phase | Duration | Key Deliverables |
|-------|----------|------------------|
| 1 | [X weeks] | [Deliverables] |
| 2 | [X weeks] | [Deliverables] |

### Phase 1: [Name]
**Goal**: [What this phase accomplishes]

**Deliverables:**
- [ ] [Deliverable 1]
- [ ] [Deliverable 2]

---

## Success Metrics

### North Star Metric
**Metric**: [Primary indicator]  
**Target**: [Goal]

### KPIs
- **[Metric]**: Target: [Value]
- **[Metric]**: Target: [Value]

---

## Backend Specs

### API Design

#### [Endpoint or Mutation]
```graphql
mutation FeatureAction($input: Input!) {
  featureAction(input: $input) {
    id
    status
  }
}
```

### Database Schema
```sql
-- Schema changes needed
```

---

## Frontend Specs

### Components

#### [ComponentName]
**Purpose**: [What it does]  
**Props**: [Key props]

### State Management
```typescript
interface FeatureState {
  // state shape
}
```

---

## Todo List

### Backend Tasks
- [ ] 🔴 **[Task Name]** [Owner] 📏[Size]
- [ ] 🟡 **[Task Name]** [Owner] 📏[Size]

### Frontend Tasks
- [ ] 🟡 **[Task Name]** [Owner] 📏[Size]
- [ ] 🟢 **[Task Name]** [Owner] 📏[Size]

---

## Custom Specs

[Add any feature-specific specifications that don't fit in the standard sections above]

### [Custom Section Name]
[Content specific to this feature]

---

## Appendix

### References
- [Link to related docs]
- [Link to design files]
- [Link to technical specifications]

### Revision History
| Date | Version | Changes | Author |
|------|---------|---------|--------|
| [Date] | 1.0 | Initial draft | [Name] |