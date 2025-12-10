# Microsoft Entra Service Principal Sign-In Events

<style>
/* Define styles for the spans to simulate cell background */
span.g, span.r, span.y { display: block; padding: 5px; margin: -5px; min-height: 1.2em; }
span.g { color: #000000; background-color: #C5FFC4; } /* Green - Available */
span.r { color: #000000; background-color: #FFB8B1; } /* Red - Not available */
span.y { color: #000000; background-color: #EBFFC4; } /* Yellow - Empty value */
</style>

[SigninLogs]

| | [AADServicePrincipalSignInLogs](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/AADServicePrincipalSignInLogs)<br>(Entra Diagnostic) | [AADManagedIdentitySignInLogs](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/AADServicePrincipalSignInLogs)<br>(Entra Diagnostic) | [EntraIdSpnSignInEvents](https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-entraidspnsigninevents-table)<br>(XDR Advanced Hunting) |
| :--- | :--- | :--- | :--- |
| **General** | | | |
| Billable | Yes | Yes | No |
| Retention | 90 days (default) up to 2 years | 90 days (default) up to 2 years | 30 days (fixed) |
| **Timestamp** | | | |
| | <span class="g">TimeGenerated</span> | <span class="g">TimeGenerated</span> | <span class="g">TimeGenerated</span> |
| | <span class="g">CreatedDateTime</span> | <span class="g">CreatedDateTime</span> | <span class="g">Timestamp</span> |
| **Authentication** | | | |
| | <span class="y">AuthenticationContextClassReferences</span> | <span class="y">AuthenticationContextClassReferences</span> | <span class="r">N/A</span> |
| | <span class="g">AuthenticationProcessingDetails</span> | <span class="y">AuthenticationProcessingDetails</span> | <span class="r">N/A</span> |
| | <span class="g">ServicePrincipalCredentialKeyId</span> | <span class="r">N/A</span> | <span class="r">N/A</span> |
| | <span class="g">ServicePrincipalCredentialThumbprint</span> | <span class="r">N/A</span> | <span class="r">N/A</span> |
| **Sign-in** | | | |
| | <span class="g">AADTenantId</span> | <span class="g">AADTenantId</span> | <span class="r">N/A</span> |
| | <span class="g">AppId</span> | <span class="g">AppId</span> | <span class="g">ApplicationId</span> |
| | <span class="g">AppOwnerTenantId</span> | <span class="y">AppOwnerTenantId</span> | <span class="r">N/A</span> |
| | <span class="r">N/A</span> | <span class="r">N/A</span> | <span class="g">GatewayJA4</span> |
| | <span class="g">ResourceDisplayName</span> | <span class="g">ResourceDisplayName</span> | <span class="g">ResourceDisplayName</span> |
| | <span class="g">ResourceIdentity</span> | <span class="g">ResourceIdentity</span> | <span class="g">ResourceId</span> |
| | <span class="g">ResourceOwnerTenantId</span> | <span class="g">ResourceOwnerTenantId</span> | <span class="g">ResourceTenantId</span> |
| | <span class="g">ResourceServicePrincipalId</span> | <span class="g">ResourceServicePrincipalId</span> | <span class="r">N/A</span> |
| | <span class="g">ResultDescription</span> | <span class="g">ResultDescription</span> | <span class="r">N/A</span> |
| | <span class="g">ResultSignature</span> | <span class="g">ResultSignature</span> | <span class="r">N/A</span> |
| | <span class="g">ResultType</span> | <span class="g">ResultType</span> | <span class="g">ErrorCode</span> |
| **Sign-in identifiers** | | | |
| | <span class="g">CorrelationId</span> | <span class="g">CorrelationId</span> | <span class="g">CorrelationId</span> |
| | <span class="g">Id</span> | <span class="g">Id</span> | <span class="g">RequestId</span> |
| | <span class="g">SessionId</span> | <span class="y">SessionId</span> | <span class="g">SessionId*</span> |
| | <span class="g">UniqueTokenIdentifier</span> | <span class="g">UniqueTokenIdentifier</span> | <span class="r">N/A</span> |
| **Agent details** | | | |
| | <span class="g">Agent</span> | <span class="g">Agent</span> | <span class="r">N/A</span> |
| **App or Workload Identity Details** | | | |
| | <span class="g">ClientCredentialType</span> | <span class="g">ClientCredentialType</span> | <span class="r">N/A</span> |
| | <span class="g">FederatedCredentialId</span> | <span class="g">FederatedCredentialId</span> | <span class="r">N/A</span> |
| | <span class="r">N/A</span> | <span class="y">ManagedServiceIdentity</span> | <span class="r">N/A</span> |
| | <span class="g">ServicePrincipalCredentialKeyId</span> | <span class="g">ServicePrincipalCredentialKeyId</span> | <span class="r">N/A</span> |
| | <span class="g">ServicePrincipalCredentialThumbprint</span> | <span class="g">ServicePrincipalCredentialThumbprint</span> | <span class="r">N/A</span> |
| | <span class="r">N/A</span> | <span class="r">N/A</span> | <span class="g">Application</span> |
| | <span class="y">Identity</span> | <span class="y">Identity</span> | <span class="r">N/A</span> |
| | <span class="g">ServicePrincipalName</span> | <span class="g">ServicePrincipalName</span> | <span class="g">ServicePrincipalName</span> |
| | <span class="g">ServicePrincipalId</span> | <span class="g">ServicePrincipalId</span> | <span class="g">ServicePrincipalId</span> |
| **Client Details** | | | |
| | <span class="g">UserAgent</span> | <span class="y">UserAgent</span> | <span class="g">UserAgent*</span> |
| | <span class="r">N/A</span> | <span class="y">SourceAppClientId</span> | <span class="r">N/A</span> |
| **Conditional Access** | | | |
| | <span class="g">ConditionalAccessPolicies</span> | <span class="g">ConditionalAccessPolicies</span> | <span class="r">N/A</span> |
| | <span class="y">ConditionalAccessPoliciesV2</span> | <span class="y">ConditionalAccessPoliciesV2</span> | <span class="r">N/A</span> |
| | <span class="g">ConditionalAccessStatus</span> | <span class="g">ConditionalAccessStatus</span> | <span class="r">N/A</span> |
| **Location** | | | |
| | <span class="g">Location</span> | <span class="y">Location</span> | <span class="g">Country</span> |
| | <span class="g">LocationDetails</span> | <span class="y">LocationDetails</span> | <span class="g">City*</span> |
| | <span class="g"></span> | <span class="y"></span> | <span class="g">Latitude*</span> |
| | <span class="g"></span> | <span class="y"></span> | <span class="g">Longitude*</span> |
| | <span class="g"></span> | <span class="y"></span> | <span class="g">State*</span> |
| **Network** | | | |
| | <span class="y">AutonomousSystemNumber</span> | <span class="r">N/A</span> | <span class="r">N/A</span> |
| | <span class="g">IPAddress</span> | <span class="y">IPAddress</span> | <span class="g">IPAddress*</span> |
| | <span class="g">NetworkLocationDetails</span> | <span class="y">NetworkLocationDetails</span> | <span class="r">N/A</span> |
| **Logging detail** | | | |
| | <span class="g">Category</span> | <span class="g">Category</span> | <span class="r">N/A</span> |
| | <span class="y">Level</span> | <span class="y">Level</span> | <span class="r">N/A</span> |
| | <span class="g">OperationName</span> | <span class="g">OperationName</span> | <span class="r">N/A</span> |
| | <span class="g">OperationVersion</span> | <span class="g">OperationVersion</span> | <span class="r">N/A</span> |
| | <span class="r">N/A</span> | <span class="r">N/A</span> | <span class="g">ReportId</span> |
| | <span class="g">ResourceGroup</span> | <span class="g">ResourceGroup</span> | <span class="r">N/A</span> |
| | <span class="g">SourceSystem</span> | <span class="g">SourceSystem</span> | <span class="y">SourceSystem</span> |
| | <span class="g">TenantId (= WorkspaceId)</span> | <span class="g">TenantId (= WorkspaceId)</span> | <span class="y">TenantId</span> |
| | <span class="g">Type</span> | <span class="g">Type</span> | <span class="g">Type</span> |
| **Telemetry** | | | |
| | <span class="g">DurationMs</span> | <span class="g">DurationMs</span> | <span class="r">N/A</span> |
| | | | |
| * only available for Service Principals | | | |
| | | | |
| **color legend**  | | | 
| | <span class="g">Available</span> | | 
| | <span class="y">Exists in schema but empty value</span> | | 
| | <span class="r">Not available</span> | | 