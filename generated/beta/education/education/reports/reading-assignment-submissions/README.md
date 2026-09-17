# /education/reports/readingAssignmentSubmissions

Create new navigation property to readingAssignmentSubmissions for education

[Catalog](../../../../README.md) · [Education](../../../README.md) · [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/readingassignmentsubmission?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /education/reports/readingAssignmentSubmissions`, `GET/PATCH/DELETE /education/reports/readingAssignmentSubmissions/{readingAssignmentSubmission-id}`.

## Usage

```hcl
module "graph_resource" {
  source = "./education/education/reports/reading-assignment-submissions"
}
```

Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.7 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Inputs

| Input | Graph property | Type | Required | Sensitive |
| --- | --- | --- | --- | --- |
| `accuracy_score` | `accuracyScore` | `any` | no | no |
| `action` | `action` | `string` | no | no |
| `assignment_id` | `assignmentId` | `string` | no | no |
| `challenging_words` | `challengingWords` | `list(object({       odata_type = optional(string, "#microsoft.graph.challengingWord")       count = optional(number)       word = optional(string)     }))` | no | no |
| `class_id` | `classId` | `string` | no | no |
| `insertions` | `insertions` | `number` | no | no |
| `mispronunciations` | `mispronunciations` | `number` | no | no |
| `missed_exclamation_marks` | `missedExclamationMarks` | `number` | no | no |
| `missed_periods` | `missedPeriods` | `number` | no | no |
| `missed_question_marks` | `missedQuestionMarks` | `number` | no | no |
| `missed_shorts` | `missedShorts` | `number` | no | no |
| `monotone_score` | `monotoneScore` | `any` | no | no |
| `odata_type` | `@odata.type` | `string` | no | no |
| `omissions` | `omissions` | `number` | no | no |
| `repetitions` | `repetitions` | `number` | no | no |
| `self_corrections` | `selfCorrections` | `number` | no | no |
| `student_id` | `studentId` | `string` | no | no |
| `submission_date_time` | `submissionDateTime` | `string` | no | no |
| `submission_id` | `submissionId` | `string` | no | no |
| `unexpected_pauses` | `unexpectedPauses` | `number` | no | no |
| `word_count` | `wordCount` | `number` | no | no |
| `words_per_minute` | `wordsPerMinute` | `any` | no | no |
| `additional_properties` | Additional writable API properties | `any` | no | yes |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Outputs: `id`, `resource_url`, and sensitive `response` (the Graph object, including service-specific IDs when returned). Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- accuracyScore: polymorphic schema; accepts an untyped value
- monotoneScore: polymorphic schema; accepts an untyped value
- wordsPerMinute: polymorphic schema; accepts an untyped value

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
