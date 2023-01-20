provider "aws" {
  region = "us-east-1"
}

resource "aws_organizations_organization" "example" {
  feature_set = "ALL"
}

resource "aws_control_tower_landing_zone" "example" {
  organization_id = aws_organizations_organization.example.id
  account_name_prefix = "example"
  email = "admin@example.com"
  enabled_regions = ["us-east-1"]

  audit_account_settings {
    enabled = true
  }

  log_archive_account_settings {
    enabled = true
  }
}

resource "aws_control_tower_guardrails" "example" {
  landing_zone_id = aws_control_tower_landing_zone.example.id
  guardrails = ["ALL"]

  kms_key_guardrail_settings {
    enabled = false
  }

  cloudtrail_guardrail_settings {
    enabled = true
  }
}
