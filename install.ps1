$ffmpeg = "6.1"
$full_build = "ffmpeg-$ffmpeg-full_build-shared"
$wc = New-Object System.Net.WebClient

if (!(Test-Path "$dev32.zip")) { $wc.DownloadFile("https://github.com/GyanD/codexffmpeg/releases/download/$ffmpeg/$full_build.zip", "$env:temp/$full_build.zip") }

if (!(Test-Path $full_build)) { Expand-Archive "$env:temp/$full_build.zip" -DestinationPath . }

# Remove-Item -Recurse examples
# New-Item -Name examples -ItemType "directory"
# Copy-Item "$full_build\examples\*.c" examples

# # unistd.h -> io.h (for MSVC)
# $cfiles = Get-ChildItem -Path examples\ -Filter *.c
# foreach ($file in $cfiles)
# {
#   (Get-Content $file.PSPath) |
#   Foreach-Object { $_ -replace "unistd.h", "io.h" } |
#     Set-Content $file.PSPath
# }
