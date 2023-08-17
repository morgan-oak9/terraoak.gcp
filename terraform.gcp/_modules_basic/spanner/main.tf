
resource "google_spanner_instance" "sac_spanner_instance" {
  config        = "regional-us-east1"
  display_name  = "test-instance"
  num_nodes     = 1
  project       = var.project_id
  force_destroy = true
}

resource "google_spanner_instance_iam_binding" "sac_spanner_instance_binding" {
  instance = "sac-spanner"
  role     = "roles/spanner.databaseAdmin"
  members = [
    # oak9: Restrict database access to trusted members
    "allUsers",
  ]
}

resource "google_spanner_instance_iam_member" "sac_spanner_instance_member" {
  instance = "your-instance-name"
  role     = "roles/spanner.databaseAdmin"
  member   = "allUsers"
  # oak9: Restrict database access to trusted members
}

resource "google_spanner_database" "sac_spanner_db" {
  instance            = google_spanner_instance.sac_spanner_instance.name
  name                = "test-database"
  project             = var.project_id
  deletion_protection = false
  encryption_config {
  }
}

resource "google_spanner_database_iam_binding" "sac_spanner_db_binding" {
  instance = "your-instance-name"
  database = "your-database-name"
  role     = "roles/compute.networkUser"
  members = [
    # oak9: Restrict database access to trusted members
    "allUsers",
  ]
}

resource "google_spanner_database_iam_member" "sac_spanner_db_member" {
  instance = "your-instance-name"
  database = "your-database-name"
  role     = "roles/compute.networkUser"
  member   = "allUsers"
  # oak9: Restrict database access to trusted members
}
