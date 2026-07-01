$ErrorActionPreference = 'Stop'

$env:ANDROID_SDK_ROOT = 'C:\Users\Administrator\AppData\Local\Android\Sdk'
$env:ANDROID_HOME = $env:ANDROID_SDK_ROOT
$env:JAVA_HOME = 'C:\Program Files\Java\jdk-21'
$env:FLUTTER_STORAGE_BASE_URL = 'https://storage.flutter-io.cn'
$env:PUB_HOSTED_URL = 'https://mirrors.tuna.tsinghua.edu.cn/dart-pub'
$env:PUB_CACHE = 'D:\work\flutter\books\.pub_cache'
$env:Path = "D:\sdk\flutter\bin;$env:JAVA_HOME\bin;$env:ANDROID_SDK_ROOT\platform-tools;$env:ANDROID_SDK_ROOT\emulator;$env:Path"

New-Item -ItemType Directory -Force -Path $env:PUB_CACHE | Out-Null

& 'D:\sdk\flutter\bin\flutter.bat' run -d 3B65CA01SHZ00000
