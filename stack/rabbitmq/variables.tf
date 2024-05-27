variable "cluster_name" {
  type        = string
  description = "The name of the Kubernetes cluster on which the resources will be created."
}

variable "host_name" {
  type        = string
  description = "The ingress host name on which the rabbitmq management app will be available."

  validation {
    condition     = can(regex("^(([a-zA-Z]{1})|([a-zA-Z]{1}[a-zA-Z]{1})|([a-zA-Z]{1}[0-9]{1})|([0-9]{1}[a-zA-Z]{1})|([a-zA-Z0-9][a-zA-Z0-9-_]{1,61}[a-zA-Z0-9])).([a-zA-Z]{2,6}|[a-zA-Z0-9-]{2,30}.[a-zA-Z]{2,3})$", var.host_name))
    error_message = "The `host_name` value must conform to the RFCs 952, 1123 & 1035 definition of a DNS hostname."
  }
}

variable "ingress_classname" {
  type        = string
  description = "Whether to use `traefik` or `nginx` as ingress controller."
  default     = "traefik"

  validation {
    condition     = can(regex("^(traefik|nginx)$", var.ingress_classname))
    error_message = "The `ingress_classname` value must be one of `traefik` or `nginx`."
  }
}

variable "ingress_path" {
  type        = string
  description = "The path on which the rabbitmq management app will be available."
  default     = "/rabbitmq"

  validation {
    condition     = can(regex("^(/[^/\\s]+)+$", var.ingress_path))
    error_message = "The `ingress_path` value must a valid URL pathname."
  }
}

variable "kube_config" {
  type        = string
  description = "The path to `kubectl` configuration file."
  default     = "~/.kube/config"
}
