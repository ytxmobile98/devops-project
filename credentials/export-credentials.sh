#!/usr/bin/env bash

CURRENT_DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")

function export_tencent_cloud_credentials {
  . "$CURRENT_DIR/tencent-cloud.env"

  export TENCENTCLOUD_SECRET_ID
  export TENCENTCLOUD_SECRET_KEY
}

function export_github_credentials {
  . "$CURRENT_DIR/github.env"

  export TF_VAR_github_username
  export TF_VAR_github_personal_token
}

function main {
  export_tencent_cloud_credentials
  export_github_credentials
}

main