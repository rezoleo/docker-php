#!/bin/bash

set -euo pipefail

versions=(5.6 7.2 7.3 7.4 8.0 8.1 8.2)

for version in "${versions[@]}"; do

  docker build \
    --tag "rezoleo/php:${version}-apache" \
    --build-arg "VERSION=${version}" \
    .

  if [[ $(git branch --show-current) == "master" ]]
  then
    docker push "rezoleo/php:${version}-apache"
  fi

done
