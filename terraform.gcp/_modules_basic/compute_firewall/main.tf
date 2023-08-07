
resource "google_compute_firewall" "sac_compute_firewall" {
  name      = "test-firewall"
  network   = google_compute_network.compute_network.name
  direction = "ingress"
  allow {
    protocol = "icmp"
  }
  source_ranges = ["*"]
  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }
  source_tags = ["web"]
}

resource "google_compute_firewall_policy_rule" "sac_compute_firewall_rule" {
  firewall_policy = google_compute_firewall_policy.default.name
  description     = "Resource created for Terraform acceptance testing"
  priority        = 9000
  enable_logging  = false
  action          = "allow"
  direction       = "EGRESS"
  disabled        = false
  match {
    layer4_configs {
      ip_protocol = "tcp"
      ports       = [8080]
    }
    layer4_configs {
      ip_protocol = "udp"
      ports       = [22]
    }
    src_ip_ranges             = ["*"]
    dest_ip_ranges            = ["11.100.0.1/32"]
    dest_fqdns                = []
    dest_region_codes         = ["US"]
    dest_threat_intelligences = ["iplist-known-malicious-ips"]
    src_address_groups        = []
    dest_address_groups       = [google_network_security_address_group.basic_global_networksecurity_address_group.id]
  }
  target_service_accounts = ["my@service-account.com"]
}

resource "google_compute_network" "compute_network" {
  name = "test-network"
}
