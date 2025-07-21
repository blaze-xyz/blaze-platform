# Webhook Specifications - Example Payment Integration

## Overview
This document provides detailed webhook specifications for the payment integration that go beyond the standard PRD format.

## Webhook Endpoints

### Production
- **URL**: `https://api.blaze.com/webhooks/provider-name/{event-type}`
- **Method**: POST
- **Authentication**: HMAC-SHA256 signature in `X-Provider-Signature` header

### Staging
- **URL**: `https://api-staging.blaze.com/webhooks/provider-name/{event-type}`

## Event Types

### payment.initiated
Fired when a payment is first created and processing begins.

**Payload Example**:
```json
{
  "event_id": "evt_1234567890",
  "event_type": "payment.initiated",
  "timestamp": "2024-01-15T10:30:00Z",
  "data": {
    "payment_id": "pay_abc123",
    "amount": 10000,
    "currency": "USD",
    "status": "processing",
    "metadata": {
      "user_id": "user_123",
      "transaction_id": "tx_456"
    }
  }
}
```

### payment.completed
Fired when payment successfully completes.

**Payload Example**:
```json
{
  "event_id": "evt_1234567891",
  "event_type": "payment.completed",
  "timestamp": "2024-01-15T10:35:00Z",
  "data": {
    "payment_id": "pay_abc123",
    "amount": 10000,
    "currency": "USD",
    "status": "completed",
    "settlement_date": "2024-01-17",
    "fees": {
      "amount": 250,
      "currency": "USD"
    }
  }
}
```

### payment.failed
Fired when payment fails for any reason.

**Payload Example**:
```json
{
  "event_id": "evt_1234567892",
  "event_type": "payment.failed",
  "timestamp": "2024-01-15T10:32:00Z",
  "data": {
    "payment_id": "pay_abc123",
    "amount": 10000,
    "currency": "USD",
    "status": "failed",
    "failure_reason": "insufficient_funds",
    "failure_code": "NSF",
    "can_retry": true
  }
}
```

## Signature Verification

```typescript
function verifyWebhookSignature(
  payload: string,
  signature: string,
  secret: string
): boolean {
  const expectedSignature = crypto
    .createHmac('sha256', secret)
    .update(payload)
    .digest('hex');
  
  return crypto.timingSafeEqual(
    Buffer.from(signature),
    Buffer.from(expectedSignature)
  );
}
```

## Retry Policy

- **Initial Retry**: 5 seconds
- **Backoff**: Exponential (5s, 10s, 30s, 1m, 5m, 15m, 30m, 1h)
- **Max Retries**: 8
- **Timeout**: 30 seconds per attempt

## Expected Responses

### Success
```
HTTP/1.1 200 OK
Content-Type: application/json

{
  "received": true
}
```

### Temporary Failure (will retry)
```
HTTP/1.1 503 Service Unavailable
Retry-After: 60
```

### Permanent Failure (won't retry)
```
HTTP/1.1 400 Bad Request
Content-Type: application/json

{
  "error": "Invalid payload",
  "code": "INVALID_PAYLOAD"
}
```

## Testing

### Test Webhook Trigger
```bash
curl -X POST https://api.provider.com/webhooks/test \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "event_type": "payment.completed",
    "payment_id": "pay_test_123"
  }'
```

### Webhook Simulator
Available at: https://dashboard.provider.com/webhooks/simulator

## Monitoring

### Expected Latency
- p50: < 100ms
- p95: < 500ms
- p99: < 2s

### Alert Thresholds
- Signature verification failures > 1%
- Processing time > 5s
- Queue depth > 1000
- Failed webhooks > 5% in 5 minutes