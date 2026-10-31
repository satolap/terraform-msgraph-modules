terraform {
  required_version = ">= 1.11.0"

  required_providers {
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.6.0, < 0.7.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.0, < 1.0.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.0, < 4.0.0"
    }
  }
}
