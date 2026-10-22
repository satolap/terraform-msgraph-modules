# Fail closed on partial/malformed collection exports. All identities are synthetic.

mock_provider "msgraph" {

  mock_data "msgraph_resource" {

    defaults = { output = { "skus" : [{ "skuId" : "11111111-1111-4111-8111-111111111111", "skuPartNumber" : "AAD_PREMIUM", "capabilityStatus" : "Enabled", "prepaidUnits" : { "enabled" : 1 }, "servicePlans" : [{ "servicePlanId" : "41781fb2-bc02-4b7c-bd55-b576c07bb09d" }] }], "next_link" : null } }

  }

}

variables {
  tier = "p1"
}

run "rejects_missing_sku_paging_export" {

  command = plan

  override_data {

    target = data.msgraph_resource.subscribed_skus[0]

    values = { output = { "skus" : [{ "skuId" : "11111111-1111-4111-8111-111111111111", "skuPartNumber" : "AAD_PREMIUM", "capabilityStatus" : "Enabled", "prepaidUnits" : { "enabled" : 1 }, "servicePlans" : [{ "servicePlanId" : "41781fb2-bc02-4b7c-bd55-b576c07bb09d" }] }] } }

  }

  expect_failures = [data.msgraph_resource.subscribed_skus[0]]

}

run "rejects_unresolved_sku_page" {

  command = plan

  override_data {

    target = data.msgraph_resource.subscribed_skus[0]

    values = { output = { "skus" : [{ "skuId" : "11111111-1111-4111-8111-111111111111", "skuPartNumber" : "AAD_PREMIUM", "capabilityStatus" : "Enabled", "prepaidUnits" : { "enabled" : 1 }, "servicePlans" : [{ "servicePlanId" : "41781fb2-bc02-4b7c-bd55-b576c07bb09d" }] }], "next_link" : "https://graph.microsoft.com/v1.0/subscribedSkus?$skiptoken=synthetic" } }

  }

  expect_failures = [data.msgraph_resource.subscribed_skus[0]]

}

run "rejects_string_units" {
  command = plan
  override_data {
    target = data.msgraph_resource.subscribed_skus[0]
    values = { output = { "skus" : [{ "skuId" : "11111111-1111-4111-8111-111111111111", "skuPartNumber" : "AAD_PREMIUM", "capabilityStatus" : "Enabled", "prepaidUnits" : { "enabled" : "1" }, "servicePlans" : [{ "servicePlanId" : "41781fb2-bc02-4b7c-bd55-b576c07bb09d" }] }], "next_link" : null } }
  }
  expect_failures = [data.msgraph_resource.subscribed_skus[0]]
}

run "rejects_fractional_units" {
  command = plan
  override_data {
    target = data.msgraph_resource.subscribed_skus[0]
    values = { output = { "skus" : [{ "skuId" : "11111111-1111-4111-8111-111111111111", "skuPartNumber" : "AAD_PREMIUM", "capabilityStatus" : "Enabled", "prepaidUnits" : { "enabled" : 1.5 }, "servicePlans" : [{ "servicePlanId" : "41781fb2-bc02-4b7c-bd55-b576c07bb09d" }] }], "next_link" : null } }
  }
  expect_failures = [data.msgraph_resource.subscribed_skus[0]]
}

run "rejects_negative_units" {
  command = plan
  override_data {
    target = data.msgraph_resource.subscribed_skus[0]
    values = { output = { "skus" : [{ "skuId" : "11111111-1111-4111-8111-111111111111", "skuPartNumber" : "AAD_PREMIUM", "capabilityStatus" : "Enabled", "prepaidUnits" : { "enabled" : -1 }, "servicePlans" : [{ "servicePlanId" : "41781fb2-bc02-4b7c-bd55-b576c07bb09d" }] }], "next_link" : null } }
  }
  expect_failures = [data.msgraph_resource.subscribed_skus[0]]
}

run "rejects_partial_service_plan" {
  command = plan
  override_data {
    target = data.msgraph_resource.subscribed_skus[0]
    values = { output = { "skus" : [{ "skuId" : "11111111-1111-4111-8111-111111111111", "skuPartNumber" : "AAD_PREMIUM", "capabilityStatus" : "Enabled", "prepaidUnits" : { "enabled" : 1 }, "servicePlans" : [{ "servicePlanId" : "41781fb2-bc02-4b7c-bd55-b576c07bb09d" }, { "servicePlanId" : null }] }], "next_link" : null } }
  }
  expect_failures = [data.msgraph_resource.subscribed_skus[0]]
}

run "accepts_uppercase_service_plan_ids" {
  command = plan
  override_data {
    target = data.msgraph_resource.subscribed_skus[0]
    values = { output = { "skus" : [{ "skuId" : "11111111-1111-4111-8111-111111111111", "skuPartNumber" : "AAD_PREMIUM", "capabilityStatus" : "Enabled", "prepaidUnits" : { "enabled" : 1 }, "servicePlans" : [{ "servicePlanId" : "41781FB2-BC02-4B7C-BD55-B576C07BB09D" }] }], "next_link" : null } }
  }
  assert {
    condition     = output.tier == "p1" && length(output.licensed_skus) == 1
    error_message = "A documented plan GUID must match independently of Graph hexadecimal casing."
  }
}
