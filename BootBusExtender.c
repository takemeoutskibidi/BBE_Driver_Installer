#include <ntddk.h>

VOID DriverUnload(PDRIVER_OBJECT DriverObject)
{
    DbgPrint("BootBusExtender: Unloaded.\n");
}

NTSTATUS DriverEntry(PDRIVER_OBJECT DriverObject, PUNICODE_STRING RegistryPath)
{
    UNREFERENCED_PARAMETER(RegistryPath);
    
    DriverObject->DriverUnload = DriverUnload;

    DbgPrint("BootBusExtender: Hello, world! Loaded at boot stage.\n");

    return STATUS_SUCCESS;
}
