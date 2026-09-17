# /education/users/{educationUser-id}/assignments

Create new navigation property to assignments for education

[Catalog](../../../../../README.md) · [Education](../../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/educationassignment?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /education/users/{educationUser-id}/assignments`, `GET/PATCH/DELETE /education/users/{educationUser-id}/assignments/{educationAssignment-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./education/education/users/by-education-user-id/assignments"
  education_user_id = "parent-object-id"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `education_user_id` | URL parameter `educationUser-id` | `string` | yes | no |
| `add_to_calendar_action` | `addToCalendarAction` | `any` | no | no |
| `added_student_action` | `addedStudentAction` | `any` | no | no |
| `allow_late_submissions` | `allowLateSubmissions` | `bool` | no | no |
| `allow_students_to_add_resources_to_submission` | `allowStudentsToAddResourcesToSubmission` | `bool` | no | no |
| `assign_to` | `assignTo` | `any` | no | no |
| `class_id` | `classId` | `string` | no | no |
| `close_date_time` | `closeDateTime` | `string` | no | no |
| `display_name` | `displayName` | `string` | no | no |
| `due_date_time` | `dueDateTime` | `string` | no | no |
| `grading` | `grading` | `any` | no | no |
| `grading_category` | `gradingCategory` | `any` | no | no |
| `grading_scheme` | `gradingScheme` | `any` | no | no |
| `instructions` | `instructions` | `any` | no | no |
| `language_tag` | `languageTag` | `string` | no | no |
| `module_url` | `moduleUrl` | `string` | no | no |
| `notification_channel_url` | `notificationChannelUrl` | `string` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `resources` | `resources` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationAssignmentResource")       dependentResources = optional(any)       distributeForStudentWork = optional(bool)       resource = optional(any)     }))` | no | no |
| `rubric` | `rubric` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- addToCalendarAction: polymorphic schema; accepts an untyped value
- addedStudentAction: polymorphic schema; accepts an untyped value
- assignTo: polymorphic schema; accepts an untyped value
- grading: polymorphic schema; accepts an untyped value
- gradingCategory: polymorphic schema; accepts an untyped value
- gradingScheme: polymorphic schema; accepts an untyped value
- instructions: polymorphic schema; accepts an untyped value
- resources[].dependentResources[]: recursive schema; accepts an untyped value
- resources[].resource: polymorphic schema; accepts an untyped value
- rubric: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
