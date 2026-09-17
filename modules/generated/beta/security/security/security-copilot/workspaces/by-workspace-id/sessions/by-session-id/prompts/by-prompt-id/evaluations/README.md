# /security/securityCopilot/workspaces/{workspace-id}/sessions/{session-id}/prompts/{prompt-id}/evaluations

Create new navigation property to evaluations for security

[Catalog](../../../../../../../../../../README.md) · [Security](../../../../../../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-securitycopilot-evaluation?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /security/securityCopilot/workspaces/{workspace-id}/sessions/{session-id}/prompts/{prompt-id}/evaluations`, `GET/PATCH/DELETE /security/securityCopilot/workspaces/{workspace-id}/sessions/{session-id}/prompts/{prompt-id}/evaluations/{evaluation-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./security/security/security-copilot/workspaces/by-workspace-id/sessions/by-session-id/prompts/by-prompt-id/evaluations"
  workspace_id = "parent-object-id"
  session_id = "parent-object-id"
  prompt_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `workspace_id` | URL parameter `workspace-id` | `string` | yes | no |
| `session_id` | URL parameter `session-id` | `string` | yes | no |
| `prompt_id` | URL parameter `prompt-id` | `string` | yes | no |
| `completed_date_time` | `completedDateTime` | `string` | no | no |
| `created_date_time` | `createdDateTime` | `string` | no | no |
| `execution_count` | `executionCount` | `number` | no | no |
| `is_cancelled` | `isCancelled` | `bool` | no | no |
| `last_modified_date_time` | `lastModifiedDateTime` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `result` | `result` | `any` | no | no |
| `run_start_date_time` | `runStartDateTime` | `string` | no | no |
| `state` | `state` | `string` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- result: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
