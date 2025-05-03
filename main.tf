provider "google" {
  credentials = file("key.json")  # Path to the key.json file you just created
  project     = "divine-aegis-454814-k0"  # Your GCP project ID
  region      = "us-central1"  # Specify your desired region
}

resource "google_compute_instance" "default" {
  name         = "terraform-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"  # Updated image
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}
