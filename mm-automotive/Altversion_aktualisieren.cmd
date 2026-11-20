@echo off
setlocal
set "MM_SCRIPT=%~f0"
powershell.exe -NoProfile -Command "$s=[IO.File]::ReadAllText($env:MM_SCRIPT); & ([scriptblock]::Create($s.Substring($s.LastIndexOf('#!POWERSHELL')+12)))"
if errorlevel 1 (echo Aktualisierung fehlgeschlagen. & pause & exit /b 1)
exit /b 0
#!POWERSHELL
$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$folder = Join-Path ([Environment]::GetFolderPath('UserProfile')) 'M_M_Automotive_DXF_LCC'
$settings = Join-Path $folder 'update_settings.json'
$target = Join-Path $folder 'Updates'
if (Test-Path -LiteralPath $settings) {
    $configured = (Get-Content -LiteralPath $settings -Raw -Encoding UTF8 | ConvertFrom-Json).source_folder
    if ($configured) { $target = $configured }
}
$null = [IO.Directory]::CreateDirectory($target)
$package = 'MM_Automotive_Windows_9.10.142.zip'
$url = 'https://github.com/maikbrehmer89-droid/Maik-Software-Freigaben/releases/download/mm-automotive-v9.10.142/' + $package
$temp = Join-Path $target ([Guid]::NewGuid().ToString() + '.download')
$dest = Join-Path $target $package
$expected = 'b734c4f1020aaec172d9d9ed4e5fcc562c6cffcee79458344fb50c7bdcc532cd'
try {
    if (!(Test-Path -LiteralPath $dest)) {
        Write-Host 'M&M Automotive 9.10.142 wird von GitHub geladen ...'
        $client = New-Object Net.WebClient
        try { $client.DownloadFile($url, $temp) } finally { $client.Dispose() }
        if ((Get-FileHash -LiteralPath $temp).Hash -ne $expected) { throw 'Die Paketpruefung ist fehlgeschlagen.' }
        [IO.File]::Move($temp, $dest)
    }
    if ((Get-FileHash -LiteralPath $dest).Hash -ne $expected) { throw 'Vorhandene Datei weicht vom freigegebenen Paket ab.' }
    Write-Host 'Paket geprueft. In M&M Automotive: Update-Center > Ordner pruefen > Installation bestaetigen.'
    if (!$env:CI) { Read-Host 'Eingabetaste zum Schliessen' }
} finally {
    if ([IO.File]::Exists($temp)) { [IO.File]::Delete($temp) }
}
