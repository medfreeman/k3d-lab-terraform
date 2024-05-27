provider "kubernetes" {
  config_path    = var.kube_config
  config_context = module.k3s-cluster.cluster_name
}

provider "helm" {
  kubernetes {
    config_path    = var.kube_config
    config_context = module.k3s-cluster.cluster_name
  }
}
