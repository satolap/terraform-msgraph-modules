# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  variables {
    company_id = "test-parent-id"
  }

  assert {
    condition     = msgraph_resource.this.url == "financials/companies/test-parent-id/items"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["baseUnitOfMeasureId", "blocked", "displayName", "gtin", "id", "inventory", "itemCategory", "itemCategoryCode", "itemCategoryId", "lastModifiedDateTime", "number", "picture", "priceIncludesTax", "taxGroupCode", "taxGroupId", "type", "unitCost", "unitPrice"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    company_id              = "test-parent-id"
    base_unit_of_measure_id = "00000000-0000-0000-0000-000000000001"
    blocked                 = false
    inventory               = 0
    picture                 = [{}]
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["baseUnitOfMeasureId"]) == jsonencode("00000000-0000-0000-0000-000000000001")
    error_message = "baseUnitOfMeasureId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["blocked"]) == jsonencode(false)
    error_message = "blocked must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["inventory"]) == jsonencode(0)
    error_message = "inventory must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["picture"]) == jsonencode([{ "@odata.type" = "#microsoft.graph.picture" }])
    error_message = "picture must preserve typed values and omit nested nulls."
  }
}
