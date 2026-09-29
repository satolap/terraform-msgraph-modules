mock_provider "msgraph" {
  mock_resource "msgraph_resource" {
    defaults = {
      id = "44444444-4444-4444-4444-444444444444"
      output = {
        display_name = "Office egress"
        is_trusted   = false
        ip_ranges    = ["2001:db8::/48", "192.0.2.0/24"]
      }
    }
  }
}

variables {
  display_name = "Office egress"
  ip_ranges    = ["2001:db8::/48", "192.0.2.0/24"]
}

run "creates_typed_sorted_ranges" {
  command = apply

  assert {
    condition     = msgraph_resource.named_location.url == "identity/conditionalAccess/namedLocations" && msgraph_resource.named_location.api_version == "v1.0"
    error_message = "Named locations must be created at identity/conditionalAccess/namedLocations on v1.0."
  }

  assert {
    condition     = msgraph_resource.named_location.ignore_missing_property == false
    error_message = "ignore_missing_property must be false so that server-side nulling shows as drift."
  }

  assert {
    condition = jsonencode(msgraph_resource.named_location.body) == jsonencode({
      "@odata.type" = "#microsoft.graph.ipNamedLocation"
      displayName   = "Office egress"
      isTrusted     = false
      ipRanges = [
        { "@odata.type" = "#microsoft.graph.iPv4CidrRange", cidrAddress = "192.0.2.0/24" },
        { "@odata.type" = "#microsoft.graph.iPv6CidrRange", cidrAddress = "2001:db8::/48" },
      ]
    })
    error_message = "The body must carry the derived @odata.type, isTrusted and sorted ranges, each with its own @odata.type."
  }

  assert {
    condition     = output.id == "44444444-4444-4444-4444-444444444444" && output.display_name == "Office egress" && output.is_trusted == false
    error_message = "id, display_name and is_trusted must come from the resource and its read-back."
  }

  assert {
    condition     = jsonencode(output.ip_ranges) == jsonencode(["192.0.2.0/24", "2001:db8::/48"])
    error_message = "ip_ranges must be the read-back ranges, sorted."
  }
}

run "updates_ranges_and_trust_in_place" {
  command = apply

  variables {
    display_name = "Office egress renamed"
    ip_ranges    = ["2001:db8::/48", "198.51.100.0/24", "192.0.2.0/24"]
    is_trusted   = true
  }

  assert {
    condition     = msgraph_resource.named_location.body["@odata.type"] == "#microsoft.graph.ipNamedLocation"
    error_message = "Every update body must carry the derived @odata.type."
  }

  assert {
    condition     = jsonencode([for r in msgraph_resource.named_location.body.ipRanges : r.cidrAddress]) == jsonencode(["192.0.2.0/24", "198.51.100.0/24", "2001:db8::/48"])
    error_message = "The update body must carry the full, sorted range list."
  }

  assert {
    condition     = msgraph_resource.named_location.body.isTrusted == true && msgraph_resource.named_location.body.displayName == "Office egress renamed"
    error_message = "The update body must carry the new trust flag and name."
  }
}

run "refresh_only_keeps_body_equal_to_configuration" {
  command = apply

  plan_options {
    mode = refresh-only
  }

  variables {
    display_name = "Office egress renamed"
    ip_ranges    = ["2001:db8::/48", "198.51.100.0/24", "192.0.2.0/24"]
    is_trusted   = true
  }

  assert {
    condition     = jsonencode(msgraph_resource.named_location.body) == jsonencode(local.body)
    error_message = "A refresh-only run must be able to compare the refreshed body with local.body."
  }
}

run "rejects_empty_ranges" {
  command = plan

  variables {
    ip_ranges = []
  }

  expect_failures = [var.ip_ranges]
}

run "rejects_more_than_2000_ranges" {
  command = plan

  variables {
    ip_ranges = [for i in concat(range(1000), range(1000, 2001)) : cidrsubnet("10.0.0.0/9", 23, i)]
  }

  expect_failures = [var.ip_ranges]
}

run "accepts_2000_ranges" {
  command = plan

  variables {
    ip_ranges = [for i in concat(range(1000), range(1000, 2000)) : cidrsubnet("10.0.0.0/9", 23, i)]
  }

  assert {
    condition     = length(msgraph_resource.named_location.body.ipRanges) == 2000
    error_message = "2000 ranges is the documented maximum and must be accepted."
  }
}

run "rejects_address_without_prefix" {
  command = plan

  variables {
    ip_ranges = ["192.0.2.1"]
  }

  expect_failures = [var.ip_ranges]
}

run "rejects_prefix_of_8" {
  command = plan

  variables {
    ip_ranges = ["10.0.0.0/8"]
  }

  expect_failures = [var.ip_ranges]
}

run "rejects_ipv6_prefix_of_8" {
  command = plan

  variables {
    ip_ranges = ["2000::/8"]
  }

  expect_failures = [var.ip_ranges]
}

run "rejects_host_bits" {
  command = plan

  variables {
    ip_ranges = ["192.0.2.10/24"]
  }

  expect_failures = [var.ip_ranges]
}

run "rejects_non_canonical_ipv6" {
  command = plan

  variables {
    ip_ranges = ["2001:DB8:0:0::/48"]
  }

  expect_failures = [var.ip_ranges]
}

run "rejects_empty_display_name" {
  command = plan

  variables {
    display_name = " "
  }

  expect_failures = [var.display_name]
}

run "rejects_unknown_api_version" {
  command = plan

  variables {
    api_version = "v2.0"
  }

  expect_failures = [var.api_version]
}
