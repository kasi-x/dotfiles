# "SKK-JISYO.jawiki"
$dictUrls = @(
    "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.L",
    "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.jinmei",
    "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.geo",
    "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.station",
    "https://raw.githubusercontent.com/skk-dev/dict/master/SKK-JISYO.fullname",
    "https://raw.githubusercontent.com/uasi/skk-emoji-jisyo/master/SKK-JISYO.emoji.utf8",
    "https://raw.githubusercontent.com/tokuhirom/skk-jisyo-neologd/master/SKK-JISYO.neologd",
    "https://raw.githubusercontent.com/tokuhirom/jawiki-kana-kanji-dict/master/SKK-JISYO.jawiki"
)
$tempDir = [System.IO.Path]::GetTempPath()
$downloadDir = Join-Path -Path $tempDir -ChildPath "skk_dicts"
New-Item -ItemType Directory -Path $downloadDir -Force

foreach ($url in $dictUrls) {
    $fileName = [System.IO.Path]::GetFileName($url)
    $destPath = Join-Path -Path $downloadDir -ChildPath $fileName

    if (-Not (Test-Path $destPath)) {
        curl -o $destPath $url
    }
}


$Env:TOOL = "${Env:HOMEDRIVE}\tools"
$outputJisyoFilename = "C:\Users\user\.skk\win_dictionary.yaskkserv2"
$command = "${Env:TOOL}\yaskkserv2\yaskkserv2_make_dictionary.exe --dictionary-filename=$outputJisyoFilename "

$dictFiles = Get-ChildItem -Path $downloadDir
foreach ($file in $dictFiles) {
    $command += "$($file.FullName) "
}

echo $command

Invoke-Expression $command