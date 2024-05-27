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

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
}
