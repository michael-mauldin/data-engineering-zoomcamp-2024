terraform {
    required_providers {
      google = {
        source = "hashicorp/google"
        version = "5.14.0"
      }
    }
}

provider "google" {
    credentials = file(var.credentials)
    project = "dtc-de-2024-1"
    region = "us-west1"
}

resource "google_storage_bucket" "ny_taxi_data_bucket" {
    name = "ny_taxi_datasets"
    location = "US"
    force_destroy = true

    public_access_prevention = "enforced"

    lifecycle_rule {
      condition {
        age = 1
      }
      action {
        type = "AbortIncompleteMultipartUpload"
      }
    }
}

resource "google_bigquery_dataset" "ny_taxi_data" {
    dataset_id = "ny_taxi"
    location = "US"
  
}