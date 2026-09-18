# Curated Microsoft Graph Terraform modules

These modules provide task-focused Terraform inputs and outputs for Microsoft
Entra users, groups, applications, service principals and entitlement management.
Start with the module README for configuration, permissions, license requirements
and lifecycle limitations.

## Folder hierarchy

The tree shows every module folder. Each module has its own README, Terraform
configuration and tests; test and support files are omitted here for readability.
Intermediate folders group related modules and are not standalone modules.

```text
curated/
├── README.md
├── applications/
├── groups/
├── identity-governance/
│   └── entitlement-management/
│       ├── access-packages/
│       │   └── resource-role-scopes/
│       ├── assignment-policies/
│       └── catalogs/
│           └── resources/
├── service-principals/
└── users/
```

`access-packages/` and `catalogs/` are modules themselves; their child folders
provide separate relationship modules. A Terraform module source points to the
specific module folder, rather than this index or a grouping folder.

## Browse modules

| Module | Purpose |
| --- | --- |
| [Applications](applications/README.md) | Application registrations and application roles |
| [Groups](groups/README.md) | Microsoft Entra groups |
| [Service principals](service-principals/README.md) | Tenant application identities linked by application ID |
| [Users](users/README.md) | Microsoft Entra user accounts |
| [Catalogs](identity-governance/entitlement-management/catalogs/README.md) | Entitlement management resource catalogs |
| [Catalog resources](identity-governance/entitlement-management/catalogs/resources/README.md) | Resource associations within a catalog |
| [Access packages](identity-governance/entitlement-management/access-packages/README.md) | Packages of access to catalog resources |
| [Resource role scopes](identity-governance/entitlement-management/access-packages/resource-role-scopes/README.md) | Resource roles and scopes attached to an access package |
| [Assignment policies](identity-governance/entitlement-management/assignment-policies/README.md) | Access-package request and assignment policies |

For the broader generated endpoint catalogs, browse [v1.0](../generated/v1.0/README.md)
or [beta](../generated/beta/README.md). Module availability and offline tests do not
by themselves establish live lifecycle support; consult each module's guidance.
