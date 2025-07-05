#!/usr/bin/env sh

# Issue to Milestone Assignment Commands

# Set repository variables
REPO_OWNER="voidrunnerhq"
REPO_NAME="voidrunner"

# First, get milestone numbers
echo "Getting milestone numbers..."
gh api repos/$REPO_OWNER/$REPO_NAME/milestones | jq '.[] | {number: .number, title: .title}'

# Assign Epic 1 issues to Milestone 1 (MVP Backend Foundation)
# Issues #1-6: Core API Infrastructure
gh api repos/$REPO_OWNER/$REPO_NAME/issues/1 \
  --method PATCH \
  --field milestone=1

gh api repos/$REPO_OWNER/$REPO_NAME/issues/2 \
  --method PATCH \
  --field milestone=1

gh api repos/$REPO_OWNER/$REPO_NAME/issues/3 \
  --method PATCH \
  --field milestone=1

gh api repos/$REPO_OWNER/$REPO_NAME/issues/4 \
  --method PATCH \
  --field milestone=1

gh api repos/$REPO_OWNER/$REPO_NAME/issues/5 \
  --method PATCH \
  --field milestone=1

gh api repos/$REPO_OWNER/$REPO_NAME/issues/6 \
  --method PATCH \
  --field milestone=1

# Assign Epic 2 issues to Milestone 2 (Secure Execution Engine)
# Issues #8-12: Container Execution Engine
gh api repos/$REPO_OWNER/$REPO_NAME/issues/8 \
  --method PATCH \
  --field milestone=2

gh api repos/$REPO_OWNER/$REPO_NAME/issues/9 \
  --method PATCH \
  --field milestone=2

gh api repos/$REPO_OWNER/$REPO_NAME/issues/10 \
  --method PATCH \
  --field milestone=2

gh api repos/$REPO_OWNER/$REPO_NAME/issues/11 \
  --method PATCH \
  --field milestone=2

gh api repos/$REPO_OWNER/$REPO_NAME/issues/12 \
  --method PATCH \
  --field milestone=2

# Assign Epic 3 issues to Milestone 3 (Complete Web Interface)
# Issues #22-26: Frontend Interface
gh api repos/$REPO_OWNER/$REPO_NAME/issues/22 \
  --method PATCH \
  --field milestone=3

gh api repos/$REPO_OWNER/$REPO_NAME/issues/23 \
  --method PATCH \
  --field milestone=3

gh api repos/$REPO_OWNER/$REPO_NAME/issues/24 \
  --method PATCH \
  --field milestone=3

gh api repos/$REPO_OWNER/$REPO_NAME/issues/25 \
  --method PATCH \
  --field milestone=3

gh api repos/$REPO_OWNER/$REPO_NAME/issues/26 \
  --method PATCH \
  --field milestone=3

# Assign Epic 4 issues to Milestone 4 (Advanced Platform Features)
# Issues #27-31: Real-time Features
gh api repos/$REPO_OWNER/$REPO_NAME/issues/27 \
  --method PATCH \
  --field milestone=4

gh api repos/$REPO_OWNER/$REPO_NAME/issues/28 \
  --method PATCH \
  --field milestone=4

gh api repos/$REPO_OWNER/$REPO_NAME/issues/29 \
  --method PATCH \
  --field milestone=4

gh api repos/$REPO_OWNER/$REPO_NAME/issues/30 \
  --method PATCH \
  --field milestone=4

gh api repos/$REPO_OWNER/$REPO_NAME/issues/31 \
  --method PATCH \
  --field milestone=4

# # Assign Epic 5 issues to Milestone 5 (Production Deployment)
# # Issues #18-21: GKE Deployment & CI/CD
# gh api repos/$REPO_OWNER/$REPO_NAME/issues/18 \
#   --method PATCH \
#   --field milestone=5
#
# gh api repos/$REPO_OWNER/$REPO_NAME/issues/19 \
#   --method PATCH \
#   --field milestone=5
#
# gh api repos/$REPO_OWNER/$REPO_NAME/issues/20 \
#   --method PATCH \
#   --field milestone=5
#
# gh api repos/$REPO_OWNER/$REPO_NAME/issues/21 \
#   --method PATCH \
#   --field milestone=5
#
# # Assign Epic 6 issues to Milestone 6 (Enterprise Ready)
# # Issues #22-25: Security & Production Readiness
# gh api repos/$REPO_OWNER/$REPO_NAME/issues/22 \
#   --method PATCH \
#   --field milestone=6
#
# gh api repos/$REPO_OWNER/$REPO_NAME/issues/23 \
#   --method PATCH \
#   --field milestone=6
#
# gh api repos/$REPO_OWNER/$REPO_NAME/issues/24 \
#   --method PATCH \
#   --field milestone=6
#
# gh api repos/$REPO_OWNER/$REPO_NAME/issues/25 \
#   --method PATCH \
#   --field milestone=6

# Verify assignments
echo "Milestone assignments completed. Checking status:"
gh api repos/$REPO_OWNER/$REPO_NAME/milestones | jq '.[] | {title: .title, open_issues: .open_issues, closed_issues: .closed_issues}'
