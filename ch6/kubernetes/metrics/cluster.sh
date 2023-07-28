#!/bin/bash

# Function to check if kind is installed and the version is v0.20.0 or greater
function check_kind {
  if command -v kind >/dev/null 2>&1; then
    version=$(kind version | cut -d " " -f 2 | tr -d 'v')  # Extracts the version number and remove 'v'
    required_version="0.20.0"
    if (( $(echo "$version $required_version" | awk '{print ($1 >= $2)}') )); then
      echo "Kind version $version is installed. Proceeding..."
      return 0
    else
      echo "Kind version is less than required ($required_version). Please update Kind and try again."
      return 1
    fi
  else
    echo "Kind is not installed. Please install Kind and try again."
    return 1
  fi
}

# Function to check if kubectl is installed
function check_kubectl {
  if command -v kubectl >/dev/null 2>&1; then
    echo "Kubectl is installed. Proceeding..."
    return 0
  else
    echo "Kubectl is not installed. Please install Kubectl and try again."
    return 1
  fi
}

# Function to create a single node cluster
function create_cluster {
  # Use the default cluster name (kind) and node name (kind-control-plane)
  kind create cluster --config kind.yaml
}

# Function to install cert-manager
function install_cert_manager {
  kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml
  echo "Cert-manager applied. Waiting for the deployment to be ready..."

  # Wait for the cert-manager deployment to be ready
  kubectl wait --for=condition=available --timeout=600s deployment/cert-manager -n cert-manager
  kubectl wait --for=condition=available --timeout=600s deployment/cert-manager-cainjector -n cert-manager
  kubectl wait --for=condition=available --timeout=600s deployment/cert-manager-webhook -n cert-manager
  echo "Cert-manager deployment is ready."
}

function install_operator {
    kubectl apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml
}

function install_prometheus {
  LATEST=$(curl -s https://api.github.com/repos/prometheus-operator/prometheus-operator/releases/latest | jq -cr .tag_name)
  curl -sL https://github.com/prometheus-operator/prometheus-operator/releases/download/${LATEST}/bundle.yaml | kubectl create -f -
}

# Function to delete the kind cluster
function delete_cluster {
  kind delete cluster --name kind
  echo "Kind cluster deleted."
}

# Main script execution
check_kind
check_kubectl
if [ $? -eq 0 ]; then
  if [ "$1" == "--delete" ]; then
    delete_cluster
  else
    create_cluster
    install_cert_manager
    install_operator
    install_prometheus
  fi
fi