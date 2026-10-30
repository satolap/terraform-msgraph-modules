# Probe of the launch and wait callback (GB-entitlement-management-519): run against a
# real tenant with `terraform test -test-directory=tests/integration`, with what the
# rest of this suite needs, including TF_VAR_logic_app. Microsoft Learn's entitlement
# management examples name the callback duration durationBeforeTimeout, while its
# customExtensionCallbackConfiguration type page names it timeoutDuration. A body with
# durationBeforeTimeout came back as timeoutDuration, so these runs check that
# timeoutDuration round-trips on create and on update with values that no default can
# explain, and whether Graph takes a callback that does not name its @odata.type,
# which Graph does not return. A failing run names what Graph returned, or fails with
# Graph's error when it rejects the body. Nothing here invokes the Logic App.

run "setup" {
  module {
    source = "./tests/integration/setup"
  }
}

run "callback_timeout_duration_on_create" {
  command = apply

  module {
    source = "./tests/integration/callback_probe"
  }

  variables {
    catalog_id   = run.setup.catalog_id
    display_name = "tftest-callback-probe-${run.setup.suffix}"
    timeout      = "PT2H"
  }

  assert {
    condition     = try(output.read_back_callback.timeoutDuration, null) == "PT2H"
    error_message = "Graph did not keep timeoutDuration = PT2H on create. A fresh read returned callbackConfiguration = ${jsonencode(output.read_back_callback)}, and the create returned ${jsonencode(output.created_callback)}."
  }
}

run "callback_timeout_duration_on_update" {
  command = apply

  module {
    source = "./tests/integration/callback_probe"
  }

  variables {
    catalog_id   = run.setup.catalog_id
    display_name = "tftest-callback-probe-${run.setup.suffix}"
    timeout      = "PT3H"
  }

  assert {
    condition     = output.id == run.callback_timeout_duration_on_create.id
    error_message = "A changed callback duration must update the extension in place."
  }

  assert {
    condition     = try(output.read_back_callback.timeoutDuration, null) == "PT3H"
    error_message = "Graph did not keep timeoutDuration = PT3H after an update. A fresh read returned callbackConfiguration = ${jsonencode(output.read_back_callback)}."
  }
}

run "callback_without_odata_type" {
  command = apply

  module {
    source = "./tests/integration/callback_probe"
  }

  variables {
    catalog_id      = run.setup.catalog_id
    display_name    = "tftest-callback-probe-${run.setup.suffix}"
    timeout         = "PT4H"
    with_odata_type = false
  }

  assert {
    condition     = try(output.read_back_callback.timeoutDuration, null) == "PT4H"
    error_message = "Graph did not keep timeoutDuration = PT4H from a callback without @odata.type. A fresh read returned callbackConfiguration = ${jsonencode(output.read_back_callback)}."
  }
}
