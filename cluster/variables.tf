variable "cluster_name" {
  type        = string
  description = "The name of the Kubernetes cluster that will be created."
}

variable "kube_config" {
  type        = string
  description = "The path to `kubectl` configuration file."
  default     = "~/.kube/config"
}
