# Microsoft Graph v1.0 module catalog

**311 generated modules**, organized by the [Microsoft Graph API reference](https://github.com/microsoftgraph/microsoft-graph-docs-contrib/blob/4b7867afe88f98d2415ac2f0219debe86fcb5652/api-reference/v1.0/toc.yml).

Only collections with documented POST and item GET, PATCH/PUT, and DELETE operations are generated. Counts describe this supported CRUD subset; they do not imply coverage of every API in a category. Categories with no generated module are retained for browsing.

## Folder hierarchy

Each module folder is its Microsoft Graph route beneath the API version, in kebab-case without the ID parameters; a route over 150 characters drops the leading words a folder repeats from its parent. The module README and manifest retain the exact Graph URL. Categories group modules in this README only, so a change to Microsoft's documentation navigation never moves a module.

Example: [applications](applications/README.md). This is one module from this catalog:

```text
v1.0/
â”œâ”€â”€ README.md
â”œâ”€â”€ LICENSING-REVIEW.md
â”œâ”€â”€ manifest.json
â””â”€â”€ applications/
    â”œâ”€â”€ README.md
    â”œâ”€â”€ declaration.json
    â”œâ”€â”€ main.tf
    â”œâ”€â”€ variables.tf
    â”œâ”€â”€ outputs.tf
    â”œâ”€â”€ versions.tf
    â””â”€â”€ tests/
        â””â”€â”€ module.tftest.hcl
```

## Browse categories

| Category | Modules | Microsoft reference |
| --- | ---: | --- |
| [Users](#users) | 3 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/users?view=graph-rest-1.0&preserve-view=true) |
| [Groups](#groups) | 4 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/groups-overview?view=graph-rest-1.0&preserve-view=true) |
| [Applications](#applications) | 11 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/applications-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Agents](#agents) | 0 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/agentid-platform-overview?view=graph-rest-1.0&preserve-view=true) |
| [Backup and recovery](#backup-and-recovery) | 4 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/tenants-backup-recovery-overview?view=graph-rest-1.0&preserve-view=true) |
| [Calendars](#calendars) | 22 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendar-overview?view=graph-rest-1.0&preserve-view=true) |
| [Change notifications](#change-notifications) | 1 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/change-notifications-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Compliance](#compliance) | 0 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/complianceapioverview?view=graph-rest-1.0&preserve-view=true) |
| [Cross-device experiences](#cross-device-experiences) | 0 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/project-rome-overview?view=graph-rest-1.0&preserve-view=true) |
| [Customer booking](#customer-booking) | 6 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/booking-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Device and app management](#device-and-app-management) | 82 | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [Education](#education) | 12 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/education-overview?view=graph-rest-1.0&preserve-view=true) |
| [Employee experience](#employee-experience) | 1 | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [Extensions](#extensions) | 13 | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |
| [External data connections](#external-data-connections) | 3 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/connectors-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Files](#files) | 6 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/onedrive?view=graph-rest-1.0&preserve-view=true) |
| [Identity and access](#identity-and-access) | 54 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-1.0&preserve-view=true) |
| [Mail](#mail) | 10 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/mail-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Mailbox import and export](#mailbox-import-and-export) | 0 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/mailbox-import-export-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Notes](#notes) | 4 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/onenote-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [People and workplace intelligence](#people-and-workplace-intelligence) | 2 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/social-overview?view=graph-rest-1.0&preserve-view=true) |
| [Personal contacts](#personal-contacts) | 6 | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [Reports](#reports) | 1 | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [Partner billing reports](#partner-billing-reports) | 0 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/partners-billing-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Search](#search) | 3 | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [Security](#security) | 11 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Sites and lists](#sites-and-lists) | 13 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/sharepoint?view=graph-rest-1.0&preserve-view=true) |
| [Tasks and plans](#tasks-and-plans) | 0 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/planner-overview?view=graph-rest-1.0&preserve-view=true) |
| [Teamwork and communications](#teamwork-and-communications) | 26 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Tenants](#tenants) | 5 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/tenants-overview?view=graph-rest-1.0&preserve-view=true) |
| [To-do tasks](#to-do-tasks) | 8 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/todo-overview?view=graph-rest-1.0&preserve-view=true) |
| [Workbooks and charts](#workbooks-and-charts) | 0 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/excel?view=graph-rest-1.0&preserve-view=true) |

Each endpoint has one physical module. Resource types and service routes resolve documentation cross-listings; parent paths such as `/users` do not turn mail or calendar modules into user modules. Uncategorized is a generator fallback, not an official Microsoft category.

Open a category below, then an endpoint README for inputs, permissions guidance, import notes, and credential-free tests. Exact Graph URLs remain in every module and in [manifest.json](manifest.json).

License requirements are reviewed for 12 of 311 modules; every other module carries an explicit unknown licensing record in its README and manifest entry.

10960 Graph paths are not generated as modules. Each is recorded under `exclusions` in [manifest.json](manifest.json) with its reason and reason code. A request wrapper is never presented as management of the object it creates.

| Reason code | Paths | Meaning |
| --- | ---: | --- |
| `action_or_function` | 1612 | OData action or function. |
| `cast` | 756 | OData type-cast segment. |
| `delete_precondition_required` | 1 | Delete requires a state change and independent read-back that `msgraph_resource` cannot enforce. |
| `if_match_required` | 3 | Update or delete needs an If-Match ETag header that `msgraph_resource` cannot send. |
| `item_requires_input` | 2 | An item operation needs a header or query parameter, such as If-Match. |
| `no_item_lifecycle` | 1839 | No single item path with GET, PATCH or PUT, and DELETE. |
| `no_post` | 4973 | Any other path without a POST the generator evaluates: read-only collections, items without a generated collection, `$count`, `$value`, alternate keys and unsupported segment syntax. |
| `no_response_id` | 2 | POST response has no id to track the created object. |
| `ref_relationship` | 101 | Relationship written through `$ref` operations. |
| `ref_singleton` | 20 | Reference with GET, PUT and DELETE in the supplied metadata; requires a separate assignment lifecycle. |
| `singleton` | 530 | Singleton with GET and PATCH but no POST; updated in place, not created. |
| `undocumented_lifecycle` | 1093 | The pinned API-specific Microsoft Learn index lacks a collection POST or member DELETE for this lifecycle. |
| `update_body_unreviewed` | 8 | Update body is not proven compatible. |
| `update_only` | 20 | Microsoft Learn documents reading and updating service-owned objects, without an ordinary create/delete lifecycle. |

Catalog scope: **Full catalog from pinned API sources**. Full-catalog licensing mapping checks run against the selected API version; partial runs do not claim mapping coverage.

Reviewed generated mapping coverage: 12 generated, 21 explicitly excluded, 0 missing. A mapped endpoint absent from both generated output and explicit exclusions fails full-catalog validation.

Mapped endpoints explicitly excluded from generation:

- `/identityGovernance/lifecycleWorkflows/deletedItems/workflows/{workflow-id}/tasks`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /identityGovernance/lifecycleWorkflows/deletedItems/workflows/{workflow-id}/tasks, DELETE /identityGovernance/lifecycleWorkflows/deletedItems/workflows/{workflow-id}/tasks/{id}
- `/identityGovernance/lifecycleWorkflows/deletedItems/workflows/{workflow-id}/versions/{workflowVersion-versionNumber}/tasks`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /identityGovernance/lifecycleWorkflows/deletedItems/workflows/{workflow-id}/versions/{workflowVersion-versionNumber}/tasks, DELETE /identityGovernance/lifecycleWorkflows/deletedItems/workflows/{workflow-id}/versions/{workflowVersion-versionNumber}/tasks/{id}
- `/identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/tasks`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 documents PATCH /identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/tasks/{id} but lacks POST /identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/tasks, DELETE /identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/tasks/{id}
- `/identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/versions/{workflowVersion-versionNumber}/tasks`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/versions/{workflowVersion-versionNumber}/tasks, DELETE /identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/versions/{workflowVersion-versionNumber}/tasks/{id}
- `/identityGovernance/privilegedAccess/group/assignmentApprovals`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /identityGovernance/privilegedAccess/group/assignmentApprovals, DELETE /identityGovernance/privilegedAccess/group/assignmentApprovals/{id}
- `/identityGovernance/privilegedAccess/group/assignmentScheduleInstances`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /identityGovernance/privilegedAccess/group/assignmentScheduleInstances, DELETE /identityGovernance/privilegedAccess/group/assignmentScheduleInstances/{id}
- `/identityGovernance/privilegedAccess/group/assignmentScheduleRequests`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks DELETE /identityGovernance/privilegedAccess/group/assignmentScheduleRequests/{id}
- `/identityGovernance/privilegedAccess/group/assignmentSchedules`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /identityGovernance/privilegedAccess/group/assignmentSchedules, DELETE /identityGovernance/privilegedAccess/group/assignmentSchedules/{id}
- `/identityGovernance/privilegedAccess/group/eligibilityScheduleInstances`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /identityGovernance/privilegedAccess/group/eligibilityScheduleInstances, DELETE /identityGovernance/privilegedAccess/group/eligibilityScheduleInstances/{id}
- `/identityGovernance/privilegedAccess/group/eligibilityScheduleRequests`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks DELETE /identityGovernance/privilegedAccess/group/eligibilityScheduleRequests/{id}
- `/identityGovernance/privilegedAccess/group/eligibilitySchedules`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /identityGovernance/privilegedAccess/group/eligibilitySchedules, DELETE /identityGovernance/privilegedAccess/group/eligibilitySchedules/{id}
- `/policies/roleManagementPolicies`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 documents PATCH /policies/roleManagementPolicies/{id} but lacks POST /policies/roleManagementPolicies, DELETE /policies/roleManagementPolicies/{id}
- `/policies/roleManagementPolicies/{unifiedRoleManagementPolicy-id}/effectiveRules`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /policies/roleManagementPolicies/{unifiedRoleManagementPolicy-id}/effectiveRules, DELETE /policies/roleManagementPolicies/{unifiedRoleManagementPolicy-id}/effectiveRules/{id}
- `/policies/roleManagementPolicies/{unifiedRoleManagementPolicy-id}/rules`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 documents PATCH /policies/roleManagementPolicies/{unifiedRoleManagementPolicy-id}/rules/{id} but lacks POST /policies/roleManagementPolicies/{unifiedRoleManagementPolicy-id}/rules, DELETE /policies/roleManagementPolicies/{unifiedRoleManagementPolicy-id}/rules/{id}
- `/policies/roleManagementPolicyAssignments`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /policies/roleManagementPolicyAssignments, DELETE /policies/roleManagementPolicyAssignments/{id}
- `/roleManagement/directory/roleAssignmentScheduleInstances`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /roleManagement/directory/roleAssignmentScheduleInstances, DELETE /roleManagement/directory/roleAssignmentScheduleInstances/{id}
- `/roleManagement/directory/roleAssignmentScheduleRequests`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks DELETE /roleManagement/directory/roleAssignmentScheduleRequests/{id}
- `/roleManagement/directory/roleAssignmentSchedules`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /roleManagement/directory/roleAssignmentSchedules, DELETE /roleManagement/directory/roleAssignmentSchedules/{id}
- `/roleManagement/directory/roleEligibilityScheduleInstances`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /roleManagement/directory/roleEligibilityScheduleInstances, DELETE /roleManagement/directory/roleEligibilityScheduleInstances/{id}
- `/roleManagement/directory/roleEligibilityScheduleRequests`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks DELETE /roleManagement/directory/roleEligibilityScheduleRequests/{id}
- `/roleManagement/directory/roleEligibilitySchedules`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /roleManagement/directory/roleEligibilitySchedules, DELETE /roleManagement/directory/roleEligibilitySchedules/{id}

## Unknown licensing review queue

299 unknown endpoints across 25 catalog families. [LICENSING-REVIEW.md](LICENSING-REVIEW.md) lists each path with a link to its generated module README; review the endpoint's Microsoft Graph documentation and Microsoft Entra licensing before relying on it. No license entitlement is inferred from API behavior.

| Family | Unknown endpoints |
| --- | ---: |
| Applications (`applications`) | 9 |
| Backup and recovery (`backup-and-recovery`) | 4 |
| Calendars (`calendars`) | 22 |
| Change notifications (`change-notifications`) | 1 |
| Customer booking (`customer-booking`) | 6 |
| Device and app management (`device-and-app-management`) | 82 |
| Education (`education`) | 12 |
| Employee experience (`employee-experience`) | 1 |
| Extensions (`extensions`) | 13 |
| External data connections (`external-data-connections`) | 3 |
| Files (`files`) | 6 |
| Groups (`groups`) | 3 |
| Identity and access (`identity-and-access`) | 46 |
| Mail (`mail`) | 10 |
| Notes (`notes`) | 4 |
| People and workplace intelligence (`people-and-workplace-intelligence`) | 2 |
| Personal contacts (`personal-contacts`) | 6 |
| Reports (`reports`) | 1 |
| Search (`search`) | 3 |
| Security (`security`) | 11 |
| Sites and lists (`sites-and-lists`) | 13 |
| Teamwork and communications (`teamwork-and-communications`) | 26 |
| Tenants (`tenants`) | 5 |
| To-do tasks (`to-do-tasks`) | 8 |
| Users (`users`) | 2 |

## Users

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/users?view=graph-rest-1.0&preserve-view=true) Â· **3 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/me/outlook/masterCategories`](me/outlook/masterCategories/README.md) | `microsoft.graph.outlookCategory` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/outlookcategory?view=graph-rest-1.0&preserve-view=true) |
| [`/users`](users/README.md) | `microsoft.graph.user` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/user?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/outlook/masterCategories`](users/outlook/masterCategories/README.md) | `microsoft.graph.outlookCategory` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/outlookcategory?view=graph-rest-1.0&preserve-view=true) |

## Groups

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/groups-overview?view=graph-rest-1.0&preserve-view=true) Â· **4 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/groupLifecyclePolicies`](groupLifecyclePolicies/README.md) | `microsoft.graph.groupLifecyclePolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/grouplifecyclepolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/groups`](groups/README.md) | `microsoft.graph.group` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/group?view=graph-rest-1.0&preserve-view=true) |
| [`/groups/{group-id}/conversations/{conversation-id}/threads`](groups/conversations/threads/README.md) | `microsoft.graph.conversationThread` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/groups-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/groups/{group-id}/threads`](groups/threads/README.md) | `microsoft.graph.conversationThread` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/groups-overview?view=graph-rest-1.0&preserve-view=true) |

## Applications

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/applications-api-overview?view=graph-rest-1.0&preserve-view=true) Â· **11 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/applications`](applications/README.md) | `microsoft.graph.application` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/application?view=graph-rest-1.0&preserve-view=true) |
| [`/applications/{application-id}/extensionProperties`](applications/extensionProperties/README.md) | `microsoft.graph.extensionProperty` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/extensionproperty?view=graph-rest-1.0&preserve-view=true) |
| [`/applications/{application-id}/federatedIdentityCredentials`](applications/federatedIdentityCredentials/README.md) | `microsoft.graph.federatedIdentityCredential` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/federatedidentitycredential?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/appManagementPolicies`](policies/appManagementPolicies/README.md) | `microsoft.graph.appManagementPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/appmanagementpolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/claimsMappingPolicies`](policies/claimsMappingPolicies/README.md) | `microsoft.graph.claimsMappingPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/claimsmappingpolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/tokenIssuancePolicies`](policies/tokenIssuancePolicies/README.md) | `microsoft.graph.tokenIssuancePolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/tokenissuancepolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/tokenLifetimePolicies`](policies/tokenLifetimePolicies/README.md) | `microsoft.graph.tokenLifetimePolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/tokenlifetimepolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/servicePrincipals`](servicePrincipals/README.md) | `microsoft.graph.servicePrincipal` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/serviceprincipal?view=graph-rest-1.0&preserve-view=true) |
| [`/servicePrincipals/{servicePrincipal-id}/delegatedPermissionClassifications`](servicePrincipals/delegatedPermissionClassifications/README.md) | `microsoft.graph.delegatedPermissionClassification` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/applications-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/servicePrincipals/{servicePrincipal-id}/remoteDesktopSecurityConfiguration/approvedClientApps`](servicePrincipals/remoteDesktopSecurityConfiguration/approvedClientApps/README.md) | `microsoft.graph.approvedClientApp` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/approvedclientapp?view=graph-rest-1.0&preserve-view=true) |
| [`/servicePrincipals/{servicePrincipal-id}/synchronization/jobs`](servicePrincipals/synchronization/jobs/README.md) | `microsoft.graph.synchronizationJob` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/synchronization-synchronizationjob?view=graph-rest-1.0&preserve-view=true) |

## Agents

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/agentid-platform-overview?view=graph-rest-1.0&preserve-view=true) Â· **0 generated modules**.

No supported CRUD collection was generated in this category from the selected inputs. APIs may still exist here as read-only endpoints, actions, unsupported lifecycles, or endpoints outside an explicit include filter.

## Backup and recovery

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/tenants-backup-recovery-overview?view=graph-rest-1.0&preserve-view=true) Â· **4 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/solutions/backupRestore/exchangeRestoreSessions/{exchangeRestoreSession-id}/mailboxRestoreArtifactsBulkAdditionRequests`](solutions/backupRestore/exchangeRestoreSessions/mailboxRestoreArtifactsBulkAdditionRequests/README.md) | `microsoft.graph.mailboxRestoreArtifactsBulkAdditionRequest` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/mailboxrestoreartifactsbulkadditionrequest?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/backupRestore/oneDriveForBusinessRestoreSessions/{oneDriveForBusinessRestoreSession-id}/driveRestoreArtifactsBulkAdditionRequests`](solutions/backupRestore/oneDriveForBusinessRestoreSessions/driveRestoreArtifactsBulkAdditionRequests/README.md) | `microsoft.graph.driveRestoreArtifactsBulkAdditionRequest` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/driverestoreartifactsbulkadditionrequest?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/backupRestore/serviceApps`](solutions/backupRestore/serviceApps/README.md) | `microsoft.graph.serviceApp` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/serviceapp?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/backupRestore/sharePointRestoreSessions/{sharePointRestoreSession-id}/siteRestoreArtifactsBulkAdditionRequests`](solutions/backupRestore/sharePointRestoreSessions/siteRestoreArtifactsBulkAdditionRequests/README.md) | `microsoft.graph.siteRestoreArtifactsBulkAdditionRequest` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/siterestoreartifactsbulkadditionrequest?view=graph-rest-1.0&preserve-view=true) |

## Calendars

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/calendar-overview?view=graph-rest-1.0&preserve-view=true) Â· **22 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/groups/{group-id}/calendar/calendarPermissions`](groups/calendar/calendarPermissions/README.md) | `microsoft.graph.calendarPermission` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendarpermission?view=graph-rest-1.0&preserve-view=true) |
| [`/groups/{group-id}/calendar/events`](groups/calendar/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/groups/{group-id}/events`](groups/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/me/calendar/events`](me/calendar/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/me/calendarGroups`](me/calendarGroups/README.md) | `microsoft.graph.calendarGroup` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendargroup?view=graph-rest-1.0&preserve-view=true) |
| [`/me/calendarGroups/{calendarGroup-id}/calendars`](me/calendarGroups/calendars/README.md) | `microsoft.graph.calendar` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendar?view=graph-rest-1.0&preserve-view=true) |
| [`/me/calendarGroups/{calendarGroup-id}/calendars/{calendar-id}/events`](me/calendarGroups/calendars/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/me/calendars`](me/calendars/README.md) | `microsoft.graph.calendar` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendar?view=graph-rest-1.0&preserve-view=true) |
| [`/me/calendars/{calendar-id}/events`](me/calendars/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/me/events`](me/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/me/settings/workHoursAndLocations/occurrences`](me/settings/workHoursAndLocations/occurrences/README.md) | `microsoft.graph.workPlanOccurrence` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/workplanoccurrence?view=graph-rest-1.0&preserve-view=true) |
| [`/me/settings/workHoursAndLocations/recurrences`](me/settings/workHoursAndLocations/recurrences/README.md) | `microsoft.graph.workPlanRecurrence` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/workplanrecurrence?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/calendar/calendarPermissions`](users/calendar/calendarPermissions/README.md) | `microsoft.graph.calendarPermission` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendarpermission?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/calendar/events`](users/calendar/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/calendarGroups`](users/calendarGroups/README.md) | `microsoft.graph.calendarGroup` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendargroup?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/calendarGroups/{calendarGroup-id}/calendars`](users/calendarGroups/calendars/README.md) | `microsoft.graph.calendar` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendar?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/calendarGroups/{calendarGroup-id}/calendars/{calendar-id}/events`](users/calendarGroups/calendars/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/calendars`](users/calendars/README.md) | `microsoft.graph.calendar` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendar?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/calendars/{calendar-id}/events`](users/calendars/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/events`](users/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/settings/workHoursAndLocations/occurrences`](users/settings/workHoursAndLocations/occurrences/README.md) | `microsoft.graph.workPlanOccurrence` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/workplanoccurrence?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/settings/workHoursAndLocations/recurrences`](users/settings/workHoursAndLocations/recurrences/README.md) | `microsoft.graph.workPlanRecurrence` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/workplanrecurrence?view=graph-rest-1.0&preserve-view=true) |

## Change notifications

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/change-notifications-api-overview?view=graph-rest-1.0&preserve-view=true) Â· **1 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/subscriptions`](subscriptions/README.md) | `microsoft.graph.subscription` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/subscription?view=graph-rest-1.0&preserve-view=true) |

## Compliance

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/complianceapioverview?view=graph-rest-1.0&preserve-view=true) Â· **0 generated modules**.

No supported CRUD collection was generated in this category from the selected inputs. APIs may still exist here as read-only endpoints, actions, unsupported lifecycles, or endpoints outside an explicit include filter.

## Cross-device experiences

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/project-rome-overview?view=graph-rest-1.0&preserve-view=true) Â· **0 generated modules**.

No supported CRUD collection was generated in this category from the selected inputs. APIs may still exist here as read-only endpoints, actions, unsupported lifecycles, or endpoints outside an explicit include filter.

## Customer booking

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/booking-api-overview?view=graph-rest-1.0&preserve-view=true) Â· **6 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/solutions/bookingBusinesses`](solutions/bookingBusinesses/README.md) | `microsoft.graph.bookingBusiness` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/bookingbusiness?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/bookingBusinesses/{bookingBusiness-id}/appointments`](solutions/bookingBusinesses/appointments/README.md) | `microsoft.graph.bookingAppointment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/bookingappointment?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/bookingBusinesses/{bookingBusiness-id}/customQuestions`](solutions/bookingBusinesses/customQuestions/README.md) | `microsoft.graph.bookingCustomQuestion` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/bookingcustomquestion?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/bookingBusinesses/{bookingBusiness-id}/customers`](solutions/bookingBusinesses/customers/README.md) | `microsoft.graph.bookingCustomerBase` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/booking-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/bookingBusinesses/{bookingBusiness-id}/services`](solutions/bookingBusinesses/services/README.md) | `microsoft.graph.bookingService` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/bookingservice?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/bookingBusinesses/{bookingBusiness-id}/staffMembers`](solutions/bookingBusinesses/staffMembers/README.md) | `microsoft.graph.bookingStaffMemberBase` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/booking-api-overview?view=graph-rest-1.0&preserve-view=true) |

## Device and app management

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) Â· **82 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/admin/edge/internetExplorerMode/siteLists`](admin/edge/internetExplorerMode/siteLists/README.md) | `microsoft.graph.browserSiteList` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/browsersitelist?view=graph-rest-1.0&preserve-view=true) |
| [`/admin/edge/internetExplorerMode/siteLists/{browserSiteList-id}/sharedCookies`](admin/edge/internetExplorerMode/siteLists/sharedCookies/README.md) | `microsoft.graph.browserSharedCookie` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/browsersharedcookie?view=graph-rest-1.0&preserve-view=true) |
| [`/admin/edge/internetExplorerMode/siteLists/{browserSiteList-id}/sites`](admin/edge/internetExplorerMode/siteLists/sites/README.md) | `microsoft.graph.browserSite` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/browsersite?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/androidManagedAppProtections`](deviceAppManagement/androidManagedAppProtections/README.md) | `microsoft.graph.androidManagedAppProtection` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-androidmanagedappprotection?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/androidManagedAppProtections/{androidManagedAppProtection-id}/apps`](deviceAppManagement/androidManagedAppProtections/apps/README.md) | `microsoft.graph.managedMobileApp` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-managedmobileapp?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/defaultManagedAppProtections`](deviceAppManagement/defaultManagedAppProtections/README.md) | `microsoft.graph.defaultManagedAppProtection` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-defaultmanagedappprotection?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/defaultManagedAppProtections/{defaultManagedAppProtection-id}/apps`](deviceAppManagement/defaultManagedAppProtections/apps/README.md) | `microsoft.graph.managedMobileApp` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-managedmobileapp?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/iosManagedAppProtections`](deviceAppManagement/iosManagedAppProtections/README.md) | `microsoft.graph.iosManagedAppProtection` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-iosmanagedappprotection?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/iosManagedAppProtections/{iosManagedAppProtection-id}/apps`](deviceAppManagement/iosManagedAppProtections/apps/README.md) | `microsoft.graph.managedMobileApp` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-managedmobileapp?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/managedAppRegistrations/{managedAppRegistration-id}/operations`](deviceAppManagement/managedAppRegistrations/operations/README.md) | `microsoft.graph.managedAppOperation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-managedappoperation?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/managedEBooks`](deviceAppManagement/managedEBooks/README.md) | `microsoft.graph.managedEBook` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-books-managedebook?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/managedEBooks/{managedEBook-id}/assignments`](deviceAppManagement/managedEBooks/assignments/README.md) | `microsoft.graph.managedEBookAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-books-managedebookassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/managedEBooks/{managedEBook-id}/deviceStates`](deviceAppManagement/managedEBooks/deviceStates/README.md) | `microsoft.graph.deviceInstallState` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-books-deviceinstallstate?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/managedEBooks/{managedEBook-id}/userStateSummary`](deviceAppManagement/managedEBooks/userStateSummary/README.md) | `microsoft.graph.userInstallStateSummary` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-books-userinstallstatesummary?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/managedEBooks/{managedEBook-id}/userStateSummary/{userInstallStateSummary-id}/deviceStates`](deviceAppManagement/managedEBooks/userStateSummary/deviceStates/README.md) | `microsoft.graph.deviceInstallState` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-books-deviceinstallstate?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mdmWindowsInformationProtectionPolicies`](deviceAppManagement/mdmWindowsInformationProtectionPolicies/README.md) | `microsoft.graph.mdmWindowsInformationProtectionPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-mdmwindowsinformationprotectionpolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}/exemptAppLockerFiles`](deviceAppManagement/mdmWindowsInformationProtectionPolicies/exemptAppLockerFiles/README.md) | `microsoft.graph.windowsInformationProtectionAppLockerFile` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-windowsinformationprotectionapplockerfile?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}/protectedAppLockerFiles`](deviceAppManagement/mdmWindowsInformationProtectionPolicies/protectedAppLockerFiles/README.md) | `microsoft.graph.windowsInformationProtectionAppLockerFile` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-windowsinformationprotectionapplockerfile?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mobileAppCategories`](deviceAppManagement/mobileAppCategories/README.md) | `microsoft.graph.mobileAppCategory` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-apps-mobileappcategory?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mobileAppConfigurations`](deviceAppManagement/mobileAppConfigurations/README.md) | `microsoft.graph.managedDeviceMobileAppConfiguration` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-apps-manageddevicemobileappconfiguration?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mobileAppConfigurations/{managedDeviceMobileAppConfiguration-id}/assignments`](deviceAppManagement/mobileAppConfigurations/assignments/README.md) | `microsoft.graph.managedDeviceMobileAppConfigurationAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-apps-manageddevicemobileappconfigurationassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mobileAppConfigurations/{managedDeviceMobileAppConfiguration-id}/deviceStatuses`](deviceAppManagement/mobileAppConfigurations/deviceStatuses/README.md) | `microsoft.graph.managedDeviceMobileAppConfigurationDeviceStatus` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-apps-manageddevicemobileappconfigurationdevicestatus?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mobileAppConfigurations/{managedDeviceMobileAppConfiguration-id}/userStatuses`](deviceAppManagement/mobileAppConfigurations/userStatuses/README.md) | `microsoft.graph.managedDeviceMobileAppConfigurationUserStatus` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-apps-manageddevicemobileappconfigurationuserstatus?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mobileApps`](deviceAppManagement/mobileApps/README.md) | `microsoft.graph.mobileApp` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-apps-mobileapp?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mobileApps/{mobileApp-id}/assignments`](deviceAppManagement/mobileApps/assignments/README.md) | `microsoft.graph.mobileAppAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-apps-mobileappassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/targetedManagedAppConfigurations`](deviceAppManagement/targetedManagedAppConfigurations/README.md) | `microsoft.graph.targetedManagedAppConfiguration` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-targetedmanagedappconfiguration?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/targetedManagedAppConfigurations/{targetedManagedAppConfiguration-id}/apps`](deviceAppManagement/targetedManagedAppConfigurations/apps/README.md) | `microsoft.graph.managedMobileApp` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-managedmobileapp?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/vppTokens`](deviceAppManagement/vppTokens/README.md) | `microsoft.graph.vppToken` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-onboarding-vpptoken?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/windowsInformationProtectionPolicies`](deviceAppManagement/windowsInformationProtectionPolicies/README.md) | `microsoft.graph.windowsInformationProtectionPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-windowsinformationprotectionpolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/windowsInformationProtectionPolicies/{windowsInformationProtectionPolicy-id}/exemptAppLockerFiles`](deviceAppManagement/windowsInformationProtectionPolicies/exemptAppLockerFiles/README.md) | `microsoft.graph.windowsInformationProtectionAppLockerFile` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-windowsinformationprotectionapplockerfile?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/windowsInformationProtectionPolicies/{windowsInformationProtectionPolicy-id}/protectedAppLockerFiles`](deviceAppManagement/windowsInformationProtectionPolicies/protectedAppLockerFiles/README.md) | `microsoft.graph.windowsInformationProtectionAppLockerFile` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-windowsinformationprotectionapplockerfile?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/auditEvents`](deviceManagement/auditEvents/README.md) | `microsoft.graph.auditEvent` | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/complianceManagementPartners`](deviceManagement/complianceManagementPartners/README.md) | `microsoft.graph.complianceManagementPartner` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-onboarding-compliancemanagementpartner?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/detectedApps`](deviceManagement/detectedApps/README.md) | `microsoft.graph.detectedApp` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-detectedapp?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCategories`](deviceManagement/deviceCategories/README.md) | `microsoft.graph.deviceCategory` | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCompliancePolicies`](deviceManagement/deviceCompliancePolicies/README.md) | `microsoft.graph.deviceCompliancePolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-devicecompliancepolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/assignments`](deviceManagement/deviceCompliancePolicies/assignments/README.md) | `microsoft.graph.deviceCompliancePolicyAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-devicecompliancepolicyassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/deviceSettingStateSummaries`](deviceManagement/deviceCompliancePolicies/deviceSettingStateSummaries/README.md) | `microsoft.graph.settingStateDeviceSummary` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-settingstatedevicesummary?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/deviceStatuses`](deviceManagement/deviceCompliancePolicies/deviceStatuses/README.md) | `microsoft.graph.deviceComplianceDeviceStatus` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-devicecompliancedevicestatus?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/scheduledActionsForRule`](deviceManagement/deviceCompliancePolicies/scheduledActionsForRule/README.md) | `microsoft.graph.deviceComplianceScheduledActionForRule` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-devicecompliancescheduledactionforrule?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/scheduledActionsForRule/{deviceComplianceScheduledActionForRule-id}/scheduledActionConfigurations`](deviceManagement/deviceCompliancePolicies/scheduledActionsForRule/scheduledActionConfigurations/README.md) | `microsoft.graph.deviceComplianceActionItem` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-devicecomplianceactionitem?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/userStatuses`](deviceManagement/deviceCompliancePolicies/userStatuses/README.md) | `microsoft.graph.deviceComplianceUserStatus` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-devicecomplianceuserstatus?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCompliancePolicySettingStateSummaries`](deviceManagement/deviceCompliancePolicySettingStateSummaries/README.md) | `microsoft.graph.deviceCompliancePolicySettingStateSummary` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-devicecompliancepolicysettingstatesummary?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCompliancePolicySettingStateSummaries/{deviceCompliancePolicySettingStateSummary-id}/deviceComplianceSettingStates`](deviceManagement/deviceCompliancePolicySettingStateSummaries/deviceComplianceSettingStates/README.md) | `microsoft.graph.deviceComplianceSettingState` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-devicecompliancesettingstate?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceConfigurations`](deviceManagement/deviceConfigurations/README.md) | `microsoft.graph.deviceConfiguration` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-deviceconfiguration?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceConfigurations/{deviceConfiguration-id}/assignments`](deviceManagement/deviceConfigurations/assignments/README.md) | `microsoft.graph.deviceConfigurationAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-deviceconfigurationassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceConfigurations/{deviceConfiguration-id}/deviceSettingStateSummaries`](deviceManagement/deviceConfigurations/deviceSettingStateSummaries/README.md) | `microsoft.graph.settingStateDeviceSummary` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-settingstatedevicesummary?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceConfigurations/{deviceConfiguration-id}/deviceStatuses`](deviceManagement/deviceConfigurations/deviceStatuses/README.md) | `microsoft.graph.deviceConfigurationDeviceStatus` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-deviceconfigurationdevicestatus?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceConfigurations/{deviceConfiguration-id}/userStatuses`](deviceManagement/deviceConfigurations/userStatuses/README.md) | `microsoft.graph.deviceConfigurationUserStatus` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-deviceconfigurationuserstatus?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceEnrollmentConfigurations`](deviceManagement/deviceEnrollmentConfigurations/README.md) | `microsoft.graph.deviceEnrollmentConfiguration` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-onboarding-deviceenrollmentconfiguration?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceEnrollmentConfigurations/{deviceEnrollmentConfiguration-id}/assignments`](deviceManagement/deviceEnrollmentConfigurations/assignments/README.md) | `microsoft.graph.enrollmentConfigurationAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-onboarding-enrollmentconfigurationassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceManagementPartners`](deviceManagement/deviceManagementPartners/README.md) | `microsoft.graph.deviceManagementPartner` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-onboarding-devicemanagementpartner?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/exchangeConnectors`](deviceManagement/exchangeConnectors/README.md) | `microsoft.graph.deviceManagementExchangeConnector` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-onboarding-devicemanagementexchangeconnector?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/importedWindowsAutopilotDeviceIdentities`](deviceManagement/importedWindowsAutopilotDeviceIdentities/README.md) | `microsoft.graph.importedWindowsAutopilotDeviceIdentity` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-enrollment-importedwindowsautopilotdeviceidentity?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/iosUpdateStatuses`](deviceManagement/iosUpdateStatuses/README.md) | `microsoft.graph.iosUpdateDeviceStatus` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-iosupdatedevicestatus?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/managedDevices`](deviceManagement/managedDevices/README.md) | `microsoft.graph.managedDevice` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-manageddevice?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/mobileAppTroubleshootingEvents`](deviceManagement/mobileAppTroubleshootingEvents/README.md) | `microsoft.graph.mobileAppTroubleshootingEvent` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-mobileapptroubleshootingevent?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/mobileAppTroubleshootingEvents/{mobileAppTroubleshootingEvent-id}/appLogCollectionRequests`](deviceManagement/mobileAppTroubleshootingEvents/appLogCollectionRequests/README.md) | `microsoft.graph.appLogCollectionRequest` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-applogcollectionrequest?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/mobileThreatDefenseConnectors`](deviceManagement/mobileThreatDefenseConnectors/README.md) | `microsoft.graph.mobileThreatDefenseConnector` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-onboarding-mobilethreatdefenseconnector?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/notificationMessageTemplates`](deviceManagement/notificationMessageTemplates/README.md) | `microsoft.graph.notificationMessageTemplate` | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/notificationMessageTemplates/{notificationMessageTemplate-id}/localizedNotificationMessages`](deviceManagement/notificationMessageTemplates/localizedNotificationMessages/README.md) | `microsoft.graph.localizedNotificationMessage` | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/remoteAssistancePartners`](deviceManagement/remoteAssistancePartners/README.md) | `microsoft.graph.remoteAssistancePartner` | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/resourceOperations`](deviceManagement/resourceOperations/README.md) | `microsoft.graph.resourceOperation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-rbac-resourceoperation?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/roleAssignments`](deviceManagement/roleAssignments/README.md) | `microsoft.graph.deviceAndAppManagementRoleAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-rbac-deviceandappmanagementroleassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/roleDefinitions`](deviceManagement/roleDefinitions/README.md) | `microsoft.graph.roleDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-rbac-roledefinition?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/roleDefinitions/{roleDefinition-id}/roleAssignments`](deviceManagement/roleDefinitions/roleAssignments/README.md) | `microsoft.graph.roleAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-rbac-roleassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/termsAndConditions`](deviceManagement/termsAndConditions/README.md) | `microsoft.graph.termsAndConditions` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-companyterms-termsandconditions?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/termsAndConditions/{termsAndConditions-id}/acceptanceStatuses`](deviceManagement/termsAndConditions/acceptanceStatuses/README.md) | `microsoft.graph.termsAndConditionsAcceptanceStatus` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-companyterms-termsandconditionsacceptancestatus?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/termsAndConditions/{termsAndConditions-id}/assignments`](deviceManagement/termsAndConditions/assignments/README.md) | `microsoft.graph.termsAndConditionsAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-companyterms-termsandconditionsassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/troubleshootingEvents`](deviceManagement/troubleshootingEvents/README.md) | `microsoft.graph.deviceManagementTroubleshootingEvent` | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/virtualEndpoint/deviceImages`](deviceManagement/virtualEndpoint/deviceImages/README.md) | `microsoft.graph.cloudPcDeviceImage` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/cloudpcdeviceimage?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/virtualEndpoint/onPremisesConnections`](deviceManagement/virtualEndpoint/onPremisesConnections/README.md) | `microsoft.graph.cloudPcOnPremisesConnection` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/cloudpconpremisesconnection?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/virtualEndpoint/provisioningPolicies`](deviceManagement/virtualEndpoint/provisioningPolicies/README.md) | `microsoft.graph.cloudPcProvisioningPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/cloudpcprovisioningpolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/virtualEndpoint/userSettings`](deviceManagement/virtualEndpoint/userSettings/README.md) | `microsoft.graph.cloudPcUserSetting` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/cloudpcusersetting?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/windowsAutopilotDeviceIdentities`](deviceManagement/windowsAutopilotDeviceIdentities/README.md) | `microsoft.graph.windowsAutopilotDeviceIdentity` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-enrollment-windowsautopilotdeviceidentity?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/windowsInformationProtectionAppLearningSummaries`](deviceManagement/windowsInformationProtectionAppLearningSummaries/README.md) | `microsoft.graph.windowsInformationProtectionAppLearningSummary` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-wip-windowsinformationprotectionapplearningsummary?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/windowsInformationProtectionNetworkLearningSummaries`](deviceManagement/windowsInformationProtectionNetworkLearningSummaries/README.md) | `microsoft.graph.windowsInformationProtectionNetworkLearningSummary` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-wip-windowsinformationprotectionnetworklearningsummary?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/windowsMalwareInformation`](deviceManagement/windowsMalwareInformation/README.md) | `microsoft.graph.windowsMalwareInformation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-windowsmalwareinformation?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/windowsMalwareInformation/{windowsMalwareInformation-id}/deviceMalwareStates`](deviceManagement/windowsMalwareInformation/deviceMalwareStates/README.md) | `microsoft.graph.malwareStateForWindowsDevice` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-malwarestateforwindowsdevice?view=graph-rest-1.0&preserve-view=true) |
| [`/print/printers/{printer-id}/taskTriggers`](print/printers/taskTriggers/README.md) | `microsoft.graph.printTaskTrigger` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/printtasktrigger?view=graph-rest-1.0&preserve-view=true) |
| [`/print/shares`](print/shares/README.md) | `microsoft.graph.printerShare` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/printershare?view=graph-rest-1.0&preserve-view=true) |
| [`/print/taskDefinitions`](print/taskDefinitions/README.md) | `microsoft.graph.printTaskDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/printtaskdefinition?view=graph-rest-1.0&preserve-view=true) |

## Education

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/education-overview?view=graph-rest-1.0&preserve-view=true) Â· **12 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/education/classes`](education/classes/README.md) | `microsoft.graph.educationClass` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/educationclass?view=graph-rest-1.0&preserve-view=true) |
| [`/education/classes/{educationClass-id}/assignmentCategories`](education/classes/assignmentCategories/README.md) | `microsoft.graph.educationCategory` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/educationcategory?view=graph-rest-1.0&preserve-view=true) |
| [`/education/classes/{educationClass-id}/assignmentSettings/gradingSchemes`](education/classes/assignmentSettings/gradingSchemes/README.md) | `microsoft.graph.educationGradingScheme` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/educationgradingscheme?view=graph-rest-1.0&preserve-view=true) |
| [`/education/classes/{educationClass-id}/assignments`](education/classes/assignments/README.md) | `microsoft.graph.educationAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/educationassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/education/classes/{educationClass-id}/assignments/{educationAssignment-id}/resources`](education/classes/assignments/resources/README.md) | `microsoft.graph.educationAssignmentResource` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/educationassignmentresource?view=graph-rest-1.0&preserve-view=true) |
| [`/education/classes/{educationClass-id}/assignments/{educationAssignment-id}/submissions/{educationSubmission-id}/outcomes`](education/classes/assignments/submissions/outcomes/README.md) | `microsoft.graph.educationOutcome` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/educationoutcome?view=graph-rest-1.0&preserve-view=true) |
| [`/education/classes/{educationClass-id}/assignments/{educationAssignment-id}/submissions/{educationSubmission-id}/resources`](education/classes/assignments/submissions/resources/README.md) | `microsoft.graph.educationSubmissionResource` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/educationsubmissionresource?view=graph-rest-1.0&preserve-view=true) |
| [`/education/classes/{educationClass-id}/modules`](education/classes/modules/README.md) | `microsoft.graph.educationModule` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/educationmodule?view=graph-rest-1.0&preserve-view=true) |
| [`/education/classes/{educationClass-id}/modules/{educationModule-id}/resources`](education/classes/modules/resources/README.md) | `microsoft.graph.educationModuleResource` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/educationmoduleresource?view=graph-rest-1.0&preserve-view=true) |
| [`/education/me/rubrics`](education/me/rubrics/README.md) | `microsoft.graph.educationRubric` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/educationrubric?view=graph-rest-1.0&preserve-view=true) |
| [`/education/schools`](education/schools/README.md) | `microsoft.graph.educationSchool` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/educationschool?view=graph-rest-1.0&preserve-view=true) |
| [`/education/users`](education/users/README.md) | `microsoft.graph.educationUser` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/educationuser?view=graph-rest-1.0&preserve-view=true) |

## Employee experience

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) Â· **1 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/employeeExperience/communities`](employeeExperience/communities/README.md) | `microsoft.graph.community` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/community?view=graph-rest-1.0&preserve-view=true) |

## Extensions

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) Â· **13 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/devices/{device-id}/extensions`](devices/extensions/README.md) | `microsoft.graph.extension` | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/groups/{group-id}/events/{event-id}/extensions`](groups/events/extensions/README.md) | `microsoft.graph.extension` | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/groups/{group-id}/extensions`](groups/extensions/README.md) | `microsoft.graph.extension` | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/groups/{group-id}/threads/{conversationThread-id}/posts/{post-id}/extensions`](groups/threads/posts/extensions/README.md) | `microsoft.graph.extension` | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/organization/{organization-id}/extensions`](organization/extensions/README.md) | `microsoft.graph.extension` | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/schemaExtensions`](schemaExtensions/README.md) | `microsoft.graph.schemaExtension` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/schemaextension?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/contacts/{contact-id}/extensions`](users/contacts/extensions/README.md) | `microsoft.graph.extension` | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/events/{event-id}/extensions`](users/events/extensions/README.md) | `microsoft.graph.extension` | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/extensions`](users/extensions/README.md) | `microsoft.graph.extension` | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/messages/{message-id}/extensions`](users/messages/extensions/README.md) | `microsoft.graph.extension` | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/notes/{note-id}/extensions`](users/notes/extensions/README.md) | `microsoft.graph.extension` | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/todo/lists/{todoTaskList-id}/extensions`](users/todo/lists/extensions/README.md) | `microsoft.graph.extension` | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/todo/lists/{todoTaskList-id}/tasks/{todoTask-id}/extensions`](users/todo/lists/tasks/extensions/README.md) | `microsoft.graph.extension` | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |

## External data connections

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/connectors-api-overview?view=graph-rest-1.0&preserve-view=true) Â· **3 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/external/connections`](external/connections/README.md) | `microsoft.graph.externalConnectors.externalConnection` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/externalconnectors-externalconnection?view=graph-rest-1.0&preserve-view=true) |
| [`/external/connections/{externalConnection-id}/groups`](external/connections/groups/README.md) | `microsoft.graph.externalConnectors.externalGroup` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/externalconnectors-externalgroup?view=graph-rest-1.0&preserve-view=true) |
| [`/external/connections/{externalConnection-id}/groups/{externalGroup-id}/members`](external/connections/groups/members/README.md) | `microsoft.graph.externalConnectors.identity` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/externalconnectors-identity?view=graph-rest-1.0&preserve-view=true) |

## Files

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/onedrive?view=graph-rest-1.0&preserve-view=true) Â· **6 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/drives/{drive-id}/items/{driveItem-id}/permissions`](drives/items/permissions/README.md) | `microsoft.graph.permission` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/permission?view=graph-rest-1.0&preserve-view=true) |
| [`/storage/fileStorage/containerTypes`](storage/fileStorage/containerTypes/README.md) | `microsoft.graph.fileStorageContainerType` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/filestoragecontainertype?view=graph-rest-1.0&preserve-view=true) |
| [`/storage/fileStorage/containers`](storage/fileStorage/containers/README.md) | `microsoft.graph.fileStorageContainer` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/filestoragecontainer?view=graph-rest-1.0&preserve-view=true) |
| [`/storage/fileStorage/containers/{fileStorageContainer-id}/migrationJobs`](storage/fileStorage/containers/migrationJobs/README.md) | `microsoft.graph.sharePointMigrationJob` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/sharepointmigrationjob?view=graph-rest-1.0&preserve-view=true) |
| [`/storage/fileStorage/containers/{fileStorageContainer-id}/sharePointGroups`](storage/fileStorage/containers/sharePointGroups/README.md) | `microsoft.graph.sharePointGroup` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/sharepointgroup?view=graph-rest-1.0&preserve-view=true) |
| [`/storage/fileStorage/containers/{fileStorageContainer-id}/sharePointGroups/{sharePointGroup-id}/members`](storage/fileStorage/containers/sharePointGroups/members/README.md) | `microsoft.graph.sharePointGroupMember` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/sharepointgroupmember?view=graph-rest-1.0&preserve-view=true) |

## Identity and access

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-1.0&preserve-view=true) Â· **54 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/devices`](devices/README.md) | `microsoft.graph.device` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/device?view=graph-rest-1.0&preserve-view=true) |
| [`/directory/administrativeUnits`](directory/administrativeUnits/README.md) | `microsoft.graph.administrativeUnit` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/administrativeunit?view=graph-rest-1.0&preserve-view=true) |
| [`/directory/administrativeUnits/{administrativeUnit-id}/scopedRoleMembers`](directory/administrativeUnits/scopedRoleMembers/README.md) | `microsoft.graph.scopedRoleMembership` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations`](directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/README.md) | `microsoft.graph.certificateBasedAuthPki` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/certificatebasedauthpki?view=graph-rest-1.0&preserve-view=true) |
| [`/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/{certificateBasedAuthPki-id}/certificateAuthorities`](directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/certificateAuthorities/README.md) | `microsoft.graph.certificateAuthorityDetail` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/certificateauthoritydetail?view=graph-rest-1.0&preserve-view=true) |
| [`/domains`](domains/README.md) | `microsoft.graph.domain` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/domain?view=graph-rest-1.0&preserve-view=true) |
| [`/domains/{domain-id}/federationConfiguration`](domains/federationConfiguration/README.md) | `microsoft.graph.internalDomainFederation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/internaldomainfederation?view=graph-rest-1.0&preserve-view=true) |
| [`/groupSettings`](groupSettings/README.md) | `microsoft.graph.groupSetting` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/groupsetting?view=graph-rest-1.0&preserve-view=true) |
| [`/groups/{group-id}/appRoleAssignments`](groups/appRoleAssignments/README.md) | `microsoft.graph.appRoleAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/approleassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/groups/{group-id}/settings`](groups/settings/README.md) | `microsoft.graph.groupSetting` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/groupsetting?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/apiConnectors`](identity/apiConnectors/README.md) | `microsoft.graph.identityApiConnector` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identityapiconnector?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/authenticationEventListeners`](identity/authenticationEventListeners/README.md) | `microsoft.graph.authenticationEventListener` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/authenticationeventlistener?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/authenticationEventsFlows`](identity/authenticationEventsFlows/README.md) | `microsoft.graph.authenticationEventsFlow` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/authenticationeventsflow?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/b2xUserFlows`](identity/b2xUserFlows/README.md) | `microsoft.graph.b2xIdentityUserFlow` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/b2xidentityuserflow?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/b2xUserFlows/{b2xIdentityUserFlow-id}/userAttributeAssignments`](identity/b2xUserFlows/userAttributeAssignments/README.md) | `microsoft.graph.identityUserFlowAttributeAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identityuserflowattributeassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/conditionalAccess/authenticationStrength/policies/{authenticationStrengthPolicy-id}/combinationConfigurations`](identity/conditionalAccess/authenticationStrength/policies/combinationConfigurations/README.md) | `microsoft.graph.authenticationCombinationConfiguration` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/authenticationcombinationconfiguration?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/conditionalAccess/policies`](identity/conditionalAccess/policies/README.md) | `microsoft.graph.conditionalAccessPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/conditionalaccesspolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/customAuthenticationExtensions`](identity/customAuthenticationExtensions/README.md) | `microsoft.graph.customAuthenticationExtension` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/customauthenticationextension?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/identityProviders`](identity/identityProviders/README.md) | `microsoft.graph.identityProviderBase` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identityproviderbase?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/riskPrevention/fraudProtectionProviders`](identity/riskPrevention/fraudProtectionProviders/README.md) | `microsoft.graph.fraudProtectionProvider` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/fraudprotectionprovider?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/riskPrevention/webApplicationFirewallProviders`](identity/riskPrevention/webApplicationFirewallProviders/README.md) | `microsoft.graph.webApplicationFirewallProvider` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/webapplicationfirewallprovider?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/userFlowAttributes`](identity/userFlowAttributes/README.md) | `microsoft.graph.identityUserFlowAttribute` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identityuserflowattribute?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/verifiedId/profiles`](identity/verifiedId/profiles/README.md) | `microsoft.graph.verifiedIdProfile` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/verifiedidprofile?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/accessReviews/definitions`](identityGovernance/accessReviews/definitions/README.md) | `microsoft.graph.accessReviewScheduleDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/accessreviewscheduledefinition?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/entitlementManagement/accessPackages`](identityGovernance/entitlementManagement/accessPackages/README.md) | `microsoft.graph.accessPackage` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/accesspackage?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}/resourceRoleScopes`](identityGovernance/entitlementManagement/accessPackages/resourceRoleScopes/README.md) | `microsoft.graph.accessPackageResourceRoleScope` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/accesspackageresourcerolescope?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/entitlementManagement/assignmentPolicies`](identityGovernance/entitlementManagement/assignmentPolicies/README.md) | `microsoft.graph.accessPackageAssignmentPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/accesspackageassignmentpolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/entitlementManagement/assignmentRequests`](identityGovernance/entitlementManagement/assignmentRequests/README.md) | `microsoft.graph.accessPackageAssignmentRequest` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/accesspackageassignmentrequest?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/entitlementManagement/catalogs`](identityGovernance/entitlementManagement/catalogs/README.md) | `microsoft.graph.accessPackageCatalog` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/accesspackagecatalog?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/entitlementManagement/catalogs/{accessPackageCatalog-id}/resources/{accessPackageResource-id}/uploadSessions`](identityGovernance/entitlementManagement/catalogs/resources/uploadSessions/README.md) | `microsoft.graph.customDataProvidedResourceUploadSession` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/customdataprovidedresourceuploadsession?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/entitlementManagement/connectedOrganizations`](identityGovernance/entitlementManagement/connectedOrganizations/README.md) | `microsoft.graph.connectedOrganization` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/connectedorganization?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/entitlementManagement/externalOriginResourceConnectors`](identityGovernance/entitlementManagement/externalOriginResourceConnectors/README.md) | `microsoft.graph.externalOriginResourceConnector` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/externaloriginresourceconnector?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/lifecycleWorkflows/customTaskExtensions`](identityGovernance/lifecycleWorkflows/customTaskExtensions/README.md) | `microsoft.graph.identityGovernance.customTaskExtension` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identitygovernance-customtaskextension?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/lifecycleWorkflows/workflows`](identityGovernance/lifecycleWorkflows/workflows/README.md) | `microsoft.graph.identityGovernance.workflow` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identitygovernance-workflow?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/privilegedAccess/customExtensions`](identityGovernance/privilegedAccess/customExtensions/README.md) | `microsoft.graph.roleManagementCustomCalloutExtension` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/rolemanagementcustomcalloutextension?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/termsOfUse/agreements`](identityGovernance/termsOfUse/agreements/README.md) | `microsoft.graph.agreement` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/agreement?view=graph-rest-1.0&preserve-view=true) |
| [`/identityProviders`](identityProviders/README.md) | `microsoft.graph.identityProvider` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identityprovider?view=graph-rest-1.0&preserve-view=true) |
| [`/oauth2PermissionGrants`](oauth2PermissionGrants/README.md) | `microsoft.graph.oAuth2PermissionGrant` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/oauth2permissiongrant?view=graph-rest-1.0&preserve-view=true) |
| [`/organization/{organization-id}/branding/localizations`](organization/branding/localizations/README.md) | `microsoft.graph.organizationalBrandingLocalization` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/organizationalbrandinglocalization?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/activityBasedTimeoutPolicies`](policies/activityBasedTimeoutPolicies/README.md) | `microsoft.graph.activityBasedTimeoutPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/activitybasedtimeoutpolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/authenticationStrengthPolicies`](policies/authenticationStrengthPolicies/README.md) | `microsoft.graph.authenticationStrengthPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/authenticationstrengthpolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/featureRolloutPolicies`](policies/featureRolloutPolicies/README.md) | `microsoft.graph.featureRolloutPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/featurerolloutpolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/homeRealmDiscoveryPolicies`](policies/homeRealmDiscoveryPolicies/README.md) | `microsoft.graph.homeRealmDiscoveryPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/homerealmdiscoverypolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/permissionGrantPolicies`](policies/permissionGrantPolicies/README.md) | `microsoft.graph.permissionGrantPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/permissionGrantPolicies/{permissionGrantPolicy-id}/excludes`](policies/permissionGrantPolicies/excludes/README.md) | `microsoft.graph.permissionGrantConditionSet` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/permissionGrantPolicies/{permissionGrantPolicy-id}/includes`](policies/permissionGrantPolicies/includes/README.md) | `microsoft.graph.permissionGrantConditionSet` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/roleManagement/directory/roleAssignments`](roleManagement/directory/roleAssignments/README.md) | `microsoft.graph.unifiedRoleAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/unifiedroleassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/roleManagement/directory/roleDefinitions`](roleManagement/directory/roleDefinitions/README.md) | `microsoft.graph.unifiedRoleDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/unifiedroledefinition?view=graph-rest-1.0&preserve-view=true) |
| [`/roleManagement/entitlementManagement/roleAssignments`](roleManagement/entitlementManagement/roleAssignments/README.md) | `microsoft.graph.unifiedRoleAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/unifiedroleassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/servicePrincipals/{servicePrincipal-id}/appRoleAssignedTo`](servicePrincipals/appRoleAssignedTo/README.md) | `microsoft.graph.appRoleAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/approleassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/servicePrincipals/{servicePrincipal-id}/appRoleAssignments`](servicePrincipals/appRoleAssignments/README.md) | `microsoft.graph.appRoleAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/approleassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/appRoleAssignments`](users/appRoleAssignments/README.md) | `microsoft.graph.appRoleAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/approleassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/authentication/emailMethods`](users/authentication/emailMethods/README.md) | `microsoft.graph.emailAuthenticationMethod` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/emailauthenticationmethod?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/authentication/phoneMethods`](users/authentication/phoneMethods/README.md) | `microsoft.graph.phoneAuthenticationMethod` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/phoneauthenticationmethod?view=graph-rest-1.0&preserve-view=true) |

## Mail

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/mail-api-overview?view=graph-rest-1.0&preserve-view=true) Â· **10 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/me/inferenceClassification/overrides`](me/inferenceClassification/overrides/README.md) | `microsoft.graph.inferenceClassificationOverride` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/inferenceclassificationoverride?view=graph-rest-1.0&preserve-view=true) |
| [`/me/mailFolders`](me/mailFolders/README.md) | `microsoft.graph.mailFolder` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/mailfolder?view=graph-rest-1.0&preserve-view=true) |
| [`/me/mailFolders/{mailFolder-id}/messages`](me/mailFolders/messages/README.md) | `microsoft.graph.message` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/message?view=graph-rest-1.0&preserve-view=true) |
| [`/me/messages`](me/messages/README.md) | `microsoft.graph.message` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/message?view=graph-rest-1.0&preserve-view=true) |
| [`/me/notes`](me/notes/README.md) | `microsoft.graph.note` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/note?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/inferenceClassification/overrides`](users/inferenceClassification/overrides/README.md) | `microsoft.graph.inferenceClassificationOverride` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/inferenceclassificationoverride?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/mailFolders`](users/mailFolders/README.md) | `microsoft.graph.mailFolder` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/mailfolder?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/mailFolders/{mailFolder-id}/messages`](users/mailFolders/messages/README.md) | `microsoft.graph.message` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/message?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/messages`](users/messages/README.md) | `microsoft.graph.message` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/message?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/notes`](users/notes/README.md) | `microsoft.graph.note` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/note?view=graph-rest-1.0&preserve-view=true) |

## Mailbox import and export

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/mailbox-import-export-api-overview?view=graph-rest-1.0&preserve-view=true) Â· **0 generated modules**.

No supported CRUD collection was generated in this category from the selected inputs. APIs may still exist here as read-only endpoints, actions, unsupported lifecycles, or endpoints outside an explicit include filter.

## Notes

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/onenote-api-overview?view=graph-rest-1.0&preserve-view=true) Â· **4 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/groups/{group-id}/onenote/pages`](groups/onenote/pages/README.md) | `microsoft.graph.onenotePage` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/onenote-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/me/onenote/pages`](me/onenote/pages/README.md) | `microsoft.graph.onenotePage` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/onenote-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/onenote/pages`](sites/onenote/pages/README.md) | `microsoft.graph.onenotePage` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/onenote-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/onenote/pages`](users/onenote/pages/README.md) | `microsoft.graph.onenotePage` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/onenote-api-overview?view=graph-rest-1.0&preserve-view=true) |

## People and workplace intelligence

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/social-overview?view=graph-rest-1.0&preserve-view=true) Â· **2 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/admin/people/profileCardProperties`](admin/people/profileCardProperties/README.md) | `microsoft.graph.profileCardProperty` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/profilecardproperty?view=graph-rest-1.0&preserve-view=true) |
| [`/admin/people/profilePropertySettings`](admin/people/profilePropertySettings/README.md) | `microsoft.graph.profilePropertySetting` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/profilepropertysetting?view=graph-rest-1.0&preserve-view=true) |

## Personal contacts

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) Â· **6 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/me/contactFolders`](me/contactFolders/README.md) | `microsoft.graph.contactFolder` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/contactfolder?view=graph-rest-1.0&preserve-view=true) |
| [`/me/contactFolders/{contactFolder-id}/contacts`](me/contactFolders/contacts/README.md) | `microsoft.graph.contact` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/contact?view=graph-rest-1.0&preserve-view=true) |
| [`/me/contacts`](me/contacts/README.md) | `microsoft.graph.contact` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/contact?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/contactFolders`](users/contactFolders/README.md) | `microsoft.graph.contactFolder` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/contactfolder?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/contactFolders/{contactFolder-id}/contacts`](users/contactFolders/contacts/README.md) | `microsoft.graph.contact` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/contact?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/contacts`](users/contacts/README.md) | `microsoft.graph.contact` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/contact?view=graph-rest-1.0&preserve-view=true) |

## Reports

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) Â· **1 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/deviceManagement/reports/exportJobs`](deviceManagement/reports/exportJobs/README.md) | `microsoft.graph.deviceManagementExportJob` | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |

## Partner billing reports

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/partners-billing-api-overview?view=graph-rest-1.0&preserve-view=true) Â· **0 generated modules**.

No supported CRUD collection was generated in this category from the selected inputs. APIs may still exist here as read-only endpoints, actions, unsupported lifecycles, or endpoints outside an explicit include filter.

## Search

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) Â· **3 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/search/acronyms`](search/acronyms/README.md) | `microsoft.graph.search.acronym` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/search-acronym?view=graph-rest-1.0&preserve-view=true) |
| [`/search/bookmarks`](search/bookmarks/README.md) | `microsoft.graph.search.bookmark` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/search-bookmark?view=graph-rest-1.0&preserve-view=true) |
| [`/search/qnas`](search/qnas/README.md) | `microsoft.graph.search.qna` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/search-qna?view=graph-rest-1.0&preserve-view=true) |

## Security

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/security-api-overview?view=graph-rest-1.0&preserve-view=true) Â· **11 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/security/attackSimulation/simulations`](security/attackSimulation/simulations/README.md) | `microsoft.graph.simulation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/simulation?view=graph-rest-1.0&preserve-view=true) |
| [`/security/cases/ediscoveryCases`](security/cases/ediscoveryCases/README.md) | `microsoft.graph.security.ediscoveryCase` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-ediscoverycase?view=graph-rest-1.0&preserve-view=true) |
| [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/caseMembers`](security/cases/ediscoveryCases/caseMembers/README.md) | `microsoft.graph.security.ediscoveryCaseMember` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-ediscoverycasemember?view=graph-rest-1.0&preserve-view=true) |
| [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/siteSources`](security/cases/ediscoveryCases/custodians/siteSources/README.md) | `microsoft.graph.security.siteSource` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/unifiedGroupSources`](security/cases/ediscoveryCases/custodians/unifiedGroupSources/README.md) | `microsoft.graph.security.unifiedGroupSource` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/userSources`](security/cases/ediscoveryCases/custodians/userSources/README.md) | `microsoft.graph.security.userSource` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/reviewSets/{ediscoveryReviewSet-id}/queries`](security/cases/ediscoveryCases/reviewSets/queries/README.md) | `microsoft.graph.security.ediscoveryReviewSetQuery` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-ediscoveryreviewsetquery?view=graph-rest-1.0&preserve-view=true) |
| [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/searches`](security/cases/ediscoveryCases/searches/README.md) | `microsoft.graph.security.ediscoverySearch` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-ediscoverysearch?view=graph-rest-1.0&preserve-view=true) |
| [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/tags`](security/cases/ediscoveryCases/tags/README.md) | `microsoft.graph.security.ediscoveryReviewTag` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-ediscoveryreviewtag?view=graph-rest-1.0&preserve-view=true) |
| [`/security/labels/retentionLabels`](security/labels/retentionLabels/README.md) | `microsoft.graph.security.retentionLabel` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-retentionlabel?view=graph-rest-1.0&preserve-view=true) |
| [`/security/triggers/retentionEvents`](security/triggers/retentionEvents/README.md) | `microsoft.graph.security.retentionEvent` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-retentionevent?view=graph-rest-1.0&preserve-view=true) |

## Sites and lists

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/sharepoint?view=graph-rest-1.0&preserve-view=true) Â· **13 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/sites/{site-id}/columns`](sites/columns/README.md) | `microsoft.graph.columnDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/columndefinition?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/contentTypes`](sites/contentTypes/README.md) | `microsoft.graph.contentType` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/contenttype?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/contentTypes/{contentType-id}/columns`](sites/contentTypes/columns/README.md) | `microsoft.graph.columnDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/columndefinition?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/lists/{list-id}/columns`](sites/lists/columns/README.md) | `microsoft.graph.columnDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/columndefinition?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/lists/{list-id}/contentTypes/{contentType-id}/columns`](sites/lists/contentTypes/columns/README.md) | `microsoft.graph.columnDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/columndefinition?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/lists/{list-id}/items`](sites/lists/items/README.md) | `microsoft.graph.listItem` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/listitem?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/lists/{list-id}/items/{listItem-id}/documentSetVersions`](sites/lists/items/documentSetVersions/README.md) | `microsoft.graph.documentSetVersion` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/documentsetversion?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/pages`](sites/pages/README.md) | `microsoft.graph.baseSitePage` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/basesitepage?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/permissions`](sites/permissions/README.md) | `microsoft.graph.permission` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/permission?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/termStore/groups`](sites/termStore/groups/README.md) | `microsoft.graph.termStore.group` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/termstore-group?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/termStore/sets`](sites/termStore/sets/README.md) | `microsoft.graph.termStore.set` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/termstore-set?view=graph-rest-1.0&preserve-view=true) |
| [`/storage/fileStorage/containers/{fileStorageContainer-id}/columns`](storage/fileStorage/containers/columns/README.md) | `microsoft.graph.columnDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/columndefinition?view=graph-rest-1.0&preserve-view=true) |
| [`/storage/fileStorage/containers/{fileStorageContainer-id}/permissions`](storage/fileStorage/containers/permissions/README.md) | `microsoft.graph.permission` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/permission?view=graph-rest-1.0&preserve-view=true) |

## Tasks and plans

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/planner-overview?view=graph-rest-1.0&preserve-view=true) Â· **0 generated modules**.

No supported CRUD collection was generated in this category from the selected inputs. APIs may still exist here as read-only endpoints, actions, unsupported lifecycles, or endpoints outside an explicit include filter.

## Teamwork and communications

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-1.0&preserve-view=true) Â· **26 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/appCatalogs/teamsApps`](appCatalogs/teamsApps/README.md) | `microsoft.graph.teamsApp` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teamsapp?view=graph-rest-1.0&preserve-view=true) |
| [`/appCatalogs/teamsApps/{teamsApp-id}/appDefinitions`](appCatalogs/teamsApps/appDefinitions/README.md) | `microsoft.graph.teamsAppDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/chats`](chats/README.md) | `microsoft.graph.chat` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/chat?view=graph-rest-1.0&preserve-view=true) |
| [`/chats/{chat-id}/installedApps`](chats/installedApps/README.md) | `microsoft.graph.teamsAppInstallation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teamsappinstallation?view=graph-rest-1.0&preserve-view=true) |
| [`/chats/{chat-id}/members`](chats/members/README.md) | `microsoft.graph.conversationMember` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/chats/{chat-id}/pinnedMessages`](chats/pinnedMessages/README.md) | `microsoft.graph.pinnedChatMessageInfo` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/pinnedchatmessageinfo?view=graph-rest-1.0&preserve-view=true) |
| [`/chats/{chat-id}/tabs`](chats/tabs/README.md) | `microsoft.graph.teamsTab` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teamstab?view=graph-rest-1.0&preserve-view=true) |
| [`/communications/calls`](communications/calls/README.md) | `microsoft.graph.call` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/call?view=graph-rest-1.0&preserve-view=true) |
| [`/communications/calls/{call-id}/audioRoutingGroups`](communications/calls/audioRoutingGroups/README.md) | `microsoft.graph.audioRoutingGroup` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/audioroutinggroup?view=graph-rest-1.0&preserve-view=true) |
| [`/employeeExperience/learningProviders/{learningProvider-id}/learningCourseActivities`](employeeExperience/learningProviders/learningCourseActivities/README.md) | `microsoft.graph.learningCourseActivity` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/learningcourseactivity?view=graph-rest-1.0&preserve-view=true) |
| [`/me/onlineMeetings`](me/onlineMeetings/README.md) | `microsoft.graph.onlineMeeting` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/onlinemeeting?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/virtualEvents/townhalls/{virtualEventTownhall-id}/presenters`](solutions/virtualEvents/townhalls/presenters/README.md) | `microsoft.graph.virtualEventPresenter` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/virtualeventpresenter?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/virtualEvents/townhalls/{virtualEventTownhall-id}/registrationConfiguration/questions`](solutions/virtualEvents/townhalls/registrationConfiguration/questions/README.md) | `microsoft.graph.virtualEventRegistrationQuestionBase` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/virtualeventregistrationquestionbase?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/virtualEvents/webinars/{virtualEventWebinar-id}/presenters`](solutions/virtualEvents/webinars/presenters/README.md) | `microsoft.graph.virtualEventPresenter` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/virtualeventpresenter?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/virtualEvents/webinars/{virtualEventWebinar-id}/registrationConfiguration/questions`](solutions/virtualEvents/webinars/registrationConfiguration/questions/README.md) | `microsoft.graph.virtualEventRegistrationQuestionBase` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/virtualeventregistrationquestionbase?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/channels`](teams/channels/README.md) | `microsoft.graph.channel` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/channel?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/channels/{channel-id}/members`](teams/channels/members/README.md) | `microsoft.graph.conversationMember` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/channels/{channel-id}/tabs`](teams/channels/tabs/README.md) | `microsoft.graph.teamsTab` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teamstab?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/installedApps`](teams/installedApps/README.md) | `microsoft.graph.teamsAppInstallation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teamsappinstallation?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/members`](teams/members/README.md) | `microsoft.graph.conversationMember` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/schedule/timeOffRequests`](teams/schedule/timeOffRequests/README.md) | `microsoft.graph.timeOffRequest` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/timeoffrequest?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/tags`](teams/tags/README.md) | `microsoft.graph.teamworkTag` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teamworktag?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/tags/{teamworkTag-id}/members`](teams/tags/members/README.md) | `microsoft.graph.teamworkTagMember` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teamworktagmember?view=graph-rest-1.0&preserve-view=true) |
| [`/teamwork/workforceIntegrations`](teamwork/workforceIntegrations/README.md) | `microsoft.graph.workforceIntegration` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/workforceintegration?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/onlineMeetings`](users/onlineMeetings/README.md) | `microsoft.graph.onlineMeeting` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/onlinemeeting?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/teamwork/installedApps`](users/teamwork/installedApps/README.md) | `microsoft.graph.userScopeTeamsAppInstallation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-1.0&preserve-view=true) |

## Tenants

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/tenants-overview?view=graph-rest-1.0&preserve-view=true) Â· **5 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/admin/configurationManagement/configurationMonitors`](admin/configurationManagement/configurationMonitors/README.md) | `microsoft.graph.configurationMonitor` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/configurationmonitor?view=graph-rest-1.0&preserve-view=true) |
| [`/directory/tenantGovernance/governanceInvitations`](directory/tenantGovernance/governanceInvitations/README.md) | `microsoft.graph.governanceInvitation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/tenantgovernanceservices-governanceinvitation?view=graph-rest-1.0&preserve-view=true) |
| [`/directory/tenantGovernance/governancePolicyTemplates`](directory/tenantGovernance/governancePolicyTemplates/README.md) | `microsoft.graph.tenantGovernancePolicyTemplate` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/tenantgovernanceservices-tenantgovernancepolicytemplate?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/crossTenantAccessPolicy/partners/{crossTenantAccessPolicyConfigurationPartner-tenantId}/m365Capabilities`](policies/crossTenantAccessPolicy/partners/m365Capabilities/README.md) | `microsoft.graph.m365CapabilityBase` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/m365capabilitybase?view=graph-rest-1.0&preserve-view=true) |
| [`/tenantRelationships/multiTenantOrganization/tenants`](tenantRelationships/multiTenantOrganization/tenants/README.md) | `microsoft.graph.multiTenantOrganizationMember` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/multitenantorganizationmember?view=graph-rest-1.0&preserve-view=true) |

## To-do tasks

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/todo-overview?view=graph-rest-1.0&preserve-view=true) Â· **8 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/me/todo/lists`](me/todo/lists/README.md) | `microsoft.graph.todoTaskList` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/todotasklist?view=graph-rest-1.0&preserve-view=true) |
| [`/me/todo/lists/{todoTaskList-id}/tasks`](me/todo/lists/tasks/README.md) | `microsoft.graph.todoTask` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/todotask?view=graph-rest-1.0&preserve-view=true) |
| [`/me/todo/lists/{todoTaskList-id}/tasks/{todoTask-id}/checklistItems`](me/todo/lists/tasks/checklistItems/README.md) | `microsoft.graph.checklistItem` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/checklistitem?view=graph-rest-1.0&preserve-view=true) |
| [`/me/todo/lists/{todoTaskList-id}/tasks/{todoTask-id}/linkedResources`](me/todo/lists/tasks/linkedResources/README.md) | `microsoft.graph.linkedResource` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/linkedresource?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/todo/lists`](users/todo/lists/README.md) | `microsoft.graph.todoTaskList` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/todotasklist?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/todo/lists/{todoTaskList-id}/tasks`](users/todo/lists/tasks/README.md) | `microsoft.graph.todoTask` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/todotask?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/todo/lists/{todoTaskList-id}/tasks/{todoTask-id}/checklistItems`](users/todo/lists/tasks/checklistItems/README.md) | `microsoft.graph.checklistItem` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/checklistitem?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/todo/lists/{todoTaskList-id}/tasks/{todoTask-id}/linkedResources`](users/todo/lists/tasks/linkedResources/README.md) | `microsoft.graph.linkedResource` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/linkedresource?view=graph-rest-1.0&preserve-view=true) |

## Workbooks and charts

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/excel?view=graph-rest-1.0&preserve-view=true) Â· **0 generated modules**.

No supported CRUD collection was generated in this category from the selected inputs. APIs may still exist here as read-only endpoints, actions, unsupported lifecycles, or endpoints outside an explicit include filter.
