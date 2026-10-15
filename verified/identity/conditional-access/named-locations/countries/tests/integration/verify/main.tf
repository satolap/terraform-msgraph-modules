# Integration-test helper: waits, then reads the named location back with a
# fresh GET and returns it in a normalised form (codes sorted). A new run_label
# replaces the wait, so every verify run reads after its own delay.
terraform {
  required_providers {
    msgraph = {
      source  = "microsoft/msgraph"
      version = ">= 0.5.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.0"
    }
  }
}

variable "named_location_id" {
  type = string
}

variable "run_label" {
  type = string
}

variable "delay_seconds" {
  type    = number
  default = 30
}

resource "time_sleep" "settle" {
  create_duration = "${var.delay_seconds}s"

  triggers = {
    named_location_id = var.named_location_id
    run_label         = var.run_label
  }
}

data "msgraph_resource" "named_location" {
  url         = "identity/conditionalAccess/namedLocations/${var.named_location_id}"
  api_version = "v1.0"

  response_export_values = {
    all = "@"
  }

  depends_on = [time_sleep.settle]
}

locals {
  got = data.msgraph_resource.named_location.output.all
}

output "configuration" {
  value = {
    odata_type                            = try(local.got["@odata.type"], null)
    display_name                          = try(local.got.displayName, null)
    countries_and_regions                 = try(sort(local.got.countriesAndRegions), [])
    include_unknown_countries_and_regions = try(local.got.includeUnknownCountriesAndRegions, null)
    country_lookup_method                 = try(local.got.countryLookupMethod, null)
  }
}
