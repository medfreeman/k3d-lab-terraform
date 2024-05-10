resource "k3d_cluster" "cluster" {
  name    = var.cluster_name
  servers = 1
  agents  = 2

  kube_api {
    host      = "k3d-lab-cluster.local"
    host_ip   = "127.0.0.1"
    host_port = 6445
  }

  image   = "rancher/k3s:v1.29.4-k3s1"
  network = "lab-net"

  port {
    host_port      = 8080
    container_port = 80
    node_filters = [
      "loadbalancer",
    ]
  }

  k3d {
    disable_load_balancer = false
    disable_image_volume  = false
  }

  kubeconfig {
    update_default_kubeconfig = true
    switch_current_context    = true
  }
}
