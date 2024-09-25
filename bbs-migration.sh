#!/bin/bash 

# Fail script on error
set -e

# Check if all required environment variables are set
if [ -z "$BITBUCKET_SERVER_URL" ] || [ -z "$GITHUB_ORG" ] || [ -z "$GH_PAT" ] || [ -z "$BBS_USERNAME" ]|| [ -z "$BBS_PASSWORD" ]; then
  echo "Error: Environment variables BITBUCKET_SERVER_URL, GH_PAT, BBS_USERNAME, BBS_PASSWORD and GITHUB_ORG must be set."
  exit 1
fi

# Variables
BITBUCKET_SERVER_PROJECT_KEY=${BITBUCKET_SERVER_PROJECT_KEY:-"MY_PROJECT"}
BITBUCKET_SERVER_URL=${BITBUCKET_SERVER_URL}
GITHUB_ORG=${GITHUB_ORG}
GH_PAT=${GH_PAT}
SPECIFIC_PROJECT_KEY=$1
SPECIFIC_REPO_NAME=$2

# Function to migrate individual repository
migrate_repo() {
  local project_key=$1
  local repo_slug=$2

  echo "Migrating repository: $repo_slug from project: $project_key"

  # Run GEI migration command
  gh bbs2gh migrate-repo --bbs-server-url "$BITBUCKET_SERVER_URL" \
  --bbs-project "$project_key" --bbs-repo "hello-world-app" \
  --github-org "$GITHUB_ORG" --github-repo "$repo_slug"

  echo "Repository $repo_slug from project $project_key migrated successfully!"
}

# If a specific project and repo name is provided, migrate only that repo
if [ -n "$SPECIFIC_PROJECT_KEY" ] && [ -n "$SPECIFIC_REPO_NAME" ]; then
  migrate_repo "$SPECIFIC_PROJECT_KEY" "$SPECIFIC_REPO_NAME"
fi

echo "Migration process completed."
