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
  ingress_enable_traefik          = var.ingress_class == "traefik"
  ingress_port                    = var.ingress_port
}

module "calico" {
  source = "./calico"

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }

  depends_on = [module.k3s-cluster.cluster_name]
}

module "ingress-nginx" {
  count = var.ingress_class == "nginx" ? 1 : 0

  source = "./ingress-nginx"

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }

  depends_on = [module.calico.id]
}
