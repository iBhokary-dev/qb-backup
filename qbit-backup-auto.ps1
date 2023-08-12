$sourceFolders = @(
    [System.Environment]::ExpandEnvironmentVariables("%appdata%\qBittorrent"),
    [System.Environment]::ExpandEnvironmentVariables("%localappdata%\qBittorrent")
)

$parentDestinationFolder = "C:\Users\lucas\Downloads\qbit-backup-path"

# Create the parent destination folder if it doesn't exist
if (-not (Test-Path -Path $parentDestinationFolder)) {
    New-Item -Path $parentDestinationFolder -ItemType Directory
}

$destinationSubfolders = @("qBittorrent_AppData", "qBittorrent_LocalAppData")

for ($i = 0; $i -lt $sourceFolders.Length; $i++) {
    $sourceFolder = $sourceFolders[$i]
    $destinationSubfolder = $destinationSubfolders[$i]
    
    $destinationPath = Join-Path -Path $parentDestinationFolder -ChildPath $destinationSubfolder
    
    # Create the destination subfolder if it doesn't exist
    if (-not (Test-Path -Path $destinationPath)) {
        New-Item -Path $destinationPath -ItemType Directory
    }
    
    # Copy the contents of the source folder to the destination subfolder
    Copy-Item -Path $sourceFolder\* -Destination $destinationPath -Recurse -Force
    
    Write-Host "Archives copied from $sourceFolder to $destinationPath"
}

Write-Host "All archives copied successfully to their respective subfolders under $parentDestinationFolder"
