# GitHubのAPIを使用して最新のリリースタグを取得
$tag = Invoke-RestMethod -Uri "https://api.github.com/repos/yuru7/udev-gothic/releases/latest" | Select-Object -ExpandProperty tag_name

# ダウンロードURLを構築
$zipUrl = "https://github.com/yuru7/udev-gothic/releases/download/$tag/UDEVGothic_NF_$tag.zip"

# Zipファイルをダウンロード
Invoke-WebRequest -Uri $zipUrl -OutFile "udev_gothic.zip"

# 一時ディレクトリにZipファイルを展開
$extractPath = [System.IO.Path]::GetTempPath() + "UDEVGothic"
Expand-Archive -LiteralPath "udev_gothic.zip" -DestinationPath $extractPath

# 展開した.ttfファイルをWindowsのフォントディレクトリにコピー
Get-ChildItem -Path "$extractPath\*.ttf" | ForEach-Object {
    $fontPath = "C:\Windows\Fonts\" + $_.Name
    if (-not (Test-Path $fontPath)) {
        Copy-Item $_.FullName -Destination $fontPath
    }
}

# ダウンロードしたZipファイルを削除
Remove-Item "udev_gothic.zip"
Remove-Item -Recurse -Force $extractPath

# フォントキャッシュを更新（オプション）
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[System.Drawing.Text.PrivateFontCollection]::new()