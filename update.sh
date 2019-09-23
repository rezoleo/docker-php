#!/bin/bash

versions=(7.2 7.3)

for version in "${versions[@]}"; do
  VERSION=$version envsubst < Dockerfile.template > "${version}-apache/Dockerfile"
  git add "${version}-apache/Dockerfile"
done

git commit -m "(actions) Updated Dockerfiles"
git remote set-url --push origin "https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}"
git push
