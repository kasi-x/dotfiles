# Set environment variables for various paths
$Env:Path += ";${Env:LOCALAPPDATA}\yarn\bin"
$Env:Path += ";${Env:ProgramFiles}\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\Roslyn"
$Env:Path += ";${Env:ProgramFiles}\Microsoft Visual Studio\2022\Community\VC\vcpkg"
$Env:Path += ";${Env:USERPROFILE}\.nimble\bin"
# $Env:Path += ";${Env:ProgramFiles(x86)}\Android\android-sdk\platform-tools"
$env:Path += ";${Env:ProgramFiles}\arduino-ide"
#$env:Path += ";${Env:ProgramFiles(x86)}\Mecab\bin"
#$env:Path += ";${ENV:ProgramFiles(x86)}\CaboCha\bin"
$env:Path += ";${Env:ProgramFiles}\NVIDIA GPU Computing Toolkit\CUDA\v12.0\bin"
$env:Path += ";${Env:LOCALAPPDATA}\Android\SDK\platform-tools"
$env:Path += ";${Env:ProgramFiles}\AutoHotkey"
# $env:Path += ";${Env:ProgramFiles}\Tailscale"
$env:Path += ";${Env:SystemDrive}\msys64\usr\bin"
$env:Path += ";${Env:ProgramFiles}\Neovide"
$env:Path += ";${Env:ProgramFiles}\Neovim\bin"

# Set the default text editor to Visual Studio Code
$Env:EDITOR = "neovide"
$Env:VIM = "neovide"
$Env:CODE = "code"

# Set XDG_CONFIG_HOME to the user's profile .config directory
$Env:XDG_CONFIG_HOME = "$Env:USERPROFILE\.config"

# Define custom environment variables
$Env:DEV = "$Env:USERPROFILE\dev"
$Env:WORK = "$Env:USERPROFILE\work"
$Env:TOOL = "$Env:HOMEDRIVE\tools"

# Define a custom prompt function based on whether the user has admin rights
function prompt { 
    if ($isAdmin) {
        "[" + (Get-Location) + "] # " 
    } else {
        "[" + (Get-Location) + "] $ "
    }
}

# Check if the current user has admin rights
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# Set the window title based on PowerShell version and admin status
$Host.UI.RawUI.WindowTitle = "PowerShell $($PSVersionTable.PSVersion.ToString())"
if ($isAdmin) {
    $Host.UI.RawUI.WindowTitle += " [ADMIN]"
}

# Define aliases for common programs and commands
Set-Alias c clear
Set-Alias open Explorer
Set-Alias o Explorer
Set-Alias e $Env:EDITOR
Set-Alias n notepad
Set-Alias subl '${Env:ProgramFiles}\"Sublime Text"\sublime_text.exe'
Set-Alias s '${Env:ProgramFiles}\"Sublime Text"\sublime_text.exe'
Set-Alias g git
Set-Alias ai "winget install "
Set-Alias chrome "${Env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe"
Set-Alias vbox "${Env:ProgramFiles}\Oracle\VirtualBox\virtualbox.exe"
Set-Alias vlc "${Env:ProgramFiles}\VideoLAN\VLC\vlc.exe"
Set-Alias pdf "${Env:LOCALAPPDATA}\SumatraPDF\sumatrapdf.exe"
# Set-Alias pic "${Env:ProgramFiles}\ImageGlass\imageglass.exe"
Set-Alias who $env:username
Set-Alias hn whoami
Set-Alias ll Get-ChildItem
Set-Alias la Get-ChildItem

# Define custom functions for common tasks
function DEV() { cd $DEV }
function DOC() { cd $DOC }
function DRIVE() { cd $HOMEDRIVE }
function DESK() { cd $DESKTOP }
function PATH() { $Env:path.split(";") }

function mcd { mkdir @args; cd @args }
function cd.. { Set-Location .. }
function cd... { Set-Location ..\.. }
function cd.... { Set-Location ..\..\.. }
function .. { Set-Location ..\ }
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }
function gcm {
    git add .
    git commit -m "$args"
}
function gacp {
    git add .
    git commit -m "$args"
    git push
}

# Define functions for file manipulation and process management
function md5 { Get-FileHash -Algorithm MD5 $args }
function sha1 { Get-FileHash -Algorithm SHA1 $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }
function rmd { Remove-Item -recurse -force @args }
function path { ($Env:Path).Replace(';', "`n") }
function skkserv {
    & "$Env:HOMEDRIVE\Tools\yaskkserv2\yaskkserv2.exe" --config-filename "$Env:USERPROFILE\dotfiles\dots\skk\win_yaskkserv2.conf"
}
# function Vim-Vimrc { ${Env:VIM} ${Env:USERPROFILE}\dotfiles\dots\nvim }
function Edit-Vimrc { Start-Process ${Env:EDITOR} -ArgumentList ${Env:USERPROFILE}\dotfiles\dots\nvim }
function Edit-Powershell-Base { Start-Process ${Env:EDITOR} -ArgumentList ${Env:USERPROFILE}\dotfiles\dots\windows\Microsoft.PowerShell_profile.ps1 }
# Set-Alias vv Vim-Vimrc
Set-Alias ev Edit-Vimrc
Set-Alias ep Edit-Powershell-Base

# Utility Functions {{{
# Update the last modified timestamp of a file or create an empty file if it doesn't exist
function touch($filePath) {
    if (Test-Path $filePath) {
        (Get-Item $filePath).LastWriteTime = Get-Date
    } else {
        Out-File -Encoding UTF8 $filePath
    }
}

# Kill a process by name
function pkill($processName) {
    Get-Process $processName -ErrorAction SilentlyContinue | Stop-Process
}

# List processes by name
function ps($processName) {
    Get-Process $processName
}

# Unzip a file to the current directory
function unzip($file) {
    Write-Output "Extracting $file to $pwd"
    $fullFile = Get-ChildItem -Path $pwd -Filter $file | ForEach-Object { $_.FullName }
    Expand-Archive -Path $fullFile -DestinationPath $pwd
}

# Upload a file to ix.io
function Upload-ToIx($file) {
    curl.exe -F "f:1=@$file" ix.io
}

# Search for a regex pattern in files within a directory
function Search-Files($regex, $directory) {
    if ($directory) {
        Get-ChildItem $directory | Select-String $regex
        return
    }
    $input | Select-String $regex
}

# Get system uptime
function Get-SystemUptime() {
    $lastBootTime = [Management.ManagementDateTimeConverter]::ToDateTime((Get-WmiObject Win32_OperatingSystem).LastBootUpTime)
    $uptime = [DateTime]::Now - $lastBootTime
    $uptime | Select-Object Days, Hours, Seconds, Milliseconds | Format-Table -AutoSize
}

# Git-related functions

# Clone a Git repository using ghq and peco for selection
function Clone-GitRepository-With-GHQ {
    param (
        [Parameter(Mandatory)]
        $RepositoryUrl,
        [Parameter(Mandatory)]
        $RepositoryName
    )

    $defaultPath = './ghq'
    $path = Join-Path $defaultPath $RepositoryName
    $quietFlag = '-q'

    Write-Host 'Trying to clone the repository...'
    $output = git clone $RepositoryUrl $path $quietFlag $quietFlag 2>&1
    
    if ($LASTEXITCODE -eq 0) {        
        Write-Host "Repository successfully cloned under $defaultPath directory!"
    } else {
        Write-Host "Error cloning repository: $output" -ForegroundColor Red
    }
}

# List and select Git repositories for cloning using ghq and peco
function List-And-Select-GitRepositories {
    gh repo list --limit 1000 | peco | ForEach-Object { 
        $repository = $_.Split()[0]
        ghq get $repository
    }
}

# List processes by name
function p($processName) {
    Get-Process | peco
}

# File and Directory Management {{{
# Get the size of a directory
function Get-DirectorySize($root = (Resolve-Path .)) {
    Get-ChildItem -Recurse $root |
      Where-Object { -not $_.PSIsContainer } |
      Measure-Object -Sum -Property Length
}

# Create a symbolic link (soft or directory) using cmd.exe
function ln($link, $target) {
    if (Test-Path -PathType Container $target) {
        $command = "cmd /c mklink /d"
    } else {
        $command = "cmd /c mklink"
    }
}

# Remove a symbolic link (soft or directory) using cmd.exe
function unlink($link) {
    if (Test-Path -PathType Container $link) {
        $command = "cmd /c rmdir"
    } else {
        $command = "cmd /c del"
    }
}
# }}}

# Debugging and Debug Mode {{{
# Toggle the global debug mode on or off
function Toggle-DebugMode() {
    switch ($DebugPreference) {
        'Continue' {
            Write-Host 'Setting debug off'
            $global:DebugPreference = 'SilentlyContinue'
        }
        'SilentlyContinue' {
            Write-Host 'Setting debug on'
            $global:DebugPreference = 'Continue'
        }
    }
}
# }}}

# Reload the PowerShell profile (user-specific and system-wide)
function Reload-PowerShellProfile {
    @(
        $Profile.AllUsersAllHosts,
        $Profile.AllUsersCurrentHost,
        $Profile.CurrentUserAllHosts,
        $Profile.CurrentUserCurrentHost
    ) | ForEach-Object {
        if (Test-Path $_) {
            Write-Verbose "Running $_"
            . $_
        }
    }
}
# Package Management {{{
# Backup installed packages for package managers (Scoop, Chocolatey, Winget)
function Backup-InstalledPackages {
    $backupPath = Join-Path $Env:USERPROFILE "dotfiles\dots\windows"

    # Ensure the backup directory exists
    if (-not (Test-Path $backupPath)) {
        New-Item -ItemType Directory -Path $backupPath
    }

    Write-Host "Start Scoop Backup."
    $scoopExportPath = Join-Path $backupPath "scoop-packages-list.txt"
    scoop export | Out-File $scoopExportPath

    Write-Host "Start Chocolatey Backup."
    $chocoExportPath = Join-Path $backupPath "choco-packages-list.config"
    choco export --output-file $chocoExportPath

    Write-Host "Start Winget Backup."
    $wingetExportPath = Join-Path $backupPath "winget-packages-list.json"
    winget export --output $wingetExportPath

    Write-Host "Backup completed successfully."
}

# Import and install previously backed up packages for package managers (Scoop, Chocolatey, Winget)
function Import-InstalledPackages {
    $backupPath = "$Env:USERPROFILE\dotfiles\dots\windows"

    $scoopExportPath = Join-Path $backupPath "scoop-packages-list.txt"
    if (Test-Path $scoopExportPath) {
        Get-Content $scoopExportPath | ForEach-Object { scoop install $_ }
    } else {
        Write-Warning "Scoop package list not found at $scoopExportPath"
    }
    
    $chocoExportPath = Join-Path $backupPath "choco-packages-list.config"
    if (Test-Path $chocoExportPath) {
        choco import $chocoExportPath
    } else {
        Write-Warning "Chocolatey package list not found at $chocoExportPath"
    }

    $wingetExportPath = Join-Path $backupPath "winget-packages-list.json"
    if (Test-Path $wingetExportPath) {
        winget import --input $wingetExportPath
    } else {
        Write-Warning "Winget package list not found at $wingetExportPath"
    }
    Write-Host "Import of installed packages completed successfully."
}

 function Update-InstalledPackages {
    Write-Host "Starting update process for installed packages..."
    # Scoop: Update all installed packages
    Write-Host "Updating Scoop packages..."
    scoop update *
    # Chocolatey: Upgrade all installed packages
    Write-Host "Upgrading Chocolatey packages..."
    choco upgrade all -y
    # Winget: Upgrade all installed packages
    Write-Host "Upgrading Winget packages..."
    winget upgrade --all
    Write-Host "Update of installed packages completed successfully."
}

# Package Management }}}

# PowerShell Profile Management {{{
# Backup the user's PowerShell profile
function Backup-PowerShellProfile {
    $sourcePath = Join-Path $Env:USERPROFILE "Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    $destinationPath = Join-Path $Env:USERPROFILE "dotfiles\dots\windows\Microsoft.PowerShell_profile.ps1"
    $destinationDir = Split-Path $destinationPath
    if (-not (Test-Path $destinationDir)) {
        New-Item -ItemType Directory -Path $destinationDir -Force
    }
    Copy-Item -Path $sourcePath -Destination $destinationPath -Force
}

# Export the user's PowerShell profile
function Export-PowerShellProfile {
    $sourcePath = Join-Path $Env:USERPROFILE "dotfiles\dots\windows\Microsoft.PowerShell_profile.ps1"
    $destinationPath = Join-Path $Env:USERPROFILE "Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    $destinationDir = Split-Path $destinationPath
    if (-not (Test-Path $destinationDir)) {
        New-Item -ItemType Directory -Path $destinationDir -Force
    }
    Copy-Item -Path $sourcePath -Destination $destinationPath -Force
}
# PowerShell Profile Management }}}

# My Original {{{
function Download-YoutubeVideo {
    param (
        [string]$VideoUrl
    )

    $ytDlpCommand = "yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' -o '$HOME\Videos\Download\%(title)s.%(ext)s' '$VideoUrl'"
    Invoke-Expression $ytDlpCommand
}
# My Original }}}
# Utility Functions }}}

Set-Alias ix Upload-ToIx
# Set-Alias grep Search-Files
Set-Alias uptime Get-SystemUptime
Set-Alias ghg Clone-GitRepository-With-GHQ
Set-Alias ghc List-And-Select-GitRepositories
Set-Alias size Get-DirectorySize
Set-Alias debug Toggle-DebugMode
Set-Alias reflect Export-PowerShellProfile
Set-Alias backup Backup-PowerShellProfile
Set-Alias pup Update-InstalledPackages
Set-Alias pback Backup-InstalledPackages
Set-Alias pimp Import-InstalledPackages
Set-Alias reload Reload-PowerShellProfile
Set-Alias r Reload-PowerShellProfile
Set-Alias yt Download-YoutubeVideo

# PowerShell Module Installation {{{
# Install a module if it's missing
function Install-ModuleIfMissing {
    param (
        [string]$ModuleName
    )

    $module = Get-Module -ListAvailable -Name $ModuleName

    if (-not $module) {
        Install-Module -Name $ModuleName -Scope CurrentUser -Force -AllowClobber
        Write-Host "Installed module: $ModuleName"
    } else {
        Write-Host "Module $ModuleName is already installed."
    }
}

# Install required modules
Install-ModuleIfMissing -ModuleName "PSFzf"
Install-ModuleIfMissing -ModuleName "VSSetup"
Install-ModuleIfMissing -ModuleName "PSReadLine"

# Options
# Install-ModuleIfMissing -ModuleName "Pscx"
# winget install junegunn.fzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadlineKeyHandler -Key "Ctrl+n" -Function "MenuComplete"
Set-PSReadlineOption -BellStyle None
Set-PSReadlineOption -HistoryNoDuplicates
Set-PSReadLineOption -PredictionSource History
Set-PSReadlineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function ForwardWord
# PowerShell Module Installation }}}

# Chocolatey profile
$ChocolateyProfile = "$Env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# mkdir -Path (Split-Path -Parent $profile) -ErrorAction SilentlyContinue
Invoke-Expression (&starship init powershell)
Invoke-Expression -Command $(gh completion -s powershell | Out-String)

# read private.env
$envFilePath = Join-Path $HOME 'credentials.env'

if (Test-Path $envFilePath) {
    Get-Content $envFilePath | ForEach-Object {
        $keyValue = $_.Split('=')
        if ($keyValue.Count -eq 2) {
            [System.Environment]::SetEnvironmentVariable($keyValue[0].Trim(), $keyValue[1].Trim(), [System.EnvironmentVariableTarget]::Process)
        }
    }
} else {
    Write-Host "credentials.env dotenv notfound"
}
