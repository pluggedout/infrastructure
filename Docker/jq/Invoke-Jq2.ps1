function Invoke-Jq {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Filter,

        [Parameter(Mandatory = $true)]
        [string]$Json
    )

    # Check if Docker is running
    try {
        docker info | Out-Null
    } catch {
        Write-Error "Docker is not running. Please start Docker."
        return
    }

    # Check if the Docker image exists locally; if not, pull it
    try {
        docker image inspect pluggedout/jq-alpine | Out-Null
    } catch {
        Write-Host "Docker image 'pluggedout/jq-alpine' not found locally. Pulling the image..."
        docker pull pluggedout/jq-alpine | Out-Null
    }

    # Run jq inside the Docker container with improved JSON handling for special characters
    $ProcessInfo = New-Object System.Diagnostics.ProcessStartInfo
    $ProcessInfo.FileName = "docker"
    $ProcessInfo.Arguments = "run --rm -i pluggedout/jq-alpine $Filter"
    $ProcessInfo.RedirectStandardInput = $true
    $ProcessInfo.RedirectStandardOutput = $true
    $ProcessInfo.UseShellExecute = $false
    $ProcessInfo.CreateNoWindow = $true

    $Process = New-Object System.Diagnostics.Process
    $Process.StartInfo = $ProcessInfo
    $Process.Start() | Out-Null

    $Process.StandardInput.Write($Json)
    $Process.StandardInput.Close()

    $Result = $Process.StandardOutput.ReadToEnd()
    $Process.WaitForExit()

    Write-Output $Result
}
