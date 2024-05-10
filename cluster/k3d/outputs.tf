output "cluster_name" {
  value = "k3d-${k3d_cluster.cluster.id}"
}
