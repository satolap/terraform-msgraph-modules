# Root module for the Terraform Registry, which requires Terraform files at the repository
# root. It manages nothing: call a module under v1.0/, beta/ or verified/ instead, for example
# source = "satolap/modules/msgraph//verified/groups". Each nested module declares
# its own provider version constraints.
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    msgraph = {
      source = "microsoft/msgraph"
    }
  }
}
