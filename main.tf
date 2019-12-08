provider "aws" {
  profile    = "default"
  region     = "eu-west-2"
}
resource "aws_instance" "main" {
  ami           = "ami-00e8b55a2e841be44"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-gcpstackdriver"
  }
}
provider "google" {
  credentials = file("../premium-nuance-257313-fcbf0a758540.json")
  project     = "premium-nuance-257313"
  region      = "us-central1"
}
resource "google_monitoring_alert_policy" "alert_policy" {
  display_name = "My Alert Policy"
  combiner = "OR"
  conditions {
    display_name = "test condition"
    condition_threshold {
      filter = "metric.type=\"aws.googleapis.com/EC2/CPUUtilization/Minimum\" AND resource.type=\"aws_ec2_instance\""
      duration = "60s"
      comparison = "COMPARISON_GT"
      aggregations {
        alignment_period = "60s"
      }
    }
  }

  user_labels = {
    foo = "bar"
  }
}