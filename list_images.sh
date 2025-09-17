#!/bin/bash

team_name="cavalier"

# get repositories matching prefix
repos=$(aws ecr describe-repositories \
  --region eu-central-1 \
  --query "repositories[?starts_with(repositoryName, \`${team_name}/\`)].repositoryName" \
  --output json | jq -r '.[]')

for repo in $repos; do
  # list tags in the repository
  tags=$(aws ecr list-images \
    --repository-name "$repo" \
    --region eu-central-1 \
    --query "imageIds[].imageTag" \
    --output json | jq -r '.[]')

  echo "Repository: $repo"
  echo "Tags: $tags"
  echo "------------------------------"
done
