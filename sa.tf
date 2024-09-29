resource "google_service_account" "terraform" {
  account_id   = "terraform-sa"
  display_name = "Terraform Service Account"
}

resource "google_project_iam_member" "sa_storage_admin" {
  project = var.project_id
  member  = "serviceAccount:${google_service_account.terraform.email}"
  role    = "roles/storage.admin"
}

resource "google_project_iam_member" "sa_editor" {
  project = var.project_id
  member  = "serviceAccount:${google_service_account.terraform.email}"
  role    = "roles/editor"
}

resource "google_service_account_key" "terraform_key" {
  service_account_id = google_service_account.terraform.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}
