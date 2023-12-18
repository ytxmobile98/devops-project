#!/usr/bin/env bash

CURRENT_DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")

. "$CURRENT_DIR/tencent-cloud.env"

export TENCENTCLOUD_SECRET_ID
export TENCENTCLOUD_SECRET_KEY