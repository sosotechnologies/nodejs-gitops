#!/bin/bash

# Fetch tags from the remote
git fetch --tags

# Get the latest tag; if no tags are found, default to 2.2.22
latest_tag=$(git describe --tags `git rev-list --tags --max-count=1` 2>/dev/null || echo "2.2.22")

# Remove 'v' prefix if it exists
latest_version=${latest_tag}

# Extract the version components
IFS='.' read -r -a version_parts <<< "$latest_version"

# Increment the patch version
version_parts[2]=$((version_parts[2] + 1))

# Create the new version
new_version="${version_parts[0]}.${version_parts[1]}.${version_parts[2]}"

# Tag the new version
git tag "$new_version"

# Push the tags to the remote
git push origin --tags

# Output the new version
echo "NEW_VERSION=$new_version" >> $GITHUB_ENV