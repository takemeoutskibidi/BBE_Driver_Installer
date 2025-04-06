@echo off
echo Installing Boot Bus Extender Driver...

:: Install the driver
pnputil /add-driver C:\Path\To\BootBusExtender.inf /install

:: Set the driver to start at boot (BOOT_START)
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BootBusExtender" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BootBusExtender" /v Type /t REG_DWORD /d 1 /f

:: Enable Kernel Debugging for DbgPrint to work
bcdedit /set debug on

:: Reboot to apply the changes
shutdown /r /t 0
