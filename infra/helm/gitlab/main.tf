provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "gitlab" {
  name       = "gitlab"
  chart      = "../../../gitlab-omnibus"
  version    = "0.1.0"

  values = [
    "${file("../../../gitlab-omnibus/values.yaml")}"
  ]

}
