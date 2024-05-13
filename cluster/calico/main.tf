module "helm" {
  source = "../../helm"

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }
}

resource "kubernetes_namespace" "tigera-operator" {
  metadata {
    name = "tigera-operator"
  }
}

resource "helm_release" "tigera-operator" {
  name      = "tigera-operator"
  namespace = kubernetes_namespace.tigera-operator.metadata[0].name

  repository = "https://docs.tigera.io/calico/charts"
  chart      = "tigera-operator"
  version    = "v3.27.3"
  lint       = true
}
