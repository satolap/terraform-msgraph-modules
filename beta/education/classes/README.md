# /education/classes

<!-- state-protection:start -->
## State and plan protection

This module's state and saved plans retain these declared values:

Sensitive inputs: `additional_properties`, `members`, `schools`, `teachers`.
Sensitive outputs: `response`.

Protect these values with an encrypted remote backend and least-privilege access to state, plans and backups. `sensitive` is presentation redaction, not encryption; provider resource values can still appear in plan/show output. Do not publish plan output in CI logs or PR comments for secret-bearing roots; keep saved plans short-lived and rotate credentials after exposure.

See [Terraform sensitive state guidance](https://developer.hashicorp.com/terraform/language/state/sensitive-data). These are exposure indicators, not a complete data classification; unmarked fields and provider responses also need protection.
<!-- state-protection:end -->

Create educationClass

[Catalog](../../README.md) Â· [Education](../../README.md#education) Â· [Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/educationclass?view=graph-rest-beta&preserve-view=true)

Generated from Microsoft Graph **beta** OpenAPI and optional EDMX metadata.

Lifecycle: `POST /education/classes`, `GET/PATCH/DELETE /education/classes/{educationClass-id}`.

Assurance: **generated (offline contract)**. Schema-derived request construction and mock tests do not prove live service behavior.

> **Beta preview:** Microsoft Graph beta APIs may change without notice. Pin the module release version and provider version, and read `interface-changes.json` in the release before upgrading. Offline tests and live acceptance do not make a beta API production-supported.

## Usage

```hcl
module "graph_resource" {
  source  = "satolap/modules/msgraph//beta/education/classes"
  version = "<version>"

}
```

Replace `<version>` with a release version, such as `0.5.0`; the [terraform-msgraph-modules README](https://github.com/satolap/terraform-msgraph-modules#install-a-module-from-the-terraform-registry) explains how to choose one. Configure the Microsoft/msgraph provider in the calling root module using your chosen authentication method. Terraform >= 1.11 and Microsoft/msgraph >= 0.4, < 1.0 are required.

## Read-back and drift

`select_response` defaults to `false`. Default reads keep `ignore_missing_property = true` and the full default GET response, including default-returned fields that were not configured. This preserves existing read behavior and response consumers, but can hide missing, null or empty reads. It does not prove a successful write or clear.

Strict read-back is not offered as a module input. Every generated body carries `@odata.type`, which ordinary GET responses omit; strict provider refresh would remove it and cause perpetual drift. Offering strict read-back requires annotation-aware comparison or a provider change, plus live proof.

Enabling `select_response` can plan an in-place resource update even when body values are unchanged. Whether an option-only change sends a write request is unverified; inspect the plan before opting in.

Only with `select_response = true`, the item GET selects `id`, `appId` when exposed as an output, and configured readable body keys (including additional properties). Annotations, known navigation properties and top-level write-only/omitted keys are excluded. This deliberately narrows the sensitive `response` output: an expression such as `module.group.response.mail` can stop working if mail was not selected. Use the default for existing consumers. Selection does not make provider refresh strict or prove a successful write.

No select-only inputs are identified by this metadata and contract; classification is incomplete.

Classification remains incomplete, especially for nested null-unless-selected values, permission-hidden properties and beta descriptions. Unclassified omissions can still be hidden by lenient refresh. Provider-refresh characterization tests are offline evidence, not proof of Graph behavior. Before offering strict read-back or changing the selection default, live independent GETs and repeated no-op plans must pass on users, groups, applications and servicePrincipals, including nested credentials and relationship cases.

## Timeouts and replication retries

The optional `timeouts` input (`create`, `read`, `update`, `delete`) is passed to the `msgraph_resource`. Every value defaults to null, which keeps the provider defaults and sends no timeouts block, so adding it changes no existing plan. Durations are whole hours, minutes or seconds greater than zero, such as `30m` or `1h30m`, and `create`, `update` and `delete` must be at least `15s`. Setting `read` plans an in-place update of every deployed object, because the provider's default read timeout is then replaced. The provider already retries 408, 429, 500, 502, 503 and 504 by itself.

This module has no reviewed replication retry.

## Inputs

**On change** says what changing an input does to the Graph object; [declaration.json](declaration.json) declares the same for tools, with the outputs. A nested object attribute behaves like the input that holds it.

| Input | Graph property | Type | Required | Sensitive | On change |
| --- | --- | --- | --- | --- | --- |
| `assignmentCategories` | `assignmentCategories` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationCategory")       displayName = optional(string)     }))` | no | no | in place |
| `assignmentDefaults` | `assignmentDefaults` | `any` | no | no | in place |
| `assignmentSettings` | `assignmentSettings` | `any` | no | no | in place |
| `assignments` | `assignments` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationAssignment")       addToCalendarAction = optional(string)       addedStudentAction = optional(string)       allowLateSubmissions = optional(bool)       allowStudentsToAddResourcesToSubmission = optional(bool)       assignTo = optional(any)       classId = optional(string)       closeDateTime = optional(string)       displayName = optional(string)       dueDateTime = optional(string)       grading = optional(any)       gradingCategory = optional(any)       gradingScheme = optional(any)       instructions = optional(object({       odata_type = optional(string, "#microsoft.graph.educationItemBody")       content = optional(string)       contentType = optional(string)     }))       languageTag = optional(string)       moduleUrl = optional(string)       notificationChannelUrl = optional(string)       resources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationAssignmentResource")       dependentResources = optional(any)       distributeForStudentWork = optional(bool)       resource = optional(any)     })))       rubric = optional(any)     }))` | no | no | in place |
| `classCode` | `classCode` | `string` | no | no | in place |
| `course` | `course` | `object({       odata_type = optional(string, "#microsoft.graph.educationCourse")       courseNumber = optional(string)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       subject = optional(string)     })` | no | no | in place |
| `createdBy` | `createdBy` | `any` | no | no | in place |
| `description` | `description` | `string` | no | no | in place |
| `displayName` | `displayName` | `string` | no | no | in place |
| `externalId` | `externalId` | `string` | no | no | in place |
| `externalName` | `externalName` | `string` | no | no | in place |
| `externalSource` | `externalSource` | `string` | no | no | in place |
| `externalSourceDetail` | `externalSourceDetail` | `string` | no | no | in place |
| `grade` | `grade` | `string` | no | no | in place |
| `group` | `group` | `any` | no | no | in place |
| `mailNickname` | `mailNickname` | `string` | no | no | in place |
| `members` | `members` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationUser")       accountEnabled = optional(bool)       assignedLicenses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     })))       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationAssignment")       addToCalendarAction = optional(string)       addedStudentAction = optional(string)       allowLateSubmissions = optional(bool)       allowStudentsToAddResourcesToSubmission = optional(bool)       assignTo = optional(any)       classId = optional(string)       closeDateTime = optional(string)       displayName = optional(string)       dueDateTime = optional(string)       grading = optional(any)       gradingCategory = optional(any)       gradingScheme = optional(any)       instructions = optional(object({       odata_type = optional(string, "#microsoft.graph.educationItemBody")       content = optional(string)       contentType = optional(string)     }))       languageTag = optional(string)       moduleUrl = optional(string)       notificationChannelUrl = optional(string)       resources = optional(any)       rubric = optional(any)     })))       businessPhones = optional(list(string))       classes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(any)       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(any)       classCode = optional(string)       course = optional(object({       odata_type = optional(string, "#microsoft.graph.educationCourse")       courseNumber = optional(string)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       subject = optional(string)     }))       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(any)       modules = optional(any)       schools = optional(any)       teachers = optional(any)       term = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTerm")       displayName = optional(string)       endDate = optional(string)       externalId = optional(string)       startDate = optional(string)     }))     })))       createdBy = optional(any)       department = optional(string)       displayName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       givenName = optional(string)       mailNickname = optional(string)       mailingAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(string)     }))       middleName = optional(string)       mobilePhone = optional(string)       officeLocation = optional(string)       onPremisesInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.educationOnPremisesInfo")       immutableId = optional(string)     }))       passwordPolicies = optional(string)       passwordProfile = optional(object({       odata_type = optional(string, "#microsoft.graph.passwordProfile")       forceChangePasswordNextSignIn = optional(bool)       forceChangePasswordNextSignInWithMfa = optional(bool)       password = optional(string)     }))       preferredLanguage = optional(string)       primaryRole = optional(string)       refreshTokensValidFromDateTime = optional(string)       relatedContacts = optional(list(object({       odata_type = optional(string, "#microsoft.graph.relatedContact")       accessConsent = optional(bool)       displayName = optional(string)       emailAddress = optional(string)       id = optional(string)       mobilePhone = optional(string)       relationship = optional(string)     })))       residenceAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(string)     }))       rubrics = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationRubric")       description = optional(object({       odata_type = optional(string, "#microsoft.graph.educationItemBody")       content = optional(string)       contentType = optional(string)     }))       displayName = optional(string)       grading = optional(any)       levels = optional(any)       qualities = optional(any)     })))       schools = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationSchool")       address = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(string)     }))       administrativeUnit = optional(any)       classes = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalPrincipalId = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       fax = optional(string)       highestGrade = optional(string)       lowestGrade = optional(string)       phone = optional(string)       principalEmail = optional(string)       principalName = optional(string)       schoolNumber = optional(string)       users = optional(any)     })))       showInAddressList = optional(bool)       student = optional(object({       odata_type = optional(string, "#microsoft.graph.educationStudent")       birthDate = optional(string)       externalId = optional(string)       gender = optional(string)       grade = optional(string)       graduationYear = optional(string)       studentNumber = optional(string)     }))       surname = optional(string)       taughtClasses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(any)       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(any)       classCode = optional(string)       course = optional(object({       odata_type = optional(string, "#microsoft.graph.educationCourse")       courseNumber = optional(string)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       subject = optional(string)     }))       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(any)       modules = optional(any)       schools = optional(any)       teachers = optional(any)       term = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTerm")       displayName = optional(string)       endDate = optional(string)       externalId = optional(string)       startDate = optional(string)     }))     })))       teacher = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTeacher")       externalId = optional(string)       teacherNumber = optional(string)     }))       usageLocation = optional(string)       user = optional(any)       userPrincipalName = optional(string)       userType = optional(string)     }))` | no | yes | in place |
| `modules` | `modules` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationModule")       description = optional(string)       displayName = optional(string)       isPinned = optional(bool)       languageTag = optional(string)       resources = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationModuleResource")       resource = optional(any)     })))     }))` | no | no | in place |
| `odata_type` | `@odata.type` | `string` | no | no | in place |
| `schools` | `schools` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationSchool")       address = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(string)     }))       administrativeUnit = optional(any)       classes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(any)       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(any)       classCode = optional(string)       course = optional(object({       odata_type = optional(string, "#microsoft.graph.educationCourse")       courseNumber = optional(string)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       subject = optional(string)     }))       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(any)       modules = optional(any)       schools = optional(any)       teachers = optional(any)       term = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTerm")       displayName = optional(string)       endDate = optional(string)       externalId = optional(string)       startDate = optional(string)     }))     })))       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalPrincipalId = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       fax = optional(string)       highestGrade = optional(string)       lowestGrade = optional(string)       phone = optional(string)       principalEmail = optional(string)       principalName = optional(string)       schoolNumber = optional(string)       users = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationUser")       accountEnabled = optional(bool)       assignedLicenses = optional(any)       assignments = optional(any)       businessPhones = optional(list(string))       classes = optional(any)       createdBy = optional(any)       department = optional(string)       displayName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       givenName = optional(string)       mailNickname = optional(string)       mailingAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(string)     }))       middleName = optional(string)       mobilePhone = optional(string)       officeLocation = optional(string)       onPremisesInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.educationOnPremisesInfo")       immutableId = optional(string)     }))       passwordPolicies = optional(string)       passwordProfile = optional(object({       odata_type = optional(string, "#microsoft.graph.passwordProfile")       forceChangePasswordNextSignIn = optional(bool)       forceChangePasswordNextSignInWithMfa = optional(bool)       password = optional(string)     }))       preferredLanguage = optional(string)       primaryRole = optional(string)       refreshTokensValidFromDateTime = optional(string)       relatedContacts = optional(any)       residenceAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(string)     }))       rubrics = optional(any)       schools = optional(any)       showInAddressList = optional(bool)       student = optional(object({       odata_type = optional(string, "#microsoft.graph.educationStudent")       birthDate = optional(string)       externalId = optional(string)       gender = optional(string)       grade = optional(string)       graduationYear = optional(string)       studentNumber = optional(string)     }))       surname = optional(string)       taughtClasses = optional(any)       teacher = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTeacher")       externalId = optional(string)       teacherNumber = optional(string)     }))       usageLocation = optional(string)       user = optional(any)       userPrincipalName = optional(string)       userType = optional(string)     })))     }))` | no | yes | in place |
| `teachers` | `teachers` | `list(object({       odata_type = optional(string, "#microsoft.graph.educationUser")       accountEnabled = optional(bool)       assignedLicenses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.assignedLicense")       disabledPlans = optional(list(string))       skuId = optional(string)     })))       assignments = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationAssignment")       addToCalendarAction = optional(string)       addedStudentAction = optional(string)       allowLateSubmissions = optional(bool)       allowStudentsToAddResourcesToSubmission = optional(bool)       assignTo = optional(any)       classId = optional(string)       closeDateTime = optional(string)       displayName = optional(string)       dueDateTime = optional(string)       grading = optional(any)       gradingCategory = optional(any)       gradingScheme = optional(any)       instructions = optional(object({       odata_type = optional(string, "#microsoft.graph.educationItemBody")       content = optional(string)       contentType = optional(string)     }))       languageTag = optional(string)       moduleUrl = optional(string)       notificationChannelUrl = optional(string)       resources = optional(any)       rubric = optional(any)     })))       businessPhones = optional(list(string))       classes = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(any)       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(any)       classCode = optional(string)       course = optional(object({       odata_type = optional(string, "#microsoft.graph.educationCourse")       courseNumber = optional(string)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       subject = optional(string)     }))       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(any)       modules = optional(any)       schools = optional(any)       teachers = optional(any)       term = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTerm")       displayName = optional(string)       endDate = optional(string)       externalId = optional(string)       startDate = optional(string)     }))     })))       createdBy = optional(any)       department = optional(string)       displayName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       givenName = optional(string)       mailNickname = optional(string)       mailingAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(string)     }))       middleName = optional(string)       mobilePhone = optional(string)       officeLocation = optional(string)       onPremisesInfo = optional(object({       odata_type = optional(string, "#microsoft.graph.educationOnPremisesInfo")       immutableId = optional(string)     }))       passwordPolicies = optional(string)       passwordProfile = optional(object({       odata_type = optional(string, "#microsoft.graph.passwordProfile")       forceChangePasswordNextSignIn = optional(bool)       forceChangePasswordNextSignInWithMfa = optional(bool)       password = optional(string)     }))       preferredLanguage = optional(string)       primaryRole = optional(string)       refreshTokensValidFromDateTime = optional(string)       relatedContacts = optional(list(object({       odata_type = optional(string, "#microsoft.graph.relatedContact")       accessConsent = optional(bool)       displayName = optional(string)       emailAddress = optional(string)       id = optional(string)       mobilePhone = optional(string)       relationship = optional(string)     })))       residenceAddress = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(string)     }))       rubrics = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationRubric")       description = optional(object({       odata_type = optional(string, "#microsoft.graph.educationItemBody")       content = optional(string)       contentType = optional(string)     }))       displayName = optional(string)       grading = optional(any)       levels = optional(any)       qualities = optional(any)     })))       schools = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationSchool")       address = optional(object({       odata_type = optional(string, "#microsoft.graph.physicalAddress")       city = optional(string)       countryOrRegion = optional(string)       postOfficeBox = optional(string)       postalCode = optional(string)       state = optional(string)       street = optional(string)       type = optional(string)     }))       administrativeUnit = optional(any)       classes = optional(any)       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalPrincipalId = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       fax = optional(string)       highestGrade = optional(string)       lowestGrade = optional(string)       phone = optional(string)       principalEmail = optional(string)       principalName = optional(string)       schoolNumber = optional(string)       users = optional(any)     })))       showInAddressList = optional(bool)       student = optional(object({       odata_type = optional(string, "#microsoft.graph.educationStudent")       birthDate = optional(string)       externalId = optional(string)       gender = optional(string)       grade = optional(string)       graduationYear = optional(string)       studentNumber = optional(string)     }))       surname = optional(string)       taughtClasses = optional(list(object({       odata_type = optional(string, "#microsoft.graph.educationClass")       assignmentCategories = optional(any)       assignmentDefaults = optional(any)       assignmentSettings = optional(any)       assignments = optional(any)       classCode = optional(string)       course = optional(object({       odata_type = optional(string, "#microsoft.graph.educationCourse")       courseNumber = optional(string)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       subject = optional(string)     }))       createdBy = optional(any)       description = optional(string)       displayName = optional(string)       externalId = optional(string)       externalName = optional(string)       externalSource = optional(string)       externalSourceDetail = optional(string)       grade = optional(string)       group = optional(any)       mailNickname = optional(string)       members = optional(any)       modules = optional(any)       schools = optional(any)       teachers = optional(any)       term = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTerm")       displayName = optional(string)       endDate = optional(string)       externalId = optional(string)       startDate = optional(string)     }))     })))       teacher = optional(object({       odata_type = optional(string, "#microsoft.graph.educationTeacher")       externalId = optional(string)       teacherNumber = optional(string)     }))       usageLocation = optional(string)       user = optional(any)       userPrincipalName = optional(string)       userType = optional(string)     }))` | no | yes | in place |
| `term` | `term` | `object({       odata_type = optional(string, "#microsoft.graph.educationTerm")       displayName = optional(string)       endDate = optional(string)       externalId = optional(string)       startDate = optional(string)     })` | no | no | in place |
| `additional_properties` | Additional writable API properties | `any` | no | yes | in place |

Explicit typed inputs take precedence over additional properties. Optional null values are omitted recursively from typed object inputs; untyped values must be supplied without nested nulls. To add undocumented fields inside an optional object, omit its typed input and pass the complete object in `additional_properties`. Nested object keys retain Graph spelling when valid Terraform identifiers; special keys such as `@odata.type` use `odata_type`. Graph type discriminators have schema-derived defaults.

Sensitive inputs, `additional_properties`, and the `response` output are redacted in normal Terraform presentation. Their values still exist in saved plans and state: restrict access to those files and the state backend. Sensitivity is not encryption or a substitute for state access controls.

## Outputs

**Known in plan after an update** is whether a plan still knows the value when it updates the object in place; a value read from the Graph response is known only after apply then.

| Output | Provides | Sensitive | Known in plan after an update |
| --- | --- | --- | --- |
| `id` | Graph object ID | no | yes |
| `resource_url` | Graph URL of the object | no | yes |
| `response` | the Graph object as returned | yes | no |

Server-assigned properties in `response`: `id`.

Import the resource at `module.graph_resource.msgraph_resource.this` using its Graph resource path.

## Permissions and limitations

## Per-operation permissions

Source: [Graph DevX map](https://raw.githubusercontent.com/microsoftgraph/microsoft-graph-devx-content/56e1917fe45fb7c52c2d9845f569c2ffdb39e4d9/permissions/new/permissions.json) (SHA-256 `4d7dee52659b1d6424bce0b26603302081d39ef9e149bc5fb50de4273b3d3514`).
The map is shared by v1.0 and beta; it does not certify API-version support. Rows show the source's least-privilege annotations, not live-tested consent. Choose an alternative for your authentication type; do not grant every listed scope. AlsoRequires lists additional scope alternatives attached to that row. Missing annotations are unknown, not evidence that an operation needs no permission. Keep the module's documented role, property-specific and tenant restrictions.

| Operation | Authentication | Least-privilege alternative | AlsoRequires |
| --- | --- | --- | --- |
| `POST /education/classes` | DelegatedWork | Unknown / not annotated | — |
| `POST /education/classes` | DelegatedPersonal | Unknown / not annotated | — |
| `POST /education/classes` | Application | `EduRoster.ReadWrite.All` | — |
| `GET /education/classes/{educationClass-id}` | DelegatedWork | `EduRoster.ReadBasic` | — |
| `GET /education/classes/{educationClass-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `GET /education/classes/{educationClass-id}` | Application | `EduRoster.Read.All` | — |
| `GET /education/classes/{educationClass-id}` | Application | `EduRoster.ReadWrite.All` | — |
| `PATCH /education/classes/{educationClass-id}` | DelegatedWork | Unknown / not annotated | — |
| `PATCH /education/classes/{educationClass-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `PATCH /education/classes/{educationClass-id}` | Application | `EduRoster.ReadWrite.All` | — |
| `DELETE /education/classes/{educationClass-id}` | DelegatedWork | Unknown / not annotated | — |
| `DELETE /education/classes/{educationClass-id}` | DelegatedPersonal | Unknown / not annotated | — |
| `DELETE /education/classes/{educationClass-id}` | Application | `EduRoster.ReadWrite.All` | — |

Review the Microsoft Graph API documentation for this endpoint's application/delegated permissions, required create fields, licensing, and tenant restrictions. Required inputs come from the request schema and explicit reviewed corrections, not from EDMX response nullability. The generated module is schema-derived; its lifecycle has not been tested against a live tenant.

Read-only properties are excluded using OpenAPI flags/descriptions and EDMX computed annotations. Metadata can enrich an existing request property but never adds response-only properties. Polymorphic, recursive, or very deep values use `any`; their server-side shape remains the caller's responsibility.

Documented collection GET parameters: `$count`, `$expand`, `$filter`, `$orderby`, `$search`, `$select`, `$skip`, `$top`. This module manages an object; it does not implement listing or pagination.

Generation notes:

- Microsoft Graph beta contracts can change without notice.
- assignmentDefaults: navigation property; accepts an untyped value
- assignmentSettings: navigation property; accepts an untyped value
- assignments[].addToCalendarAction: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: studentsOnly; excluded from typed input validation
- assignments[].assignTo: polymorphic schema; accepts an untyped value
- assignments[].grading: polymorphic schema; accepts an untyped value
- assignments[].gradingCategory: navigation property; accepts an untyped value
- assignments[].gradingScheme: navigation property; accepts an untyped value
- assignments[].resources[].dependentResources[]: recursive schema; accepts an untyped value
- assignments[].resources[].resource: polymorphic schema; accepts an untyped value
- assignments[].rubric: navigation property; accepts an untyped value
- createdBy: polymorphic schema; accepts an untyped value
- externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- group: navigation property; accepts an untyped value
- members[].assignments[].addToCalendarAction: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: studentsOnly; excluded from typed input validation
- members[].assignments[].assignTo: polymorphic schema; accepts an untyped value
- members[].assignments[].grading: polymorphic schema; accepts an untyped value
- members[].assignments[].gradingCategory: navigation property; accepts an untyped value
- members[].assignments[].gradingScheme: navigation property; accepts an untyped value
- members[].assignments[].resources[]: nested schema exceeds depth limit; accepts an untyped value
- members[].assignments[].rubric: navigation property; accepts an untyped value
- members[].classes[].assignmentCategories[]: nested schema exceeds depth limit; accepts an untyped value
- members[].classes[].assignmentDefaults: navigation property; accepts an untyped value
- members[].classes[].assignmentSettings: navigation property; accepts an untyped value
- members[].classes[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- members[].classes[].createdBy: polymorphic schema; accepts an untyped value
- members[].classes[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- members[].classes[].group: navigation property; accepts an untyped value
- members[].classes[].members[]: recursive schema; accepts an untyped value
- members[].classes[].modules[]: nested schema exceeds depth limit; accepts an untyped value
- members[].classes[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- members[].classes[].teachers[]: recursive schema; accepts an untyped value
- members[].createdBy: polymorphic schema; accepts an untyped value
- members[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- members[].primaryRole: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: faculty; excluded from typed input validation
- members[].rubrics[].grading: polymorphic schema; accepts an untyped value
- members[].rubrics[].levels[]: nested schema exceeds depth limit; accepts an untyped value
- members[].rubrics[].qualities[]: nested schema exceeds depth limit; accepts an untyped value
- members[].schools[].administrativeUnit: navigation property; accepts an untyped value
- members[].schools[].classes[]: nested schema exceeds depth limit; accepts an untyped value
- members[].schools[].createdBy: polymorphic schema; accepts an untyped value
- members[].schools[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- members[].schools[].users[]: recursive schema; accepts an untyped value
- members[].taughtClasses[].assignmentCategories[]: nested schema exceeds depth limit; accepts an untyped value
- members[].taughtClasses[].assignmentDefaults: navigation property; accepts an untyped value
- members[].taughtClasses[].assignmentSettings: navigation property; accepts an untyped value
- members[].taughtClasses[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- members[].taughtClasses[].createdBy: polymorphic schema; accepts an untyped value
- members[].taughtClasses[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- members[].taughtClasses[].group: navigation property; accepts an untyped value
- members[].taughtClasses[].members[]: recursive schema; accepts an untyped value
- members[].taughtClasses[].modules[]: nested schema exceeds depth limit; accepts an untyped value
- members[].taughtClasses[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- members[].taughtClasses[].teachers[]: recursive schema; accepts an untyped value
- members[].user: polymorphic schema; accepts an untyped value
- modules[].resources[].resource: polymorphic schema; accepts an untyped value
- schools[].administrativeUnit: navigation property; accepts an untyped value
- schools[].classes[].assignmentCategories[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].classes[].assignmentDefaults: navigation property; accepts an untyped value
- schools[].classes[].assignmentSettings: navigation property; accepts an untyped value
- schools[].classes[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].classes[].createdBy: polymorphic schema; accepts an untyped value
- schools[].classes[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- schools[].classes[].group: navigation property; accepts an untyped value
- schools[].classes[].members[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].classes[].modules[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].classes[].schools[]: recursive schema; accepts an untyped value
- schools[].classes[].teachers[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].createdBy: polymorphic schema; accepts an untyped value
- schools[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- schools[].users[].assignedLicenses[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].users[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].users[].classes[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].users[].createdBy: polymorphic schema; accepts an untyped value
- schools[].users[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- schools[].users[].primaryRole: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: faculty; excluded from typed input validation
- schools[].users[].relatedContacts[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].users[].rubrics[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].users[].schools[]: recursive schema; accepts an untyped value
- schools[].users[].taughtClasses[]: nested schema exceeds depth limit; accepts an untyped value
- schools[].users[].user: polymorphic schema; accepts an untyped value
- teachers[].assignments[].addToCalendarAction: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: studentsOnly; excluded from typed input validation
- teachers[].assignments[].assignTo: polymorphic schema; accepts an untyped value
- teachers[].assignments[].grading: polymorphic schema; accepts an untyped value
- teachers[].assignments[].gradingCategory: navigation property; accepts an untyped value
- teachers[].assignments[].gradingScheme: navigation property; accepts an untyped value
- teachers[].assignments[].resources[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].assignments[].rubric: navigation property; accepts an untyped value
- teachers[].classes[].assignmentCategories[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].classes[].assignmentDefaults: navigation property; accepts an untyped value
- teachers[].classes[].assignmentSettings: navigation property; accepts an untyped value
- teachers[].classes[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].classes[].createdBy: polymorphic schema; accepts an untyped value
- teachers[].classes[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- teachers[].classes[].group: navigation property; accepts an untyped value
- teachers[].classes[].members[]: recursive schema; accepts an untyped value
- teachers[].classes[].modules[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].classes[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].classes[].teachers[]: recursive schema; accepts an untyped value
- teachers[].createdBy: polymorphic schema; accepts an untyped value
- teachers[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- teachers[].primaryRole: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: faculty; excluded from typed input validation
- teachers[].rubrics[].grading: polymorphic schema; accepts an untyped value
- teachers[].rubrics[].levels[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].rubrics[].qualities[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].schools[].administrativeUnit: navigation property; accepts an untyped value
- teachers[].schools[].classes[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].schools[].createdBy: polymorphic schema; accepts an untyped value
- teachers[].schools[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- teachers[].schools[].users[]: recursive schema; accepts an untyped value
- teachers[].taughtClasses[].assignmentCategories[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].taughtClasses[].assignmentDefaults: navigation property; accepts an untyped value
- teachers[].taughtClasses[].assignmentSettings: navigation property; accepts an untyped value
- teachers[].taughtClasses[].assignments[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].taughtClasses[].createdBy: polymorphic schema; accepts an untyped value
- teachers[].taughtClasses[].externalSource: enum members after unknownFutureValue require Prefer: include-unknown-enum-members on refresh and a live probe before use: lms; excluded from typed input validation
- teachers[].taughtClasses[].group: navigation property; accepts an untyped value
- teachers[].taughtClasses[].members[]: recursive schema; accepts an untyped value
- teachers[].taughtClasses[].modules[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].taughtClasses[].schools[]: nested schema exceeds depth limit; accepts an untyped value
- teachers[].taughtClasses[].teachers[]: recursive schema; accepts an untyped value
- teachers[].user: polymorphic schema; accepts an untyped value

## Licensing and prerequisites

License requirements for this endpoint have not been reviewed. Check the Microsoft Graph documentation and Microsoft Entra licensing for the feature this resource belongs to before relying on the module; a successful API call does not establish entitlement.

## Offline test

```sh
terraform init -backend=false
terraform test
```

The included mock test checks URL construction and request omission without Graph credentials. It does not verify permissions or server behavior.
