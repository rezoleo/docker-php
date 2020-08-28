#!/bin/bash

set -euo pipefail

versions=(5.6 7.2 7.3)
declare -A roots
roots=([standard-root]=/var/www/html [public-root]=/var/www/html/public)

for version in "${versions[@]}"; do
  for root in "${!roots[@]}"; do

    docker build \
      --tag "rezoleo/php:${version}-apache-${root}" \
      --build-arg "VERSION=${version}" \
      --build-arg "APACHE_PUBLIC_FOLDER=${roots[$root]}" \
      .
    # docker push "rezoleo/php:${version}-apache-${root}"
  done
done
