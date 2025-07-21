# New Feature PRD Prompt Template

Use this prompt when starting a new feature to ensure all necessary information is captured in the PRD.

---

## Prompt for New Feature PRD

```
I need to create a Product Requirements Document (PRD) for a new feature. Please help me structure this according to our PRD template.

**Feature Name**: [Name of the feature]

**Feature Description**: 
[2-3 sentences describing what this feature does]

**Business Context**:
- Current situation: [What's happening now]
- Problem we're solving: [Main pain points]
- Business value: [Expected impact]

**Users**:
- Primary users: [Who will use this most]
- Secondary users: [Other user groups]
- User needs: [What users are asking for]

**High-Level Requirements**:
- [Requirement 1]
- [Requirement 2]
- [Requirement 3]

**Technical Considerations**:
- Existing systems to integrate with: [List systems]
- External services needed: [APIs, third-party services]
- Performance requirements: [Any specific needs]
- Security/compliance needs: [Any special requirements]

**Success Criteria**:
- How will we measure success: [Key metrics]
- Target values: [Specific goals]

**Timeline**:
- Desired launch date: [Date]
- Any hard deadlines: [Events, regulatory, etc.]

**Constraints**:
- Budget: [If applicable]
- Technical limitations: [Known constraints]
- Resource availability: [Team constraints]

**Additional Context**:
[Any other relevant information, competitor features, user feedback, etc.]

Please create a comprehensive PRD following our template structure, filling in all sections with appropriate detail based on the information provided above. For any sections where information is missing, please indicate what additional details would be needed.
```

---

## Quick Start Prompts by Feature Type

### Payment Integration
```
Create a PRD for integrating [Payment Provider Name] as a new payment method. 

Key details:
- Payment type: [Card/Bank/Crypto/etc]
- Transaction limits: [Min/max amounts]
- Geographic availability: [Countries]
- Processing time: [Instant/1-3 days/etc]
- Fees: [Percentage and/or fixed]
- Why this provider: [Business reason]
```

### User Feature
```
Create a PRD for [Feature Name] that allows users to [primary action].

User problem:
- Users currently have to [current process]
- This causes [pain points]
- Users have requested [specific asks]

Expected outcome:
- Users will be able to [new capability]
- This will reduce/improve [metric]
```

### Internal Tool
```
Create a PRD for an internal tool that helps [team] to [objective].

Current workflow:
- Team currently [manual process]
- Takes [time] per [frequency]
- Causes [issues/delays]

Desired workflow:
- Automated/simplified process for [tasks]
- Expected time savings: [amount]
- Additional benefits: [list]
```

### API/Integration
```
Create a PRD for building an API/webhook integration with [service].

Integration purpose:
- Send data: [what data and when]
- Receive data: [what data and when]
- Business logic: [what happens with the data]

Technical requirements:
- Authentication method: [API key/OAuth/etc]
- Rate limits: [if known]
- Data format: [JSON/XML/etc]
- Real-time vs batch: [which one]
```

---

## PRD Review Checklist

Before finalizing your PRD, ensure you have:

### Completeness
- [ ] All template sections are filled out
- [ ] Visuals/mockups are included
- [ ] Success metrics are specific and measurable
- [ ] Timeline and phases are realistic
- [ ] Technical specs are detailed enough for implementation

### Clarity
- [ ] Problem statement is clear and compelling
- [ ] Requirements are unambiguous
- [ ] User stories have clear acceptance criteria
- [ ] Technical constraints are documented
- [ ] Dependencies are identified

### Alignment
- [ ] Stakeholders are identified and consulted
- [ ] Success metrics align with business goals
- [ ] Technical approach aligns with architecture
- [ ] Timeline aligns with business needs
- [ ] Resource needs are understood

### Risk Management
- [ ] Technical risks are identified
- [ ] Mitigation strategies are defined
- [ ] Rollback plan is documented
- [ ] Security/compliance reviewed
- [ ] Performance impact assessed

---

## Tips for Writing Effective PRDs

1. **Start with Why**: Always begin with the problem, not the solution
2. **Be Specific**: Use numbers, not vague terms like "improve" or "faster"
3. **Include Visuals**: A picture is worth a thousand words
4. **Think End-to-End**: Consider the entire user journey
5. **Plan for Failure**: What happens when things go wrong?
6. **Iterate**: PRDs are living documents that evolve
7. **Get Feedback Early**: Share drafts with stakeholders
8. **Consider Support**: How will customer support handle this?
9. **Think Long-term**: How will this scale? What's the maintenance burden?
10. **Document Decisions**: Explain why you chose this approach over alternatives

---

## Common Pitfalls to Avoid

1. **Solution in Search of a Problem**: Starting with a feature idea instead of user need
2. **Scope Creep**: Adding "nice to haves" that delay the core value
3. **Unclear Success**: Not defining how to measure success
4. **Missing Edge Cases**: Only considering the happy path
5. **Ignoring Technical Debt**: Not considering long-term maintenance
6. **Poor Communication Planning**: Forgetting about user education
7. **Incomplete Testing Plans**: Not planning for quality assurance
8. **Unrealistic Timelines**: Not accounting for unknowns and delays
9. **Siloed Thinking**: Not considering impact on other teams/features
10. **No Rollback Plan**: Not planning for if things go wrong