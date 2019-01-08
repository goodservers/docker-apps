#!/bin/bash
set -euo pipefail

if [ ! -e index.php ]; then
  echo >&2 "Drupal not found in $PWD - copying now..."
  tar --create \
    --file - \
    --one-file-system \
    --directory /usr/src/drupal \
    --owner www-data --group www-data \
    . | tar --extract --file -
  echo >&2 "Complete! Drupal has been successfully copied to $PWD"
fi

# now that we're definitely done writing configuration, let's clear out the relevant envrionment variables (so that stray "phpinfo()" calls don't leak secrets from our code)
for e in "${envs[@]}"; do
  unset "$e"
done

exec "$@"