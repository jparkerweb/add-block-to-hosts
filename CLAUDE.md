# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Windows PowerShell script that blocks addresses by adding entries to the Windows hosts file. The script automatically elevates to administrator privileges, validates input, creates optional backups, and flushes the DNS cache.

## How to Run

Execute the main script:
```powershell
.\add-block-to-hosts.ps1
```

The script will automatically request administrator privileges if not already running as admin.

## Architecture

- **Single PowerShell script**: `add-block-to-hosts.ps1` contains all functionality
- **Administrator elevation**: Uses `Start-Process` with `-Verb RunAs` to elevate privileges
- **Hosts file manipulation**: Directly modifies `C:\Windows\System32\drivers\etc\hosts`
- **DNS cache management**: Uses `ipconfig /flushdns` to clear DNS cache after modification

## Key Components

- **Privilege checking**: Uses `WindowsPrincipal` and `WindowsIdentity` to verify admin rights
- **Input validation**: Trims whitespace and checks for empty input
- **Duplicate detection**: Uses regex matching to prevent duplicate entries
- **Backup system**: Optional timestamped backup creation before modification
- **Error handling**: Try-catch blocks for file operations and DNS flushing