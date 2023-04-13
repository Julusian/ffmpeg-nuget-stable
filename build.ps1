$lib = "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\Lib.exe"
$files64 = Get-ChildItem -Path "ffmpeg*-full_build-shared/lib/*.def"

Foreach ($file in $files64) {
  $defname = $file.FullName
  $pos = $defname.LastIndexOf("-")
  $libname = "$($defname.Substring(0, $pos)).lib"
  & "$lib" /def:"$defname" /out:"$libname" /machine:x64 /nologo
}
