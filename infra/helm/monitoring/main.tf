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
 
resource "helm_release" "nginx" {
  name       = "nginx"
  chart      = "../../../helm_servicies/nginx"
  version    = "edge"
  namespace  = "monitoring"

}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  chart      = "../../../helm_servicies/prometheus"
  version    = "11.12.1"
  namespace  = "monitoring"
  create_namespace = true

  values = [
    "${file("../../../helm_servicies/prometheus/custom_values.yml")}"
  ]

 set {
    name  = "cluster.listen-address"
    value = ""
}

}

resource "helm_release" "grafana" {
  name       = "grafana"
  chart      = "../../../helm_servicies/grafana"
  version    = "5.5.7"
  namespace  = "monitoring"

  values = [
    "${file("../../../helm_servicies/grafana/values.yaml")}"
  ]

 set {
    name  = "adminPassword"
    value = "admin"
}

 set {
    name  = "service.type"
    value = "NodePort"
}

 set {
    name  = "ingress.enabled"
    value = "true"
}

 set {
    name  = "ingress.hosts"
    value = "{webserf-grafana}"
 }
}

resource "helm_release" "efk1" {
  name       = "efk1"
  chart      = "../../../helm_servicies/efk"
  version    = "0.1.0"
  namespace  = "monitoring"

}

resource "helm_release" "kibana" {
  name       = "kibana"
  chart      = "../../../helm_servicies/kibana"
  version    = "0.1.1"
  namespace  = "monitoring"

 set {
    name  = "env.ELASTICSEARCH_URL"
    value = "http://elasticsearch-logging:9200"
}

 set {
    name  = "ingress.enabled"
    value = "true"
}

 set {
    name  = "ingress.hosts"
    value = "{webserf-kibana}"
 }

 set {
    name  = "image.tag"
    value = "5.6.4"
 }


} 
#resource "helm_release" "gitlab" {
#  name       = "gitlab"
#  chart      = "../../../gitlab-omnibus"
#  version    = "0.1.0"

#  values = [
#    "${file("../../../gitlab-omnibus/values.yaml")}"
#  ]

#}

