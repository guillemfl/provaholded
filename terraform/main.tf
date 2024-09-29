provider "google" {
  credentials = file("~/terraform-sa-key.json")
  project = var.project_id
  region  = "europe-west1"
}

resource "google_storage_bucket" "terraform_state" {
  name     = "terraform-state-bucket"
  location = "EU"
}

terraform {
  backend "gcs" {
    bucket = "terraform-state-bucket"
    prefix = "terraform/state"
  }
}

resource "google_container_cluster" "primary" {
  name     = "holded-gke-cluster"
  location = "europe-west1"

  node_config {
    machine_type = "e2-medium"
  }

  initial_node_count = 2
}

resource "google_artifact_registry_repository" "prova_holded_repo" {
  provider          = google
  location          = "europe-west1"
  repository_id     = "prova-holded-repo"
  description       = "Docker repository"
  format            = "DOCKER"
}

resource "null_resource" "configure_docker" {
  provisioner "local-exec" {
    command = "gcloud auth configure-docker europe-west1-docker.pkg.dev"
  }
}
