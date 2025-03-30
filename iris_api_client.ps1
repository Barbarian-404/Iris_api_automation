# IRIS API Client PowerShell Script
# Usage: .\iris_api_client.ps1 [-Output filename.md] [-Pretty]

param (
    [string]$Output = "iris_cases.md",
    [switch]$Pretty
)

$url = "https://yoururl.com"
$token = "YOU TOKEN"

if ($Pretty) {
    python iris_api_client.py --url $url --token $token --pretty
} else {
    python iris_api_client.py --url $url --token $token --output $Output
}
