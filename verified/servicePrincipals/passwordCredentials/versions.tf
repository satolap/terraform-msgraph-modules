terraform {
  required_version = ">= 1.11.0"

  required_providers {
    # The destroy-only action is required; ordinary actions do nothing on delete.
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.6.0, < 0.7.0"
    }
  }
}
