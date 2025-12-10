# Microsoft Entra Service Principal Sign-In Events

[SigninLogs]

| | [AADServicePrincipalSignInLogs](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/AADServicePrincipalSignInLogs)<br>(Entra Diagnostic) | [AADManagedIdentitySignInLogs](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/AADServicePrincipalSignInLogs)<br>(Entra Diagnostic) | [EntraIdSpnSignInEvents](https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-entraidspnsigninevents-table)<br>(XDR Advanced Hunting) |
| :--- | :--- | :--- | :--- |
| **General** | | | |
| Billable | Yes | Yes | No |
| Retention | 90 days (default) up to 2 years | 90 days (default) up to 2 years | 30 days (fixed) |
| **Timestamp** | | | |
| | ✅  TimeGenerated | ✅  TimeGenerated | ✅  TimeGenerated |
| | ✅  CreatedDateTime | ✅  CreatedDateTime | ✅  Timestamp |
| **Authentication** | | | |
| | ⚠️ AuthenticationContextClassReferences | ⚠️ AuthenticationContextClassReferences | ❌ N/A |
| | ✅  AuthenticationProcessingDetails | ⚠️ AuthenticationProcessingDetails | ❌ N/A |
| | ✅  ServicePrincipalCredentialKeyId | ❌ N/A | ❌ N/A |
| | ✅  ServicePrincipalCredentialThumbprint | ❌ N/A | ❌ N/A |
| **Sign-in** | | | |
| | ✅  AADTenantId | ✅  AADTenantId | ❌ N/A |
| | ✅  AppId | ✅  AppId | ✅  ApplicationId |
| | ✅  AppOwnerTenantId | ⚠️ AppOwnerTenantId | ❌ N/A |
| | ❌ N/A | ❌ N/A | ✅  GatewayJA4 |
| | ✅  ResourceDisplayName | ✅  ResourceDisplayName | ✅  ResourceDisplayName |
| | ✅  ResourceIdentity | ✅  ResourceIdentity | ✅  ResourceId |
| | ✅  ResourceOwnerTenantId | ✅  ResourceOwnerTenantId | ✅  ResourceTenantId |
| | ✅  ResourceServicePrincipalId | ✅  ResourceServicePrincipalId | ❌ N/A |
| | ✅  ResultDescription | ✅  ResultDescription | ❌ N/A |
| | ✅  ResultSignature | ✅  ResultSignature | ❌ N/A |
| | ✅  ResultType | ✅  ResultType | ✅  ErrorCode |
| **Sign-in identifiers** | | | |
| | ✅  CorrelationId | ✅  CorrelationId | ✅  CorrelationId |
| | ✅  Id | ✅  Id | ✅  RequestId |
| | ✅  SessionId | ⚠️ SessionId | ✅  SessionId* |
| | ✅  UniqueTokenIdentifier | ✅  UniqueTokenIdentifier | ❌ N/A |
| **Agent details** | | | |
| | ✅  Agent | ✅  Agent | ❌ N/A |
| **App or Workload Identity Details** | | | |
| | ✅  ClientCredentialType | ✅  ClientCredentialType | ❌ N/A |
| | ✅  FederatedCredentialId | ✅  FederatedCredentialId | ❌ N/A |
| | ❌ N/A | ⚠️ ManagedServiceIdentity | ❌ N/A |
| | ✅  ServicePrincipalCredentialKeyId | ✅  ServicePrincipalCredentialKeyId | ❌ N/A |
| | ✅  ServicePrincipalCredentialThumbprint | ✅  ServicePrincipalCredentialThumbprint | ❌ N/A |
| | ❌ N/A | ❌ N/A | ✅  Application |
| | ⚠️ Identity | ⚠️ Identity | ❌ N/A |
| | ✅  ServicePrincipalName | ✅  ServicePrincipalName | ✅  ServicePrincipalName |
| | ✅  ServicePrincipalId | ✅  ServicePrincipalId | ✅  ServicePrincipalId |
| **Client Details** | | | |
| | ✅  UserAgent | ⚠️ UserAgent | ✅  UserAgent* |
| | ❌ N/A | ⚠️ SourceAppClientId | ❌ N/A |
| **Conditional Access** | | | |
| | ✅  ConditionalAccessPolicies | ✅  ConditionalAccessPolicies | ❌ N/A |
| | ⚠️ ConditionalAccessPoliciesV2 | ⚠️ ConditionalAccessPoliciesV2 | ❌ N/A |
| | ✅  ConditionalAccessStatus | ✅  ConditionalAccessStatus | ❌ N/A |
| **Location** | | | |
| | ✅  Location | ⚠️ Location | ✅  Country |
| | ✅  LocationDetails | ⚠️ LocationDetails | ✅  City* |
| | | | ✅  Latitude* |
| | | | ✅  Longitude* |
| | | | ✅  State* |
| **Network** | | | |
| | ⚠️ AutonomousSystemNumber | ❌ N/A | ❌ N/A |
| | ✅  IPAddress | ⚠️ IPAddress | ✅  IPAddress* |
| | ✅  NetworkLocationDetails | ⚠️ NetworkLocationDetails | ❌ N/A |
| **Logging detail** | | | |
| | ✅  Category | ✅  Category | ❌ N/A |
| | ⚠️ Level | ⚠️ Level | ❌ N/A |
| | ✅  OperationName | ✅  OperationName | ❌ N/A |
| | ✅  OperationVersion | ✅  OperationVersion | ❌ N/A |
| | ❌ N/A | ❌ N/A | ✅  ReportId |
| | ✅  ResourceGroup | ✅  ResourceGroup | ❌ N/A |
| | ✅  SourceSystem | ✅  SourceSystem | ⚠️ SourceSystem |
| | ✅  TenantId (= WorkspaceId) | ✅  TenantId (= WorkspaceId) | ⚠️ TenantId |
| | ✅  Type | ✅  Type | ✅  Type |
| **Telemetry** | | | |
| | ✅  DurationMs | ✅  DurationMs | ❌ N/A |
| | | | |
| * only available for Service Principals | | | |
| | | | |
| **Legend** | | | 
| | ✅ # Microsoft Entra Service Principal Sign-In Events

[SigninLogs]

| | [AADServicePrincipalSignInLogs](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/AADServicePrincipalSignInLogs)<br>(Entra Diagnostic) | [AADManagedIdentitySignInLogs](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/AADServicePrincipalSignInLogs)<br>(Entra Diagnostic) | [EntraIdSpnSignInEvents](https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-entraidspnsigninevents-table)<br>(XDR Advanced Hunting) |
| :--- | :--- | :--- | :--- |
| **General** | | | |
| Billable | Yes | Yes | No |
| Retention | 90 days (default) up to 2 years | 90 days (default) up to 2 years | 30 days (fixed) |
| **Timestamp** | | | |
| | ✅  TimeGenerated | ✅  TimeGenerated | ✅  TimeGenerated |
| | ✅  CreatedDateTime | ✅  CreatedDateTime | ✅  Timestamp |
| **Authentication** | | | |
| | ⚠️ AuthenticationContextClassReferences | ⚠️ AuthenticationContextClassReferences | ❌ N/A |
| | ✅  AuthenticationProcessingDetails | ⚠️ AuthenticationProcessingDetails | ❌ N/A |
| | ✅  ServicePrincipalCredentialKeyId | ❌ N/A | ❌ N/A |
| | ✅  ServicePrincipalCredentialThumbprint | ❌ N/A | ❌ N/A |
| **Sign-in** | | | |
| | ✅  AADTenantId | ✅  AADTenantId | ❌ N/A |
| | ✅  AppId | ✅  AppId | ✅  ApplicationId |
| | ✅  AppOwnerTenantId | ⚠️ AppOwnerTenantId | ❌ N/A |
| | ❌ N/A | ❌ N/A | ✅  GatewayJA4 |
| | ✅  ResourceDisplayName | ✅  ResourceDisplayName | ✅  ResourceDisplayName |
| | ✅  ResourceIdentity | ✅  ResourceIdentity | ✅  ResourceId |
| | ✅  ResourceOwnerTenantId | ✅  ResourceOwnerTenantId | ✅  ResourceTenantId |
| | ✅  ResourceServicePrincipalId | ✅  ResourceServicePrincipalId | ❌ N/A |
| | ✅  ResultDescription | ✅  ResultDescription | ❌ N/A |
| | ✅  ResultSignature | ✅  ResultSignature | ❌ N/A |
| | ✅  ResultType | ✅  ResultType | ✅  ErrorCode |
| **Sign-in identifiers** | | | |
| | ✅  CorrelationId | ✅  CorrelationId | ✅  CorrelationId |
| | ✅  Id | ✅  Id | ✅  RequestId |
| | ✅  SessionId | ⚠️ SessionId | ✅  SessionId* |
| | ✅  UniqueTokenIdentifier | ✅  UniqueTokenIdentifier | ❌ N/A |
| **Agent details** | | | |
| | ✅  Agent | ✅  Agent | ❌ N/A |
| **App or Workload Identity Details** | | | |
| | ✅  ClientCredentialType | ✅  ClientCredentialType | ❌ N/A |
| | ✅  FederatedCredentialId | ✅  FederatedCredentialId | ❌ N/A |
| | ❌ N/A | ⚠️ ManagedServiceIdentity | ❌ N/A |
| | ✅  ServicePrincipalCredentialKeyId | ✅  ServicePrincipalCredentialKeyId | ❌ N/A |
| | ✅  ServicePrincipalCredentialThumbprint | ✅  ServicePrincipalCredentialThumbprint | ❌ N/A |
| | ❌ N/A | ❌ N/A | ✅  Application |
| | ⚠️ Identity | ⚠️ Identity | ❌ N/A |
| | ✅  ServicePrincipalName | ✅  ServicePrincipalName | ✅  ServicePrincipalName |
| | ✅  ServicePrincipalId | ✅  ServicePrincipalId | ✅  ServicePrincipalId |
| **Client Details** | | | |
| | ✅  UserAgent | ⚠️ UserAgent | ✅  UserAgent* |
| | ❌ N/A | ⚠️ SourceAppClientId | ❌ N/A |
| **Conditional Access** | | | |
| | ✅  ConditionalAccessPolicies | ✅  ConditionalAccessPolicies | ❌ N/A |
| | ⚠️ ConditionalAccessPoliciesV2 | ⚠️ ConditionalAccessPoliciesV2 | ❌ N/A |
| | ✅  ConditionalAccessStatus | ✅  ConditionalAccessStatus | ❌ N/A |
| **Location** | | | |
| | ✅  Location | ⚠️ Location | ✅  Country |
| | ✅  LocationDetails | ⚠️ LocationDetails | ✅  City* |
| | | | ✅  Latitude* |
| | | | ✅  Longitude* |
| | | | ✅  State* |
| **Network** | | | |
| | ⚠️ AutonomousSystemNumber | ❌ N/A | ❌ N/A |
| | ✅  IPAddress | ⚠️ IPAddress | ✅  IPAddress* |
| | ✅  NetworkLocationDetails | ⚠️ NetworkLocationDetails | ❌ N/A |
| **Logging detail** | | | |
| | ✅  Category | ✅  Category | ❌ N/A |
| | ⚠️ Level | ⚠️ Level | ❌ N/A |
| | ✅  OperationName | ✅  OperationName | ❌ N/A |
| | ✅  OperationVersion | ✅  OperationVersion | ❌ N/A |
| | ❌ N/A | ❌ N/A | ✅  ReportId |
| | ✅  ResourceGroup | ✅  ResourceGroup | ❌ N/A |
| | ✅  SourceSystem | ✅  SourceSystem | ⚠️ SourceSystem |
| | ✅  TenantId (= WorkspaceId) | ✅  TenantId (= WorkspaceId) | ⚠️ TenantId |
| | ✅  Type | ✅  Type | ✅  Type |
| **Telemetry** | | | |
| | ✅  DurationMs | ✅  DurationMs | ❌ N/A |
| | | | |
| * only available for Service Principals | | | |
| | | | |
| **Legend** | | | 
| | ✅  Available | | 
| | ⚠️ Exists in schema, but empty value |
| | ❌ Not available | | 