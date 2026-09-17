# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "assignableTo"              = var.assignable_to
    "assignments"               = (var.assignments == null ? null : [for item0 in var.assignments : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allotment" = item0["allotment"], "assignedTo" = (item0["assignedTo"] == null ? null : { for key2, value2 in { "@odata.type" = item0["assignedTo"]["odata_type"], "deletedDateTime" = item0["assignedTo"]["deletedDateTime"] } : key2 => value2 if value2 != null }), "disabledServicePlanIds" = (item0["disabledServicePlanIds"] == null ? null : [for item2 in item0["disabledServicePlanIds"] : item2 if item2 != null]) } : key1 => value1 if value1 != null }) if item0 != null])
    "externalServiceIdentifier" = var.external_service_identifier
    "@odata.type"               = var.odata_type
    "subscriptions"             = (var.subscriptions == null ? null : [for item0 in var.subscriptions : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "nextLifecycleDate" = item0["nextLifecycleDate"], "startDate" = item0["startDate"], "state" = item0["state"], "subscriptionId" = item0["subscriptionId"], "tags" = item0["tags"] } : key1 => value1 if value1 != null }) if item0 != null])
    "waitingMembers"            = (var.waiting_members == null ? null : [for item0 in var.waiting_members : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "allotment" = (item0["allotment"] == null ? null : { for key2, value2 in { "@odata.type" = item0["allotment"]["odata_type"], "assignableTo" = item0["allotment"]["assignableTo"], "assignments" = (item0["allotment"]["assignments"] == null ? null : [for item3 in item0["allotment"]["assignments"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "allotment" = item3["allotment"], "assignedTo" = item3["assignedTo"], "disabledServicePlanIds" = item3["disabledServicePlanIds"] } : key4 => value4 if value4 != null }) if item3 != null]), "externalServiceIdentifier" = item0["allotment"]["externalServiceIdentifier"], "subscriptions" = (item0["allotment"]["subscriptions"] == null ? null : [for item3 in item0["allotment"]["subscriptions"] : (item3 == null ? null : { for key4, value4 in { "@odata.type" = item3["odata_type"], "nextLifecycleDate" = item3["nextLifecycleDate"], "startDate" = item3["startDate"], "state" = item3["state"], "subscriptionId" = item3["subscriptionId"], "tags" = item3["tags"] } : key4 => value4 if value4 != null }) if item3 != null]), "waitingMembers" = (item0["allotment"]["waitingMembers"] == null ? null : [for item3 in item0["allotment"]["waitingMembers"] : item3 if item3 != null]) } : key2 => value2 if value2 != null }), "assignedTo" = (item0["assignedTo"] == null ? null : { for key2, value2 in { "@odata.type" = item0["assignedTo"]["odata_type"], "deletedDateTime" = item0["assignedTo"]["deletedDateTime"] } : key2 => value2 if value2 != null }), "waitingSinceDateTime" = item0["waitingSinceDateTime"] } : key1 => value1 if value1 != null }) if item0 != null])
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "admin/cloudLicensing/allotments"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
