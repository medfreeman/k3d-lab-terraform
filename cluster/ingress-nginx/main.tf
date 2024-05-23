module "helm" {
  source = "../../helm"

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }
}

resource "kubernetes_namespace" "ingress-nginx" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "helm_release" "ingress-nginx" {
  name      = "ingress-nginx"
  namespace = kubernetes_namespace.ingress-nginx.metadata[0].name

  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "nginx-ingress-controller"
  version    = "11.2.1"
  lint       = true

  values = [
    file("${path.module}/chart/values.yaml")
  ]
}
