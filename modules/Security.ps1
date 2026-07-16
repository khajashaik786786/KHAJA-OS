function Show-Security {

    Show-KhHeader "KHAJA SECURITY CENTER"

    Start-KhAnimation @(
        "Checking Windows Defender",
        "Checking Firewall",
        "Checking Secure Boot",
        "Checking Administrator",
        "Building Security Report"
    )

    # -------------------------------------------------
    # Windows Defender
    # -------------------------------------------------

    try {

        $Defender = Get-MpComputerStatus

        if ($Defender.AntivirusEnabled) {
            Show-OK "Windows Defender : Enabled"
        }
        else {
            Show-Fail "Windows Defender : Disabled"
        }

    }
    catch {

        Show-Warn "Windows Defender : Unknown"

    }

    # -------------------------------------------------
    # Windows Firewall
    # -------------------------------------------------

    try {

        $Firewall = Get-NetFirewallProfile

        if ($Firewall.Enabled -contains $true) {
            Show-OK "Firewall          : Enabled"
        }
        else {
            Show-Fail "Firewall          : Disabled"
        }

    }
    catch {

        Show-Warn "Firewall          : Unknown"

    }

    # -------------------------------------------------
    # Secure Boot
    # -------------------------------------------------

    try {

        $SecureBoot = Confirm-SecureBootUEFI

        if ($SecureBoot) {
            Show-OK "Secure Boot       : Enabled"
        }
        else {
            Show-Warn "Secure Boot       : Disabled"
        }

    }
    catch {

        Show-Warn "Secure Boot       : Unable to Determine"

    }

    # -------------------------------------------------
    # Administrator
    # -------------------------------------------------

    try {

        $Identity  = [Security.Principal.WindowsIdentity]::GetCurrent()
        $Principal = New-Object Security.Principal.WindowsPrincipal($Identity)

        if ($Principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

            Show-OK "Administrator     : Yes"

        }
        else {

            Show-Warn "Administrator     : No"

        }

    }
    catch {

        Show-Warn "Administrator     : Unknown"

    }

    # -------------------------------------------------
    # Public IP
    # -------------------------------------------------

    try {

        $IPFile = Join-Path $PSScriptRoot "..\Cache\ip.json"

        if (Test-Path $IPFile) {

            $IP = Get-Content $IPFile -Raw | ConvertFrom-Json

            Write-Host ""
            Write-Host "Public IP         : " -NoNewline
            Write-Host $IP.ip -ForegroundColor Cyan

        }
        else {

            Show-Warn "Public IP         : Cache Missing"

        }

    }
    catch {

        Show-Warn "Public IP         : Unknown"

    }

    Show-KhFooter

}