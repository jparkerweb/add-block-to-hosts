# 🚫 add-block-to-hosts

A PowerShell script to block websites and domains by adding entries to your Windows hosts file.

## What it does

This script allows you to quickly block access to specific websites or domains by redirecting them to `0.0.0.0` in your Windows hosts file. Perfect for blocking distracting websites, malicious domains, or testing purposes.

## Features

- ✅ Automatic administrator privilege elevation
- ✅ Input validation and duplicate detection
- ✅ Optional backup creation with timestamps
- ✅ DNS cache flushing after modification
- ✅ User-friendly prompts and colored output
- ✅ Error handling for common issues

## Usage

1. Run the script:
   ```powershell
   .\add-block-to-hosts.ps1
   ```

2. The script will automatically request administrator privileges if needed

3. Enter the address you want to block when prompted:
   ```
   Enter the address to block: example.com
   ```

4. Choose whether to create a backup of your hosts file:
   ```
   Create backup of hosts file? (y/N): y
   ```

5. The script will add the entry and flush your DNS cache

## Requirements

- Windows operating system
- PowerShell (any version)
- Administrator privileges (automatically requested)

## What gets added

The script adds entries in this format to your hosts file:
```
0.0.0.0 example.com
```

This redirects any requests to the specified domain to the null route (0.0.0.0), effectively blocking access.

## Safety features

- **Duplicate prevention**: Checks if the address is already blocked
- **Backup option**: Create timestamped backups before making changes
- **Input validation**: Ensures valid input before processing
- **Error handling**: Graceful handling of permission and file access issues

## Unblocking addresses

To unblock an address, manually edit the hosts file at:
```
C:\Windows\System32\drivers\etc\hosts
```

Remove the line containing the blocked address, or restore from a backup created by this script.
