variable "project_id" { }

variable "credentials_file" { }

variable "services" {
  type = list(string)
  default = [
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iamcredentials.googleapis.com",
    "sts.googleapis.com",
  ]
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}
