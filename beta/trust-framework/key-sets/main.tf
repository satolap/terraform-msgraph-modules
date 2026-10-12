# Generated from pinned Microsoft Graph sources; do not edit.
locals {
  typed_body = { for key, value in {
    "keys"        = (var.keys == null ? null : [for item0 in var.keys : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "d" = item0["d"], "dp" = item0["dp"], "dq" = item0["dq"], "e" = item0["e"], "exp" = item0["exp"], "k" = item0["k"], "kid" = item0["kid"], "kty" = item0["kty"], "n" = item0["n"], "nbf" = item0["nbf"], "p" = item0["p"], "q" = item0["q"], "qi" = item0["qi"], "status" = item0["status"], "use" = item0["use"], "x5c" = (item0["x5c"] == null ? null : [for item2 in item0["x5c"] : item2 if item2 != null]), "x5t" = item0["x5t"] } : key1 => value1 if value1 != null }) if item0 != null])
    "keys_v2"     = (var.keys_v2 == null ? null : [for item0 in var.keys_v2 : (item0 == null ? null : { for key1, value1 in { "@odata.type" = item0["odata_type"], "d" = item0["d"], "dp" = item0["dp"], "dq" = item0["dq"], "e" = item0["e"], "exp" = item0["exp"], "k" = item0["k"], "kid" = item0["kid"], "kty" = item0["kty"], "n" = item0["n"], "nbf" = item0["nbf"], "p" = item0["p"], "q" = item0["q"], "qi" = item0["qi"], "status" = item0["status"], "use" = item0["use"], "x5c" = (item0["x5c"] == null ? null : [for item2 in item0["x5c"] : item2 if item2 != null]), "x5t" = item0["x5t"] } : key1 => value1 if value1 != null }) if item0 != null])
    "@odata.type" = var.odata_type
  } : key => value if value != null }
  body = merge({ for key, value in var.additional_properties : key => value if value != null }, local.typed_body)
}

resource "msgraph_resource" "this" {
  url                     = "trustFramework/keySets"
  api_version             = "beta"
  update_method           = "PATCH"
  body                    = local.body
  ignore_missing_property = true

  response_export_values = {
    response = "@"
  }
}
