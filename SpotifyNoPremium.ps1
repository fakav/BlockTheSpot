# Ignore errors from `Stop-Process`
$PSDefaultParameterValues['Stop-Process:ErrorAction'] = [System.Management.Automation.ActionPreference]::SilentlyContinue
function Get-File
{
  param (
    [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [System.Uri]
    $Uri,
    [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [System.IO.FileInfo]
    $TargetFile,
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [Int32]
    $BufferSize = 1,
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [ValidateSet('KB, MB')]
    [String]
    $BufferUnit = 'MB',
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [ValidateSet('KB, MB')]
    [Int32]
    $Timeout = 10000
  )

  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

  $useBitTransfer = $null -ne (Get-Module -Name BitsTransfer -ListAvailable) -and ($PSVersionTable.PSVersion.Major -le 5) -and ((Get-Service -Name BITS).StartType -ne [System.ServiceProcess.ServiceStartMode]::Disabled)

  if ($useBitTransfer)
  {
    Write-Information -MessageData 'Usando método alternativo.'
    Start-BitsTransfer -Source $Uri -Destination "$($TargetFile.FullName)"
  }
  else
  {
    $request = [System.Net.HttpWebRequest]::Create($Uri)
    $request.set_Timeout($Timeout) #15 second timeout
    $response = $request.GetResponse()
    $totalLength = [System.Math]::Floor($response.get_ContentLength() / 1024)
    $responseStream = $response.GetResponseStream()
    $targetStream = New-Object -TypeName ([System.IO.FileStream]) -ArgumentList "$($TargetFile.FullName)", Create
    switch ($BufferUnit)
    {
      'KB' { $BufferSize = $BufferSize * 1024 }
      'MB' { $BufferSize = $BufferSize * 1024 * 1024 }
      Default { $BufferSize = 1024 * 1024 }
    }
    Write-Verbose -Message "Buffer size: $BufferSize B ($($BufferSize/("1$BufferUnit")) $BufferUnit)"
    $buffer = New-Object byte[] $BufferSize
    $count = $responseStream.Read($buffer, 0, $buffer.length)
    $downloadedBytes = $count
    $downloadedFileName = $Uri -split '/' | Select-Object -Last 1
    while ($count -gt 0)
    {
      $targetStream.Write($buffer, 0, $count)
      $count = $responseStream.Read($buffer, 0, $buffer.length)
      $downloadedBytes = $downloadedBytes + $count
      Write-Progress -Activity "Downloading file '$downloadedFileName'" -Status "Downloaded ($([System.Math]::Floor($downloadedBytes/1024))K of $($totalLength)K): " -PercentComplete ((([System.Math]::Floor($downloadedBytes / 1024)) / $totalLength) * 100)
    }

    Write-Progress -Activity "Se ha descargado '$downloadedFileName'"

    $targetStream.Flush()
    $targetStream.Close()
    $targetStream.Dispose()
    $responseStream.Dispose()
  }
}

Write-Host @'
 
))) Codigo creado por:

           /$$  /$$$$$$          /$$                           
          | $$ /$$__  $$        | $$                           
  /$$$$$$ | $$| $$  \__//$$$$$$ | $$   /$$  /$$$$$$  /$$    /$$
 /$$__  $$| $$| $$$$   |____  $$| $$  /$$/ |____  $$|  $$  /$$/
| $$$$$$$$| $$| $$_/    /$$$$$$$| $$$$$$/   /$$$$$$$ \  $$/$$/ 
| $$_____/| $$| $$     /$$__  $$| $$_  $$  /$$__  $$  \  $$$/  
|  $$$$$$$| $$| $$    |  $$$$$$$| $$ \  $$|  $$$$$$$   \  $/   
 \_______/|__/|__/     \_______/|__/  \__/ \_______/    \_/    
                                                               
                                                               
'@

$spotifyDirectory = Join-Path -Path $env:APPDATA -ChildPath 'Spotify'
$spotifyExecutable = Join-Path -Path $spotifyDirectory -ChildPath 'Spotify.exe'
$spotifyApps = Join-Path -Path $spotifyDirectory -ChildPath 'Apps'

Write-Host "Cerrando Spotify...`n"
Stop-Process -Name Spotify
Stop-Process -Name SpotifyWebHelper

Push-Location -LiteralPath $env:TEMP
try
{
  # Unique directory name based on time
  New-Item -Type Directory -Name "BlockTheSpot-$(Get-Date -UFormat '%Y-%m-%d_%H-%M-%S')" |
  Convert-Path |
  Set-Location
}
catch
{
  Write-Output $_
  Read-Host 'Toca cualquier tecla para salir...'
  exit
}

Write-Host "Descargando el ultimo parche... UwU`n"
$elfPath = Join-Path -Path $PWD -ChildPath 'chrome_elf.zip'
try
{
  $uri = 'https://github.com/mrpond/BlockTheSpot/releases/latest/download/chrome_elf.zip'
  Get-File -Uri $uri -TargetFile "$elfPath"
}
catch
{
  Write-Output $_
  Start-Sleep
}

Expand-Archive -Force -LiteralPath "$elfPath" -DestinationPath $PWD
Remove-Item -LiteralPath "$elfPath" -Force

$elfDllBackFilePath = Join-Path -Path $spotifyDirectory -ChildPath 'chrome_elf_bak.dll'
$elfBackFilePath = Join-Path -Path $spotifyDirectory -ChildPath 'chrome_elf.dll'
if ((Test-Path $elfDllBackFilePath) -eq $false)
{
  Move-Item -LiteralPath "$elfBackFilePath" -Destination "$elfDllBackFilePath" | Write-Verbose
}

Write-Host 'Parcheando tu Spotify...'
$patchFiles = (Join-Path -Path $PWD -ChildPath 'chrome_elf.dll'), (Join-Path -Path $PWD -ChildPath 'config.ini')

Copy-Item -LiteralPath $patchFiles -Destination "$spotifyDirectory"

$tempDirectory = $PWD
Pop-Location

Remove-Item -LiteralPath $tempDirectory -Recurse

Write-Host 'Parche completado correctamente. Iniciando tu Spotify...'

Start-Process -WorkingDirectory $spotifyDirectory -FilePath $spotifyExecutable
Write-Host 'Instalacion completada. Ya puedes cerrar esta ventana.'

exit
