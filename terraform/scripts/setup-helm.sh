#!/usr/bin/env bash

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

function main {
  setup_helm_repo
}
