terraform {
  required_version = ">= 1.11.0"

  required_providers {
    # Match the child modules' tested msgraph provider window.
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.6.0, < 0.7.0"
    }
  }
}
