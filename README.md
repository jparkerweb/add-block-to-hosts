# 🚫 add-block-to-hosts
A PowerShell script to block websites and domains by adding entries to your Windows hosts file.

<img src="./.readme/add-block-to-hosts.jpg" alt="add-block-to-hosts" style="max-width: 600px;">

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

## Bonus: Network Traffic Analysis with Fiddler

This repository includes `FiddlerSetup.5.0.20253.3311-latest.zip` - a network traffic analyzer that can help you discover addresses you might want to block.

### What is Fiddler?

Fiddler is a web debugging proxy that logs all HTTP(S) traffic between your computer and the internet. It's useful for:
- Identifying unwanted network requests from applications
- Discovering tracking domains and analytics endpoints
- Finding advertising networks to block
- Analyzing what websites your browser or applications connect to

### Using Fiddler to find addresses to block

1. Install Fiddler from the included zip file
2. Run Fiddler and start capturing traffic
3. Use your computer normally or visit websites
4. Review the captured requests to identify unwanted domains
5. Use those domain names with this blocking script

### Important note

**Fiddler is completely optional** - you don't need it to use the blocking script. It's simply a helpful tool for discovering what addresses you might want to block. The PowerShell script works independently and only requires the domain/address you want to block.
