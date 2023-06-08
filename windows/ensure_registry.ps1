# Set the registry path
$registryPath = "HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate"

# Check if the registry key exists
if(!(Test-Path $registryPath))
{
    # Create the registry key if it doesn't exist
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry values
New-ItemProperty -Path $registryPath -Name "AUOptions" -Value 2 -PropertyType "DWord" -Force | Out-Null
New-ItemProperty -Path $registryPath -Name "UseWUServer" -Value 1 -PropertyType "DWord" -Force | Out-Null

# List of properties that should exist
$validProperties = "AUOptions","UseWUServer"

# Get all properties of the registry key
$properties = Get-ItemProperty -Path $registryPath

# Loop through the properties
foreach ($property in $properties.PSObject.Properties) {
    # Check if the property is not in the list of valid properties
    if ($property.Name -notin $validProperties) {
        # Remove the property
        Remove-ItemProperty -Path $registryPath -Name $property.Name
    }
}

Write-Output "Registry key and values created successfully. Other entries have been deleted."
