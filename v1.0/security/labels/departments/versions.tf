terraform {
  required_version = ">= 1.7.0, < 2.0.0"

  required_providers {
    msgraph = {
      source  = "Microsoft/msgraph"
      version = ">= 0.4.0, < 1.0.0"
    }
  }
}
