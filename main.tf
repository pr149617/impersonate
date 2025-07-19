provider "google" {
    project = "canvas-primacy-466005-f9"
    
  impersonate_service_account = "terraform-svc@canvas-primacy-466005-f9.iam.gserviceaccount.com"
}
resource "google_compute_network" "custom_vpc" {
  name                    = "dev-vpc"
  auto_create_subnetworks = false  # Set to true for auto mode
  description             = "Terraform-created VPC"
}