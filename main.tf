provider "google" {
  credentials = file(var.credentials_file)

  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_project_service" "services" {
  for_each = toset(var.services)
  project = var.project_id
  service = each.value
  disable_dependent_services = true
}

resource "google_service_account" "sa" {
  project    = var.project_id
  account_id = "github-actions-oidc"
}

resource "google_project_iam_member" "project" {
  project = var.project_id
  role    = "roles/compute.admin"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

module "gh_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = var.project_id
  pool_id     = "github-actions"
  provider_id = "github"
  sa_mapping = {
   (google_service_account.sa.account_id) = {
      sa_name   = google_service_account.sa.name
      attribute = "google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository"
    }
  }
}
