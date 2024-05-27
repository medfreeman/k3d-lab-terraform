module "helm" {
  source = "../../helm"

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }
}

resource "kubernetes_namespace" "rabbitmq" {
  metadata {
    name = "rabbitmq"
  }
}

resource "helm_release" "rabbitmq" {
  name      = "rabbitmq"
  namespace = kubernetes_namespace.rabbitmq.metadata[0].name

  chart             = "${path.module}/chart"
  dependency_update = true
  lint              = true

  set {
    name  = "rabbitmq.ingress.hostname"
    value = var.host_name
  }

  set {
    name  = "rabbitmq.ingress.ingressClassName"
    value = var.ingress_class
  }

  set {
    name  = "rabbitmq.ingress.path"
    value = var.ingress_class == "traefik" ? var.ingress_path : "${var.ingress_path}(/|$)(.*)"
  }

  set {
    name  = var.ingress_class == "traefik" ? "rabbitmq.ingress.annotations.traefik\\.ingress\\.kubernetes\\.io/router\\.middlewares" : "rabbitmq.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/rewrite-target"
    value = var.ingress_class == "traefik" ? "kube-system-strip-prefix-rabbitmq@kubernetescrd" : "/$2"
  }
}
