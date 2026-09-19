# Downloads Sonniss GDC 2026 bundle (7.47 GB) - run manually, once.
# Source: https://gdc.sonniss.com/ - royalty-free for games, see ../audio_realistic/README.md
$out = "$PSScriptRoot/sonniss_gdc2026"
New-Item -ItemType Directory -Path $out -Force | Out-Null
$files = @(
  "Sonniss.com-GDC2026-GameAudioBundle1of5.zip",
  "Sonniss.com-GDC2026-GameAudioBundle2of5.zip",
  "Sonniss.com-GDC2026-GameAudioBundle3of5.zip",
  "Sonniss.com-GDC2026-GameAudioBundle4of5.zip",
  "Sonniss.com-GDC2026-GameAudioBundle5of5.zip"
)
foreach ($f in $files) {
  $url = "https://gdc.sonniss.com/$f"
  $dst = Join-Path $out $f
  if (Test-Path $dst) { Write-Host "exists, skip: $f"; continue }
  Write-Host "downloading $f ..."
  curl.exe -L -o $dst $url
}
Write-Host "done. Unzip and copy chosen .wav into D:/game/sounds/"
