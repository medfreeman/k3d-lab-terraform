variable "cluster_name" {
  type        = string
  description = "The name of the Kubernetes cluster that will be created."

  validation {
    # max length is 63 and the name will be prefixed with `k3d-`, hence < 60
    condition     = length(var.cluster_name) < 60 && can(regex("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$", var.cluster_name))
    error_message = "The cluster_name value must conform to the RFC 1123 definition of a DNS label."
  }
}
