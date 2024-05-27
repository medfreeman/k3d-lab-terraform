provider "kubernetes" {
  config_path    = var.kube_config
  config_context = var.cluster_name
}

provider "helm" {
  kubernetes {
    config_path    = var.kube_config
    config_context = var.cluster_name
  }
}
