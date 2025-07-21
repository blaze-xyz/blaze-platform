# Custom Specs Directory

This directory is for feature-specific documentation that doesn't fit into the standard PRD template sections. Each feature can have its own subdirectory with custom specifications.

## When to Use Custom Specs

Use this directory when your feature requires:
- Detailed technical specifications beyond standard backend/frontend specs
- Complex business logic documentation
- Third-party integration guides
- Migration plans
- Security protocols
- Compliance documentation
- Performance benchmarks
- Custom workflows

## Directory Structure

```
custom-specs/
├── README.md (this file)
├── [feature-name]/
│   ├── integration-guide.md
│   ├── migration-plan.md
│   ├── security-review.md
│   ├── performance-benchmarks.md
│   └── [other-specific-docs].md
└── [another-feature]/
    └── [specific-docs].md
```

## Examples

### Payment Provider Integration
```
custom-specs/
└── coinflow-ach/
    ├── webhook-payload-examples.md
    ├── error-code-mapping.md
    ├── settlement-reconciliation.md
    └── test-scenarios.md
```

### Complex Migration
```
custom-specs/
└── user-data-migration/
    ├── migration-phases.md
    ├── rollback-procedures.md
    ├── data-validation-rules.md
    └── cutover-checklist.md
```

### Compliance Feature
```
custom-specs/
└── kyc-integration/
    ├── compliance-requirements.md
    ├── data-retention-policy.md
    ├── audit-trail-spec.md
    └── regulatory-mapping.md
```

## Best Practices

1. **Keep it Organized**: Create a subdirectory for each feature
2. **Use Clear Names**: File names should be self-descriptive
3. **Link from PRD**: Reference these documents in the main PRD
4. **Version Control**: Track changes carefully, especially for compliance docs
5. **Review Requirements**: Some docs may need legal/security review

## Template Files

Common custom spec templates:

### Integration Guide Template
- Authentication setup
- API endpoint documentation
- Request/response examples
- Error handling
- Rate limits
- Testing procedures

### Migration Plan Template
- Current state analysis
- Target state definition
- Migration phases
- Risk assessment
- Rollback procedures
- Success criteria

### Security Review Template
- Threat model
- Data flow diagram
- Encryption specifications
- Access control matrix
- Audit requirements
- Incident response plan

### Performance Benchmark Template
- Baseline metrics
- Target metrics
- Test scenarios
- Load patterns
- Optimization strategies
- Monitoring plan