# Mocking providers does not suppress destroy provisioners. Disable that hook.
mock_provider "null" {}
mock_provider "time" {}

mock_provider "msgraph" {
  mock_resource "msgraph_resource_action" {
    defaults = {
      id = "req-00000000-0000-0000-0000-000000000001"
      output = {
        request_id = "req-00000000-0000-0000-0000-000000000001"
        state      = "delivered"
      }
    }
  }

  # By default the verification read finds nothing, mimicking a resource that
  # is still provisioning; individual runs override this where needed.
  mock_data "msgraph_resource" {
    defaults = {
      output = {
        resources = []
      }
    }
  }
}

variables {
  enable_destroy_cleanup = false
  catalog_id             = "11111111-1111-1111-1111-111111111111"
  resource_origin_system = "AadGroup"
  resource_origin_id     = "33333333-3333-3333-3333-333333333333"
  resource_display_name  = "Engineering"

  # keep unit tests fast and tolerant of the empty mock read
  verification_delay_seconds    = 0
  fail_on_verification_mismatch = false
}

run "submits_admin_add_request" {
  command = apply

  assert {
    condition     = msgraph_resource_action.add_request.resource_url == "identityGovernance/entitlementManagement/resourceRequests"
    error_message = "The add must POST to the resourceRequests action endpoint."
  }

  assert {
    condition     = msgraph_resource_action.add_request.method == "POST"
    error_message = "The add request must be a POST."
  }

  assert {
    condition     = msgraph_resource_action.add_request.body.requestType == "adminAdd"
    error_message = "The request type must be adminAdd."
  }

  assert {
    condition     = msgraph_resource_action.add_request.body.catalog.id == "11111111-1111-1111-1111-111111111111"
    error_message = "The catalog must be referenced by id."
  }

  assert {
    condition     = msgraph_resource_action.add_request.body.resource.originId == "33333333-3333-3333-3333-333333333333"
    error_message = "The resource must be referenced by originId."
  }

  assert {
    condition     = msgraph_resource_action.add_request.body.resource.originSystem == "AadGroup"
    error_message = "The resource must carry its originSystem."
  }

  assert {
    condition     = msgraph_resource_action.add_request.body.resource.displayName == "Engineering"
    error_message = "The optional display name must be included when set."
  }

  assert {
    condition     = data.msgraph_resource.verify.query_parameters["$filter"][0] == "originId eq '33333333-3333-3333-3333-333333333333' and originSystem eq 'AadGroup'"
    error_message = "Verification must filter the catalog's resources by originId via query_parameters."
  }

  assert {
    condition     = output.verified == false && output.resource_id == null
    error_message = "An empty verification read must surface verified=false and a null resource_id."
  }

  assert {
    condition     = output.request_id == "req-00000000-0000-0000-0000-000000000001"
    error_message = "request_id output must expose the accessPackageResourceRequest id."
  }
}

run "captures_resource_id_when_found" {
  command = plan

  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = {
        resources = [
          {
            id           = "catres-00000000-0000-0000-0000-0000000000aa"
            originId     = "33333333-3333-3333-3333-333333333333"
            originSystem = "AadGroup"
          },
        ]
      }
    }
  }

  assert {
    condition     = output.verified == true
    error_message = "A successful verification read must surface verified=true."
  }

  assert {
    condition     = output.resource_id == "catres-00000000-0000-0000-0000-0000000000aa"
    error_message = "The catalog-internal accessPackageResource id must be captured for role scopes and adminRemove."
  }
}

run "fails_gate_when_resource_missing" {
  command = plan

  variables {
    fail_on_verification_mismatch = true
  }

  expect_failures = [terraform_data.verification_gate]
}

run "rejects_invalid_origin_system" {
  command = plan

  variables {
    resource_origin_system = "AzureResource"
  }

  expect_failures = [var.resource_origin_system]
}

run "rejects_negative_delay" {
  command = plan

  variables {
    verification_delay_seconds = -5
  }

  expect_failures = [var.verification_delay_seconds]
}

run "escapes_odata_string_literals" {
  command = plan
  variables {
    resource_origin_system = "SharePointOnline"
    resource_origin_id     = "https://contoso.sharepoint.com/sites/Director'sOffice"
  }
  assert {
    condition     = data.msgraph_resource.verify.query_parameters["$filter"][0] == "originId eq 'https://contoso.sharepoint.com/sites/Director''sOffice' and originSystem eq 'SharePointOnline'"
    error_message = "Apostrophes in origin IDs must be escaped as OData literals."
  }
}

run "rejects_ambiguous_resource_lookup" {
  command = plan
  variables {
    fail_on_verification_mismatch = true
  }
  override_data {
    target = data.msgraph_resource.verify
    values = {
      output = { resources = [{ id = "first" }, { id = "second" }] }
    }
  }
  expect_failures = [terraform_data.verification_gate]
}
