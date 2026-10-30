terraform {
  required_version = ">= 1.11.0"

  required_providers {
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.5.0, < 0.7.0"
    }
  }
}
