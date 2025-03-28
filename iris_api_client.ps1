# IRIS API Client PowerShell Script
# Usage: .\iris_api_client.ps1 [-Output filename.md] [-Pretty]

param (
    [string]$Output = "iris_cases.md",
    [switch]$Pretty
)

$url = "https://iris.westeros.cpt/manage/cases/list?cid=1"
$token = "Y9hT6f60qEMnFxmyLzZBI0YidRIEiEa_tKiy8ADrYb2rFvhcS9GwBApRXMQuuHVLFq_p2gnU62vAD_Uy2JsLjA"

if ($Pretty) {
    python iris_api_client.py --url $url --token $token --pretty
} else {
    python iris_api_client.py --url $url --token $token --output $Output
}
