$ErrorActionPreference = 'Stop'

$jdkRoot = 'K:\work\AndroidSDK\jdk'
$jdkBin = 'K:\work\AndroidSDK\jdk\bin'

$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
$entries = @($userPath -split ';' | Where-Object { $_ -and $_.Trim() -ne '' })

if ($entries -notcontains $jdkBin) {
  $entries += $jdkBin
}

[Environment]::SetEnvironmentVariable('JAVA_HOME', $jdkRoot, 'User')
[Environment]::SetEnvironmentVariable('Path', ($entries -join ';'), 'User')

$env:JAVA_HOME = $jdkRoot
if (($env:Path -split ';') -notcontains $jdkBin) {
  $env:Path = "$jdkBin;$env:Path"
}

& 'K:\app\flutter\flutter\bin\flutter.bat' doctor
