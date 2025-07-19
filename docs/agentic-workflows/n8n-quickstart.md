# n8n Quick Start Guide for Blaze Agentic Workflows

## Overview
This guide will help you get n8n running with the bug fixing workflow in under 30 minutes.

## Prerequisites
- Docker and Docker Compose installed
- Access to Blaze's APIs (Slack, GitHub, ClickUp, etc.)
- Claude API key from Anthropic

## Step 1: Clone and Setup (5 minutes)

```bash
# Create n8n directory
mkdir -p ~/blaze-n8n
cd ~/blaze-n8n

# Create docker-compose.yml
cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  n8n:
    image: n8nio/n8n:latest
    container_name: blaze-n8n
    restart: always
    ports:
      - "5678:5678"
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=changeme
      - N8N_ENCRYPTION_KEY=your-32-char-encryption-key-here
      - N8N_HOST=localhost
      - N8N_PORT=5678
      - N8N_PROTOCOL=http
      - WEBHOOK_URL=http://localhost:5678
      - NODE_ENV=production
    volumes:
      - n8n_data:/home/node/.n8n
      - ./workflows:/workflows
      - ./custom-nodes:/home/node/.n8n/custom

  postgres:
    image: postgres:15
    container_name: n8n-postgres
    restart: always
    environment:
      - POSTGRES_USER=n8n
      - POSTGRES_PASSWORD=n8n
      - POSTGRES_DB=n8n
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  n8n_data:
  postgres_data:
EOF

# Start n8n
docker-compose up -d
```

## Step 2: Access n8n UI (2 minutes)

1. Open browser to http://localhost:5678
2. Login with admin/changeme
3. Complete initial setup wizard

## Step 3: Add Credentials (10 minutes)

Navigate to **Credentials** in n8n and add:

### 1. Slack API
```
Type: Slack API
Name: Blaze Slack
Access Token: xoxb-your-slack-bot-token
```

### 2. Claude API
```
Type: Header Auth
Name: Claude API
Header Name: x-api-key
Header Value: your-claude-api-key
```

### 3. PostgreSQL
```
Type: Postgres
Name: Production DB Read-Only
Host: your-db-host.amazonaws.com
Database: production
User: readonly_user
Password: your-password
SSL: Enable
```

### 4. ClickUp API
```
Type: Header Auth
Name: ClickUp API
Header Name: Authorization
Header Value: your-clickup-api-key
```

### 5. GitHub API
```
Type: GitHub API
Name: Blaze GitHub
Access Token: your-github-pat
```

## Step 4: Import Workflow Template (5 minutes)

### Option A: Import via UI
1. Click **Workflows** → **Add Workflow** → **Import from File**
2. Select `bug-investigation-template.json`
3. Update any environment-specific values

### Option B: Import via CLI
```bash
# Download the template
curl -O https://raw.githubusercontent.com/blaze-xyz/blaze-platform/main/docs/agentic-workflows/n8n-workflows/bug-investigation-template.json

# Import using n8n CLI
docker exec -it blaze-n8n n8n import:workflow --input=/workflows/bug-investigation-template.json
```

## Step 5: Configure Environment Variables (3 minutes)

Create `.env` file:
```bash
cat > .env << 'EOF'
# ClickUp
CLICKUP_BUG_LIST_ID=your-bug-list-id
CLICKUP_WORKSPACE_ID=your-workspace-id

# Sentry
SENTRY_PROJECT=spark
SENTRY_ORG=blaze-xyz

# Workflow IDs (update after creating workflows)
SOLUTION_WORKFLOW_ID=workflow-id-here
REVIEW_WORKFLOW_ID=workflow-id-here
QA_WORKFLOW_ID=workflow-id-here

# Slack
SLACK_CHANNEL_BUGS=#eng-bugs
SLACK_CHANNEL_ALERTS=#eng-alerts
EOF
```

Update docker-compose.yml to use env file:
```yaml
services:
  n8n:
    env_file:
      - .env
```

## Step 6: Test the Workflow (5 minutes)

### 1. Create Test Webhook
In n8n UI:
1. Open the Bug Investigation workflow
2. Click on "Slack Bug Report" node
3. Click "Listen for Test Event"
4. Copy the webhook URL

### 2. Send Test Request
```bash
# Test with curl
curl -X POST http://localhost:5678/webhook-test/slack-bug-report \
  -H "Content-Type: application/json" \
  -d '{
    "user_name": "test_user",
    "user": {"email": "test@blaze.xyz"},
    "channel_id": "C1234567890",
    "text": "Users are seeing 500 errors when trying to withdraw funds",
    "ts": "1234567890.123456"
  }'
```

### 3. Verify Execution
- Check n8n execution history
- Verify ClickUp ticket created
- Check Slack notification sent

## Step 7: Connect to Real Slack (5 minutes)

### 1. Create Slack App
1. Go to https://api.slack.com/apps
2. Create new app → From scratch
3. Add OAuth scopes:
   - `commands`
   - `chat:write`
   - `chat:write.public`

### 2. Add Slash Command
```
Command: /bug-report
Request URL: https://your-n8n-url/webhook/slack-bug-report
Short Description: Report a bug for investigation
```

### 3. Install to Workspace
1. Install app to your Slack workspace
2. Copy Bot User OAuth Token
3. Update n8n Slack credential

## Common Issues & Solutions

### Issue: Claude API returns 401
**Solution**: Verify API key and add `anthropic-version: 2023-06-01` header

### Issue: PostgreSQL connection fails
**Solution**: 
- Check firewall rules allow n8n IP
- Verify SSL is enabled
- Test connection from container:
```bash
docker exec -it blaze-n8n sh
apk add postgresql-client
psql "postgresql://user:pass@host:5432/db?sslmode=require"
```

### Issue: Workflow execution fails silently
**Solution**: 
- Check n8n logs: `docker logs blaze-n8n`
- Enable debug mode: Add `N8N_LOG_LEVEL=debug` to environment
- Check node timeout settings

## Production Deployment

### 1. Use Proper Domain
```nginx
server {
    listen 80;
    server_name n8n.blaze.xyz;
    
    location / {
        proxy_pass http://localhost:5678;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
    }
}
```

### 2. Enable HTTPS
```bash
# Use Let's Encrypt
certbot --nginx -d n8n.blaze.xyz
```

### 3. Set Production Environment
```yaml
environment:
  - NODE_ENV=production
  - N8N_BASIC_AUTH_ACTIVE=false  # Use proper auth
  - N8N_AUTH_TYPE=jwt
  - N8N_JWT_AUTH_ACTIVE=true
  - N8N_JWT_AUTH_HEADER=Authorization
  - N8N_JWT_AUTH_HEADER_VALUE_PREFIX=Bearer
```

### 4. Add Monitoring
```yaml
# Add to docker-compose.yml
prometheus:
  image: prom/prometheus
  volumes:
    - ./prometheus.yml:/etc/prometheus/prometheus.yml
    
grafana:
  image: grafana/grafana
  ports:
    - "3000:3000"
```

## Next Steps

### 1. Create Additional Workflows
- [ ] Solution Generation Workflow
- [ ] Code Review Workflow
- [ ] QA Automation Workflow
- [ ] Error Handler Workflow

### 2. Add Custom Nodes
```bash
# Install n8n-node-dev
npm install -g n8n-node-dev

# Create custom node
n8n-node-dev new

# Build and copy to n8n
npm run build
cp -r dist/* ~/blaze-n8n/custom-nodes/
```

### 3. Set Up Backup
```bash
# Backup script
#!/bin/bash
docker exec n8n-postgres pg_dump -U n8n n8n > backup-$(date +%Y%m%d).sql
docker exec blaze-n8n n8n export:workflow --all --output=/workflows/backup-$(date +%Y%m%d)
```

### 4. Implement Monitoring
- Set up execution alerts
- Monitor API rate limits
- Track workflow performance
- Create dashboards

## Useful n8n Resources

- **Documentation**: https://docs.n8n.io
- **Community Forum**: https://community.n8n.io
- **Node Library**: https://n8n.io/integrations
- **API Reference**: https://docs.n8n.io/api/

## Support

For Blaze-specific issues:
- Check `/docs/agentic-workflows/` for detailed documentation
- Post in #eng-automation Slack channel
- Review workflow execution logs in n8n UI

For n8n issues:
- Check n8n community forum
- Review n8n documentation
- Enable debug logging for troubleshooting