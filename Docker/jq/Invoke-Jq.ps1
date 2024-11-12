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
