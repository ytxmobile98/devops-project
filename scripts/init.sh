#!/usr/bin/env bash

CURDIR=$(dirname "$(realpath "$0")")

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

function install_helm {
  # See: https://helm.sh/docs/intro/install/#from-script
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
}

function install_yq {
  # See: https://github.com/mikefarah/yq#latest-version
  wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq &&\
    chmod +x /usr/bin/yq
}

function setup_cli {
  install_helm
  install_yq
}

function setup_helm_repo {
  # https://artifacthub.io/packages/helm/jenkinsci/jenkins
  helm repo add jenkins https://charts.jenkins.io

  # https://artifacthub.io/packages/helm/ingress-nginx
  helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

  # https://artifacthub.io/packages/helm/crossplane/crossplane
  helm repo add crossplane-stable https://charts.crossplane.io/stable

  # https://argoproj.github.io/argo-helm/
  helm repo add argo https://argoproj.github.io/argo-helm

  helm repo update
}

function setup_ingress_nginx {
  helm upgrade --install ingress-nginx ingress-nginx \
    --namespace ingress-nginx \
    --create-namespace \
    --values "$CURDIR/../yaml/ingress-value.yaml" \
    --version "4.8.4" \
    --wait
}

function setup_jenkins {
  kubectl create ns jenkins

  kubectl apply -f /tmp/yaml/github/pat-secret-text.yaml
  kubectl apply -f /tmp/yaml/github/personal-token.yaml
  kubectl apply -f /tmp/yaml/jenkins/service-account.yaml

  helm upgrade -i jenkins jenkins/jenkins \
    -n jenkins --create-namespace \
    -f /tmp/yaml/jenkins/values.yaml --version "4.6.1"
}

function main {
  setup_cli
  setup_helm_repo
  setup_ingress_nginx
  setup_jenkins
}

main