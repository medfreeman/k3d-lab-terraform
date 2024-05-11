resource "k3d_cluster" "cluster" {
  name    = var.cluster_name
  servers = var.cluster_nodes_number_of_servers
  agents  = var.cluster_nodes_number_of_agents

  kube_api {
    host      = var.host_name
    host_ip   = var.host_ip
    host_port = var.host_port
  }

  image   = var.cluster_nodes_docker_image
  network = var.cluster_nodes_network_name

  port {
    host_port      = var.ingress_port
    container_port = 80
    node_filters = [
      "loadbalancer",
    ]
  }

  k3d {
    disable_load_balancer = false
    disable_image_volume  = false
  }

  k3s {
    dynamic "extra_args" {
      for_each = var.ingress_enable_traefik ? range(0) : []

      content {
        arg          = "--disable=traefik"
        node_filters = ["server:*"]
      }
    }
  }

  kubeconfig {
    update_default_kubeconfig = true
    switch_current_context    = false
  }
}
