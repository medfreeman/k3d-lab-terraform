variable "cluster_name" {
  type        = string
  description = "The name of the Kubernetes cluster that will be created."

  validation {
    # max length is 63 and the name will be prefixed with `k3d-`, hence < 60
    condition     = length(var.cluster_name) < 60 && can(regex("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$", var.cluster_name))
    error_message = "The `cluster_name` value must conform to the RFC 1123 definition of a DNS label."
  }
}

variable "cluster_nodes_docker_image" {
  type        = string
  description = "The docker image that will be used to create the nodes that the Kubernetes cluster will run on."
}

variable "cluster_nodes_network_name" {
  type        = string
  description = "The name of the Docker network on which the Kubernetes cluster nodes will communicate on."
}

variable "cluster_nodes_number_of_agents" {
  type        = number
  description = "The number of agent nodes that the Kubernetes cluster will run on."
}

variable "cluster_nodes_number_of_servers" {
  type        = number
  description = "The number of server nodes that the Kubernetes control plane will run on."
}

variable "host_ip" {
  type        = string
  description = "The host ip adress on which the Kubernetes cluster will be bound."
}

variable "host_name" {
  type        = string
  description = "The host name on which the Kubernetes cluster will be bound.\nIt needs to resolve to the `host_ip`."
}

variable "host_port" {
  type        = number
  description = "The port number on which the Kubernetes cluster control plane will be available."
}

variable "ingress_port" {
  type        = number
  description = "The port number on which the Kubernetes cluster ingress will be available."
}
