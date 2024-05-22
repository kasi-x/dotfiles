New-Item -ItemType SymbolicLink -Path $Env:USERPROFILE/dotfiles -Value $Env:USERPROFILE/github.com/kasi-x/dotfiles
New-Item -ItemType SymbolicLink -Path $Env:USERPROFILE/.skk  -Value $Env:USERPROFILE/dotfiles/dots/skk
New-Item -ItemType SymbolicLink $Env:USERPROFILE/.tmux.conf -Value $Env:USERPROFILE/dotfiles/dots/tmux.conf
New-Item -ItemType SymbolicLink $Env:USERPROFILE/.config/git/config -Value  $Env:USERPROFILE/dotfiles/dots/config/git/config
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE/.config/skk"

# AppData\Local\nvim
# New-Item -ItemType SymbolicLink -Path $Env:USERPROFILE/.config  -Value $Env:USERPROFILE\dotfiles\dots\config

# New-Item -Path $Env:USERPROFILE/.config  -Value $Env:USERPROFILE\dotfiles\dots\config -ItemType SymbolicLink

# New-Item -Type Symbol icLink $Env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1 -Value $Env:USERPROFILE\dotfiles\dots\windows\Microsoft.PowerShell_profile.ps1

