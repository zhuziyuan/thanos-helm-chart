#!/bin/sh
set -e
helm init --client-only
helm lint thanos
mkdir -p pkg

gcloud config set account carlos@carlosbecker.com
gcloud config set project carlos-kube

gsutil rsync gs://carlos-charts pkg
helm package thanos --destination pkg
helm repo index pkg/ --url "https://carlos-charts.storage.googleapis.com"
gsutil rsync pkg gs://carlos-charts

helm repo update
