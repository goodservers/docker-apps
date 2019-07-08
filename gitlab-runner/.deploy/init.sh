#!/usr/bin/env bash

# Creates config.toml for gitlab runner
echo "concurrent = 1
check_interval = 0

[[runners]]
  name = "{{PROJECT_NAME}}"
  url = "https://${GITLAB_DOMAIN}/"
  token = "${GITLAB_RUNNER_TOKEN}"
  executor = "docker"
  [runners.docker]
    tls_verify = false
    image = "docker:stable"
    privileged = true
    disable_cache = false
    volumes = ["/cache"]
    shm_size = 0
  [runners.cache]
    Insecure = false
" > /etc/gitlab-runner/config.toml