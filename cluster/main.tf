locals {
  ingress-nginx_enable_count   = var.ingress_classname == "nginx" ? 1 : 0
  ingress-traefik_enable_count = var.ingress_classname == "traefik" ? 1 : 0
}

module "k3s-cluster" {
  source = "./k3d"

  cluster_name                    = var.cluster_name
  cluster_nodes_docker_image      = var.cluster_nodes_docker_image
  cluster_nodes_network_name      = var.cluster_nodes_network_name
  cluster_nodes_number_of_agents  = var.cluster_nodes_number_of_agents
  cluster_nodes_number_of_servers = var.cluster_nodes_number_of_servers
  host_ip                         = var.host_ip
  host_name                       = var.host_name
  host_port                       = var.host_port
  ingress_port                    = var.ingress_port
}

module "ingress-nginx" {
  count = local.ingress-nginx_enable_count

  source = "./ingress-nginx"

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }

  # waits for the cluster to be initialized
  depends_on = [module.k3s-cluster.cluster_name]

  ingress_port = var.ingress_port
}

module "ingress-traefik" {
  count = local.ingress-traefik_enable_count

  source = "./ingress-traefik"

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }

  # waits for the cluster to be initialized
  depends_on = [module.k3s-cluster.cluster_name]

  ingress_port = var.ingress_port
}
