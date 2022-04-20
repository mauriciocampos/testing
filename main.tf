provider "google" {
    project = var.gcp_project
}

resource "google_compute_instance" "testing-bastion" {
    name = "test-bastion"
    machine_type = "g1-small"
    zone = "europe-west4-a"
    metadata = {
      user-data = file("scripts/cloud-init-bastion-conf")
      startup-script = file("scripts/cloud_init_bastion.sh")
    }
    network_interface {
      network = "default"  
      access_config {
      }
    }
    boot_disk {
        initialize_params {
        image = "debian-cloud/debian-10"
        }
    }    
}

resource "google_compute_instance" "testing-migration" {
    name = "test-migration"
    machine_type = "g1-small"
    zone = "europe-west4-a"
    metadata = {
      user-data = file("scripts/cloud-init-migration-conf")
      startup-script = file("scripts/cloud_init_migration_install.sh")
    }
    network_interface {
      network = "default"  
      access_config {
      }
    }
    boot_disk {
        initialize_params {
        image = "debian-cloud/debian-10"
        }
    }    
}