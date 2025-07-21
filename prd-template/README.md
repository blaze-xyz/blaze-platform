# PRD Template Structure

A comprehensive Product Requirements Document (PRD) template for creating detailed feature specifications at Blaze.

## Overview

This template provides a structured approach to documenting product features, ensuring all aspects from business requirements to technical implementation are thoroughly captured.

## Directory Structure

```
prd-template/
├── README.md                    # This file
├── PRD-TEMPLATE.md             # Master template with all sections
├── NEW-FEATURE-PROMPT.md       # Prompt template for starting new PRDs
├── sections/                   # Individual section templates with detailed guidance
│   ├── 01-overview.md
│   ├── 02-problem-statement.md
│   ├── 03-visuals.md
│   ├── 04-requirements.md
│   ├── 05-user-stories.md
│   ├── 06-communications.md
│   ├── 07-analytics.md
│   ├── 08-testing-plan.md
│   ├── 09-phases.md
│   ├── 10-success-metrics.md
│   ├── 11-backend-specs.md
│   ├── 12-frontend-specs.md
│   └── 13-todo-list.md
└── custom-specs/              # Feature-specific documentation
    ├── README.md
    └── example-payment-integration/
        └── webhook-specifications.md
```

## How to Use This Template

### Starting a New PRD

1. **Copy the template**: Copy `PRD-TEMPLATE.md` to your project's documentation folder
2. **Rename appropriately**: Name it after your feature (e.g., `ach-deposits-prd.md`)
3. **Fill in sections**: Work through each section, referring to individual templates in `sections/` for guidance
4. **Add visuals**: Create a `visuals/` subdirectory for mockups and diagrams
5. **Custom specs**: Add feature-specific docs to `custom-specs/[feature-name]/`

### Using the Prompt Template

1. Open `NEW-FEATURE-PROMPT.md`
2. Choose the appropriate prompt type for your feature
3. Fill in the bracketed information
4. Use with Claude or share with team to generate initial PRD

### Section-by-Section Guide

Each file in the `sections/` directory contains:
- **Purpose**: Why this section matters
- **Template**: Structure to follow
- **Example**: Real-world example (ACH deposits)
- **Best Practices**: Tips for that section

## Key Principles

### 1. Start with Why
Always begin with the problem statement and user needs, not the solution.

### 2. Be Specific
Use concrete numbers, dates, and examples rather than vague terms.

### 3. Think End-to-End
Consider the entire user journey and all system touchpoints.

### 4. Plan for Reality
Include error cases, rollback plans, and post-launch activities.

### 5. Make it Measurable
Define clear success metrics and acceptance criteria.

## Section Overview

### Core Sections

1. **Overview**: High-level summary and business value
2. **Problem Statement**: What problem we're solving and why
3. **Visuals**: All mockups, flows, and diagrams
4. **Requirements**: Functional and non-functional requirements
5. **User Stories**: Feature requirements from user perspective
6. **Communications**: Email, SMS, and notification templates
7. **Analytics**: Events and metrics to track
8. **Testing Plan**: Comprehensive testing strategy
9. **Phases**: Implementation roadmap and rollout plan
10. **Success Metrics**: How we measure success
11. **Backend Specs**: Technical API and service details
12. **Frontend Specs**: UI components and interactions
13. **Todo List**: Detailed task breakdown

### Custom Specs

Use the `custom-specs/` directory for:
- Complex integration guides
- Migration plans
- Security protocols
- Performance benchmarks
- Compliance documentation
- Any feature-specific technical details

## Best Practices

### DO:
- ✅ Include visuals for every major user flow
- ✅ Define specific, measurable success criteria
- ✅ Consider error states and edge cases
- ✅ Include post-launch monitoring plans
- ✅ Get stakeholder review early and often
- ✅ Keep the PRD updated as requirements evolve

### DON'T:
- ❌ Skip sections (mark as "N/A" if truly not applicable)
- ❌ Use technical jargon without explanation
- ❌ Forget about customer support implications
- ❌ Ignore performance and scaling considerations
- ❌ Leave success metrics vague or unmeasurable
- ❌ Create the PRD in isolation

## PRD Lifecycle

1. **Draft**: Initial creation, gathering requirements
2. **Review**: Stakeholder feedback and iteration
3. **Approved**: Sign-off from all stakeholders
4. **In Development**: Active implementation
5. **Launched**: Feature is live
6. **Archived**: Historical reference

## Tips for Success

1. **Collaborate Early**: Share drafts to get feedback before investing too much time
2. **Use Real Examples**: Concrete examples make requirements clearer
3. **Version Control**: Track changes and decisions in git
4. **Link Everything**: Connect to designs, tickets, and other docs
5. **Stay Focused**: Resist scope creep - document it for "v2"

## Questions?

- For template improvements: Create a PR with suggested changes
- For help with specific sections: Refer to the examples in each section file
- For feature-specific questions: Consult with the product team

---

Remember: A good PRD is a living document that evolves with your understanding of the problem and solution. Don't aim for perfection on the first draft - iterate based on feedback and learnings.