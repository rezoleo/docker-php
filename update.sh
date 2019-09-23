#!/bin/bash

for version in 7.2 7.3; do
  VERSION=$version envsubst < Dockerfile.template > "${version}-apache/Dockerfile"
done

cat 7.2-apache/Dockerfile
