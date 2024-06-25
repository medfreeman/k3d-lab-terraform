module "helm" {
  source = "../../helm"

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }
}

resource "helm_release" "prometheus-operator" {
  name      = "prometheus-operator"
  namespace = "kube-system"

  chart             = "${path.module}/chart"
  dependency_update = true
  lint              = true

  wait_for_jobs = true

  # Prometheus
  set {
    name  = "kube-prometheus.prometheus.ingress.hostname"
    value = var.ingress_hostname
  }

  set {
    name  = "kube-prometheus.prometheus.ingress.ingressClassName"
    value = var.ingress_classname
  }

  set {
    name  = "kube-prometheus.prometheus.ingress.path"
    value = var.ingress_classname == "traefik" ? var.prometheus_ingress_path : "${var.prometheus_ingress_path}(/|$)(.*)"
  }

  # set {
  #   name  = var.ingress_classname == "traefik" ? "kube-prometheus.prometheus.ingress.annotations.traefik\\.ingress\\.kubernetes\\.io/router\\.middlewares" : "kube-prometheus.prometheus.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/rewrite-target"
  #   value = var.ingress_classname == "traefik" ? "kube-system-strip-prefix-prometheus@kubernetescrd" : "/$2"
  # }
  #
  # dynamic "set" {
  #   for_each = var.ingress_classname == "nginx" ? range(0) : []
  #
  #   content {
  #     name  = "kube-prometheus.prometheus.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/rewrite-target"
  #     value = "/$2"
  #   }
  # }

  # Thanos
  set {
    name  = "kube-prometheus.prometheus.thanos.ingress.hostname"
    value = var.ingress_hostname
  }

  set {
    name  = "kube-prometheus.prometheus.thanos.ingress.ingressClassName"
    value = var.ingress_classname
  }

  set {
    name  = "kube-prometheus.prometheus.thanos.ingress.path"
    value = var.ingress_classname == "traefik" ? var.thanos_ingress_path : "${var.thanos_ingress_path}(/|$)(.*)"
  }

  set {
    name  = var.ingress_classname == "traefik" ? "kube-prometheus.prometheus.thanos.ingress.annotations.traefik\\.ingress\\.kubernetes\\.io/router\\.middlewares" : "kube-prometheus.prometheus.thanos.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/rewrite-target"
    value = var.ingress_classname == "traefik" ? "kube-system-strip-prefix-thanos@kubernetescrd" : "/$2"
  }

  # Alertmanager
  set {
    name  = "kube-prometheus.alertmanager.ingress.hostname"
    value = var.ingress_hostname
  }

  set {
    name  = "kube-prometheus.alertmanager.ingress.ingressClassName"
    value = var.ingress_classname
  }

  set {
    name  = "kube-prometheus.alertmanager.ingress.path"
    value = var.ingress_classname == "traefik" ? var.alertmanager_ingress_path : "${var.alertmanager_ingress_path}(/|$)(.*)"
  }

  set {
    name  = var.ingress_classname == "traefik" ? "kube-prometheus.alertmanager.ingress.annotations.traefik\\.ingress\\.kubernetes\\.io/router\\.middlewares" : "kube-prometheus.alertmanager.ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/rewrite-target"
    value = var.ingress_classname == "traefik" ? "kube-system-strip-prefix-alertmanager@kubernetescrd" : "/$2"
  }
}
