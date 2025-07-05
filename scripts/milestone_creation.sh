#!/usr/bin/env sh

# VoidRunner GitHub Milestones - Creation Commands

# Set repository variables
REPO_OWNER="voidrunnerhq"
REPO_NAME="voidrunner"

# Milestone 1: MVP Backend Foundation
gh api repos/$REPO_OWNER/$REPO_NAME/milestones \
  --method POST \
  --field title="MVP Backend Foundation" \
  --field description="Functional backend API with authentication and basic task management. Establishes Go+Gin+PostgreSQL foundation with JWT auth and basic CRUD operations." \
  --field due_on="2025-07-31T23:59:59Z" \
  --field state="open"

# Milestone 2: Secure Execution Engine  
gh api repos/$REPO_OWNER/$REPO_NAME/milestones \
  --method POST \
  --field title="Secure Execution Engine" \
  --field description="Secure container execution with real-time monitoring. Docker integration with security controls, resource limits, and log streaming for Python/Bash execution." \
  --field due_on="2025-08-31T23:59:59Z" \
  --field state="open"

# Milestone 3: Complete Web Interface
gh api repos/$REPO_OWNER/$REPO_NAME/milestones \
  --method POST \
  --field title="Complete Web Interface" \
  --field description="Full-featured Svelte web application for task management. User auth flows, code editor integration, task management UI, and real-time status updates." \
  --field due_on="2025-09-30T23:59:59Z" \
  --field state="open"

# Milestone 4: Advanced Platform Features
gh api repos/$REPO_OWNER/$REPO_NAME/milestones \
  --method POST \
  --field title="Advanced Platform Features" \
  --field description="Enhanced platform with monitoring, analytics, and collaboration. Real-time dashboards, notifications, search/filtering, and collaborative features." \
  --field due_on="2025-10-31T23:59:59Z" \
  --field state="open"

# Milestone 5: Production Deployment
gh api repos/$REPO_OWNER/$REPO_NAME/milestones \
  --method POST \
  --field title="Production Deployment" \
  --field description="Production-ready deployment with automated operations. GKE cluster, CI/CD pipeline, monitoring, SSL/TLS, and disaster recovery procedures." \
  --field due_on="2025-11-30T23:59:59Z" \
  --field state="open"

# Milestone 6: Enterprise Ready
gh api repos/$REPO_OWNER/$REPO_NAME/milestones \
  --method POST \
  --field title="Enterprise Ready" \
  --field description="Enterprise-grade security and compliance readiness. SOC 2 compliance, security hardening, performance optimization, and production operations." \
  --field due_on="2025-12-15T23:59:59Z" \
  --field state="open"

# Verify milestones created
echo "Created milestones:"
gh api repos/$REPO_OWNER/$REPO_NAME/milestones | jq '.[].title'
