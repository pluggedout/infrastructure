
# Convenience Docker image bringing the power of jq to PowerShell.

```powershell
# Function: Invoke-Jq
# This function allows you to use jq within PowerShell by running it inside a Docker container.
function Invoke-Jq {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Filter,

        [Parameter(Mandatory=$true)]
        [string]$Json
    )

    # Run jq inside your custom Docker container
    echo $Json | docker run --rm -i jq-alpine $Filter
}

# Steps to set up and use Invoke-Jq in PowerShell:

# 1. Pull the jq Docker image:
docker pull pluggedout/jq-alpine:latest

# 2. Pull the cwe-lookup Docker image to retrieve CWE data:
docker pull pluggedout/cwe-lookup:latest

# 3. Load (dot-source) the Invoke-Jq function into your PowerShell session:
. .\Invoke-Jq.ps1

# You can now use jq in PowerShell without needing WSL.

# Example usage:
# Capture the JSON output from the cwe-lookup Docker container and pass it to Invoke-Jq for processing.
# This example retrieves and filters data related to CWE-362.

# Pull the CWE data and filter the JSON for Detection Methods and their Effectiveness
$jsonData = $(docker run --rm pluggedout/cwe-lookup:latest 362 | Out-String).Trim()
Invoke-Jq -Filter '.Weaknesses[0].DetectionMethods | map({Method, Effectiveness})' -Json $jsonData

# Additional usage example:
# Invoke-Jq -Filter '.address | {city, zip}' -Json '{ "name": "Alice", "age": 30, "address": { "city": "Wonderland", "zip": "12345" }, "interests": ["reading", "gardening"] }'

```
