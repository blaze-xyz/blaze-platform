# Frontend Specs

## Purpose
Define detailed technical specifications for frontend implementation, including UI components, state management, user flows, and integration with backend services.

### Template:
```
## Frontend Specs

### UI/UX Overview
[High-level description of the user interface and experience]

### Component Architecture

#### New Components

##### [ComponentName]
**Purpose**: [What this component does]  
**Props**:
```typescript
interface ComponentProps {
  propName: type; // description
  onEvent?: (data: type) => void;
}
```
**State**:
```typescript
interface ComponentState {
  stateName: type; // description
}
```
**Key Features**:
- [Feature 1]
- [Feature 2]

#### Component Hierarchy
```
ParentComponent
├── ChildComponent1
│   ├── GrandchildComponent
│   └── GrandchildComponent2
└── ChildComponent2
```

### Screen Specifications

#### [Screen Name]
**Route**: `/path/to/screen`  
**Purpose**: [What users do here]  
**Components Used**: [List of components]

**State Management**:
```typescript
interface ScreenState {
  isLoading: boolean;
  data: DataType | null;
  error: Error | null;
}
```

**User Actions**:
1. [Action]: [What happens]
2. [Action]: [What happens]

### State Management

#### Local State
- **Component**: [Where managed]
- **Data**: [What's stored]

#### Global State
```typescript
interface GlobalState {
  feature: {
    data: Type;
    status: 'idle' | 'loading' | 'success' | 'error';
  };
}
```

#### Cache Strategy
- **Data Type**: [Cache duration and policy]
- **Invalidation**: [When to refresh]

### API Integration

#### GraphQL Queries
```typescript
const GET_DATA = gql`
  query GetData($id: ID!) {
    data(id: $id) {
      id
      field
    }
  }
`;
```

#### GraphQL Mutations
```typescript
const CREATE_THING = gql`
  mutation CreateThing($input: CreateInput!) {
    createThing(input: $input) {
      id
      status
    }
  }
`;
```

#### Error Handling
```typescript
interface ErrorDisplay {
  title: string;
  message: string;
  action?: {
    label: string;
    handler: () => void;
  };
}
```

### Navigation Flow

#### Flow Diagram
```
Home → Feature List → Feature Detail → Action → Success
                    ↓                    ↓
                 Error Page          Error Modal
```

#### Deep Linking
- **Pattern**: `/feature/:id/action`
- **Parameters**: [What each param means]

### Form Handling

#### [Form Name]
**Fields**:
```typescript
interface FormData {
  field1: string; // validation: required, min 3 chars
  field2: number; // validation: min 0, max 100
}
```

**Validation Rules**:
- Field-level validation on blur
- Form-level validation on submit
- Server error mapping

### Responsive Design

#### Breakpoints
- **Mobile**: < 768px
- **Tablet**: 768px - 1024px
- **Desktop**: > 1024px

#### Component Variations
- **Mobile**: [How it differs]
- **Tablet**: [How it differs]
- **Desktop**: [Full features]

### Performance Optimization

#### Code Splitting
- Lazy load: [Which components]
- Bundle size targets: [Size limits]

#### Optimization Techniques
- Virtualization for: [Long lists]
- Memoization for: [Expensive computations]
- Debouncing for: [User inputs]

### Accessibility

#### WCAG Compliance
- **Level**: AA
- **Key Requirements**:
  - Keyboard navigation
  - Screen reader support
  - Color contrast ratios
  - Focus indicators

#### ARIA Implementation
```tsx
<button
  aria-label="Submit deposit"
  aria-disabled={isLoading}
  aria-describedby="error-message"
>
```

### Analytics Implementation

#### Event Tracking
```typescript
trackEvent('feature.action.performed', {
  propertyName: value,
});
```

#### Page Views
- Route changes automatically tracked
- Custom page view events for modals

### Testing Strategy

#### Unit Tests
- Component rendering
- User interactions
- State changes

#### Integration Tests
- User flows
- API interactions
- Error scenarios

#### E2E Tests
- Critical paths
- Cross-browser testing
```

### Example:
```
## Frontend Specs

### UI/UX Overview
The ACH deposit feature integrates seamlessly into the existing deposit flow, adding bank account as a payment method option. The UI emphasizes trust and security while providing clear feedback about the multi-day processing time.

### Component Architecture

#### New Components

##### BankAccountSelector
**Purpose**: Display connected bank accounts and allow selection  
**Props**:
```typescript
interface BankAccountSelectorProps {
  accounts: BankAccount[];
  selectedId?: string;
  onSelect: (accountId: string) => void;
  onAddAccount: () => void;
}
```
**Key Features**:
- Display masked account numbers
- Show bank logos when available
- Highlight default account
- "Add Bank Account" CTA

##### PlaidLinkButton
**Purpose**: Initiate Plaid Link flow for bank connection  
**Props**:
```typescript
interface PlaidLinkButtonProps {
  onSuccess: (publicToken: string, metadata: PlaidMetadata) => void;
  onError: (error: PlaidError) => void;
  environment: 'sandbox' | 'production';
}
```
**State**:
```typescript
interface PlaidLinkState {
  linkToken: string | null;
  isLoading: boolean;
  error: Error | null;
}
```

##### ACHDepositForm
**Purpose**: Handle amount entry and deposit initiation  
**Props**:
```typescript
interface ACHDepositFormProps {
  selectedAccount: BankAccount;
  onSubmit: (amount: number) => void;
  limits: {
    min: number;
    max: number;
    daily: number;
  };
}
```

#### Component Hierarchy
```
DepositScreen
├── PaymentMethodTabs
│   ├── CardTab
│   └── ACHTab
│       ├── BankAccountSelector
│       │   └── BankAccountCard
│       ├── PlaidLinkButton
│       └── ACHDepositForm
│           ├── AmountInput
│           ├── FeeDisplay
│           └── ProcessingTimeNotice
```

### Screen Specifications

#### Bank Account Management Screen
**Route**: `/settings/payment-methods/bank-accounts`  
**Purpose**: View and manage connected bank accounts

**State Management**:
```typescript
interface BankAccountsState {
  accounts: BankAccount[];
  isLoading: boolean;
  isConnecting: boolean;
  error: Error | null;
  deleteConfirmation: {
    accountId: string;
    isOpen: boolean;
  } | null;
}
```

**User Actions**:
1. View list of connected accounts
2. Add new bank account via Plaid
3. Set default account
4. Remove bank account (with confirmation)

#### ACH Deposit Flow
**Route**: `/deposit?method=ach`  
**Purpose**: Complete ACH deposit

**Steps**:
1. **Select Account**: Choose from connected banks or add new
2. **Enter Amount**: Input with validation and limits
3. **Review**: Show fees, processing time, total
4. **Confirm**: Submit deposit with loading state
5. **Success**: Show confirmation with tracking info

### State Management

#### Local State (Component Level)
- **Form Data**: Amount, selected account (in ACHDepositForm)
- **UI State**: Loading, errors, validation (per component)

#### Global State (Redux/Context)
```typescript
interface PaymentMethodsState {
  bankAccounts: {
    data: BankAccount[];
    isLoading: boolean;
    error: Error | null;
  };
  achDeposit: {
    status: 'idle' | 'pending' | 'success' | 'error';
    transaction: Transaction | null;
    error: Error | null;
  };
}
```

#### Cache Strategy
- **Bank Accounts**: Cache for session, invalidate on add/remove
- **Transaction History**: Cache for 5 minutes
- **Plaid Link Token**: No cache, always fresh

### API Integration

#### GraphQL Queries
```typescript
const GET_BANK_ACCOUNTS = gql`
  query GetBankAccounts {
    bankAccounts {
      id
      mask
      bankName
      accountType
      isDefault
      createdAt
    }
  }
`;

const GET_ACH_LIMITS = gql`
  query GetACHLimits {
    achDepositLimits {
      minAmount
      maxAmount
      dailyLimit
      dailyRemaining
    }
  }
`;
```

#### GraphQL Mutations
```typescript
const CONNECT_BANK_ACCOUNT = gql`
  mutation ConnectBankAccount($input: ConnectBankAccountInput!) {
    connectBankAccount(input: $input) {
      id
      mask
      bankName
    }
  }
`;

const INITIATE_ACH_DEPOSIT = gql`
  mutation InitiateACHDeposit($input: ACHDepositInput!) {
    initiateACHDeposit(input: $input) {
      id
      amount
      status
      estimatedSettlement
    }
  }
`;
```

#### Error Handling
```typescript
const ACH_ERROR_MESSAGES: Record<string, ErrorDisplay> = {
  AMOUNT_TOO_LOW: {
    title: "Amount Too Low",
    message: "Minimum deposit is $10",
    action: {
      label: "Update Amount",
      handler: () => focusAmountInput(),
    },
  },
  DAILY_LIMIT_EXCEEDED: {
    title: "Daily Limit Reached",
    message: "You've reached your daily ACH deposit limit",
    action: {
      label: "Try Tomorrow",
      handler: () => navigateToHome(),
    },
  },
};
```

### Form Handling

#### ACH Deposit Form
**Fields**:
```typescript
interface ACHDepositFormData {
  amount: string; // As string for input, convert to cents
  accountId: string; // Selected bank account
}
```

**Validation Rules**:
```typescript
const validationSchema = yup.object({
  amount: yup
    .number()
    .min(10, "Minimum deposit is $10")
    .max(25000, "Maximum deposit is $25,000")
    .required("Amount is required"),
  accountId: yup
    .string()
    .required("Please select a bank account"),
});
```

### Responsive Design

#### Mobile Optimizations
- Full-screen Plaid Link experience
- Large touch targets (min 44px)
- Simplified account cards
- Bottom sheet for confirmations

#### Tablet Adjustments
- Side-by-side account comparison
- Larger amount input
- More details visible by default

#### Desktop Features
- Inline Plaid Link (modal)
- Hover states for all interactive elements
- Keyboard shortcuts for power users

### Performance Optimization

#### Code Splitting
```typescript
const PlaidLink = lazy(() => import('./components/PlaidLink'));
const ACHDepositFlow = lazy(() => import('./flows/ACHDeposit'));
```

#### Optimization Techniques
- Debounce amount validation (300ms)
- Memoize fee calculations
- Virtualize account list if > 20 accounts
- Prefetch bank logos

### Accessibility

#### Keyboard Navigation
- Tab through all form fields
- Enter to submit forms
- Escape to close modals
- Arrow keys for account selection

#### Screen Reader Support
```tsx
<div role="status" aria-live="polite">
  {isLoading && "Connecting to your bank..."}
  {error && `Error: ${error.message}`}
</div>
```

#### Color and Contrast
- Error states not solely color-based
- Success/pending states use icons + color
- All text meets WCAG AA contrast ratios

### Analytics Implementation

#### Key Events
```typescript
// Bank connection flow
trackEvent('ach.bank_connection.started');
trackEvent('ach.bank_connection.completed', { 
  bankName: metadata.institution.name 
});

// Deposit flow
trackEvent('ach.deposit.amount_entered', { 
  amount: amountInCents 
});
trackEvent('ach.deposit.initiated', { 
  amount: amountInCents,
  bankAccountId: hashedId,
});
```

### Testing Strategy

#### Unit Tests
```typescript
describe('ACHDepositForm', () => {
  it('validates minimum amount', () => {});
  it('shows daily limit when exceeded', () => {});
  it('calculates fees correctly', () => {});
});
```

#### E2E Tests
```typescript
describe('ACH Deposit Flow', () => {
  it('completes full deposit flow', () => {
    // 1. Connect bank account
    // 2. Select account
    // 3. Enter amount
    // 4. Submit deposit
    // 5. Verify success
  });
});
```
```

### Best Practices:
1. **Component reusability**: Design components for reuse
2. **State locality**: Keep state as close to usage as possible
3. **Error boundaries**: Wrap features in error boundaries
4. **Loading states**: Always show loading feedback
5. **Optimistic updates**: Update UI before server confirms
6. **Responsive first**: Design mobile-first, enhance for desktop