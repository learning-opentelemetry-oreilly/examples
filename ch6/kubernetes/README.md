# Kubernetes Metrics

Each directory contains a script to create a single-node Kubernetes cluster
using KIND, as well as an associated deployment for the OpenTelemetry Collector.

## Prerequisites

- KIND v0.20.0+
- jq
- kubectl

## Usage

In each directory, you can run `./cluster.sh` to create the cluster. After it's
up, run `kubectl apply -f collector.yaml` to deploy.

In a web browser, navigate to `https://localhost:30000` to view metrics.

## Metrics Available By Receiver Type

`k8s_cluster`
k8s_container_cpu_limit{}
k8s_container_cpu_request{}
k8s_container_memory_limit{}
k8s_container_memory_request{}
k8s_container_ready{}
k8s_container_restarts{}
k8s_daemonset_current_scheduled_nodes{}
k8s_daemonset_desired_scheduled_nodes{}
k8s_daemonset_misscheduled_nodes{}
k8s_daemonset_ready_nodes{}
k8s_deployment_available{}
k8s_deployment_desired{}
k8s_namespace_phase{}
k8s_node_condition_ready{}
k8s_pod_phase{}
k8s_replicaset_available{}
k8s_replicaset_desired{}
k8s_statefulset_current_pods{}
k8s_statefulset_desired_pods{}
k8s_statefulset_ready_pods{}
k8s_statefulset_updated_pods{}

`kubeletstats`
container_cpu_time{}
container_cpu_utilization{}
container_filesystem_available{}
container_filesystem_capacity{}
container_filesystem_usage{}
container_memory_working_set{}
k8s_node_cpu_time{}
k8s_node_cpu_utilization{}
k8s_node_filesystem_available{}
k8s_node_filesystem_capacity{}
k8s_node_filesystem_usage{}
k8s_node_memory_available{}
k8s_node_memory_major_page_faults{}
k8s_node_memory_page_faults{}
k8s_node_memory_rss{}
k8s_node_memory_usage{}
k8s_node_memory_working_set{}
k8s_node_network_errors{}
k8s_node_network_io{}
k8s_pod_cpu_time{}
k8s_pod_filesystem_available{}
k8s_pod_filesystem_capacity{}
k8s_pod_filesystem_usage{}
k8s_pod_memory_available{}
k8s_pod_memory_major_page_faults{}
k8s_pod_memory_page_faults{}
k8s_pod_memory_rss{}
k8s_pod_memory_usage{}
k8s_pod_memory_working_set{}
k8s_pod_network_errors{}
k8s_pod_network_io{}
