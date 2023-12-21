#!/usr/bin/env bash

CURRENT_DIR=$(dirname "$(realpath "$0")")

. "$CURRENT_DIR/tencent-cloud.env"

export TENCENTCLOUD_SECRET_ID
export TENCENTCLOUD_SECRET_KEY