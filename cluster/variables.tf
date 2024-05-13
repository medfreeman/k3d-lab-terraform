variable "cluster_name" {
  type        = string
  description = "The name of the Kubernetes cluster that will be created."
}

variable "cluster_nodes_docker_image" {
  type        = string
  description = "The docker image that will be used to create the nodes that the Kubernetes cluster will run on."
  default     = "rancher/k3s:v1.29.4-k3s1"
}

variable "cluster_nodes_network_name" {
  type        = string
  description = "The name of the Docker network on which the Kubernetes cluster nodes will communicate on."
}

variable "cluster_nodes_number_of_agents" {
  type        = number
  description = "The number of agent nodes that the Kubernetes cluster will run on."
  default     = 2

  validation {
    condition     = var.cluster_nodes_number_of_agents > 0
    error_message = "The `cluster_nodes_number_of_agents` value must be greater than 0."
  }
}

variable "cluster_nodes_number_of_servers" {
  type        = number
  description = "The number of server nodes that the Kubernetes control plane will run on."
  default     = 1

  validation {
    condition     = var.cluster_nodes_number_of_servers > 0
    error_message = "The `cluster_nodes_number_of_servers` value must be greater than 0."
  }
}

variable "host_ip" {
  type        = string
  description = "The host ip adress on which the Kubernetes cluster will be bound."
  default     = "127.0.0.1"

  validation {
    condition     = can(regex("^(((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\\.|$)){4})", var.host_ip))
    error_message = "The `host_ip` value must conform to the RFC 791 definition of an IPv4 adress."
  }
}

variable "host_name" {
  type        = string
  description = "The host name on which the Kubernetes cluster will be bound.\nIt needs to resolve to the `host_ip`."

  validation {
    condition     = can(regex("^(([a-zA-Z]{1})|([a-zA-Z]{1}[a-zA-Z]{1})|([a-zA-Z]{1}[0-9]{1})|([0-9]{1}[a-zA-Z]{1})|([a-zA-Z0-9][a-zA-Z0-9-_]{1,61}[a-zA-Z0-9])).([a-zA-Z]{2,6}|[a-zA-Z0-9-]{2,30}.[a-zA-Z]{2,3})$", var.host_name))
    error_message = "The `host_name` value must conform to the RFCs 952, 1123 & 1035 definition of a DNS hostname."
  }
}

variable "host_port" {
  type        = number
  description = "The port number on which the Kubernetes cluster control plane will be available."
  default     = 6445

  validation {
    condition     = var.host_port > 0 && var.host_port < 65536
    error_message = "The `host_port` value must be a valid port number."
  }
}

variable "ingress_class" {
  type        = string
  description = "Whether to enable installation of `traefik` or `nginx` as Kubernetes default ingress controller."
  default     = "traefik"

  validation {
    condition     = can(regex("^(traefik|nginx)$", var.ingress_class))
    error_message = "The `ingress_class` value must be one of `traefik` or `nginx`."
  }
}

variable "ingress_port" {
  type        = number
  description = "The port number on which the Kubernetes cluster ingress will be available."

  validation {
    condition     = var.ingress_port > 0 && var.ingress_port < 65536
    error_message = "The `ingress_port` value must be a valid port number."
  }
}

variable "kube_config" {
  type        = string
  description = "The path to `kubectl` configuration file."
  default     = "~/.kube/config"
}
