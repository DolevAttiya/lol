# MEGA credentials
$megaEmail = "your_email@example.com"
$megaPassword = "your_password"

# File details
$localFilePath = "C:\path\to\file.ext"
$remoteDirectory = "/remote/directory/"

# MEGA API endpoints
$loginEndpoint = "https://g.api.mega.co.nz/cs"
$uploadEndpoint = "https://g.api.mega.co.nz/up"

# Login to MEGA
$loginParams = @{
    "a" = "us"
    "user" = $megaEmail
    "p" = $megaPassword
}
$loginResponse = Invoke-RestMethod -Uri $loginEndpoint -Method POST -Body $loginParams

if ($loginResponse.e -ne 0) {
    Write-Host "Login failed: $($loginResponse.m)"
    exit
}

# Get the upload URL
$uploadParams = @{
    "r" = $loginResponse.r
    "n" = "1"
    "ssl" = "1"
    "d" = $remoteDirectory
}
$uploadResponse = Invoke-RestMethod -Uri $uploadEndpoint -Method POST -Body $uploadParams

if ($uploadResponse.s -ne 0) {
    Write-Host "Upload URL retrieval failed: $($uploadResponse.e)"
    exit
}

# Upload the file
$uploadUrl = $uploadResponse.p[0].u
$uploadFileParams = @{
    "ssl" = "1"
    "u" = $uploadUrl
    "s" = (Get-Item $localFilePath).Length
    "d" = $remoteDirectory
}
$uploadFileResponse = Invoke-RestMethod -Uri $uploadUrl -Method POST -InFile $localFilePath -ContentType "application/octet-stream" -Body $uploadFileParams

if ($uploadFileResponse.s -ne 0) {
    Write-Host "File upload failed: $($uploadFileResponse.e)"
    exit
}

Write-Host "File uploaded successfully!"
