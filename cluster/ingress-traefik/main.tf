module "helm" {
  source = "../../helm"

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }
}

# resource "kubernetes_namespace" "ingress-traefik" {
#   metadata {
#     name = "ingress-traefik"
#   }
# }

resource "helm_release" "ingress-traefik" {
  name      = "ingress-traefik"
  namespace = "kube-system"
  # namespace = kubernetes_namespace.ingress-traefik.metadata[0].name

  # TODO: move to `oci://` protocol when available
  # https://github.com/traefik/traefik-helm-chart/issues/962
  repository = "https://traefik.github.io/charts"
  chart      = "traefik"
  version    = "28.1.0"
  lint       = true


  wait_for_jobs = true
  values = [
    file("${path.module}/chart/values.yaml")
  ]

  set {
    name  = "ports.web.port"
    value = 80
  }

  set {
    name  = "ports.web.containerPort"
    value = var.ingress_port
  }

  set {
    name  = "ports.web.targetPort"
    value = var.ingress_port
  }
}
