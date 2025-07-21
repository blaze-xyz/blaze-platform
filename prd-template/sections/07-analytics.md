# Analytics

## Purpose
Define all analytics events, properties, and tracking requirements. This ensures we can measure feature success, understand user behavior, and make data-driven decisions.

### Template:
```
## Analytics

### Event Naming Convention
`[feature].[action].[result]`
Example: `ach_deposit.initiated.success`

### Core Events

#### [Event Name]
**Trigger**: [When this event fires]  
**Category**: [User Action | System Event | Error]  
**Properties**:
```typescript
{
  // Required properties
  userId: string
  timestamp: string
  
  // Event-specific properties
  propertyName: type // description
  propertyName: type // description
}
```
**Purpose**: [Why we track this]  
**Questions it answers**: [Business questions this helps answer]

### Funnel Events
Define the key steps in the user journey:

1. `[feature].funnel.step1`
2. `[feature].funnel.step2`
3. `[feature].funnel.completed`

### Error Tracking

#### [Error Event Name]
**Properties**:
```typescript
{
  errorCode: string
  errorMessage: string
  errorType: 'user' | 'system' | 'external'
  context: object
}
```

### Metrics to Calculate

#### [Metric Name]
- **Definition**: [How to calculate]
- **Target**: [Goal value]
- **Frequency**: [How often to measure]

### Dashboard Requirements
- **Real-time metrics**: [List of real-time needs]
- **Daily/Weekly/Monthly aggregations**: [What to aggregate]
- **Alerts**: [Conditions for alerts]

### Implementation Notes
- Use existing event schema where possible
- Consider data volume and sampling needs
- Ensure PII is not included in event properties
- Follow company data retention policies
```

### Example:
```
## Analytics

### Event Naming Convention
`[feature].[action].[result]`

### Core Events

#### ach_deposit.initiated.success
**Trigger**: User successfully submits ACH deposit request  
**Category**: User Action  
**Properties**:
```typescript
{
  // Required properties
  userId: string
  timestamp: string
  sessionId: string
  
  // Event-specific properties
  amount: number // Amount in cents
  currency: 'USD'
  bankAccountId: string // Hashed bank account identifier
  paymentMethodId: string
  estimatedSettlementDays: number
  userAccountAge: number // Days since account creation
  previousDepositCount: number
  previousDepositMethod: 'card' | 'ach' | 'crypto' | null
}
```
**Purpose**: Track deposit initiation for conversion funnel  
**Questions it answers**: 
- What's the average ACH deposit amount?
- How many users attempt ACH vs card deposits?

#### ach_deposit.status.updated
**Trigger**: Webhook updates transaction status  
**Category**: System Event  
**Properties**:
```typescript
{
  userId: string
  timestamp: string
  transactionId: string
  previousStatus: string
  newStatus: 'pending' | 'processing' | 'completed' | 'failed' | 'cancelled'
  processingTime: number // milliseconds since initiation
  failureReason?: string // Only if failed
}
```

### Funnel Events

1. `ach_deposit.funnel.viewed_option` - User sees ACH as payment option
2. `ach_deposit.funnel.selected_ach` - User selects ACH over other methods
3. `ach_deposit.funnel.entered_amount` - User enters deposit amount
4. `ach_deposit.funnel.confirmed` - User confirms deposit details
5. `ach_deposit.funnel.completed` - Deposit successfully initiated

### Error Tracking

#### ach_deposit.error.validation_failed
**Properties**:
```typescript
{
  errorCode: 'AMOUNT_TOO_LOW' | 'AMOUNT_TOO_HIGH' | 'DAILY_LIMIT_EXCEEDED'
  errorMessage: string
  errorType: 'user'
  attemptedAmount: number
  limitValue: number
  bankAccountId: string
}
```

#### ach_deposit.error.api_failure
**Properties**:
```typescript
{
  errorCode: string
  errorMessage: string
  errorType: 'external'
  provider: 'coinflow' | 'plaid'
  httpStatus: number
  retriable: boolean
}
```

### Metrics to Calculate

#### ACH Adoption Rate
- **Definition**: (Unique users with ACH deposit / Total users with any deposit) * 100
- **Target**: 20% within 30 days of launch
- **Frequency**: Daily

#### Average ACH Deposit Value
- **Definition**: Sum of ACH deposits / Count of ACH deposits
- **Target**: $2,000
- **Frequency**: Daily

#### ACH Success Rate
- **Definition**: (Completed ACH deposits / Initiated ACH deposits) * 100
- **Target**: > 90%
- **Frequency**: Hourly (for monitoring)

#### Time to Settlement
- **Definition**: Average time from initiation to completion
- **Target**: < 3 business days
- **Frequency**: Daily

### Dashboard Requirements
- **Real-time metrics**: 
  - Current processing deposits count
  - Last hour success rate
  - Current day deposit volume
- **Daily aggregations**:
  - New ACH users
  - Total ACH volume
  - Average deposit size
  - Success/failure rates
- **Alerts**:
  - Success rate drops below 85%
  - API errors exceed 5% in 10-minute window
  - Average settlement time exceeds 4 days

### Implementation Notes
- Hash bank account IDs before sending to analytics
- Do not include full bank names or account numbers
- Use userId rather than email/phone for privacy
- Sample high-volume events at 10% after first week
- Ensure all monetary values are in cents to avoid float issues
```

### Best Practices:
1. **Privacy first**: Never log PII or sensitive financial data
2. **Consistent naming**: Follow the naming convention strictly
3. **Property types**: Always specify data types for properties
4. **Business value**: Every event should answer a specific question
5. **Versioning**: Plan for event schema evolution
6. **Testing**: Verify events fire correctly before launch