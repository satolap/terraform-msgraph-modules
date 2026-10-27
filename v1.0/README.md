# Microsoft Graph v1.0 module catalog

**320 generated modules**, organized by the [Microsoft Graph API reference](https://github.com/microsoftgraph/microsoft-graph-docs-contrib/blob/4b7867afe88f98d2415ac2f0219debe86fcb5652/api-reference/v1.0/toc.yml).

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
| [Identity and access](#identity-and-access) | 56 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-1.0&preserve-view=true) |
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
| [Teamwork and communications](#teamwork-and-communications) | 33 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [Tenants](#tenants) | 5 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/tenants-overview?view=graph-rest-1.0&preserve-view=true) |
| [To-do tasks](#to-do-tasks) | 8 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/todo-overview?view=graph-rest-1.0&preserve-view=true) |
| [Workbooks and charts](#workbooks-and-charts) | 0 | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/excel?view=graph-rest-1.0&preserve-view=true) |

Each endpoint has one physical module. Resource types and service routes resolve documentation cross-listings; parent paths such as `/users` do not turn mail or calendar modules into user modules. Uncategorized is a generator fallback, not an official Microsoft category.

Open a category below, then an endpoint README for inputs, permissions guidance, import notes, and credential-free tests. Exact Graph URLs remain in every module and in [manifest.json](manifest.json).

License requirements are reviewed for 12 of 320 modules; every other module carries an explicit unknown licensing record in its README and manifest entry.

10942 Graph paths are not generated as modules. Each is recorded under `exclusions` in [manifest.json](manifest.json) with its reason and reason code. A request wrapper is never presented as management of the object it creates.

| Reason code | Paths | Meaning |
| --- | ---: | --- |
| `action_or_function` | 1612 | OData action or function. |
| `cast` | 756 | OData type-cast segment. |
| `if_match_required` | 3 | Update or delete needs an If-Match ETag header that `msgraph_resource` cannot send. |
| `item_requires_input` | 2 | An item operation needs a header or query parameter, such as If-Match. |
| `no_item_lifecycle` | 1839 | No single item path with GET, PATCH or PUT, and DELETE. |
| `no_post` | 4964 | Any other path without a POST the generator evaluates: read-only collections, items without a generated collection, `$count`, `$value`, alternate keys and unsupported segment syntax. |
| `no_response_id` | 2 | POST response has no id to track the created object. |
| `ref_relationship` | 101 | Relationship written through `$ref` operations. |
| `ref_singleton` | 20 | Reference with GET, PUT and DELETE in the supplied metadata; requires a separate assignment lifecycle. |
| `singleton` | 530 | Singleton with GET and PATCH but no POST; updated in place, not created. |
| `undocumented_lifecycle` | 1110 | The pinned API-specific Microsoft Learn index lacks a collection POST or member DELETE for this lifecycle. |
| `update_only` | 3 | Microsoft Learn documents reading and updating service-owned objects, without an ordinary create/delete lifecycle. |

Catalog scope: **Full catalog from pinned API sources**. Full-catalog licensing mapping checks run against the selected API version; partial runs do not claim mapping coverage.

Reviewed generated mapping coverage: 12 generated, 21 explicitly excluded, 0 missing. A mapped endpoint absent from both generated output and explicit exclusions fails full-catalog validation.

Mapped endpoints explicitly excluded from generation:

- `/identityGovernance/lifecycleWorkflows/deletedItems/workflows/{workflow-id}/tasks`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /identityGovernance/lifecycleWorkflows/deletedItems/workflows/{workflow-id}/tasks, DELETE /identityGovernance/lifecycleWorkflows/deletedItems/workflows/{workflow-id}/tasks/{id}
- `/identityGovernance/lifecycleWorkflows/deletedItems/workflows/{workflow-id}/versions/{workflowVersion-versionNumber}/tasks`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /identityGovernance/lifecycleWorkflows/deletedItems/workflows/{workflow-id}/versions/{workflowVersion-versionNumber}/tasks, DELETE /identityGovernance/lifecycleWorkflows/deletedItems/workflows/{workflow-id}/versions/{workflowVersion-versionNumber}/tasks/{id}
- `/identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/tasks`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/tasks, DELETE /identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/tasks/{id}
- `/identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/versions/{workflowVersion-versionNumber}/tasks`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/versions/{workflowVersion-versionNumber}/tasks, DELETE /identityGovernance/lifecycleWorkflows/workflows/{workflow-id}/versions/{workflowVersion-versionNumber}/tasks/{id}
- `/identityGovernance/privilegedAccess/group/assignmentApprovals`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /identityGovernance/privilegedAccess/group/assignmentApprovals, DELETE /identityGovernance/privilegedAccess/group/assignmentApprovals/{id}
- `/identityGovernance/privilegedAccess/group/assignmentScheduleInstances`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /identityGovernance/privilegedAccess/group/assignmentScheduleInstances, DELETE /identityGovernance/privilegedAccess/group/assignmentScheduleInstances/{id}
- `/identityGovernance/privilegedAccess/group/assignmentScheduleRequests`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks DELETE /identityGovernance/privilegedAccess/group/assignmentScheduleRequests/{id}
- `/identityGovernance/privilegedAccess/group/assignmentSchedules`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /identityGovernance/privilegedAccess/group/assignmentSchedules, DELETE /identityGovernance/privilegedAccess/group/assignmentSchedules/{id}
- `/identityGovernance/privilegedAccess/group/eligibilityScheduleInstances`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /identityGovernance/privilegedAccess/group/eligibilityScheduleInstances, DELETE /identityGovernance/privilegedAccess/group/eligibilityScheduleInstances/{id}
- `/identityGovernance/privilegedAccess/group/eligibilityScheduleRequests`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks DELETE /identityGovernance/privilegedAccess/group/eligibilityScheduleRequests/{id}
- `/identityGovernance/privilegedAccess/group/eligibilitySchedules`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /identityGovernance/privilegedAccess/group/eligibilitySchedules, DELETE /identityGovernance/privilegedAccess/group/eligibilitySchedules/{id}
- `/policies/roleManagementPolicies`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /policies/roleManagementPolicies, DELETE /policies/roleManagementPolicies/{id}
- `/policies/roleManagementPolicies/{unifiedRoleManagementPolicy-id}/effectiveRules`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /policies/roleManagementPolicies/{unifiedRoleManagementPolicy-id}/effectiveRules, DELETE /policies/roleManagementPolicies/{unifiedRoleManagementPolicy-id}/effectiveRules/{id}
- `/policies/roleManagementPolicies/{unifiedRoleManagementPolicy-id}/rules`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /policies/roleManagementPolicies/{unifiedRoleManagementPolicy-id}/rules, DELETE /policies/roleManagementPolicies/{unifiedRoleManagementPolicy-id}/rules/{id}
- `/policies/roleManagementPolicyAssignments`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /policies/roleManagementPolicyAssignments, DELETE /policies/roleManagementPolicyAssignments/{id}
- `/roleManagement/directory/roleAssignmentScheduleInstances`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /roleManagement/directory/roleAssignmentScheduleInstances, DELETE /roleManagement/directory/roleAssignmentScheduleInstances/{id}
- `/roleManagement/directory/roleAssignmentScheduleRequests`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks DELETE /roleManagement/directory/roleAssignmentScheduleRequests/{id}
- `/roleManagement/directory/roleAssignmentSchedules`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /roleManagement/directory/roleAssignmentSchedules, DELETE /roleManagement/directory/roleAssignmentSchedules/{id}
- `/roleManagement/directory/roleEligibilityScheduleInstances`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /roleManagement/directory/roleEligibilityScheduleInstances, DELETE /roleManagement/directory/roleEligibilityScheduleInstances/{id}
- `/roleManagement/directory/roleEligibilityScheduleRequests`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks DELETE /roleManagement/directory/roleEligibilityScheduleRequests/{id}
- `/roleManagement/directory/roleEligibilitySchedules`: Microsoft Learn index microsoftgraph/microsoft-graph-docs-contrib@4b7867afe88f98d2415ac2f0219debe86fcb5652 lacks POST /roleManagement/directory/roleEligibilitySchedules, DELETE /roleManagement/directory/roleEligibilitySchedules/{id}

## Unknown licensing review queue

308 unknown endpoints across 25 catalog families. [LICENSING-REVIEW.md](LICENSING-REVIEW.md) lists each path with a link to its generated module README; review the endpoint's Microsoft Graph documentation and Microsoft Entra licensing before relying on it. No license entitlement is inferred from API behavior.

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
| Identity and access (`identity-and-access`) | 48 |
| Mail (`mail`) | 10 |
| Notes (`notes`) | 4 |
| People and workplace intelligence (`people-and-workplace-intelligence`) | 2 |
| Personal contacts (`personal-contacts`) | 6 |
| Reports (`reports`) | 1 |
| Search (`search`) | 3 |
| Security (`security`) | 11 |
| Sites and lists (`sites-and-lists`) | 13 |
| Teamwork and communications (`teamwork-and-communications`) | 33 |
| Tenants (`tenants`) | 5 |
| To-do tasks (`to-do-tasks`) | 8 |
| Users (`users`) | 2 |

## Users

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/users?view=graph-rest-1.0&preserve-view=true) Â· **3 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/me/outlook/masterCategories`](me/outlook/master-categories/README.md) | `microsoft.graph.outlookCategory` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/outlookcategory?view=graph-rest-1.0&preserve-view=true) |
| [`/users`](users/README.md) | `microsoft.graph.user` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/user?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/outlook/masterCategories`](users/outlook/master-categories/README.md) | `microsoft.graph.outlookCategory` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/outlookcategory?view=graph-rest-1.0&preserve-view=true) |

## Groups

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/groups-overview?view=graph-rest-1.0&preserve-view=true) Â· **4 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/groupLifecyclePolicies`](group-lifecycle-policies/README.md) | `microsoft.graph.groupLifecyclePolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/grouplifecyclepolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/groups`](groups/README.md) | `microsoft.graph.group` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/group?view=graph-rest-1.0&preserve-view=true) |
| [`/groups/{group-id}/conversations/{conversation-id}/threads`](groups/conversations/threads/README.md) | `microsoft.graph.conversationThread` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/groups-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/groups/{group-id}/threads`](groups/threads/README.md) | `microsoft.graph.conversationThread` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/groups-overview?view=graph-rest-1.0&preserve-view=true) |

## Applications

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/applications-api-overview?view=graph-rest-1.0&preserve-view=true) Â· **11 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/applications`](applications/README.md) | `microsoft.graph.application` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/application?view=graph-rest-1.0&preserve-view=true) |
| [`/applications/{application-id}/extensionProperties`](applications/extension-properties/README.md) | `microsoft.graph.extensionProperty` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/extensionproperty?view=graph-rest-1.0&preserve-view=true) |
| [`/applications/{application-id}/federatedIdentityCredentials`](applications/federated-identity-credentials/README.md) | `microsoft.graph.federatedIdentityCredential` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/federatedidentitycredential?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/appManagementPolicies`](policies/app-management-policies/README.md) | `microsoft.graph.appManagementPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/appmanagementpolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/claimsMappingPolicies`](policies/claims-mapping-policies/README.md) | `microsoft.graph.claimsMappingPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/claimsmappingpolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/tokenIssuancePolicies`](policies/token-issuance-policies/README.md) | `microsoft.graph.tokenIssuancePolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/tokenissuancepolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/tokenLifetimePolicies`](policies/token-lifetime-policies/README.md) | `microsoft.graph.tokenLifetimePolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/tokenlifetimepolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/servicePrincipals`](service-principals/README.md) | `microsoft.graph.servicePrincipal` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/serviceprincipal?view=graph-rest-1.0&preserve-view=true) |
| [`/servicePrincipals/{servicePrincipal-id}/delegatedPermissionClassifications`](service-principals/delegated-permission-classifications/README.md) | `microsoft.graph.delegatedPermissionClassification` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/applications-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/servicePrincipals/{servicePrincipal-id}/remoteDesktopSecurityConfiguration/approvedClientApps`](service-principals/remote-desktop-security-configuration/approved-client-apps/README.md) | `microsoft.graph.approvedClientApp` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/approvedclientapp?view=graph-rest-1.0&preserve-view=true) |
| [`/servicePrincipals/{servicePrincipal-id}/synchronization/jobs`](service-principals/synchronization/jobs/README.md) | `microsoft.graph.synchronizationJob` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/synchronization-synchronizationjob?view=graph-rest-1.0&preserve-view=true) |

## Agents

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/agentid-platform-overview?view=graph-rest-1.0&preserve-view=true) Â· **0 generated modules**.

No supported CRUD collection was generated in this category from the selected inputs. APIs may still exist here as read-only endpoints, actions, unsupported lifecycles, or endpoints outside an explicit include filter.

## Backup and recovery

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/tenants-backup-recovery-overview?view=graph-rest-1.0&preserve-view=true) Â· **4 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/solutions/backupRestore/exchangeRestoreSessions/{exchangeRestoreSession-id}/mailboxRestoreArtifactsBulkAdditionRequests`](solutions/backup-restore/exchange-restore-sessions/mailbox-restore-artifacts-bulk-addition-requests/README.md) | `microsoft.graph.mailboxRestoreArtifactsBulkAdditionRequest` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/mailboxrestoreartifactsbulkadditionrequest?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/backupRestore/oneDriveForBusinessRestoreSessions/{oneDriveForBusinessRestoreSession-id}/driveRestoreArtifactsBulkAdditionRequests`](solutions/backup-restore/one-drive-for-business-restore-sessions/drive-restore-artifacts-bulk-addition-requests/README.md) | `microsoft.graph.driveRestoreArtifactsBulkAdditionRequest` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/driverestoreartifactsbulkadditionrequest?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/backupRestore/serviceApps`](solutions/backup-restore/service-apps/README.md) | `microsoft.graph.serviceApp` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/serviceapp?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/backupRestore/sharePointRestoreSessions/{sharePointRestoreSession-id}/siteRestoreArtifactsBulkAdditionRequests`](solutions/backup-restore/share-point-restore-sessions/site-restore-artifacts-bulk-addition-requests/README.md) | `microsoft.graph.siteRestoreArtifactsBulkAdditionRequest` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/siterestoreartifactsbulkadditionrequest?view=graph-rest-1.0&preserve-view=true) |

## Calendars

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/calendar-overview?view=graph-rest-1.0&preserve-view=true) Â· **22 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/groups/{group-id}/calendar/calendarPermissions`](groups/calendar/calendar-permissions/README.md) | `microsoft.graph.calendarPermission` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendarpermission?view=graph-rest-1.0&preserve-view=true) |
| [`/groups/{group-id}/calendar/events`](groups/calendar/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/groups/{group-id}/events`](groups/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/me/calendar/events`](me/calendar/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/me/calendarGroups`](me/calendar-groups/README.md) | `microsoft.graph.calendarGroup` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendargroup?view=graph-rest-1.0&preserve-view=true) |
| [`/me/calendarGroups/{calendarGroup-id}/calendars`](me/calendar-groups/calendars/README.md) | `microsoft.graph.calendar` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendar?view=graph-rest-1.0&preserve-view=true) |
| [`/me/calendarGroups/{calendarGroup-id}/calendars/{calendar-id}/events`](me/calendar-groups/calendars/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/me/calendars`](me/calendars/README.md) | `microsoft.graph.calendar` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendar?view=graph-rest-1.0&preserve-view=true) |
| [`/me/calendars/{calendar-id}/events`](me/calendars/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/me/events`](me/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/me/settings/workHoursAndLocations/occurrences`](me/settings/work-hours-and-locations/occurrences/README.md) | `microsoft.graph.workPlanOccurrence` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/workplanoccurrence?view=graph-rest-1.0&preserve-view=true) |
| [`/me/settings/workHoursAndLocations/recurrences`](me/settings/work-hours-and-locations/recurrences/README.md) | `microsoft.graph.workPlanRecurrence` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/workplanrecurrence?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/calendar/calendarPermissions`](users/calendar/calendar-permissions/README.md) | `microsoft.graph.calendarPermission` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendarpermission?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/calendar/events`](users/calendar/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/calendarGroups`](users/calendar-groups/README.md) | `microsoft.graph.calendarGroup` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendargroup?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/calendarGroups/{calendarGroup-id}/calendars`](users/calendar-groups/calendars/README.md) | `microsoft.graph.calendar` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendar?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/calendarGroups/{calendarGroup-id}/calendars/{calendar-id}/events`](users/calendar-groups/calendars/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/calendars`](users/calendars/README.md) | `microsoft.graph.calendar` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/calendar?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/calendars/{calendar-id}/events`](users/calendars/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/events`](users/events/README.md) | `microsoft.graph.event` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/event?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/settings/workHoursAndLocations/occurrences`](users/settings/work-hours-and-locations/occurrences/README.md) | `microsoft.graph.workPlanOccurrence` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/workplanoccurrence?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/settings/workHoursAndLocations/recurrences`](users/settings/work-hours-and-locations/recurrences/README.md) | `microsoft.graph.workPlanRecurrence` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/workplanrecurrence?view=graph-rest-1.0&preserve-view=true) |

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
| [`/solutions/bookingBusinesses`](solutions/booking-businesses/README.md) | `microsoft.graph.bookingBusiness` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/bookingbusiness?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/bookingBusinesses/{bookingBusiness-id}/appointments`](solutions/booking-businesses/appointments/README.md) | `microsoft.graph.bookingAppointment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/bookingappointment?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/bookingBusinesses/{bookingBusiness-id}/customQuestions`](solutions/booking-businesses/custom-questions/README.md) | `microsoft.graph.bookingCustomQuestion` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/bookingcustomquestion?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/bookingBusinesses/{bookingBusiness-id}/customers`](solutions/booking-businesses/customers/README.md) | `microsoft.graph.bookingCustomerBase` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/booking-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/bookingBusinesses/{bookingBusiness-id}/services`](solutions/booking-businesses/services/README.md) | `microsoft.graph.bookingService` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/bookingservice?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/bookingBusinesses/{bookingBusiness-id}/staffMembers`](solutions/booking-businesses/staff-members/README.md) | `microsoft.graph.bookingStaffMemberBase` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/booking-api-overview?view=graph-rest-1.0&preserve-view=true) |

## Device and app management

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) Â· **82 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/admin/edge/internetExplorerMode/siteLists`](admin/edge/internet-explorer-mode/site-lists/README.md) | `microsoft.graph.browserSiteList` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/browsersitelist?view=graph-rest-1.0&preserve-view=true) |
| [`/admin/edge/internetExplorerMode/siteLists/{browserSiteList-id}/sharedCookies`](admin/edge/internet-explorer-mode/site-lists/shared-cookies/README.md) | `microsoft.graph.browserSharedCookie` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/browsersharedcookie?view=graph-rest-1.0&preserve-view=true) |
| [`/admin/edge/internetExplorerMode/siteLists/{browserSiteList-id}/sites`](admin/edge/internet-explorer-mode/site-lists/sites/README.md) | `microsoft.graph.browserSite` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/browsersite?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/androidManagedAppProtections`](device-app-management/android-managed-app-protections/README.md) | `microsoft.graph.androidManagedAppProtection` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-androidmanagedappprotection?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/androidManagedAppProtections/{androidManagedAppProtection-id}/apps`](device-app-management/android-managed-app-protections/apps/README.md) | `microsoft.graph.managedMobileApp` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-managedmobileapp?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/defaultManagedAppProtections`](device-app-management/default-managed-app-protections/README.md) | `microsoft.graph.defaultManagedAppProtection` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-defaultmanagedappprotection?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/defaultManagedAppProtections/{defaultManagedAppProtection-id}/apps`](device-app-management/default-managed-app-protections/apps/README.md) | `microsoft.graph.managedMobileApp` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-managedmobileapp?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/iosManagedAppProtections`](device-app-management/ios-managed-app-protections/README.md) | `microsoft.graph.iosManagedAppProtection` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-iosmanagedappprotection?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/iosManagedAppProtections/{iosManagedAppProtection-id}/apps`](device-app-management/ios-managed-app-protections/apps/README.md) | `microsoft.graph.managedMobileApp` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-managedmobileapp?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/managedAppRegistrations/{managedAppRegistration-id}/operations`](device-app-management/managed-app-registrations/operations/README.md) | `microsoft.graph.managedAppOperation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-managedappoperation?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/managedEBooks`](device-app-management/managed-e-books/README.md) | `microsoft.graph.managedEBook` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-books-managedebook?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/managedEBooks/{managedEBook-id}/assignments`](device-app-management/managed-e-books/assignments/README.md) | `microsoft.graph.managedEBookAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-books-managedebookassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/managedEBooks/{managedEBook-id}/deviceStates`](device-app-management/managed-e-books/device-states/README.md) | `microsoft.graph.deviceInstallState` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-books-deviceinstallstate?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/managedEBooks/{managedEBook-id}/userStateSummary`](device-app-management/managed-e-books/user-state-summary/README.md) | `microsoft.graph.userInstallStateSummary` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-books-userinstallstatesummary?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/managedEBooks/{managedEBook-id}/userStateSummary/{userInstallStateSummary-id}/deviceStates`](device-app-management/managed-e-books/user-state-summary/device-states/README.md) | `microsoft.graph.deviceInstallState` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-books-deviceinstallstate?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mdmWindowsInformationProtectionPolicies`](device-app-management/mdm-windows-information-protection-policies/README.md) | `microsoft.graph.mdmWindowsInformationProtectionPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-mdmwindowsinformationprotectionpolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}/exemptAppLockerFiles`](device-app-management/mdm-windows-information-protection-policies/exempt-app-locker-files/README.md) | `microsoft.graph.windowsInformationProtectionAppLockerFile` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-windowsinformationprotectionapplockerfile?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mdmWindowsInformationProtectionPolicies/{mdmWindowsInformationProtectionPolicy-id}/protectedAppLockerFiles`](device-app-management/mdm-windows-information-protection-policies/protected-app-locker-files/README.md) | `microsoft.graph.windowsInformationProtectionAppLockerFile` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-windowsinformationprotectionapplockerfile?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mobileAppCategories`](device-app-management/mobile-app-categories/README.md) | `microsoft.graph.mobileAppCategory` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-apps-mobileappcategory?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mobileAppConfigurations`](device-app-management/mobile-app-configurations/README.md) | `microsoft.graph.managedDeviceMobileAppConfiguration` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-apps-manageddevicemobileappconfiguration?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mobileAppConfigurations/{managedDeviceMobileAppConfiguration-id}/assignments`](device-app-management/mobile-app-configurations/assignments/README.md) | `microsoft.graph.managedDeviceMobileAppConfigurationAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-apps-manageddevicemobileappconfigurationassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mobileAppConfigurations/{managedDeviceMobileAppConfiguration-id}/deviceStatuses`](device-app-management/mobile-app-configurations/device-statuses/README.md) | `microsoft.graph.managedDeviceMobileAppConfigurationDeviceStatus` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-apps-manageddevicemobileappconfigurationdevicestatus?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mobileAppConfigurations/{managedDeviceMobileAppConfiguration-id}/userStatuses`](device-app-management/mobile-app-configurations/user-statuses/README.md) | `microsoft.graph.managedDeviceMobileAppConfigurationUserStatus` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-apps-manageddevicemobileappconfigurationuserstatus?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mobileApps`](device-app-management/mobile-apps/README.md) | `microsoft.graph.mobileApp` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-apps-mobileapp?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/mobileApps/{mobileApp-id}/assignments`](device-app-management/mobile-apps/assignments/README.md) | `microsoft.graph.mobileAppAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-apps-mobileappassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/targetedManagedAppConfigurations`](device-app-management/targeted-managed-app-configurations/README.md) | `microsoft.graph.targetedManagedAppConfiguration` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-targetedmanagedappconfiguration?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/targetedManagedAppConfigurations/{targetedManagedAppConfiguration-id}/apps`](device-app-management/targeted-managed-app-configurations/apps/README.md) | `microsoft.graph.managedMobileApp` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-managedmobileapp?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/vppTokens`](device-app-management/vpp-tokens/README.md) | `microsoft.graph.vppToken` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-onboarding-vpptoken?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/windowsInformationProtectionPolicies`](device-app-management/windows-information-protection-policies/README.md) | `microsoft.graph.windowsInformationProtectionPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-windowsinformationprotectionpolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/windowsInformationProtectionPolicies/{windowsInformationProtectionPolicy-id}/exemptAppLockerFiles`](device-app-management/windows-information-protection-policies/exempt-app-locker-files/README.md) | `microsoft.graph.windowsInformationProtectionAppLockerFile` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-windowsinformationprotectionapplockerfile?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceAppManagement/windowsInformationProtectionPolicies/{windowsInformationProtectionPolicy-id}/protectedAppLockerFiles`](device-app-management/windows-information-protection-policies/protected-app-locker-files/README.md) | `microsoft.graph.windowsInformationProtectionAppLockerFile` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-mam-windowsinformationprotectionapplockerfile?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/auditEvents`](device-management/audit-events/README.md) | `microsoft.graph.auditEvent` | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/complianceManagementPartners`](device-management/compliance-management-partners/README.md) | `microsoft.graph.complianceManagementPartner` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-onboarding-compliancemanagementpartner?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/detectedApps`](device-management/detected-apps/README.md) | `microsoft.graph.detectedApp` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-detectedapp?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCategories`](device-management/device-categories/README.md) | `microsoft.graph.deviceCategory` | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCompliancePolicies`](device-management/device-compliance-policies/README.md) | `microsoft.graph.deviceCompliancePolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-devicecompliancepolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/assignments`](device-management/device-compliance-policies/assignments/README.md) | `microsoft.graph.deviceCompliancePolicyAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-devicecompliancepolicyassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/deviceSettingStateSummaries`](device-management/device-compliance-policies/device-setting-state-summaries/README.md) | `microsoft.graph.settingStateDeviceSummary` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-settingstatedevicesummary?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/deviceStatuses`](device-management/device-compliance-policies/device-statuses/README.md) | `microsoft.graph.deviceComplianceDeviceStatus` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-devicecompliancedevicestatus?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/scheduledActionsForRule`](device-management/device-compliance-policies/scheduled-actions-for-rule/README.md) | `microsoft.graph.deviceComplianceScheduledActionForRule` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-devicecompliancescheduledactionforrule?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/scheduledActionsForRule/{deviceComplianceScheduledActionForRule-id}/scheduledActionConfigurations`](device-management/device-compliance-policies/scheduled-actions-for-rule/scheduled-action-configurations/README.md) | `microsoft.graph.deviceComplianceActionItem` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-devicecomplianceactionitem?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCompliancePolicies/{deviceCompliancePolicy-id}/userStatuses`](device-management/device-compliance-policies/user-statuses/README.md) | `microsoft.graph.deviceComplianceUserStatus` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-devicecomplianceuserstatus?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCompliancePolicySettingStateSummaries`](device-management/device-compliance-policy-setting-state-summaries/README.md) | `microsoft.graph.deviceCompliancePolicySettingStateSummary` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-devicecompliancepolicysettingstatesummary?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceCompliancePolicySettingStateSummaries/{deviceCompliancePolicySettingStateSummary-id}/deviceComplianceSettingStates`](device-management/device-compliance-policy-setting-state-summaries/device-compliance-setting-states/README.md) | `microsoft.graph.deviceComplianceSettingState` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-devicecompliancesettingstate?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceConfigurations`](device-management/device-configurations/README.md) | `microsoft.graph.deviceConfiguration` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-deviceconfiguration?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceConfigurations/{deviceConfiguration-id}/assignments`](device-management/device-configurations/assignments/README.md) | `microsoft.graph.deviceConfigurationAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-deviceconfigurationassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceConfigurations/{deviceConfiguration-id}/deviceSettingStateSummaries`](device-management/device-configurations/device-setting-state-summaries/README.md) | `microsoft.graph.settingStateDeviceSummary` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-settingstatedevicesummary?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceConfigurations/{deviceConfiguration-id}/deviceStatuses`](device-management/device-configurations/device-statuses/README.md) | `microsoft.graph.deviceConfigurationDeviceStatus` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-deviceconfigurationdevicestatus?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceConfigurations/{deviceConfiguration-id}/userStatuses`](device-management/device-configurations/user-statuses/README.md) | `microsoft.graph.deviceConfigurationUserStatus` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-deviceconfigurationuserstatus?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceEnrollmentConfigurations`](device-management/device-enrollment-configurations/README.md) | `microsoft.graph.deviceEnrollmentConfiguration` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-onboarding-deviceenrollmentconfiguration?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceEnrollmentConfigurations/{deviceEnrollmentConfiguration-id}/assignments`](device-management/device-enrollment-configurations/assignments/README.md) | `microsoft.graph.enrollmentConfigurationAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-onboarding-enrollmentconfigurationassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/deviceManagementPartners`](device-management/device-management-partners/README.md) | `microsoft.graph.deviceManagementPartner` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-onboarding-devicemanagementpartner?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/exchangeConnectors`](device-management/exchange-connectors/README.md) | `microsoft.graph.deviceManagementExchangeConnector` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-onboarding-devicemanagementexchangeconnector?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/importedWindowsAutopilotDeviceIdentities`](device-management/imported-windows-autopilot-device-identities/README.md) | `microsoft.graph.importedWindowsAutopilotDeviceIdentity` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-enrollment-importedwindowsautopilotdeviceidentity?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/iosUpdateStatuses`](device-management/ios-update-statuses/README.md) | `microsoft.graph.iosUpdateDeviceStatus` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-iosupdatedevicestatus?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/managedDevices`](device-management/managed-devices/README.md) | `microsoft.graph.managedDevice` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-manageddevice?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/mobileAppTroubleshootingEvents`](device-management/mobile-app-troubleshooting-events/README.md) | `microsoft.graph.mobileAppTroubleshootingEvent` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-mobileapptroubleshootingevent?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/mobileAppTroubleshootingEvents/{mobileAppTroubleshootingEvent-id}/appLogCollectionRequests`](device-management/mobile-app-troubleshooting-events/app-log-collection-requests/README.md) | `microsoft.graph.appLogCollectionRequest` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-applogcollectionrequest?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/mobileThreatDefenseConnectors`](device-management/mobile-threat-defense-connectors/README.md) | `microsoft.graph.mobileThreatDefenseConnector` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-onboarding-mobilethreatdefenseconnector?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/notificationMessageTemplates`](device-management/notification-message-templates/README.md) | `microsoft.graph.notificationMessageTemplate` | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/notificationMessageTemplates/{notificationMessageTemplate-id}/localizedNotificationMessages`](device-management/notification-message-templates/localized-notification-messages/README.md) | `microsoft.graph.localizedNotificationMessage` | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/remoteAssistancePartners`](device-management/remote-assistance-partners/README.md) | `microsoft.graph.remoteAssistancePartner` | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/resourceOperations`](device-management/resource-operations/README.md) | `microsoft.graph.resourceOperation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-rbac-resourceoperation?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/roleAssignments`](device-management/role-assignments/README.md) | `microsoft.graph.deviceAndAppManagementRoleAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-rbac-deviceandappmanagementroleassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/roleDefinitions`](device-management/role-definitions/README.md) | `microsoft.graph.roleDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-rbac-roledefinition?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/roleDefinitions/{roleDefinition-id}/roleAssignments`](device-management/role-definitions/role-assignments/README.md) | `microsoft.graph.roleAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-rbac-roleassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/termsAndConditions`](device-management/terms-and-conditions/README.md) | `microsoft.graph.termsAndConditions` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-companyterms-termsandconditions?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/termsAndConditions/{termsAndConditions-id}/acceptanceStatuses`](device-management/terms-and-conditions/acceptance-statuses/README.md) | `microsoft.graph.termsAndConditionsAcceptanceStatus` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-companyterms-termsandconditionsacceptancestatus?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/termsAndConditions/{termsAndConditions-id}/assignments`](device-management/terms-and-conditions/assignments/README.md) | `microsoft.graph.termsAndConditionsAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-companyterms-termsandconditionsassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/troubleshootingEvents`](device-management/troubleshooting-events/README.md) | `microsoft.graph.deviceManagementTroubleshootingEvent` | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/virtualEndpoint/deviceImages`](device-management/virtual-endpoint/device-images/README.md) | `microsoft.graph.cloudPcDeviceImage` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/cloudpcdeviceimage?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/virtualEndpoint/onPremisesConnections`](device-management/virtual-endpoint/on-premises-connections/README.md) | `microsoft.graph.cloudPcOnPremisesConnection` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/cloudpconpremisesconnection?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/virtualEndpoint/provisioningPolicies`](device-management/virtual-endpoint/provisioning-policies/README.md) | `microsoft.graph.cloudPcProvisioningPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/cloudpcprovisioningpolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/virtualEndpoint/userSettings`](device-management/virtual-endpoint/user-settings/README.md) | `microsoft.graph.cloudPcUserSetting` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/cloudpcusersetting?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/windowsAutopilotDeviceIdentities`](device-management/windows-autopilot-device-identities/README.md) | `microsoft.graph.windowsAutopilotDeviceIdentity` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-enrollment-windowsautopilotdeviceidentity?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/windowsInformationProtectionAppLearningSummaries`](device-management/windows-information-protection-app-learning-summaries/README.md) | `microsoft.graph.windowsInformationProtectionAppLearningSummary` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-wip-windowsinformationprotectionapplearningsummary?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/windowsInformationProtectionNetworkLearningSummaries`](device-management/windows-information-protection-network-learning-summaries/README.md) | `microsoft.graph.windowsInformationProtectionNetworkLearningSummary` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-wip-windowsinformationprotectionnetworklearningsummary?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/windowsMalwareInformation`](device-management/windows-malware-information/README.md) | `microsoft.graph.windowsMalwareInformation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-windowsmalwareinformation?view=graph-rest-1.0&preserve-view=true) |
| [`/deviceManagement/windowsMalwareInformation/{windowsMalwareInformation-id}/deviceMalwareStates`](device-management/windows-malware-information/device-malware-states/README.md) | `microsoft.graph.malwareStateForWindowsDevice` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/intune-devices-malwarestateforwindowsdevice?view=graph-rest-1.0&preserve-view=true) |
| [`/print/printers/{printer-id}/taskTriggers`](print/printers/task-triggers/README.md) | `microsoft.graph.printTaskTrigger` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/printtasktrigger?view=graph-rest-1.0&preserve-view=true) |
| [`/print/shares`](print/shares/README.md) | `microsoft.graph.printerShare` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/printershare?view=graph-rest-1.0&preserve-view=true) |
| [`/print/taskDefinitions`](print/task-definitions/README.md) | `microsoft.graph.printTaskDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/printtaskdefinition?view=graph-rest-1.0&preserve-view=true) |

## Education

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/education-overview?view=graph-rest-1.0&preserve-view=true) Â· **12 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/education/classes`](education/classes/README.md) | `microsoft.graph.educationClass` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/educationclass?view=graph-rest-1.0&preserve-view=true) |
| [`/education/classes/{educationClass-id}/assignmentCategories`](education/classes/assignment-categories/README.md) | `microsoft.graph.educationCategory` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/educationcategory?view=graph-rest-1.0&preserve-view=true) |
| [`/education/classes/{educationClass-id}/assignmentSettings/gradingSchemes`](education/classes/assignment-settings/grading-schemes/README.md) | `microsoft.graph.educationGradingScheme` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/educationgradingscheme?view=graph-rest-1.0&preserve-view=true) |
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
| [`/employeeExperience/communities`](employee-experience/communities/README.md) | `microsoft.graph.community` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/community?view=graph-rest-1.0&preserve-view=true) |

## Extensions

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) Â· **13 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/devices/{device-id}/extensions`](devices/extensions/README.md) | `microsoft.graph.extension` | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/groups/{group-id}/events/{event-id}/extensions`](groups/events/extensions/README.md) | `microsoft.graph.extension` | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/groups/{group-id}/extensions`](groups/extensions/README.md) | `microsoft.graph.extension` | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/groups/{group-id}/threads/{conversationThread-id}/posts/{post-id}/extensions`](groups/threads/posts/extensions/README.md) | `microsoft.graph.extension` | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/organization/{organization-id}/extensions`](organization/extensions/README.md) | `microsoft.graph.extension` | [Documentation](https://learn.microsoft.com/en-us/graph/extensibility-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/schemaExtensions`](schema-extensions/README.md) | `microsoft.graph.schemaExtension` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/schemaextension?view=graph-rest-1.0&preserve-view=true) |
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
| [`/storage/fileStorage/containerTypes`](storage/file-storage/container-types/README.md) | `microsoft.graph.fileStorageContainerType` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/filestoragecontainertype?view=graph-rest-1.0&preserve-view=true) |
| [`/storage/fileStorage/containers`](storage/file-storage/containers/README.md) | `microsoft.graph.fileStorageContainer` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/filestoragecontainer?view=graph-rest-1.0&preserve-view=true) |
| [`/storage/fileStorage/containers/{fileStorageContainer-id}/migrationJobs`](storage/file-storage/containers/migration-jobs/README.md) | `microsoft.graph.sharePointMigrationJob` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/sharepointmigrationjob?view=graph-rest-1.0&preserve-view=true) |
| [`/storage/fileStorage/containers/{fileStorageContainer-id}/sharePointGroups`](storage/file-storage/containers/share-point-groups/README.md) | `microsoft.graph.sharePointGroup` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/sharepointgroup?view=graph-rest-1.0&preserve-view=true) |
| [`/storage/fileStorage/containers/{fileStorageContainer-id}/sharePointGroups/{sharePointGroup-id}/members`](storage/file-storage/containers/share-point-groups/members/README.md) | `microsoft.graph.sharePointGroupMember` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/sharepointgroupmember?view=graph-rest-1.0&preserve-view=true) |

## Identity and access

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-1.0&preserve-view=true) Â· **56 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/devices`](devices/README.md) | `microsoft.graph.device` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/device?view=graph-rest-1.0&preserve-view=true) |
| [`/directory/administrativeUnits`](directory/administrative-units/README.md) | `microsoft.graph.administrativeUnit` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/administrativeunit?view=graph-rest-1.0&preserve-view=true) |
| [`/directory/administrativeUnits/{administrativeUnit-id}/scopedRoleMembers`](directory/administrative-units/scoped-role-members/README.md) | `microsoft.graph.scopedRoleMembership` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations`](directory/public-key-infrastructure/certificate-based-auth-configurations/README.md) | `microsoft.graph.certificateBasedAuthPki` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/certificatebasedauthpki?view=graph-rest-1.0&preserve-view=true) |
| [`/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/{certificateBasedAuthPki-id}/certificateAuthorities`](directory/public-key-infrastructure/certificate-based-auth-configurations/certificate-authorities/README.md) | `microsoft.graph.certificateAuthorityDetail` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/certificateauthoritydetail?view=graph-rest-1.0&preserve-view=true) |
| [`/domains`](domains/README.md) | `microsoft.graph.domain` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/domain?view=graph-rest-1.0&preserve-view=true) |
| [`/domains/{domain-id}/federationConfiguration`](domains/federation-configuration/README.md) | `microsoft.graph.internalDomainFederation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/internaldomainfederation?view=graph-rest-1.0&preserve-view=true) |
| [`/groupSettings`](group-settings/README.md) | `microsoft.graph.groupSetting` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/groupsetting?view=graph-rest-1.0&preserve-view=true) |
| [`/groups/{group-id}/appRoleAssignments`](groups/app-role-assignments/README.md) | `microsoft.graph.appRoleAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/approleassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/groups/{group-id}/settings`](groups/settings/README.md) | `microsoft.graph.groupSetting` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/groupsetting?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/apiConnectors`](identity/api-connectors/README.md) | `microsoft.graph.identityApiConnector` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identityapiconnector?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/authenticationEventListeners`](identity/authentication-event-listeners/README.md) | `microsoft.graph.authenticationEventListener` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/authenticationeventlistener?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/authenticationEventsFlows`](identity/authentication-events-flows/README.md) | `microsoft.graph.authenticationEventsFlow` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/authenticationeventsflow?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/b2xUserFlows`](identity/b2x-user-flows/README.md) | `microsoft.graph.b2xIdentityUserFlow` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/b2xidentityuserflow?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/b2xUserFlows/{b2xIdentityUserFlow-id}/userAttributeAssignments`](identity/b2x-user-flows/user-attribute-assignments/README.md) | `microsoft.graph.identityUserFlowAttributeAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identityuserflowattributeassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/conditionalAccess/authenticationStrength/policies/{authenticationStrengthPolicy-id}/combinationConfigurations`](identity/conditional-access/authentication-strength/policies/combination-configurations/README.md) | `microsoft.graph.authenticationCombinationConfiguration` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/authenticationcombinationconfiguration?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/conditionalAccess/namedLocations`](identity/conditional-access/named-locations/README.md) | `microsoft.graph.namedLocation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/namedlocation?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/conditionalAccess/policies`](identity/conditional-access/policies/README.md) | `microsoft.graph.conditionalAccessPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/conditionalaccesspolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/customAuthenticationExtensions`](identity/custom-authentication-extensions/README.md) | `microsoft.graph.customAuthenticationExtension` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/customauthenticationextension?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/identityProviders`](identity/identity-providers/README.md) | `microsoft.graph.identityProviderBase` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identityproviderbase?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/riskPrevention/fraudProtectionProviders`](identity/risk-prevention/fraud-protection-providers/README.md) | `microsoft.graph.fraudProtectionProvider` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/fraudprotectionprovider?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/riskPrevention/webApplicationFirewallProviders`](identity/risk-prevention/web-application-firewall-providers/README.md) | `microsoft.graph.webApplicationFirewallProvider` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/webapplicationfirewallprovider?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/userFlowAttributes`](identity/user-flow-attributes/README.md) | `microsoft.graph.identityUserFlowAttribute` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identityuserflowattribute?view=graph-rest-1.0&preserve-view=true) |
| [`/identity/verifiedId/profiles`](identity/verified-id/profiles/README.md) | `microsoft.graph.verifiedIdProfile` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/verifiedidprofile?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/accessReviews/definitions`](identity-governance/access-reviews/definitions/README.md) | `microsoft.graph.accessReviewScheduleDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/accessreviewscheduledefinition?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/entitlementManagement/accessPackages`](identity-governance/entitlement-management/access-packages/README.md) | `microsoft.graph.accessPackage` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/accesspackage?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/entitlementManagement/accessPackages/{accessPackage-id}/resourceRoleScopes`](identity-governance/entitlement-management/access-packages/resource-role-scopes/README.md) | `microsoft.graph.accessPackageResourceRoleScope` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/accesspackageresourcerolescope?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/entitlementManagement/assignmentPolicies`](identity-governance/entitlement-management/assignment-policies/README.md) | `microsoft.graph.accessPackageAssignmentPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/accesspackageassignmentpolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/entitlementManagement/assignmentRequests`](identity-governance/entitlement-management/assignment-requests/README.md) | `microsoft.graph.accessPackageAssignmentRequest` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/accesspackageassignmentrequest?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/entitlementManagement/catalogs`](identity-governance/entitlement-management/catalogs/README.md) | `microsoft.graph.accessPackageCatalog` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/accesspackagecatalog?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/entitlementManagement/catalogs/{accessPackageCatalog-id}/customWorkflowExtensions`](identity-governance/entitlement-management/catalogs/custom-workflow-extensions/README.md) | `microsoft.graph.customCalloutExtension` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/entitlementManagement/catalogs/{accessPackageCatalog-id}/resources/{accessPackageResource-id}/uploadSessions`](identity-governance/entitlement-management/catalogs/resources/upload-sessions/README.md) | `microsoft.graph.customDataProvidedResourceUploadSession` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/customdataprovidedresourceuploadsession?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/entitlementManagement/connectedOrganizations`](identity-governance/entitlement-management/connected-organizations/README.md) | `microsoft.graph.connectedOrganization` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/connectedorganization?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/entitlementManagement/externalOriginResourceConnectors`](identity-governance/entitlement-management/external-origin-resource-connectors/README.md) | `microsoft.graph.externalOriginResourceConnector` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/externaloriginresourceconnector?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/lifecycleWorkflows/customTaskExtensions`](identity-governance/lifecycle-workflows/custom-task-extensions/README.md) | `microsoft.graph.identityGovernance.customTaskExtension` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identitygovernance-customtaskextension?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/lifecycleWorkflows/workflows`](identity-governance/lifecycle-workflows/workflows/README.md) | `microsoft.graph.identityGovernance.workflow` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identitygovernance-workflow?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/privilegedAccess/customExtensions`](identity-governance/privileged-access/custom-extensions/README.md) | `microsoft.graph.roleManagementCustomCalloutExtension` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/rolemanagementcustomcalloutextension?view=graph-rest-1.0&preserve-view=true) |
| [`/identityGovernance/termsOfUse/agreements`](identity-governance/terms-of-use/agreements/README.md) | `microsoft.graph.agreement` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/agreement?view=graph-rest-1.0&preserve-view=true) |
| [`/identityProviders`](identity-providers/README.md) | `microsoft.graph.identityProvider` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identityprovider?view=graph-rest-1.0&preserve-view=true) |
| [`/oauth2PermissionGrants`](oauth2-permission-grants/README.md) | `microsoft.graph.oAuth2PermissionGrant` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/oauth2permissiongrant?view=graph-rest-1.0&preserve-view=true) |
| [`/organization/{organization-id}/branding/localizations`](organization/branding/localizations/README.md) | `microsoft.graph.organizationalBrandingLocalization` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/organizationalbrandinglocalization?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/activityBasedTimeoutPolicies`](policies/activity-based-timeout-policies/README.md) | `microsoft.graph.activityBasedTimeoutPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/activitybasedtimeoutpolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/authenticationStrengthPolicies`](policies/authentication-strength-policies/README.md) | `microsoft.graph.authenticationStrengthPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/authenticationstrengthpolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/featureRolloutPolicies`](policies/feature-rollout-policies/README.md) | `microsoft.graph.featureRolloutPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/featurerolloutpolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/homeRealmDiscoveryPolicies`](policies/home-realm-discovery-policies/README.md) | `microsoft.graph.homeRealmDiscoveryPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/homerealmdiscoverypolicy?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/permissionGrantPolicies`](policies/permission-grant-policies/README.md) | `microsoft.graph.permissionGrantPolicy` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/permissionGrantPolicies/{permissionGrantPolicy-id}/excludes`](policies/permission-grant-policies/excludes/README.md) | `microsoft.graph.permissionGrantConditionSet` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/permissionGrantPolicies/{permissionGrantPolicy-id}/includes`](policies/permission-grant-policies/includes/README.md) | `microsoft.graph.permissionGrantConditionSet` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/identity-network-access-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/roleManagement/directory/roleAssignments`](role-management/directory/role-assignments/README.md) | `microsoft.graph.unifiedRoleAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/unifiedroleassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/roleManagement/directory/roleDefinitions`](role-management/directory/role-definitions/README.md) | `microsoft.graph.unifiedRoleDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/unifiedroledefinition?view=graph-rest-1.0&preserve-view=true) |
| [`/roleManagement/entitlementManagement/roleAssignments`](role-management/entitlement-management/role-assignments/README.md) | `microsoft.graph.unifiedRoleAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/unifiedroleassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/servicePrincipals/{servicePrincipal-id}/appRoleAssignedTo`](service-principals/app-role-assigned-to/README.md) | `microsoft.graph.appRoleAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/approleassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/servicePrincipals/{servicePrincipal-id}/appRoleAssignments`](service-principals/app-role-assignments/README.md) | `microsoft.graph.appRoleAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/approleassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/appRoleAssignments`](users/app-role-assignments/README.md) | `microsoft.graph.appRoleAssignment` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/approleassignment?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/authentication/emailMethods`](users/authentication/email-methods/README.md) | `microsoft.graph.emailAuthenticationMethod` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/emailauthenticationmethod?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/authentication/phoneMethods`](users/authentication/phone-methods/README.md) | `microsoft.graph.phoneAuthenticationMethod` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/phoneauthenticationmethod?view=graph-rest-1.0&preserve-view=true) |

## Mail

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/mail-api-overview?view=graph-rest-1.0&preserve-view=true) Â· **10 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/me/inferenceClassification/overrides`](me/inference-classification/overrides/README.md) | `microsoft.graph.inferenceClassificationOverride` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/inferenceclassificationoverride?view=graph-rest-1.0&preserve-view=true) |
| [`/me/mailFolders`](me/mail-folders/README.md) | `microsoft.graph.mailFolder` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/mailfolder?view=graph-rest-1.0&preserve-view=true) |
| [`/me/mailFolders/{mailFolder-id}/messages`](me/mail-folders/messages/README.md) | `microsoft.graph.message` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/message?view=graph-rest-1.0&preserve-view=true) |
| [`/me/messages`](me/messages/README.md) | `microsoft.graph.message` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/message?view=graph-rest-1.0&preserve-view=true) |
| [`/me/notes`](me/notes/README.md) | `microsoft.graph.note` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/note?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/inferenceClassification/overrides`](users/inference-classification/overrides/README.md) | `microsoft.graph.inferenceClassificationOverride` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/inferenceclassificationoverride?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/mailFolders`](users/mail-folders/README.md) | `microsoft.graph.mailFolder` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/mailfolder?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/mailFolders/{mailFolder-id}/messages`](users/mail-folders/messages/README.md) | `microsoft.graph.message` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/message?view=graph-rest-1.0&preserve-view=true) |
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
| [`/admin/people/profileCardProperties`](admin/people/profile-card-properties/README.md) | `microsoft.graph.profileCardProperty` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/profilecardproperty?view=graph-rest-1.0&preserve-view=true) |
| [`/admin/people/profilePropertySettings`](admin/people/profile-property-settings/README.md) | `microsoft.graph.profilePropertySetting` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/profilepropertysetting?view=graph-rest-1.0&preserve-view=true) |

## Personal contacts

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) Â· **6 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/me/contactFolders`](me/contact-folders/README.md) | `microsoft.graph.contactFolder` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/contactfolder?view=graph-rest-1.0&preserve-view=true) |
| [`/me/contactFolders/{contactFolder-id}/contacts`](me/contact-folders/contacts/README.md) | `microsoft.graph.contact` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/contact?view=graph-rest-1.0&preserve-view=true) |
| [`/me/contacts`](me/contacts/README.md) | `microsoft.graph.contact` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/contact?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/contactFolders`](users/contact-folders/README.md) | `microsoft.graph.contactFolder` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/contactfolder?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/contactFolders/{contactFolder-id}/contacts`](users/contact-folders/contacts/README.md) | `microsoft.graph.contact` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/contact?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/contacts`](users/contacts/README.md) | `microsoft.graph.contact` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/contact?view=graph-rest-1.0&preserve-view=true) |

## Reports

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) Â· **1 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/deviceManagement/reports/exportJobs`](device-management/reports/export-jobs/README.md) | `microsoft.graph.deviceManagementExportJob` | [Documentation](https://learn.microsoft.com/en-us/graph/api/overview?view=graph-rest-1.0&preserve-view=true) |

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
| [`/security/attackSimulation/simulations`](security/attack-simulation/simulations/README.md) | `microsoft.graph.simulation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/simulation?view=graph-rest-1.0&preserve-view=true) |
| [`/security/cases/ediscoveryCases`](security/cases/ediscovery-cases/README.md) | `microsoft.graph.security.ediscoveryCase` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-ediscoverycase?view=graph-rest-1.0&preserve-view=true) |
| [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/caseMembers`](security/cases/ediscovery-cases/case-members/README.md) | `microsoft.graph.security.ediscoveryCaseMember` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-ediscoverycasemember?view=graph-rest-1.0&preserve-view=true) |
| [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/siteSources`](security/cases/ediscovery-cases/custodians/site-sources/README.md) | `microsoft.graph.security.siteSource` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/unifiedGroupSources`](security/cases/ediscovery-cases/custodians/unified-group-sources/README.md) | `microsoft.graph.security.unifiedGroupSource` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/custodians/{ediscoveryCustodian-id}/userSources`](security/cases/ediscovery-cases/custodians/user-sources/README.md) | `microsoft.graph.security.userSource` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/reviewSets/{ediscoveryReviewSet-id}/queries`](security/cases/ediscovery-cases/review-sets/queries/README.md) | `microsoft.graph.security.ediscoveryReviewSetQuery` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-ediscoveryreviewsetquery?view=graph-rest-1.0&preserve-view=true) |
| [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/searches`](security/cases/ediscovery-cases/searches/README.md) | `microsoft.graph.security.ediscoverySearch` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-ediscoverysearch?view=graph-rest-1.0&preserve-view=true) |
| [`/security/cases/ediscoveryCases/{ediscoveryCase-id}/tags`](security/cases/ediscovery-cases/tags/README.md) | `microsoft.graph.security.ediscoveryReviewTag` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-ediscoveryreviewtag?view=graph-rest-1.0&preserve-view=true) |
| [`/security/labels/retentionLabels`](security/labels/retention-labels/README.md) | `microsoft.graph.security.retentionLabel` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-retentionlabel?view=graph-rest-1.0&preserve-view=true) |
| [`/security/triggers/retentionEvents`](security/triggers/retention-events/README.md) | `microsoft.graph.security.retentionEvent` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/security-retentionevent?view=graph-rest-1.0&preserve-view=true) |

## Sites and lists

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/sharepoint?view=graph-rest-1.0&preserve-view=true) Â· **13 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/sites/{site-id}/columns`](sites/columns/README.md) | `microsoft.graph.columnDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/columndefinition?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/contentTypes`](sites/content-types/README.md) | `microsoft.graph.contentType` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/contenttype?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/contentTypes/{contentType-id}/columns`](sites/content-types/columns/README.md) | `microsoft.graph.columnDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/columndefinition?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/lists/{list-id}/columns`](sites/lists/columns/README.md) | `microsoft.graph.columnDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/columndefinition?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/lists/{list-id}/contentTypes/{contentType-id}/columns`](sites/lists/content-types/columns/README.md) | `microsoft.graph.columnDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/columndefinition?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/lists/{list-id}/items`](sites/lists/items/README.md) | `microsoft.graph.listItem` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/listitem?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/lists/{list-id}/items/{listItem-id}/documentSetVersions`](sites/lists/items/document-set-versions/README.md) | `microsoft.graph.documentSetVersion` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/documentsetversion?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/pages`](sites/pages/README.md) | `microsoft.graph.baseSitePage` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/basesitepage?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/permissions`](sites/permissions/README.md) | `microsoft.graph.permission` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/permission?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/termStore/groups`](sites/term-store/groups/README.md) | `microsoft.graph.termStore.group` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/termstore-group?view=graph-rest-1.0&preserve-view=true) |
| [`/sites/{site-id}/termStore/sets`](sites/term-store/sets/README.md) | `microsoft.graph.termStore.set` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/termstore-set?view=graph-rest-1.0&preserve-view=true) |
| [`/storage/fileStorage/containers/{fileStorageContainer-id}/columns`](storage/file-storage/containers/columns/README.md) | `microsoft.graph.columnDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/columndefinition?view=graph-rest-1.0&preserve-view=true) |
| [`/storage/fileStorage/containers/{fileStorageContainer-id}/permissions`](storage/file-storage/containers/permissions/README.md) | `microsoft.graph.permission` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/permission?view=graph-rest-1.0&preserve-view=true) |

## Tasks and plans

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/planner-overview?view=graph-rest-1.0&preserve-view=true) Â· **0 generated modules**.

No supported CRUD collection was generated in this category from the selected inputs. APIs may still exist here as read-only endpoints, actions, unsupported lifecycles, or endpoints outside an explicit include filter.

## Teamwork and communications

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-1.0&preserve-view=true) Â· **33 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/appCatalogs/teamsApps`](app-catalogs/teams-apps/README.md) | `microsoft.graph.teamsApp` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teamsapp?view=graph-rest-1.0&preserve-view=true) |
| [`/appCatalogs/teamsApps/{teamsApp-id}/appDefinitions`](app-catalogs/teams-apps/app-definitions/README.md) | `microsoft.graph.teamsAppDefinition` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/chats`](chats/README.md) | `microsoft.graph.chat` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/chat?view=graph-rest-1.0&preserve-view=true) |
| [`/chats/{chat-id}/installedApps`](chats/installed-apps/README.md) | `microsoft.graph.teamsAppInstallation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teamsappinstallation?view=graph-rest-1.0&preserve-view=true) |
| [`/chats/{chat-id}/members`](chats/members/README.md) | `microsoft.graph.conversationMember` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/chats/{chat-id}/pinnedMessages`](chats/pinned-messages/README.md) | `microsoft.graph.pinnedChatMessageInfo` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/pinnedchatmessageinfo?view=graph-rest-1.0&preserve-view=true) |
| [`/chats/{chat-id}/tabs`](chats/tabs/README.md) | `microsoft.graph.teamsTab` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teamstab?view=graph-rest-1.0&preserve-view=true) |
| [`/communications/calls`](communications/calls/README.md) | `microsoft.graph.call` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/call?view=graph-rest-1.0&preserve-view=true) |
| [`/communications/calls/{call-id}/audioRoutingGroups`](communications/calls/audio-routing-groups/README.md) | `microsoft.graph.audioRoutingGroup` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/audioroutinggroup?view=graph-rest-1.0&preserve-view=true) |
| [`/employeeExperience/learningProviders/{learningProvider-id}/learningCourseActivities`](employee-experience/learning-providers/learning-course-activities/README.md) | `microsoft.graph.learningCourseActivity` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/learningcourseactivity?view=graph-rest-1.0&preserve-view=true) |
| [`/me/onlineMeetings`](me/online-meetings/README.md) | `microsoft.graph.onlineMeeting` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/onlinemeeting?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/virtualEvents/townhalls/{virtualEventTownhall-id}/presenters`](solutions/virtual-events/townhalls/presenters/README.md) | `microsoft.graph.virtualEventPresenter` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/virtualeventpresenter?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/virtualEvents/townhalls/{virtualEventTownhall-id}/registrationConfiguration/questions`](solutions/virtual-events/townhalls/registration-configuration/questions/README.md) | `microsoft.graph.virtualEventRegistrationQuestionBase` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/virtualeventregistrationquestionbase?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/virtualEvents/webinars/{virtualEventWebinar-id}/presenters`](solutions/virtual-events/webinars/presenters/README.md) | `microsoft.graph.virtualEventPresenter` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/virtualeventpresenter?view=graph-rest-1.0&preserve-view=true) |
| [`/solutions/virtualEvents/webinars/{virtualEventWebinar-id}/registrationConfiguration/questions`](solutions/virtual-events/webinars/registration-configuration/questions/README.md) | `microsoft.graph.virtualEventRegistrationQuestionBase` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/virtualeventregistrationquestionbase?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/channels`](teams/channels/README.md) | `microsoft.graph.channel` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/channel?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/channels/{channel-id}/members`](teams/channels/members/README.md) | `microsoft.graph.conversationMember` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/channels/{channel-id}/tabs`](teams/channels/tabs/README.md) | `microsoft.graph.teamsTab` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teamstab?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/installedApps`](teams/installed-apps/README.md) | `microsoft.graph.teamsAppInstallation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teamsappinstallation?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/members`](teams/members/README.md) | `microsoft.graph.conversationMember` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/schedule/dayNotes`](teams/schedule/day-notes/README.md) | `microsoft.graph.dayNote` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/daynote?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/schedule/openShifts`](teams/schedule/open-shifts/README.md) | `microsoft.graph.openShift` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/openshift?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/schedule/schedulingGroups`](teams/schedule/scheduling-groups/README.md) | `microsoft.graph.schedulingGroup` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/schedulinggroup?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/schedule/shifts`](teams/schedule/shifts/README.md) | `microsoft.graph.shift` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/shift?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/schedule/timeCards`](teams/schedule/time-cards/README.md) | `microsoft.graph.timeCard` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/timecard?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/schedule/timeOffReasons`](teams/schedule/time-off-reasons/README.md) | `microsoft.graph.timeOffReason` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/timeoffreason?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/schedule/timeOffRequests`](teams/schedule/time-off-requests/README.md) | `microsoft.graph.timeOffRequest` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/timeoffrequest?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/schedule/timesOff`](teams/schedule/times-off/README.md) | `microsoft.graph.timeOff` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/timeoff?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/tags`](teams/tags/README.md) | `microsoft.graph.teamworkTag` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teamworktag?view=graph-rest-1.0&preserve-view=true) |
| [`/teams/{team-id}/tags/{teamworkTag-id}/members`](teams/tags/members/README.md) | `microsoft.graph.teamworkTagMember` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teamworktagmember?view=graph-rest-1.0&preserve-view=true) |
| [`/teamwork/workforceIntegrations`](teamwork/workforce-integrations/README.md) | `microsoft.graph.workforceIntegration` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/workforceintegration?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/onlineMeetings`](users/online-meetings/README.md) | `microsoft.graph.onlineMeeting` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/onlinemeeting?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/teamwork/installedApps`](users/teamwork/installed-apps/README.md) | `microsoft.graph.userScopeTeamsAppInstallation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/teams-api-overview?view=graph-rest-1.0&preserve-view=true) |

## Tenants

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/tenants-overview?view=graph-rest-1.0&preserve-view=true) Â· **5 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/admin/configurationManagement/configurationMonitors`](admin/configuration-management/configuration-monitors/README.md) | `microsoft.graph.configurationMonitor` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/configurationmonitor?view=graph-rest-1.0&preserve-view=true) |
| [`/directory/tenantGovernance/governanceInvitations`](directory/tenant-governance/governance-invitations/README.md) | `microsoft.graph.governanceInvitation` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/tenantgovernanceservices-governanceinvitation?view=graph-rest-1.0&preserve-view=true) |
| [`/directory/tenantGovernance/governancePolicyTemplates`](directory/tenant-governance/governance-policy-templates/README.md) | `microsoft.graph.tenantGovernancePolicyTemplate` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/tenantgovernanceservices-tenantgovernancepolicytemplate?view=graph-rest-1.0&preserve-view=true) |
| [`/policies/crossTenantAccessPolicy/partners/{crossTenantAccessPolicyConfigurationPartner-tenantId}/m365Capabilities`](policies/cross-tenant-access-policy/partners/m365-capabilities/README.md) | `microsoft.graph.m365CapabilityBase` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/m365capabilitybase?view=graph-rest-1.0&preserve-view=true) |
| [`/tenantRelationships/multiTenantOrganization/tenants`](tenant-relationships/multi-tenant-organization/tenants/README.md) | `microsoft.graph.multiTenantOrganizationMember` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/multitenantorganizationmember?view=graph-rest-1.0&preserve-view=true) |

## To-do tasks

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/todo-overview?view=graph-rest-1.0&preserve-view=true) Â· **8 generated modules**.

| Graph collection | Resource type | Microsoft reference |
| --- | --- | --- |
| [`/me/todo/lists`](me/todo/lists/README.md) | `microsoft.graph.todoTaskList` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/todotasklist?view=graph-rest-1.0&preserve-view=true) |
| [`/me/todo/lists/{todoTaskList-id}/tasks`](me/todo/lists/tasks/README.md) | `microsoft.graph.todoTask` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/todotask?view=graph-rest-1.0&preserve-view=true) |
| [`/me/todo/lists/{todoTaskList-id}/tasks/{todoTask-id}/checklistItems`](me/todo/lists/tasks/checklist-items/README.md) | `microsoft.graph.checklistItem` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/checklistitem?view=graph-rest-1.0&preserve-view=true) |
| [`/me/todo/lists/{todoTaskList-id}/tasks/{todoTask-id}/linkedResources`](me/todo/lists/tasks/linked-resources/README.md) | `microsoft.graph.linkedResource` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/linkedresource?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/todo/lists`](users/todo/lists/README.md) | `microsoft.graph.todoTaskList` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/todotasklist?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/todo/lists/{todoTaskList-id}/tasks`](users/todo/lists/tasks/README.md) | `microsoft.graph.todoTask` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/todotask?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/todo/lists/{todoTaskList-id}/tasks/{todoTask-id}/checklistItems`](users/todo/lists/tasks/checklist-items/README.md) | `microsoft.graph.checklistItem` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/checklistitem?view=graph-rest-1.0&preserve-view=true) |
| [`/users/{user-id}/todo/lists/{todoTaskList-id}/tasks/{todoTask-id}/linkedResources`](users/todo/lists/tasks/linked-resources/README.md) | `microsoft.graph.linkedResource` | [Documentation](https://learn.microsoft.com/en-us/graph/api/resources/linkedresource?view=graph-rest-1.0&preserve-view=true) |

## Workbooks and charts

[Microsoft Graph reference](https://learn.microsoft.com/en-us/graph/api/resources/excel?view=graph-rest-1.0&preserve-view=true) Â· **0 generated modules**.

No supported CRUD collection was generated in this category from the selected inputs. APIs may still exist here as read-only endpoints, actions, unsupported lifecycles, or endpoints outside an explicit include filter.
