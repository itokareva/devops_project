provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

provider "google-beta" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

#data "google_container_engine_versions" "europenorth1a" {
#  provider       = google-beta
#  location       = "europe-north1-a"
#  version_prefix = "1.14.10-gke.1504"
#}

resource "google_container_cluster" "webserf" {
  name     = "webserf"
  location = "europe-north1-a"
  min_master_version          = "1.14.10-gke.1504"
  node_version                = "1.14.10-gke.1504"
  enable_legacy_abac          = true

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  monitoring_service       = var.monitoring_service 
  logging_service          = var.logging_service


  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "webserf-pool"
  location   = var.region 
  cluster    = google_container_cluster.webserf.name
  node_count = 3
  version             = "1.14.10-gke.1504"

  node_config {
    preemptible  = true
    machine_type = "e2-standard-2"
    disk_size_gb = 30

    metadata = {
      disable-legacy-endpoints = "true"
    }

#    oauth_scopes = [
#      "https://www.googleapis.com/auth/logging.write",
#      "https://www.googleapis.com/auth/monitoring",
#    ]

  }
}
