#!/bin/bash 

# Fail script on error
set -e

# Check if all required environment variables are set
if [ -z "$BITBUCKET_SERVER_URL" ] || [ -z "$GITHUB_ORG" ] || [ -z "$GH_PAT" ] || [ -z "$BBS_USERNAME" ]|| [ -z "$BBS_PASSWORD" ]; then
  echo "Error: Environment variables BITBUCKET_SERVER_URL, GH_PAT, BBS_USERNAME, BBS_PASSWORD and GITHUB_ORG must be set."
  exit 1
fi

# Variables
# BITBUCKET_SERVER_PROJECT_KEY=${BITBUCKET_SERVER_PROJECT_KEY}
# BITBUCKET_SERVER_URL=${BITBUCKET_SERVER_URL}
# GITHUB_ORG=${GITHUB_ORG}
# GH_PAT=${GH_PAT}
# BITBUCKET_SHARED_HOME="/var/atlassian/application-data/bitbucket/shared"

# ARCHIVE_DIR="$BITBUCKET_SHARED_HOME/data/migration/export/"
# SPECIFIC_PROJECT_KEY=$1
# SPECIFIC_REPO_NAME=$2

# Step 1: Fetch the latest archive file from the export directory
# LATEST_ARCHIVE=$(ls -t $ARCHIVE_DIR | grep 'Bitbucket_export_' | head -n 1)
# # Check if the archive file exists
# if [ -z "$LATEST_ARCHIVE" ]; then
#     echo "No archive found in the export directory."
#     exit 1
# fi

# Step 2: Construct the full archive path
ARCHIVE_PATH="${ARCHIVE_DIR}${LATEST_ARCHIVE}"

# echo "Found the latest archive: $ARCHIVE_PATH"

# Function to migrate individual repository
# migrate_repo() {
  # local project_key=$1
  # local repo_slug=$2

  # echo "Migrating repository: $repo_slug from project: $project_key"

  # Run GEI migration command
  # gh bbs2gh migrate-repo --bbs-server-url "$BITBUCKET_SERVER_URL" \
  # --bbs-project "$BITBUCKET_SERVER_PROJECT_KEY" \
  # --bbs-repo "$SPECIFIC_REPO_NAME"

  # gh bbs2gh migrate-repo --archive-path "$ARCHIVE_PATH" \
  # --github-org "$GITHUB_ORG" \
  # --github-repo "$NEW_NAME" \
  # --bbs-server-url "$BBS_SERVER_URL" \
  # --bbs-project "$BITBUCKET_SERVER_PROJECT_KEY" \
  # --bbs-repo "$SPECIFIC_REPO_NAME"
  echo "$BITBUCKET_SHARED_HOME"
  echo "Repository $SPECIFIC_REPO_NAME from project $SPECIFIC_PROJECT_KEY migrated successfully!"
# }

# If a specific project and repo name is provided, migrate only that repo
# if [ -n "$SPECIFIC_PROJECT_KEY" ] && [ -n "$SPECIFIC_REPO_NAME" ]; then
#   migrate_repo "$SPECIFIC_PROJECT_KEY" "$SPECIFIC_REPO_NAME"
# fi

echo "Migration process completed."
