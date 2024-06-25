variable "ingress_hostname" {
  type        = string
  description = "The ingress host name on which the prometheus management app will be available."

  validation {
    condition     = can(regex("^(([a-zA-Z]{1})|([a-zA-Z]{1}[a-zA-Z]{1})|([a-zA-Z]{1}[0-9]{1})|([0-9]{1}[a-zA-Z]{1})|([a-zA-Z0-9][a-zA-Z0-9-_]{1,61}[a-zA-Z0-9])).([a-zA-Z]{2,6}|[a-zA-Z0-9-]{2,30}.[a-zA-Z]{2,3})$", var.ingress_hostname))
    error_message = "The `ingress_hostname` value must conform to the RFCs 952, 1123 & 1035 definition of a DNS hostname."
  }
}

variable "ingress_classname" {
  type        = string
  description = "Whether to use `traefik` or `nginx` as ingress controller."

  validation {
    condition     = can(regex("^(traefik|nginx)$", var.ingress_classname))
    error_message = "The `ingress_classname` value must be one of `traefik` or `nginx`."
  }
}

variable "prometheus_ingress_path" {
  type        = string
  description = "The path on which the prometheus management app will be available."
  default     = "/prometheus"

  validation {
    condition     = can(regex("^(/[^/\\s]+)+$", var.prometheus_ingress_path))
    error_message = "The `prometheus_ingress_path` value must a valid URL pathname."
  }
}

variable "thanos_ingress_path" {
  type        = string
  description = "The path on which the thanos management app will be available."
  default     = "/thanos"

  validation {
    condition     = can(regex("^(/[^/\\s]+)+$", var.thanos_ingress_path))
    error_message = "The `thanos_ingress_path` value must a valid URL pathname."
  }
}

variable "alertmanager_ingress_path" {
  type        = string
  description = "The path on which the alertmanager management app will be available."
  default     = "/alertmanager"

  validation {
    condition     = can(regex("^(/[^/\\s]+)+$", var.alertmanager_ingress_path))
    error_message = "The `alertmanager_ingress_path` value must a valid URL pathname."
  }
}
