# Offline plan tests: Terraform mocks the provider and never contacts Microsoft Graph.
mock_provider "msgraph" {}

run "minimal_request" {
  command = plan

  assert {
    condition     = msgraph_resource.this.url == "reports/dailyPrintUsageSummariesByPrinter"
    error_message = "The collection URL must include parent identifiers and exclude the API-version prefix."
  }

  assert {
    condition     = alltrue([for key in ["blackAndWhitePageCount", "colorPageCount", "completedBlackAndWhiteJobCount", "completedColorJobCount", "completedJobCount", "doubleSidedSheetCount", "incompleteJobCount", "mediaSheetCount", "pageCount", "printerId", "printerName", "singleSidedSheetCount", "usageDate"] : !contains(keys(msgraph_resource.this.body), key)])
    error_message = "Unset optional inputs must be omitted from the Graph request."
  }
}

run "typed_request" {
  command = plan

  variables {
    printer_id                 = "example"
    black_and_white_page_count = 0
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["printerId"]) == jsonencode("example")
    error_message = "printerId must preserve typed values and omit nested nulls."
  }

  assert {
    condition     = jsonencode(msgraph_resource.this.body["blackAndWhitePageCount"]) == jsonencode(0)
    error_message = "blackAndWhitePageCount must preserve typed values and omit nested nulls."
  }
}
