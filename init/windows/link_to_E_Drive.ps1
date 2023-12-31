$folders = @('Documents', 'Videos', 'Picuters', 'Music', 'Downloads')

foreach ($folder in $folders) {
    $targetPath = "E:\$folder"

    $linkPath = "$Env:USERPROFILE\$folder"

    if (Test-Path $linkPath) {
        Remove-Item $linkPath -Force
    }
    New-Item -ItemType SymbolicLink -Path $linkPath -Target $targetPath
}

Write-Host "シンボリックリンクを作成しました。"