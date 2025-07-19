# n8n Deployment

This directory contains the configuration for deploying n8n using Porter.

## Structure

- `porter/porter.yaml` - Porter deployment configuration
- `docker-compose.yml` - Local development with SQLite
- `docker-compose.postgres.yml` - Local development with PostgreSQL
- `Dockerfile` - Production container image

## Local Development

### Basic Setup (SQLite)
```bash
docker-compose up -d
```

### With PostgreSQL
```bash
docker-compose -f docker-compose.postgres.yml up -d
```

Access n8n at: http://localhost:5678

## Porter Deployment

The Porter configuration includes:
- n8n web service with 2 CPU cores and 2GB RAM
- PostgreSQL addon for data persistence
- Proper environment variables for production

To deploy:
1. Ensure you have Porter CLI installed
2. Run `porter apply -f porter/porter.yaml`

## Environment Variables

The following environment variables are configured for production:
- `N8N_RUNNERS_ENABLED=true` - Enable task runners
- `N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true` - Security setting
- Database connection variables are automatically injected from the PostgreSQL addon

## Security Notes

- The production deployment uses HTTPS
- Database credentials are managed by Porter
- Settings file permissions are enforced
