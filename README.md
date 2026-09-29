# AWS Project 3 — Application Deployment & Automation

A hands-on AWS/Linux project demonstrating application deployment, Linux service management, Nginx reverse proxying, deployment automation, S3 backups, IAM permissions, and failure recovery.

## Architecture

![Project 3 Architecture](screenshots/architecture-diagram.png)

### Architecture Flow

```text
User
  |
  | HTTP :80
  v
AWS EC2
  |
  +--> Nginx :80
          |
          | Reverse Proxy
          v
      Flask Application :5000
          |
          +--> /health
               "Application is healthy"

GitHub
  |
  | git pull
  v
deploy.sh
  |
  +--> Install dependencies
  +--> Restart systemd service
  +--> Health check

EC2
  |
  | backup.sh
  v
Amazon S3
  |
  +--> Timestamped application backup