# Claude Configuration for Blaze

This directory contains the configuration and setup scripts for Claude MCP (Model Context Protocol) integrations used by the Blaze platform.

## Overview

MCPs allow Claude to interact with external services and data sources, enabling powerful workflows like:
- Querying production databases (read-only)
- Searching logs and error tracking
- Creating tickets in ClickUp
- Analyzing screen recordings
- Interacting with GitHub repositories

## Setup Instructions

### 1. Configure Environment Variables

```bash
# Copy the example environment file
cp .env.example .env

# Edit .env with your actual credentials
nano .env
```

### 2. Install MCPs

Run the installation script to add all MCPs to your Claude instance:

```bash
./install-mcps.sh
```

This script will:
- Read the MCP configurations from `mcp-list.json`
- Substitute environment variables from `.env`
- Install each MCP using the Claude CLI
- Show a summary of successful/failed installations

### 3. Verify Installation

Check that MCPs are installed correctly:

```bash
claude mcp list
```

## Available MCPs

| MCP Name | Purpose | Access Level |
|----------|---------|--------------|
| `postgres-prod` | Production database queries | Read-only |
| `betterstack-logs` | Log searching and analysis | Read-only |
| `sentry-errors` | Error tracking and session replays | Read-only |
| `posthog-analytics` | Analytics and screen recordings | Read-only |
| `clickup-tasks` | Bug ticket creation and management | Read/Write |
| `github-repos` | Repository access and PR creation | Read/Write |
| `slack-notifications` | Send notifications and interact | Write |
| `filesystem-local` | Local code access | Read/Write |

## Usage Examples

### Bug Investigation Workflow

```bash
# Start Claude with MCP support
claude --mcp

# In Claude, you can now:
# 1. Query production data
> Use postgres-prod to find users affected by payment errors in last 24h

# 2. Search logs for errors
> Use betterstack-logs to find all 500 errors related to payments

# 3. Create a bug ticket
> Use clickup-tasks to create a bug ticket with the investigation findings
```

### Code Fix Workflow

```bash
# Access code and create fixes
> Use filesystem-local to read payment.service.ts
> Use github-repos to create a PR with the fix
> Use slack-notifications to notify #eng-bugs channel
```

## Adding New MCPs

To add a new MCP:

1. Add the configuration to `mcp-list.json`:
```json
{
  "name": "new-service",
  "type": "@modelcontextprotocol/server-new",
  "description": "Description of what this MCP does",
  "config": {
    "apiKey": "${NEW_SERVICE_API_KEY}",
    // other config options
  }
}
```

2. Add required environment variables to `.env.example`

3. Run the install script again

## Security Notes

- **Never commit `.env` files** - They contain sensitive credentials
- **Use read-only access** where possible (e.g., database connections)
- **Limit permissions** to only what's necessary
- **Rotate credentials** regularly
- **Audit MCP usage** through Claude logs

## Troubleshooting

### MCP Installation Fails
- Check that all required environment variables are set in `.env`
- Verify the Claude CLI is installed and authenticated
- Check MCP type names are correct in `mcp-list.json`

### Permission Denied
- Ensure API keys have necessary permissions
- Check database user has read-only access
- Verify GitHub token has repo access

### Connection Issues
- Test connections outside of Claude first
- Check firewall/VPN settings
- Verify service endpoints are accessible

## Best Practices

1. **Test in Development First**: Use development databases/services when testing
2. **Monitor Usage**: Keep track of API calls and costs
3. **Document Changes**: Update this README when adding new MCPs
4. **Review Access**: Periodically audit what MCPs have access to
5. **Use Specific Queries**: Avoid broad data pulls that could impact performance

## Related Documentation

- [Bug Fixing Workflow](../docs/agentic-workflows/bug-fixing/)
- [MCP Protocol Spec](https://modelcontextprotocol.org)
- [Claude CLI Documentation](https://claude.ai/docs/cli)