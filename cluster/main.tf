module "k3s-cluster" {
  source = "./k3d"

  cluster_name = var.cluster_name
}

module "ingress-nginx" {
  source = "./ingress-nginx"

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }

  depends_on = [module.k3s-cluster.cluster_name]
}
