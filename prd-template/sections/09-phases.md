# Phases

## Purpose
Break down the implementation into manageable phases with clear deliverables, dependencies, and success criteria. This enables incremental delivery and reduces risk.

### Template:
```
## Phases

### Phasing Strategy
[Explain the overall approach to breaking down the work]

### Phase Overview
| Phase | Name | Duration | Key Deliverables | Dependencies |
|-------|------|----------|------------------|--------------|
| 1 | [Name] | [X weeks] | [Main deliverable] | [Prerequisites] |
| 2 | [Name] | [X weeks] | [Main deliverable] | Phase 1 |

### Phase 1: [Phase Name]
**Duration**: [Timeframe]  
**Goal**: [What this phase accomplishes]

#### Deliverables
- [ ] [Specific deliverable with acceptance criteria]
- [ ] [Specific deliverable with acceptance criteria]

#### Success Criteria
- [ ] [Measurable outcome]
- [ ] [Measurable outcome]

#### Dependencies
- **External**: [External services or approvals needed]
- **Internal**: [Other teams or features required]

#### Risks & Mitigations
| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| [Risk description] | High/Med/Low | High/Med/Low | [Mitigation strategy] |

#### Go/No-Go Criteria
- [ ] [Condition that must be met to proceed]
- [ ] [Condition that must be met to proceed]

### Rollout Strategy
- **Feature Flags**: [Which flags control the rollout]
- **User Segments**: [How users will be given access]
- **Rollback Plan**: [How to revert if issues arise]

### Post-Launch Activities
- [ ] Monitor key metrics
- [ ] Gather user feedback
- [ ] Address critical bugs
- [ ] Plan next phase improvements
```

### Example:
```
## Phases

### Phasing Strategy
We'll implement ACH deposits in 4 phases, starting with backend infrastructure and gradually rolling out to users. This approach minimizes risk and allows us to validate assumptions before full launch.

### Phase Overview
| Phase | Name | Duration | Key Deliverables | Dependencies |
|-------|------|----------|------------------|--------------|
| 1 | Backend Infrastructure | 2 weeks | Database, APIs, Webhooks | Coinflow access |
| 2 | Bank Connection | 2 weeks | Plaid integration, UI | Phase 1, Plaid setup |
| 3 | Limited Beta | 3 weeks | Full ACH flow for 100 users | Phases 1-2 |
| 4 | General Availability | 2 weeks | Launch to all users | Beta success |

### Phase 1: Backend Infrastructure
**Duration**: 2 weeks (Sprint 24-25)  
**Goal**: Complete all backend components needed for ACH deposits

#### Deliverables
- [ ] Database schema with ACH support (migrations run in production)
- [ ] CoinflowACHService with full test coverage (>90%)
- [ ] Webhook endpoint processing ACH events
- [ ] Integration with RampProvider routing

#### Success Criteria
- [ ] All integration tests passing
- [ ] Webhook signature verification working
- [ ] Can process test ACH deposits in staging
- [ ] No impact on existing card deposits

#### Dependencies
- **External**: 
  - Coinflow production API credentials
  - Webhook URL configuration
- **Internal**: 
  - DevOps support for environment setup
  - Security review of data handling

#### Risks & Mitigations
| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| Coinflow API changes | High | Low | Maintain version lock, regular sync with Coinflow |
| Database migration issues | High | Medium | Test migrations in staging, have rollback ready |
| Webhook reliability | Medium | Medium | Implement retry logic and monitoring |

#### Go/No-Go Criteria
- [ ] All automated tests passing
- [ ] Security review approved
- [ ] Staging environment fully functional
- [ ] Rollback procedure tested

### Phase 2: Bank Connection UI
**Duration**: 2 weeks (Sprint 26-27)  
**Goal**: Enable users to connect bank accounts via Plaid

#### Deliverables
- [ ] Plaid Link integration in mobile app
- [ ] Bank account management UI
- [ ] GraphQL APIs for bank operations
- [ ] Error handling for connection failures

#### Success Criteria
- [ ] 95% success rate for bank connections in testing
- [ ] UI works on all supported devices
- [ ] Clear error messages for all failure scenarios

### Phase 3: Limited Beta
**Duration**: 3 weeks (Sprint 28-30)  
**Goal**: Validate ACH deposits with real users in production

#### Deliverables
- [ ] Feature flag system for beta access
- [ ] Beta user selection (100 high-value users)
- [ ] Monitoring dashboards
- [ ] Support documentation

#### Success Criteria
- [ ] 90% deposit success rate
- [ ] Average deposit value > $1,500
- [ ] Customer satisfaction > 4.5/5
- [ ] Support ticket rate < 5%

#### Rollout Strategy
- Week 1: 10 internal users
- Week 2: 50 beta users
- Week 3: 100 beta users

### Phase 4: General Availability
**Duration**: 2 weeks (Sprint 31-32)  
**Goal**: Launch ACH deposits to all eligible users

#### Deliverables
- [ ] Marketing communications
- [ ] Help center documentation
- [ ] Customer support training
- [ ] Performance optimizations

#### Rollout Strategy
- **Feature Flags**: 
  - `ach_deposits_enabled`: Controls feature visibility
  - `ach_deposit_limits`: Controls transaction limits
- **User Segments**:
  - Day 1-3: Verified users with 30+ day history
  - Day 4-7: All verified users
  - Week 2: New users (with lower limits)
- **Rollback Plan**:
  - Feature flag to hide ACH option
  - Disable webhook processing
  - Communication template ready

### Post-Launch Activities
- [ ] Monitor success rates hourly for first week
- [ ] Daily review of support tickets
- [ ] Weekly business metrics review
- [ ] Plan Phase 5: International ACH support
```

### Best Practices:
1. **Start small**: Begin with lowest risk components
2. **Build in buffers**: Add time for unexpected issues
3. **Define clear gates**: Don't proceed without meeting criteria
4. **Plan for rollback**: Always have a way to revert
5. **Measure everything**: Track metrics from day one
6. **Communicate clearly**: Keep stakeholders informed of progress