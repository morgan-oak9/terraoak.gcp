
resource "google_secret_manager_secret" "sac_secret_manager" {
  secret_id = "secret"
  rotation {
  }
  replication {
    user_managed {
      replicas {
      }
    }
    replicas {
      location = "us-east1"
    }
  }
}

resource "google_secret_manager_secret_iam_binding" "sac_secret_manager_binding" {
  project   = google_secret_manager_secret.sac_secret_manager.project
  secret_id = google_secret_manager_secret.sac_secret_manager.secret_id
  role      = "roles/secretmanager.secretAccessor"
  members = [
    # oak9: Grant secrets access to only trusted users or accounts
    "allUsers",
  ]
}

resource "google_secret_manager_secret_iam_member" "sac_secret_manager_member" {
  project   = google_secret_manager_secret.sac_secret_manager.project
  secret_id = google_secret_manager_secret.sac_secret_manager.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "allUsers"
  # oak9: Grant secrets access to only trusted users or accounts
}
