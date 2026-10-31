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
  enable_destroy_cleanup  = false
  accessPackageCatalog-id = "11111111-1111-1111-1111-111111111111"
  resource_origin_system  = "AadGroup"
  resource_origin_id      = "33333333-3333-3333-3333-333333333333"
  resource_display_name   = "Engineering"

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

  assert {
    condition     = join(",", sort(keys(msgraph_resource_action.add_request.body.resource))) == "displayName,originId,originSystem"
    error_message = "Non-Azure resources must not carry resourceType; a changed body would re-run the add on existing deployments."
  }
}

run "adds_azure_subscription" {
  command = plan

  variables {
    resource_origin_system = "AzureResources"
    resource_origin_id     = "/subscriptions/88888888-8888-4888-8888-888888888888"
    resource_display_name  = "Dev"
  }

  assert {
    condition     = msgraph_resource_action.add_request.body.resource.resourceType == "Subscription"
    error_message = "A subscription must be added with resourceType Subscription."
  }

  assert {
    condition     = msgraph_resource_action.add_request.body.resource.originSystem == "AzureResources" && msgraph_resource_action.add_request.body.resource.originId == "/subscriptions/88888888-8888-4888-8888-888888888888"
    error_message = "The subscription must be referenced by its Azure resource ID with the AzureResources origin system."
  }

  assert {
    condition     = data.msgraph_resource.verify.query_parameters["$filter"][0] == "originId eq '/subscriptions/88888888-8888-4888-8888-888888888888' and originSystem eq 'AzureResources'"
    error_message = "Verification must filter by the subscription's resource ID."
  }
}

run "adds_azure_management_group" {
  command = plan

  variables {
    resource_origin_system = "AzureResources"
    resource_origin_id     = "/providers/Microsoft.Management/managementGroups/mg-platform"
  }

  assert {
    condition     = msgraph_resource_action.add_request.body.resource.resourceType == "ManagementGroup"
    error_message = "A management group must be added with resourceType ManagementGroup."
  }
}

run "rejects_azure_resource_group" {
  command = plan

  variables {
    resource_origin_system = "AzureResources"
    resource_origin_id     = "/subscriptions/88888888-8888-4888-8888-888888888888/resourceGroups/rg-app"
  }

  expect_failures = [msgraph_resource_action.add_request]
}

run "rejects_bare_subscription_guid" {
  command = plan

  variables {
    resource_origin_system = "AzureResources"
    resource_origin_id     = "88888888-8888-4888-8888-888888888888"
  }

  expect_failures = [msgraph_resource_action.add_request]
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

# The runs below change the target of the add request. Plan runs leave the
# state of the first run, which created the add request and the sleep; apply
# runs update it. A replaced sleep takes the id of the override_resource block,
# a kept sleep keeps the id in the state.

# A new catalog submits a new adminAdd, so the verification read must wait for
# apply and the new delay. With the default empty read and
# fail_on_verification_mismatch, a read at plan time would fail this plan.
run "a_new_catalog_defers_verification_to_apply" {
  command = plan

  variables {
    accessPackageCatalog-id       = "44444444-4444-4444-4444-444444444444"
    fail_on_verification_mismatch = true
  }

  assert {
    condition     = msgraph_resource_action.add_request.body.catalog.id == "44444444-4444-4444-4444-444444444444"
    error_message = "The new adminAdd must name the new catalog."
  }

  assert {
    condition = jsonencode(terraform_data.add_target.input) == jsonencode({
      api_version            = "v1.0"
      catalog_id             = "44444444-4444-4444-4444-444444444444"
      resource_origin_id     = "33333333-3333-3333-3333-333333333333"
      resource_origin_system = "AadGroup"
    })
    error_message = "The add target must hold the catalog, the resource and the api_version."
  }
}

run "a_new_catalog_waits_again_before_verifying" {
  command = apply

  variables {
    accessPackageCatalog-id = "44444444-4444-4444-4444-444444444444"
  }

  override_resource {
    target = time_sleep.wait_for_delivery
    values = {
      id = "sleep-after-new-catalog"
    }
  }

  assert {
    condition     = time_sleep.wait_for_delivery.id == "sleep-after-new-catalog"
    error_message = "A new adminAdd must replace the sleep, so that verification waits again."
  }

  assert {
    condition     = data.msgraph_resource.verify.url == "identityGovernance/entitlementManagement/catalogs/44444444-4444-4444-4444-444444444444/resources"
    error_message = "Verification must read the new catalog."
  }
}

run "a_new_resource_waits_again_before_verifying" {
  command = apply

  variables {
    accessPackageCatalog-id = "44444444-4444-4444-4444-444444444444"
    resource_origin_id      = "55555555-5555-5555-5555-555555555555"
  }

  override_resource {
    target = time_sleep.wait_for_delivery
    values = {
      id = "sleep-after-new-resource"
    }
  }

  assert {
    condition     = time_sleep.wait_for_delivery.id == "sleep-after-new-resource"
    error_message = "A new resource must replace the sleep, so that verification waits again."
  }
}

run "a_new_api_version_waits_again_before_verifying" {
  command = apply

  variables {
    accessPackageCatalog-id = "44444444-4444-4444-4444-444444444444"
    resource_origin_id      = "55555555-5555-5555-5555-555555555555"
    api_version             = "beta"
  }

  override_resource {
    target = time_sleep.wait_for_delivery
    values = {
      id = "sleep-after-new-api-version"
    }
  }

  assert {
    condition     = time_sleep.wait_for_delivery.id == "sleep-after-new-api-version"
    error_message = "A new api_version replaces the add request, so the sleep must be replaced too."
  }
}

# A display name alone never replays the one-shot add request. The sleep is kept, so verification reads at plan time
# and the captured resource id, which the destroy hook holds, stays known.
run "a_new_display_name_keeps_the_sleep" {
  command = apply

  variables {
    accessPackageCatalog-id = "44444444-4444-4444-4444-444444444444"
    resource_origin_id      = "55555555-5555-5555-5555-555555555555"
    api_version             = "beta"
    resource_display_name   = "Engineering (renamed)"
  }

  override_resource {
    target = time_sleep.wait_for_delivery
    values = {
      id = "sleep-after-new-display-name"
    }
  }

  assert {
    condition     = time_sleep.wait_for_delivery.id == "sleep-after-new-api-version"
    error_message = "A new display name alone must not replace the sleep."
  }

  assert {
    condition     = msgraph_resource_action.add_request.body.resource.displayName == "Engineering"
    error_message = "The one-shot add request must keep its captured display name without replay."
  }
}

run "directory_role_requires_preview_acknowledgement" {
  command = plan
  variables { resource_origin_system = "DirectoryRole" }
  expect_failures = [var.acknowledge_directory_role_preview]
}

run "directory_role_rejects_null_acknowledgement" {
  command = plan
  variables {
    resource_origin_system             = "DirectoryRole"
    acknowledge_directory_role_preview = null
  }
  expect_failures = [var.acknowledge_directory_role_preview]
}

run "directory_role_rejects_non_guid_origin" {
  command = plan
  variables {
    resource_origin_system             = "DirectoryRole"
    acknowledge_directory_role_preview = true
    resource_origin_id                 = "Directory Readers"
  }
  expect_failures = [var.resource_origin_id]
}

run "directory_role_rejects_null_origin" {
  command = plan
  variables {
    resource_origin_system             = "DirectoryRole"
    acknowledge_directory_role_preview = true
    resource_origin_id                 = null
  }
  expect_failures = [var.resource_origin_id]
}

run "directory_role_add_body" {
  command = plan
  variables {
    resource_origin_system             = "DirectoryRole"
    acknowledge_directory_role_preview = true
  }
  assert {
    condition = msgraph_resource_action.add_request.body.resource == {
      originSystem = "DirectoryRole"
      originId     = "33333333-3333-3333-3333-333333333333"
      displayName  = "Engineering"
    }
    error_message = "DirectoryRole onboarding must send the role definition GUID without grant or Azure resourceType fields."
  }
}

run "sharepoint_keeps_url_origin_without_preview_acknowledgement" {
  command = plan
  variables {
    resource_origin_system = "SharePointOnline"
    resource_origin_id     = "https://contoso.sharepoint.com/sites/engineering"
  }
  assert {
    condition = msgraph_resource_action.add_request.body.resource == {
      originSystem = "SharePointOnline"
      originId     = "https://contoso.sharepoint.com/sites/engineering"
      displayName  = "Engineering"
    }
    error_message = "Existing origins must keep their body shape and accept non-GUID origin IDs."
  }
}
