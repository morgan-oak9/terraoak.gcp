
resource "google_redis_instance" "sac_redis_cache" {
  name                    = "memory-cache"
  memory_size_gb          = 1
  tier                    = "BASIC"
  auth_enabled            = true
  transit_encryption_mode = "SERVER_AUTHENTICATION"
}
