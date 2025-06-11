<#
.SYNOPSIS
Ingests Maester test results from a specified folder into a Log Analytics Custom Log Table using Azure Data Collection Rules.

.DESCRIPTION
This script reads test results from JSON files in a specified folder, processes the data, and ingests it into a Log Analytics Custom Log Table.
It uses Azure Data Collection Rules to direct the data to the appropriate Log Analytics workspace.
The script requires the AzAPICall module to be installed and configured with appropriate permissions to access Azure resources.
It's designed to be used in a CI/CD pipeline, such as GitHub Actions, to automate the ingestion of test results.

.PARAMETER ImportFolder
The folder containing the test results in JSON format. Default is "tests.results".

.PARAMETER TempFolder
The temporary folder where intermediate files will be stored. Default is "temp".

.PARAMETER DataCollectionRuleSubscriptionId
The subscription ID where the Data Collection Rule is located. This is required for the script to function.

.PARAMETER DataCollectionRuleResourceGroup
The resource group containing the Data Collection Rule. Default is "maester-rg".

.PARAMETER DataCollectionRuleName
The name of the Data Collection Rule to use for ingestion. Default is "maester-dcr".

.PARAMETER LogAnalyticsCustomLogTableName
The name of the Log Analytics Custom Log Table where the data will be ingested. Default is "Maester_CL".

.PARAMETER ThrottleLimitMonitor
The maximum number of parallel requests to the Azure Monitor ingestion endpoint. Default is 5.

.EXAMPLE
Run interactively in PowerShell to ingest test results:
.\ingest.ps1 -ImportFolder "path\to\results" -DataCollectionRuleSubscriptionId "your-subscription-id"

.EXAMPLE
Copy this line into the next step in a GitHub Actions workflow after Maester collects data to automate the ingestion of test results:
- name: Ingest Maester results
  uses: azure/powershell@v2
  with:
    inlineScript: |
      .\ingest.ps1 `
        -ImportFolder "test-results" `
        -DataCollectionRuleSubscriptionId "${{ secrets.AZURE_SUBSCRIPTION_ID }}" `
        -DataCollectionRuleResourceGroup "maester-rg" `
        -DataCollectionRuleName "maester-dcr" `
        -LogAnalyticsCustomLogTableName "Maester_CL"
    azPSVersion: "latest"

#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]$ImportFolder = "tests.results",

    [Parameter(Mandatory = $false)]
    [string]$TempFolder = "temp",

    [Parameter(Mandatory = $true)]
    [string]$DataCollectionRuleSubscriptionId,

    [Parameter(Mandatory = $false)]
    [string]$DataCollectionRuleResourceGroup = "maester-rg",

    [Parameter(Mandatory = $false)]
    [string]$DataCollectionRuleName = "maester-dcr",

    [Parameter(Mandatory = $false)]
    [string]$LogAnalyticsCustomLogTableName = "Maester_CL",

    [Parameter(Mandatory = $false)]
    [int]$ThrottleLimitMonitor = 5
)

Install-Module AzAPICall -Force
New-Item -Path $TempFolder -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null

Write-Host "Ingesting to Log Analytics Custom Log Table '$($LogAnalyticsCustomLogTableName)'"
Write-Host " DataCollectionRuleSubscriptionId '$($DataCollectionRuleSubscriptionId)'"
Write-Host " DataCollectionRuleResourceGroup '$($DataCollectionRuleResourceGroup)'"
Write-Host " DataCollectionRuleName: '$($DataCollectionRuleName)'"
Write-Host " LogAnalyticsCustomLogTableName: '$($LogAnalyticsCustomLogTableName)'"
Write-Host " ThrottleLimitMonitor: '$($ThrottleLimitMonitor)'"

$TestResultsJsonFile = (Get-ChildItem -Path $ImportFolder -Recurse -Filter "*.json" | Sort-Object -Property LastWriteTime -Descending | Select-Object -First 1).FullName
Write-Warning $TestResultsJsonFile

$TestResultsJSON = Get-Content -Path $TestResultsJsonFile | ConvertFrom-Json -Depth 10 
$TestResultsCleanJSON = $TestResultsJSON.tests | Select-Object -ExcludeProperty ErrorRecord, ScriptBlock, ScriptBlockFile, Duration
foreach ($TestResult in $TestResultsCleanJSON) { 

    $TestResultDetail = $TestResult.ResultDetail.TestResult 

    # Extract lines that are part of the markdown table
    $TestResultDetailMarkdown = $TestResultDetail -split "`n" | Where-Object { $_ -match '^\s*\|' }

    if ($TestResultDetailMarkdown.Count -ge 3) {
        # Extract headers
        $headers = ($TestResultDetailMarkdown[0] -split '\|').Trim() | Where-Object { $_ -ne "" }
        # Parse rows (skip header and separator)
        $rows = $TestResultDetailMarkdown[2..($tableLines.Count - 1)]
        # Convert each row to PSCustomObject
        $objects = foreach ($row in $rows) {
            $values = ($row -split '\|').Trim() | Where-Object { $_ -ne "" }
            $props = @{}
            for ($i = 0; $i -lt $headers.Count; $i++) {
                $props[$headers[$i]] = $values[$i]
            }
            [PSCustomObject]$props
        }
            $TestResult.ResultDetail | Add-Member -MemberType NoteProperty -Name 'TestResultTable' -Value $objects -Force
    } else {
        Write-Verbose "No markdown table found."
    }

    Write-Host $($TestResult.Id)
    $TestResult | ConvertTo-Json -Depth 10 | Out-File -FilePath "./temp/$($TestResult.Index).json" -Encoding utf8
}


# Get Maester JSON files
$MaesterJsonFiles = (Get-ChildItem -Path $TempFolder -Recurse -Filter '*.json').FullName
$MaesterJsonFilesCount = $MaesterJsonFiles.Count
Write-Host "Found $($MaesterJsonFilesCount) JSON files in directory '$($TempFolder)'"

if ($MaesterJsonFilesCount -eq 0) {
    Write-Host 'Nothing to do!?'
} else {
    $azAPICallConf = initAzAPICall

    $UTC = (Get-Date).ToUniversalTime()
    $logTimeGenerated = $UTC.ToString('o')
    $runId = $UTC.ToString('yyyyMMddHHmmss')
    Write-Host "RunId: $($runId)"

    $currentTask = "Get Data Collection Rule $($DataCollectionRuleName)"
    $uriDCR = "$($azAPICallConf['azAPIEndpointUrls'].ARM)/subscriptions/$($DataCollectionRuleSubscriptionId)/resourceGroups/$($DataCollectionRuleResourceGroup)/providers/Microsoft.Insights/dataCollectionRules/$($DataCollectionRuleName)?api-version=2022-06-01"
    $DCR = AzAPICall -AzAPICallConfiguration $azAPICallConf -uri $uriDCR -method 'Get' -listenOn Content -currentTask $currentTask

    $dataCollectionEndpointId = $DCR.properties.dataCollectionEndpointId
    $currentTask = "Get Data Collection Endpoint $($dataCollectionEndpointId)"
    $uriDCE = "$($azAPICallConf['azAPIEndpointUrls'].ARM)$($dataCollectionEndpointId)?api-version=2022-06-01"
    $dceResourceJson = AzAPICall -AzAPICallConfiguration $azAPICallConf -uri $uriDCE -method 'Get' -listenOn Content -currentTask $currentTask
    $dceIngestEndpointUrl = $dceResourceJson.properties.logsIngestion.endpoint

    $postUri = "$dceIngestEndpointUrl/dataCollectionRules/$($DCR.properties.immutableId)/streams/Custom-$($LogAnalyticsCustomLogTableName)?api-version=2023-01-01"

    createBearerToken -targetEndPoint 'MonitorIngest' -AzAPICallConfiguration $azAPICallConf

    $batchSize = [math]::ceiling($MaesterJsonFilesCount / $ThrottleLimitMonitor)
    Write-Host "Optimal batch size: $($batchSize)"
    $counterBatch = [PSCustomObject] @{ Value = 0 }
    $filesBatch = ($MaesterJsonFiles) | Group-Object -Property { [math]::Floor($counterBatch.Value++ / $batchSize) }
    Write-Host "Ingesting data in $($filesBatch.Count) batches"

    $filesBatch | ForEach-Object -Parallel {
        $logTimeGenerated = $using:logTimeGenerated
        $runId = $using:runId
        $postUri = $using:postUri
        $azAPICallConf = $using:azAPICallConf

        $filesProcessCounter = 0
        foreach ($jsonFilePath in $_.Group) {
            $filesProcessCounter++
            $jsonRaw = Get-Content -Path $jsonFilePath -Raw
            try {
                $jsonObject = $jsonRaw | ConvertFrom-Json
                $checkInfoObj = [ordered]@{
                    CheckType = $jsonObject.Block
                    CheckId = $jsonObject.Id
                }
                $checkInfoObj = ($checkInfoObj.Keys | ForEach-Object { "$($_)=$($checkInfoObj.($_))" }) -join ', '
                # Add TimeGenerated to JSON data
                $jsonObject | Add-Member -NotePropertyName TimeGenerated -NotePropertyValue $logTimeGenerated -Force
                $jsonObject | Add-Member -NotePropertyName RunId -NotePropertyValue $runId -Force
                $jsonRawAsArray = $jsonObject | ConvertTo-Json -AsArray -Compress -Depth 10
            }
            catch {
                Write-Error 'Cannot convert jsonRaw content to jsonObject'
                throw $_
            }

            $currentTask = "Batch#$($_.Name); Process file $($filesProcessCounter)/$($_.Count); Ingesting data for $($checkInfoObj)"
            Write-Host $currentTask
            AzAPICall -AzAPICallConfiguration $azAPICallConf -uri $postUri -method 'Post' -body $jsonRawAsArray -currentTask $currentTask
        }
    } -ThrottleLimit $ThrottleLimitMonitor

    Remove-Item -Path "$TempFolder\*" -Force -Recurse -ErrorAction SilentlyContinue
}
