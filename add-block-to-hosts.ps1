# Check if running as administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "This script requires administrator privileges. Attempting to relaunch as Administrator..." -ForegroundColor Yellow
    try {
        $scriptPath = $MyInvocation.MyCommand.Path
        Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
        exit 0
    } catch {
        Write-Host "Failed to relaunch as Administrator: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "Please manually run PowerShell as Administrator and try again." -ForegroundColor Red
        Write-Host "Press any key to exit..."
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        exit 1
    }
}

# Get address from user
$address = Read-Host "Enter the address to block"

# Validate input
if ([string]::IsNullOrWhiteSpace($address)) {
    Write-Host "No address provided. Exiting." -ForegroundColor Red
    exit 1
}

# Trim whitespace
$address = $address.Trim()

# Path to hosts file
$hostsPath = "C:\Windows\System32\drivers\etc\hosts"

# Check if hosts file exists
if (-not (Test-Path $hostsPath)) {
    Write-Host "Hosts file not found at $hostsPath" -ForegroundColor Red
    exit 1
}

# Ask user if they want to create a backup
$createBackup = Read-Host "Create backup of hosts file? (y/N)"
if ($createBackup -eq "y" -or $createBackup -eq "Y") {
    $backupPath = "$hostsPath.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    try {
        Copy-Item $hostsPath $backupPath -Force
        Write-Host "Backup created: $backupPath" -ForegroundColor Green
    } catch {
        Write-Host "Failed to create backup: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Skipping backup creation." -ForegroundColor Yellow
}

# Check if address already exists in hosts file
$hostsContent = Get-Content $hostsPath
$entryExists = $hostsContent | Where-Object { $_ -match "^\s*0\.0\.0\.0\s+$([regex]::Escape($address))\s*$" }

if ($entryExists) {
    Write-Host "Address '$address' is already blocked in hosts file." -ForegroundColor Yellow
    exit 0
}

# Add new entry to hosts file
$newEntry = "0.0.0.0 $address"
try {
    # Read the current content and ensure it ends with a newline
    $content = Get-Content $hostsPath -Raw
    if (-not $content.EndsWith("`r`n") -and -not $content.EndsWith("`n")) {
        $content += "`r`n"
    }
    # Add our entry on a new line
    $content += "$newEntry`r`n"
    # Write back to file
    Set-Content -Path $hostsPath -Value $content -Encoding ASCII -NoNewline
    Write-Host "Successfully added: $newEntry" -ForegroundColor Green
} catch {
    Write-Host "Failed to update hosts file: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Flush DNS cache
try {
    ipconfig /flushdns | Out-Null
    Write-Host "DNS cache flushed successfully." -ForegroundColor Green
} catch {
    Write-Host "Warning: Could not flush DNS cache." -ForegroundColor Yellow
}

Write-Host "Address '$address' has been blocked successfully." -ForegroundColor Green
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")