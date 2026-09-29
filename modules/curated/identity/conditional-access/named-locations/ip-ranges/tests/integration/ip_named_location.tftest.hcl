# Integration tests: run against a real tenant with `terraform test
# -test-directory=tests/integration`. Requires msgraph provider credentials
# (az login or ARM_* environment variables) that carry Policy.Read.All and
# Policy.ReadWrite.ConditionalAccess. Delegated access needs both scopes in the
# token plus the Conditional Access Administrator or Security Administrator
# role. Uses documentation address ranges only, and no policy references the
# location. Destroy is implicit, and a trusted location cannot be deleted, so the
# untrust run follows the trust run at once: no read or refresh run sits between
# them that could fail and leave the location trusted. If a run still errors, the
# remaining runs are skipped; see "After a failed Conditional Access run" in
# docs/test-tenant-setup.md.

run "setup" {
  module {
    source = "./tests/integration/setup"
  }
}

run "create_location" {
  command = apply

  variables {
    display_name = "tftest-ca-ip-${run.setup.suffix}"
    ip_ranges    = ["192.0.2.0/24", "2001:db8::/48"]
  }

  assert {
    condition     = can(regex("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$", output.id))
    error_message = "Graph must return a GUID id for the created location."
  }

  assert {
    condition     = output.display_name == "tftest-ca-ip-${run.setup.suffix}" && output.is_trusted == false
    error_message = "The create read-back must carry the name and an untrusted flag."
  }

  assert {
    condition     = jsonencode(output.ip_ranges) == jsonencode(["192.0.2.0/24", "2001:db8::/48"])
    error_message = "The create read-back must carry both ranges."
  }
}

run "verify_created" {
  module {
    source = "./tests/integration/verify"
  }

  variables {
    named_location_id = run.create_location.id
    run_label         = "created"
  }

  assert {
    condition     = output.configuration.odata_type == "#microsoft.graph.ipNamedLocation" && output.configuration.display_name == "tftest-ca-ip-${run.setup.suffix}" && output.configuration.is_trusted == false
    error_message = "A fresh GET must return the derived type, the name and an untrusted flag."
  }

  assert {
    condition = jsonencode(output.configuration.ip_ranges) == jsonencode([
      { odata_type = "#microsoft.graph.iPv4CidrRange", cidr_address = "192.0.2.0/24" },
      { odata_type = "#microsoft.graph.iPv6CidrRange", cidr_address = "2001:db8::/48" },
    ])
    error_message = "A fresh GET must return exactly the two ranges, each with its IPv4 or IPv6 type and the canonical address."
  }
}

# Idempotency: a refresh-only apply GETs the location and maps the response onto
# the configured body. If the refreshed body equals local.body, the next plan
# has no change to the body.
run "refresh_created" {
  command = apply

  plan_options {
    mode = refresh-only
  }

  variables {
    display_name = "tftest-ca-ip-${run.setup.suffix}"
    ip_ranges    = ["192.0.2.0/24", "2001:db8::/48"]
  }

  assert {
    condition     = jsonencode(msgraph_resource.named_location.body) == jsonencode(local.body)
    error_message = "After a refresh the body differs from the configuration, so the next plan would not be empty."
  }
}

# PATCH: rename, add a range, trust the location. The trusted flag is checked
# from this run's own read-back, so that the untrust run can follow immediately.
run "update_location" {
  command = apply

  variables {
    display_name = "tftest-ca-ip-${run.setup.suffix}-updated"
    ip_ranges    = ["192.0.2.0/24", "198.51.100.0/24", "2001:db8::/48"]
    is_trusted   = true
  }

  assert {
    condition     = output.id == run.create_location.id
    error_message = "A value change must update the location in place."
  }

  assert {
    condition     = output.display_name == "tftest-ca-ip-${run.setup.suffix}-updated" && output.is_trusted == true
    error_message = "The update read-back must carry the new name and the trusted flag."
  }

  assert {
    condition     = jsonencode(output.ip_ranges) == jsonencode(["192.0.2.0/24", "198.51.100.0/24", "2001:db8::/48"])
    error_message = "The update read-back must carry the full, replaced range list."
  }
}

# A trusted location cannot be deleted, so drop trust before anything else runs
# and before the implicit destroy.
run "untrust_before_destroy" {
  command = apply

  variables {
    display_name = "tftest-ca-ip-${run.setup.suffix}-updated"
    ip_ranges    = ["192.0.2.0/24", "198.51.100.0/24", "2001:db8::/48"]
    is_trusted   = false
  }

  assert {
    condition     = output.id == run.create_location.id && output.is_trusted == false
    error_message = "Dropping trust must update the location in place and read back as untrusted."
  }
}

run "verify_updated" {
  module {
    source = "./tests/integration/verify"
  }

  variables {
    named_location_id = run.untrust_before_destroy.id
    run_label         = "updated"
  }

  assert {
    condition     = output.configuration.display_name == "tftest-ca-ip-${run.setup.suffix}-updated" && output.configuration.is_trusted == false
    error_message = "A fresh GET must return the new name and the location as untrusted before destroy."
  }

  assert {
    condition     = jsonencode([for r in output.configuration.ip_ranges : r.cidr_address]) == jsonencode(["192.0.2.0/24", "198.51.100.0/24", "2001:db8::/48"])
    error_message = "A fresh GET must return the full, replaced range list."
  }
}

run "refresh_updated" {
  command = apply

  plan_options {
    mode = refresh-only
  }

  variables {
    display_name = "tftest-ca-ip-${run.setup.suffix}-updated"
    ip_ranges    = ["192.0.2.0/24", "198.51.100.0/24", "2001:db8::/48"]
    is_trusted   = false
  }

  assert {
    condition     = jsonencode(msgraph_resource.named_location.body) == jsonencode(local.body)
    error_message = "After a refresh the body differs from the configuration, so the next plan would not be empty."
  }
}
