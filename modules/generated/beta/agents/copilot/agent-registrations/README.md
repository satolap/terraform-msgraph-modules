# /copilot/agentRegistrations

Create new navigation property to agentRegistrations for copilot

[Catalog](../../../README.md) · [Agents](../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/agentid-platform-overview?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /copilot/agentRegistrations`, `GET/PATCH/DELETE /copilot/agentRegistrations/{agentRegistration-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./agents/copilot/agent-registrations"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `agent_card` | `agentCard` | `any` | no | no |
| `agent_identity_blueprint_id` | `agentIdentityBlueprintId` | `string` | no | no |
| `agent_identity_id` | `agentIdentityId` | `string` | no | no |
| `created_by` | `createdBy` | `string` | no | no |
| `description` | `description` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `last_published_by` | `lastPublishedBy` | `string` | no | no |
| `managed_by_app_id` | `managedByAppId` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `originating_store` | `originatingStore` | `string` | no | no |
| `owner_ids` | `ownerIds` | `list(string)` | no | no |
| `source_agent_id` | `sourceAgentId` | `string` | no | no |
| `source_created_date_time` | `sourceCreatedDateTime` | `string` | no | no |
| `source_last_modified_date_time` | `sourceLastModifiedDateTime` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Generation notes:

- Microsoft Graph beta contracts can change without notice.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
