$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

$sdkRoot = 'K:\work\AndroidSDK'
$jdkRoot = Join-Path $sdkRoot 'jdk'
$cmdToolsRoot = Join-Path $sdkRoot 'cmdline-tools'
$zipPath = Join-Path $sdkRoot 'commandlinetools.zip'

New-Item -ItemType Directory -Force -Path $sdkRoot | Out-Null

winget install --id EclipseAdoptium.Temurin.21.JDK --accept-source-agreements --accept-package-agreements --location $jdkRoot

$studioPage = Invoke-WebRequest -UseBasicParsing 'https://developer.android.com/studio'
$url = [regex]::Match(
  $studioPage.Content,
  'https://dl.google.com/android/repository/commandlinetools-win-[0-9]+_latest.zip'
).Value

if (-not $url) {
  throw '未找到 Android command line tools 下载地址'
}

Invoke-WebRequest -UseBasicParsing $url -OutFile $zipPath
New-Item -ItemType Directory -Force -Path $cmdToolsRoot | Out-Null
Expand-Archive -LiteralPath $zipPath -DestinationPath $cmdToolsRoot -Force

$nestedRoot = Join-Path $cmdToolsRoot 'cmdline-tools'
$latestRoot = Join-Path $cmdToolsRoot 'latest'
if (Test-Path $nestedRoot) {
  if (Test-Path $latestRoot) {
    Remove-Item -Recurse -Force $latestRoot
  }

  Move-Item -LiteralPath $nestedRoot -Destination $latestRoot
}

$env:JAVA_HOME = $jdkRoot
$env:Path = "$jdkRoot\bin;$latestRoot\bin;$sdkRoot\platform-tools;$env:Path"

1..20 | ForEach-Object { 'y' } | & "$latestRoot\bin\sdkmanager.bat" --sdk_root=$sdkRoot --licenses
& "$latestRoot\bin\sdkmanager.bat" --sdk_root=$sdkRoot 'platform-tools' 'platforms;android-35' 'platforms;android-36' 'build-tools;35.0.0' 'build-tools;36.0.0' 'build-tools;28.0.3'
& 'K:\app\flutter\flutter\bin\flutter.bat' config --android-sdk $sdkRoot
& 'K:\app\flutter\flutter\bin\flutter.bat' doctor
