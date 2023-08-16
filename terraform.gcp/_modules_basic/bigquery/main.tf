
resource "google_bigquery_dataset" "sac_bigquery_dataset" {
  name     = "sac-bigquery"
  location = "US-EAST1"
  project  = "sandbox"
  access {
    special_group = "allUseres"
  }
  default_encryption_configuration {
  }
}

resource "google_bigquery_dataset_iam_binding" "sac_bigquery_iam_binding" {
  dataset_id = google_bigquery_dataset.sac_bigquery_dataset.dataset_id
  role       = "roles/bigquery.dataViewer"
  members = [
    "allUsers",
  ]
}

resource "google_bigquery_dataset_iam_member" "sac_bigquery_iam_member" {
  dataset_id = google_bigquery_dataset.sac_bigquery_dataset.dataset_id
  role       = "roles/bigquery.dataEditor"
  member     = "allUsers"
  # oak9: Limit access to only trusted users or accounts
}

resource "google_bigquery_table" "sac_bigquery_table" {
  dataset_id = google_bigquery_dataset.sac_bigquery_dataset.dataset_id
  table_id   = "bigQ"
  time_partitioning {
    type = "DAY"
  }
  encryption_configuration {
  }
}

resource "google_bigquery_table_iam_binding" "table_iam_binding" {
  dataset_id = google_bigquery_table.sac_bigquery_table.dataset_id
  table_id   = google_bigquery_table.sac_bigquery_table.table_id
  role       = "roles/bigquery.dataOwner"
  members = [
    # oak9: Limit access to only trusted users or accounts
    "allUsers",
  ]
}

resource "google_bigquery_table_iam_member" "table_iam_member" {
  dataset_id = google_bigquery_table.sac_bigquery_table.dataset_id
  table_id   = google_bigquery_table.sac_bigquery_table.table_id
  role       = "roles/bigquery.dataOwner"
  member     = "allUsers"
  # oak9: Limit access to only trusted users or accounts
}
