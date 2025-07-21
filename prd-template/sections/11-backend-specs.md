# Backend Specs

## Purpose
Define detailed technical specifications for backend implementation, including API design, database schema, service architecture, and integration requirements.

### Template:
```
## Backend Specs

### Architecture Overview
[High-level description of backend architecture and how this feature fits in]

### Database Schema

#### New Tables/Collections

##### [Table Name]
```sql
CREATE TABLE table_name (
    id UUID PRIMARY KEY,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    -- other fields
);
```
**Purpose**: [What this table stores]  
**Relationships**: [Foreign keys and associations]  
**Indexes**: [Required indexes for performance]

#### Schema Modifications
```sql
ALTER TABLE existing_table 
ADD COLUMN new_column TYPE;
```

### API Design

#### REST Endpoints

##### [Method] /api/v1/[resource]
**Purpose**: [What this endpoint does]  
**Authentication**: [Required auth method]  
**Request**:
```json
{
  "field": "value"
}
```
**Response** (200 OK):
```json
{
  "id": "uuid",
  "status": "success"
}
```
**Error Responses**:
- `400 Bad Request`: [When this occurs]
- `401 Unauthorized`: [When this occurs]
- `500 Internal Server Error`: [When this occurs]

#### GraphQL Schema

##### Types
```graphql
type NewType {
  id: ID!
  field: String!
  relatedObject: RelatedType
}
```

##### Mutations
```graphql
extend type Mutation {
  createThing(input: CreateThingInput!): Thing!
}

input CreateThingInput {
  field: String!
}
```

##### Queries
```graphql
extend type Query {
  thing(id: ID!): Thing
  things(filter: ThingFilter): [Thing!]!
}
```

### Service Architecture

#### New Services

##### [ServiceName]Service
**Purpose**: [Core responsibility]  
**Dependencies**: [Other services it needs]  
**Key Methods**:
```typescript
class ServiceName {
  async createThing(data: CreateData): Promise<Thing>
  async processThing(id: string): Promise<void>
}
```

#### Service Interactions
```
UserRequest → API Gateway → ServiceA → ServiceB → Database
                          ↓
                    QueueService → NotificationService
```

### External Integrations

#### [Third-party Service]
**Purpose**: [Why we integrate]  
**Authentication**: [API key, OAuth, etc]  
**Rate Limits**: [Requests per second/minute]  
**Key Endpoints**:
- `POST /endpoint`: [What it does]
- `GET /endpoint/:id`: [What it returns]

**Error Handling**:
- Retry strategy: [Exponential backoff, etc]
- Timeout: [Seconds]
- Fallback: [What happens on failure]

### Queue Design

#### [QueueName]
**Purpose**: [What tasks it handles]  
**Message Format**:
```json
{
  "type": "TASK_TYPE",
  "payload": {},
  "metadata": {}
}
```
**Processing**: [Concurrency, retry policy]  
**Dead Letter Queue**: [What happens to failed messages]

### Caching Strategy
- **Cache Layer**: [Redis, Memory, etc]
- **TTL**: [Time to live for different data types]
- **Invalidation**: [When to clear cache]

### Security Considerations
- **Authentication**: [How users are authenticated]
- **Authorization**: [Permission model]
- **Data Encryption**: [At rest and in transit]
- **PII Handling**: [How sensitive data is protected]

### Performance Requirements
- **API Latency**: [Target response times]
- **Throughput**: [Requests per second]
- **Database Queries**: [Query performance targets]

### Monitoring & Logging
- **Metrics**: [What to track]
- **Logs**: [What to log and log levels]
- **Alerts**: [Conditions for alerts]
- **Dashboards**: [Key visualizations needed]
```

### Example:
```
## Backend Specs

### Architecture Overview
ACH deposits will be integrated into the existing payment processing pipeline, utilizing the RampProvider pattern for routing and the existing transaction models with ACH-specific extensions.

### Database Schema

#### Schema Modifications

##### payment_methods table
```sql
-- Already supports via PaymentMethodType enum
-- Bank = ACH payment method
-- No changes needed
```

##### coinflow_payment_method_data table
```sql
-- Existing table structure supports ACH via JSON data field
-- ACH-specific data stored as:
{
  "accountId": "plaid_account_id",
  "accountMask": "1234",
  "bankName": "Chase Bank",
  "accountType": "checking",
  "routingNumber": "021000021" -- encrypted
}
```

##### coinflow_transfer_data table
```sql
-- Add new statuses to CoinflowTransferStatus enum
ALTER TYPE "CoinflowTransferStatus" ADD VALUE 'Processing';
ALTER TYPE "CoinflowTransferStatus" ADD VALUE 'Cancelled';
ALTER TYPE "CoinflowTransferStatus" ADD VALUE 'Settled';
ALTER TYPE "CoinflowTransferStatus" ADD VALUE 'RequiresAction';
```

### API Design

#### GraphQL Schema

##### Types
```graphql
type ACHBankAccount {
  id: ID!
  mask: String!
  bankName: String!
  accountType: String!
  isDefault: Boolean!
  createdAt: DateTime!
}

extend type PaymentMethod {
  achData: ACHBankAccount
}

extend type Transfer {
  estimatedSettlement: DateTime
  achReturnCode: String
}
```

##### Mutations
```graphql
extend type Mutation {
  connectBankAccount(input: ConnectBankAccountInput!): PaymentMethod!
  initiateACHDeposit(input: ACHDepositInput!): Transfer!
  removeBankAccount(paymentMethodId: ID!): Boolean!
}

input ConnectBankAccountInput {
  plaidPublicToken: String!
  accountId: String!
}

input ACHDepositInput {
  paymentMethodId: ID!
  amount: Int! # in cents
}
```

##### Queries
```graphql
extend type Query {
  bankAccounts: [PaymentMethod!]!
  achTransfer(id: ID!): Transfer
}
```

### Service Architecture

#### Modified Services

##### CoinflowService (Extended)
**Purpose**: Handle both Card and ACH operations  
**New Methods**:
```typescript
class CoinflowService {
  // Existing method now supports ACH
  async createCheckout(params: {
    amount: FiatAmountInMinorUnits;
    paymentMethodType: PaymentMethodType;
    paymentMethodId?: string;
    bankAccountId?: string; // For ACH
  }): Promise<CoinflowCheckout>

  async handleACHWebhook(
    event: CoinflowWebhookEvent
  ): Promise<void>
}
```

##### PlaidService (New)
**Purpose**: Handle bank account verification  
**Key Methods**:
```typescript
class PlaidService {
  async exchangePublicToken(token: string): Promise<string>
  async getAccountDetails(accessToken: string, accountId: string): Promise<PlaidAccount>
  async verifyAccountOwnership(accessToken: string): Promise<boolean>
  async handleWebhook(event: PlaidWebhook): Promise<void>
}
```

#### Service Interactions
```
GraphQL Mutation
    ↓
RampProviderRouter (routes to Coinflow for ACH)
    ↓
CoinflowService
    ↓
CoinflowAPIService → Coinflow ACH API
    ↓
Database (generic models)
    ↓
Webhook → CoinflowWebhookService → Status Updates
    ↓
NotificationService → Email/SMS
```

### External Integrations

#### Coinflow ACH API
**Purpose**: Process ACH deposits and convert to USDC  
**Authentication**: API Key + HMAC signature  
**Rate Limits**: 100 requests/minute  
**Key Endpoints**:
- `POST /v1/checkout/ach`: Create ACH checkout
- `GET /v1/checkout/:id`: Get checkout status

**Request Example**:
```json
{
  "amount": 10000, // cents
  "currency": "USD",
  "destinationAddress": "stellar:GDEX...",
  "bankAccountId": "plaid_account_id",
  "merchantTransactionId": "tx_123",
  "webhookUrl": "https://api.blaze.com/webhooks/coinflow/ach"
}
```

**Error Handling**:
- Retry strategy: Exponential backoff, max 3 retries
- Timeout: 30 seconds
- Fallback: Log error, notify user to retry

#### Plaid Integration
**Purpose**: Securely connect and verify bank accounts  
**Authentication**: Client ID + Secret  
**Key Flows**:
1. Link token creation (backend)
2. Plaid Link (frontend)
3. Public token exchange (backend)
4. Account verification (backend)

### Queue Design

#### ACHStatusUpdateQueue
**Purpose**: Process ACH webhook events asynchronously  
**Message Format**:
```json
{
  "type": "ACH_STATUS_UPDATE",
  "payload": {
    "transferId": "uuid",
    "oldStatus": "Pending",
    "newStatus": "Completed",
    "coinflowTransactionId": "cf_123"
  },
  "metadata": {
    "receivedAt": "2024-01-15T10:00:00Z",
    "retryCount": 0
  }
}
```
**Processing**: 
- Concurrency: 10 workers
- Retry: 3 attempts with exponential backoff
- DLQ: After 3 failures, move to dead letter queue

### Caching Strategy
- **Payment Methods**: Cache for 5 minutes after fetch
- **Transfer Status**: No caching (always fresh)
- **Bank Names**: Cache Plaid institution data for 24 hours
- **User Limits**: Cache for 1 minute

### Security Considerations
- **Bank Credentials**: Never stored, only Plaid access tokens
- **Routing Numbers**: Encrypted at rest using AES-256
- **Webhook Signatures**: Verify all Coinflow webhooks with HMAC
- **PII**: Mask account numbers, only store last 4 digits
- **Authorization**: Users can only access their own payment methods

### Performance Requirements
- **Deposit Initiation**: < 3 seconds (P95)
- **Bank Connection**: < 30 seconds (including Plaid)
- **Webhook Processing**: < 500ms
- **Status Query**: < 100ms

### Monitoring & Logging
- **Metrics**:
  - ACH deposit success rate
  - Average processing time
  - Webhook processing lag
  - API error rates
- **Logs**:
  - All ACH operations at INFO level
  - Errors with full context
  - Webhook payloads (without PII)
- **Alerts**:
  - Success rate < 85%
  - Webhook lag > 5 minutes
  - API errors > 5%
- **Dashboards**:
  - Real-time ACH volume
  - Status distribution
  - Error breakdown
  - Processing time trends
```

### Best Practices:
1. **Use existing patterns**: Follow established architectural patterns
2. **Design for scale**: Consider 10x growth scenarios
3. **Plan for failure**: Define behavior for every error case
4. **Security first**: Encrypt sensitive data, validate all inputs
5. **Make it observable**: Log and monitor everything
6. **Document decisions**: Explain why, not just what