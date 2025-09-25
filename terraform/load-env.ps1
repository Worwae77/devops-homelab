# Load environment variables from .env file
function Load-EnvFile {
    $envFile = ".\.env"
    if (Test-Path $envFile) {
        Get-Content $envFile | ForEach-Object {
            if ($_ -match '^\s*([^#].*?)=(.*)$') {
                $key = $Matches[1].Trim()
                $value = $Matches[2].Trim()
                [System.Environment]::SetEnvironmentVariable($key, $value, [System.EnvironmentVariableTarget]::Process)
                Write-Host "Loaded $key environment variable"
            }
        }
    } else {
        Write-Host "No .env file found at $envFile"
    }
}

# Execute the function
Load-EnvFile