#!/bin/bash 

# Fail script on error
set -e

# Check if all required environment variables are set
if [ -z "$BITBUCKET_SERVER_URL" ] || [ -z "$BITBUCKET_SERVER_TOKEN" ] || [ -z "$GITHUB_ORG" ] || [ -z "$GITHUB_TOKEN" ]; then
  echo "Error: Environment variables BITBUCKET_SERVER_URL, BITBUCKET_SERVER_TOKEN, GITHUB_ORG, and GITHUB_TOKEN must be set."
  exit 1
fi

# Variables
BITBUCKET_SERVER_PROJECT_KEY=${BITBUCKET_SERVER_PROJECT_KEY:-"MY_PROJECT"}
BITBUCKET_SERVER_URL=${BITBUCKET_SERVER_URL}
GITHUB_ORG=${GITHUB_ORG}
GITHUB_TOKEN=${GITHUB_TOKEN}
BITBUCKET_SERVER_TOKEN=${BITBUCKET_SERVER_TOKEN}
SPECIFIC_PROJECT_KEY=$1
SPECIFIC_REPO_NAME=$2

# Function to migrate individual repository
migrate_repo() {
  local project_key=$1
  local repo_slug=$2

  echo "Migrating repository: $repo_slug from project: $project_key"

  # Run GEI migration command
  gh gei migrate-repo \
    --github-org "$GITHUB_ORG" \
    --github-repo "$repo_slug" \
    --bitbucket-server-url "$BITBUCKET_SERVER_URL" \
    --bitbucket-server-token "$BITBUCKET_SERVER_TOKEN" \
    --bitbucket-server-project-key "$project_key" \
    --bitbucket-server-repo "$repo_slug" \
    --github-token "$GITHUB_TOKEN" \
    --wait

  echo "Repository $repo_slug from project $project_key migrated successfully!"
}

# If a specific project and repo name is provided, migrate only that repo
if [ -n "$SPECIFIC_PROJECT_KEY" ] && [ -n "$SPECIFIC_REPO_NAME" ]; then
  migrate_repo "$SPECIFIC_PROJECT_KEY" "$SPECIFIC_REPO_NAME"
fi

echo "Migration process completed."
