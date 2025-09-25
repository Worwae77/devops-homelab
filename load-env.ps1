# Load environment variables from .envrc
Get-Content .envrc | ForEach-Object {
    if ($_ -match '^set\s+(\w+)=(.*)$') {
        $varName = $Matches[1]
        $varValue = $Matches[2]
        [Environment]::SetEnvironmentVariable($varName, $varValue, [System.EnvironmentVariableTarget]::Process)
        Write-Host "Set $varName environment variable"
    }
}

# Verify AWS environment variables
Get-ChildItem Env: | Where-Object { $_.Name -like "AWS_*" } | Format-Table -AutoSize