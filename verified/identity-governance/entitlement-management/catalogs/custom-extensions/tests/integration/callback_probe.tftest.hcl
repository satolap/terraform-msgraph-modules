# Probe of the launch and wait callback (GB-entitlement-management-519): run against a
# real tenant with `terraform test -test-directory=tests/integration`, with what the
# rest of this suite needs, including TF_VAR_logic_app. Microsoft Learn's entitlement
# management examples name the callback duration durationBeforeTimeout, while its
# customExtensionCallbackConfiguration type page names it timeoutDuration. The run
# creates a request workflow extension whose callback uses durationBeforeTimeout and
# reads it back. It passes when Graph keeps that name, and otherwise fails with what
# Graph returned, or with Graph's error when it rejects the body: either result
# settles the name that the launch and wait input sends. Nothing here invokes the
# Logic App.

run "setup" {
  module {
    source = "./tests/integration/setup"
  }
}

run "callback_keeps_duration_before_timeout" {
  command = apply

  module {
    source = "./tests/integration/callback_probe"
  }

  variables {
    catalog_id   = run.setup.catalog_id
    display_name = "tftest-callback-probe-${run.setup.suffix}"
  }

  assert {
    condition     = try(output.read_back_callback.durationBeforeTimeout, null) == "PT1H"
    error_message = "Graph did not keep the callback duration as durationBeforeTimeout = PT1H. A fresh read returned callbackConfiguration = ${jsonencode(output.read_back_callback)}, and the create returned ${jsonencode(output.created_callback)}. Record the result in GB-entitlement-management-519 and send the name Graph keeps."
  }
}
