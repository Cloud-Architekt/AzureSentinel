# SignInEvents

<style>
/* Define styles for the spans to simulate cell background */
span.g, span.r, span.y { display: block; padding: 5px; margin: -5px; }
span.g { color: #000000; background-color: #C5FFC4; } /* Green - Available */
span.r { color: #000000; background-color: #FFB8B1; } /* Red - Not available */
span.y { color: #000000; background-color: #EBFFC4; } /* Yellow - Empty value */
</style>

| Category | [SigninLogs](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/SigninLogs), [AADNonInteractiveUserSignInLogs](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/AADNonInteractiveUserSignInLogs)<br>(Entra Diagnostic) | [EntraIdSignInEvents](https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-entraidsigninevents-table)<br>(XDR Advanced Hunting) |
| :--- | :--- | :--- |
| **General** | | |
| Billable | Yes | No |
| Retention | 90 days (default) up to 2 years | 30 days (fixed) |
| **Timestamp** | | |
| | <span class="g">TimeGenerated</span> | <span class="g">TimeGenerated</span> |
| | <span class="g">CreatedDateTime</span> | <span class="g">Timestamp</span> |
| **Authentication** | | |
| | <span class="g">AuthenticationAppDeviceDetails</span> | <span class="r">N/A</span> |
| | <span class="g">AuthenticationAppPolicyEvaluationDetails</span> | <span class="r">N/A</span> |
| | <span class="g">AuthenticationContextClassReferences</span> | <span class="r">N/A</span> |
| | <span class="g">AuthenticationDetails</span> | <span class="r">N/A</span> |
| | <span class="g">AuthenticationMethodsUsed</span> | <span class="r">N/A</span> |
| | <span class="g">AuthenticationProcessingDetails</span> | <span class="g">AuthenticationProcessingDetails</span> |
| | <span class="g">AuthenticationProtocol</span> | <span class="r">N/A</span> |
| | <span class="g">AuthenticationRequirement</span> | <span class="g">AuthenticationRequirement</span> |
| | <span class="g">AuthenticationRequirementPolicies</span> | <span class="r">N/A</span> |
| | <span class="g">CrossTenantAccessType</span> | <span class="r">N/A</span> |
| **Sign-in**| | |
| | <span class="g">AADTenantId</span> | <span class="r">N/A</span> |
| | <span class="g">AppId</span> | <span class="g">ApplicationId</span> |
| | <span class="g">AppDisplayName</span> | <span class="g">Application</span> |
| | <span class="g">AppOwnerTenantId</span> | <span class="r">N/A</span> |
| | <span class="r">N/A</span> | <span class="g">EndpointCall</span> |
| | <span class="r">N/A</span> | <span class="g">GatewayJA4</span> |
| | <span class="g">IncomingTokenType</span> | <span class="r">N/A</span> |
| | <span class="g">IsInteractive</span> | <span class="g">LogonType</span> |
| | <span class="g">MfaDetail</span> | <span class="r">N/A</span> |
| | <span class="g">Resource</span> | <span class="r">N/A</span> |
| | <span class="g">ResourceDisplayName</span> | <span class="g">ResourceDisplayName</span> |
| | <span class="g">ResourceId</span> | <span class="g">ResourceId</span> |
| | <span class="g">ResourceIdentity</span> | <span class="r">N/A</span> |
| | <span class="g">ResourceOwnerTenantId</span> | <span class="r">N/A</span> |
| | <span class="g">ResourceProvider</span> | <span class="r">N/A</span> |
| | <span class="g">ResourceServicePrincipalId</span> | <span class="r">N/A</span> |
| | <span class="g">ResourceTenantId</span> | <span class="g">ResourceTenantId</span> |
| | <span class="g">ResultDescription</span> | <span class="r">N/A</span> |
| | <span class="g">ResultSignature</span> | <span class="r">N/A</span> |
| | <span class="g">ResultType</span> | <span class="g">ErrorCode</span> |
| | <span class="g">Status</span> | <span class="r">N/A</span> |
| **Sign-in identifiers** | | |
| | <span class="g">CorrelationId</span> | <span class="g">CorrelationId</span> |
| | <span class="g">Id; OriginalRequestId</span> | <span class="g">RequestId</span> |
| | <span class="g">SessionId</span> | <span class="g">SessionId</span> |
| | <span class="g">SignInIdentifier</span> | <span class="r">N/A</span> |
| | <span class="g">SignInIdentifierType</span> | <span class="r">N/A</span> |
| | <span class="g">UniqueTokenIdentifier</span> | <span class="r">N/A</span> |
| **Agent details**| | |
| | <span class="g">Agent</span> | <span class="r">N/A</span> |
| **App or Workload Identity Details** | | |
| | <span class="g">AppliedEventListeners</span> | <span class="r">N/A</span> |
| | <span class="g">ClientCredentialType</span> | <span class="r">N/A</span> |
| | <span class="g">FederatedCredentialId</span> | <span class="r">N/A</span> |
| | <span class="g">ServicePrincipalId</span> | <span class="r">N/A</span> |
| | <span class="g">ServicePrincipalName</span> | <span class="r">N/A</span> |
| **User Details** | | |
| | <span class="g">AlternateSignInName</span> | <span class="g">AlternateSignInName</span> |
| | <span class="g">HomeTenantId</span> | <span class="r">N/A</span> |
| | <span class="y">HomeTenantName</span> | <span class="r">N/A</span> |
| | <span class="g">LastPasswordChangeTimestamp</span> | <span class="r">N/A</span> |
| | <span class="g">Identity</span> | <span class="r">N/A</span> |
| | <span class="g">UserDisplayName</span> | <span class="g">AccountDisplayName</span> |
| | <span class="g">UserId</span> | <span class="g">AccountObjectId</span> |
| | <span class="g">UserPrincipalName</span> | <span class="g">AccountUpn</span> |
| | <span class="g">UserType</span> | <span class="g">IsExternalUser</span> |
| | <span class="r">N/A</span> | <span class="g">IsGuestUser</span> |
| **Client Details** | | |
| | <span class="g">ClientAppUsed</span> | <span class="g">ClientAppUsed</span> |
| | <span class="g">SourceAppClientId</span> | <span class="r">N/A</span> |
| | <span class="g">UserAgent</span> | <span class="g">UserAgent</span> |
| **Conditional Access** | | |
| | <span class="g">AppliedConditionalAccessPolicies</span> | <span class="r">N/A</span> |
| | <span class="g">ConditionalAccessPolicies</span> | <span class="g">ConditionalAccessPolicies</span> |
| | <span class="r">N/A</span> | <span class="y">ConditionalAccessPoliciesV2</span> |
| | <span class="g">ConditionalAccessStatus</span> | <span class="g">ConditionalAccessStatus</span> |
| **Device** | | |
| | <span class="g">DeviceDetail</span> | <span class="g">Browser</span> |
| | <span class="g"></span> | <span class="g">DeviceName</span> |
| | <span class="g"></span> | <span class="g">DeviceTrustType</span> |
| | <span class="g"></span> | <span class="g">EntraIdDeviceId</span> |
| | <span class="g"></span> | <span class="g">IsCompliant</span> |
| | <span class="g"></span> | <span class="g">IsManaged</span> |
| | <span class="g"></span> | <span class="g">OSPlatform</span> |
| **Location** | | |
| | <span class="g">Location</span> | <span class="g">Country</span> |
| | <span class="g">LocationDetails</span> | <span class="g">City</span> |
| | <span class="g"></span> | <span class="g">Latitude</span> |
| | <span class="g"></span> | <span class="g">Longitude</span> |
| | <span class="g"></span> | <span class="g">State</span> |
| **Network** | | |
| | <span class="g">AutonomousSystemNumber</span> | <span class="r">N/A</span> |
| | <span class="g">GlobalSecureAccessIpAddress</span> | <span class="r">N/A</span> |
| | <span class="g">IPAddress</span> | <span class="g">IPAddress</span> |
| | <span class="g">IPAddressFromResourceProvider</span> | <span class="r">N/A</span> |
| | <span class="g">IsThroughGlobalSecureAccess</span> | <span class="r">N/A</span> |
| | <span class="g">NetworkLocationDetails</span> | <span class="g">NetworkLocationDetails</span> |
| **Security and risk details** | | |
| | <span class="g">FlaggedForReview</span> | <span class="r">N/A</span> |
| | <span class="g">IsRisky</span> | <span class="r">N/A</span> |
| | <span class="g">IsTenantRestricted</span> | <span class="r">N/A</span> |
| | <span class="g">RiskDetail</span> | <span class="r">N/A</span> |
| | <span class="g">RiskEventTypes</span> | <span class="g">RiskEventTypes</span> |
| | <span class="g">RiskEventTypes_V2</span> | <span class="r">N/A</span> |
| | <span class="g">RiskLevel</span> | <span class="r">N/A</span> |
| | <span class="g">RiskLevelAggregated</span> | <span class="g">RiskLevelAggregated</span> |
| | <span class="g">RiskLevelDuringSignIn</span> | <span class="g">RiskLevelDuringSignIn</span> |
| | <span class="g">RiskState</span> | <span class="g">RiskState</span> |
| **Token and Session** | | |
| | <span class="g">IncomingTokenType</span> | <span class="r">N/A</span> |
| | <span class="g">SessionLifetimePolicies</span> | <span class="r">N/A</span> |
| | <span class="g">OriginalTransferMethod</span> | <span class="r">N/A</span> |
| | <span class="g">TokenIssuerName</span> | <span class="r">N/A</span> |
| | <span class="g">TokenIssuerType</span> | <span class="g">TokenIssuerType</span> |
| | <span class="g">TokenProtectionStatusDetails</span> | <span class="r">N/A</span> |
| **Logging detail** | | |
| | <span class="g">Category</span> | <span class="r">N/A</span> |
| | <span class="y">Level</span> | <span class="r">N/A</span> |
| | <span class="g">OperationName</span> | <span class="r">N/A</span> |
| | <span class="g">OperationVersion</span> | <span class="r">N/A</span> |
| | <span class="r">N/A</span> | <span class="g">ReportId</span> |
| | <span class="g">ResourceGroup</span> | <span class="r">N/A</span> |
| | <span class="g">SourceSystem</span> | <span class="y">SourceSystem</span> |
| | <span class="g">TenantId (= WorkspaceId)</span> | <span class="r">N/A</span> |
| | <span class="g">Type</span> | <span class="g">Type</span> |
| **Telemetry** | | |
| | <span class="g">DurationMs</span> | <span class="r">N/A</span> |
| | <span class="g">ProcessingTimeInMilliseconds</span> | <span class="r">N/A</span> |
| | | |
<br/>
| **color legend**  | | | 
| | <span class="g">Available</span> | | 
| | <span class="y">Exists in schema but empty value</span> | | 
| | <span class="r">Not available</span> | | 