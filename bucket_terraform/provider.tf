terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.46.0"
    }
  }
}

provider "google" {
  # Configuration options
  # credentials = file("/home/carlosfeu/Documentos/cosmic-tensor-371107-46c1046641d8.json")
  project = "cosmic-tensor-371107"
  region = "us-central1"
  zone = "us-central1-c"
} 
