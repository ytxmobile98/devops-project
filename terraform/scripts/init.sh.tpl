#!/usr/bin/env bash

CURDIR=$(dirname "$(realpath "$0")")

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

function setup_cli {
  bash "${CURDIR}/install-helm.sh"
  bash "${CURDIR}/install-yq.sh"
}

function setup_helm {
  bash "${CURDIR}/setup-helm.sh"
}

function main {
  setup_cli
  setup_helm
}