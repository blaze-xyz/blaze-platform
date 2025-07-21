# Communications

## Purpose
Define all user communications related to the feature, including emails, SMS messages, push notifications, and in-app messaging. This ensures consistent and effective user communication throughout the feature experience.

### Template:
```
## Communications

### Communication Types

#### Email Templates

##### [Email Name]
**Trigger**: [When this email is sent]  
**Subject**: [Email subject line]  
**Preview Text**: [Email preview text]  
**From**: [Sender name and email]  
**Priority**: [Transactional | Marketing | Informational]

**Content**:
```
[Email body with placeholders for dynamic content]
```

**Dynamic Variables**:
- `{{userName}}`: User's display name
- `{{amount}}`: Transaction amount
- `{{customVariable}}`: Description

**Design Notes**:
- [Special design considerations]
- [CTA button requirements]

#### SMS Messages

##### [SMS Name]
**Trigger**: [When this SMS is sent]  
**Character Limit**: 160  
**Priority**: [High | Medium | Low]

**Content**:
```
[SMS message with {{variables}}]
```

**Opt-out**: [Include opt-out instructions if marketing]

#### Push Notifications

##### [Notification Name]
**Trigger**: [When this notification is sent]  
**Platform**: [iOS | Android | Both]  
**Type**: [Alert | Silent | Rich]

**Title**: [Notification title]  
**Body**: [Notification message]  
**Deep Link**: [Where it takes the user]

**Rich Media** (if applicable):
- Image requirements
- Action buttons

### Communication Flow

1. **[Event]** → [Communication type]
2. **[Event]** → [Communication type]

### Localization Requirements
- Languages supported: [List languages]
- Regional variations: [Any regional differences]

### Compliance Requirements
- Include unsubscribe links in marketing emails
- SMS compliance with TCPA
- Push notification opt-in requirements
```

### Example:
```
## Communications

### Communication Types

#### Email Templates

##### ACH Deposit Initiated
**Trigger**: User successfully initiates ACH deposit  
**Subject**: Your ${{amount}} deposit is on the way  
**Preview Text**: Your bank transfer has been initiated and will arrive in 1-3 business days  
**From**: Blaze <noreply@blaze.com>  
**Priority**: Transactional

**Content**:
```
Hi {{userName}},

Your ACH deposit has been initiated successfully!

**Deposit Details:**
- Amount: ${{amount}} USD
- From: {{bankName}} (...{{lastFour}})
- Expected arrival: {{estimatedArrival}}
- Transaction ID: {{transactionId}}

Your funds will be automatically converted to USDC and deposited to your Blaze wallet once the bank transfer completes.

**What's next?**
You can track your deposit status in the app. We'll notify you when your funds arrive.

Need help? Reply to this email or visit our Help Center.

Best,
The Blaze Team
```

**Dynamic Variables**:
- `{{userName}}`: User's first name or display name
- `{{amount}}`: Deposit amount formatted with commas
- `{{bankName}}`: Connected bank name
- `{{lastFour}}`: Last 4 digits of account
- `{{estimatedArrival}}`: Date range (e.g., "March 15-17")
- `{{transactionId}}`: Unique transaction identifier

#### SMS Messages

##### ACH Deposit Failed
**Trigger**: ACH deposit fails or is returned  
**Character Limit**: 160  
**Priority**: High

**Content**:
```
Blaze: Your ${{amount}} deposit failed. Reason: {{failureReason}}. Open app for details or to retry. Text STOP to opt out.
```

#### Push Notifications

##### ACH Deposit Completed
**Trigger**: ACH deposit successfully completes and USDC is credited  
**Platform**: Both  
**Type**: Alert

**Title**: Deposit Complete! 
**Body**: Your ${{amount}} deposit has arrived and been converted to USDC  
**Deep Link**: /wallet/transactions/{{transactionId}}

### Communication Flow

1. **Deposit Initiated** → Transactional Email (immediate)
2. **Status Change** → Push Notification (if enabled)
3. **Deposit Failed** → SMS (immediate) + Email (immediate)
4. **Deposit Completed** → Push Notification + Email

### Localization Requirements
- Languages supported: English (launch), Spanish (Phase 2)
- Currency formatting based on user locale

### Compliance Requirements
- No marketing content in transactional emails
- Include transaction details for record-keeping
- Clear support contact information
- SMS includes opt-out instructions
```

### Best Practices:
1. **Timing**: Send transactional messages immediately
2. **Clarity**: Use simple, clear language
3. **Actionable**: Include clear next steps or CTAs
4. **Consistency**: Match in-app messaging tone
5. **Testing**: A/B test subject lines and content
6. **Accessibility**: Ensure emails work with screen readers