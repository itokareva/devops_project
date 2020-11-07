provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "namespace" {
  name       = "namespace"
  chart      = "../../../helm/namespace"
  version    = "0.1.0"
}

resource "helm_release" "webserf" {
  name       = "webserf"
  chart      = "../../../helm/webserf"
  version    = "0.1.0"
  namespace  = "application"
}
