$ErrorActionPreference = "Stop"

# Ensure this script is running as Admin
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole('Administrator')) {
    Write-Host "Please run this script as Administrator." -ForegroundColor Red
    exit 1
}

Write-Host "Boot Bus Extender - Automated Installation Script" -ForegroundColor Cyan

# Paths to files
$driverSourcePath = "C:\Path\To\BootBusExtender.sys"
$infFilePath      = "C:\Path\To\BootBusExtender.inf"
$driverDestination = "C:\Windows\System32\drivers\BootBusExtender.sys"

# Step 1: Build Driver using Visual Studio (assuming you have a build environment set up)
Write-Host "Building driver using Visual Studio..." -ForegroundColor Green
Start-Process -FilePath "msbuild" -ArgumentList "BootBusExtender.sln" -Wait

# Step 2: Install the driver with pnputil
Write-Host "Installing driver using pnputil..." -ForegroundColor Green
pnputil /add-driver $infFilePath /install

# Step 3: Set driver to boot start (BootStart)
Write-Host "Setting driver to boot start in registry..." -ForegroundColor Green
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\BootBusExtender" -Name "Start" -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\BootBusExtender" -Name "Type" -Value 1 -PropertyType DWord -Force

# Step 4: Enable Kernel Debugging (if necessary for DbgPrint)
Write-Host "Enabling Kernel Debugging..." -ForegroundColor Green
bcdedit /set debug on

# Step 5: Reboot the system (so that the driver can be loaded)
Write-Host "Rebooting system to load the driver..." -ForegroundColor Green
Restart-Computer -Force

Write-Host "Driver installation complete! Boot Bus Extender driver is now running." -ForegroundColor Green
