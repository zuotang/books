$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

$installRoot = 'K:\work\VisualStudio\2022\Community'
New-Item -ItemType Directory -Force -Path $installRoot | Out-Null

$override = @(
  '--wait'
  '--quiet'
  '--norestart'
  '--installPath', "`"$installRoot`""
  '--add', 'Microsoft.VisualStudio.Workload.NativeDesktop'
  '--includeRecommended'
) -join ' '

winget install --id Microsoft.VisualStudio.2022.Community `
  --accept-source-agreements `
  --accept-package-agreements `
  --override $override

& 'K:\app\flutter\flutter\bin\flutter.bat' doctor
