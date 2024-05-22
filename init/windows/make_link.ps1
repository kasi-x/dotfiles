function link {
  param(
    [Parameter(Mandatory = $true)]
    [string] $SourceFileName,
    [Parameter(Mandatory = $false)]
    [string] $TargetDirectory = $HOME
  )

  # Build the source path
  $sourcePath = Join-Path $HOME "dotfiles\dots\$SourceFileName"

  # Check if source file/directory exists
  if (!(Test-Path -Path $sourcePath)) {
    Write-Error "Error: Source path '$sourcePath' does not exist."
    return
  }

  # Determine target based on source type
  if ((Get-Item -Path $sourcePath -PathType Directory)) {
    $targetPath = Join-Path $TargetDirectory $SourceFileName
  } else {
    $targetPath = Join-Path $TargetDirectory ".$SourceFileName"
  }

  # Create target directory if needed
  $targetDir = Split-Path -Path $targetPath -Parent
  if (!(Test-Path -Path $targetDir -PathType Container)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
  }

  # Remove existing target (file or symbolic link)
  Remove-Item -Path $targetPath -Force -ErrorAction SilentlyContinue

  # Create symbolic link
  New-ItemSymbolicLink -Path $targetPath -ItemPath $sourcePath -Force
}


# link "kaggle"
link "skk"
link "kaggle" ".kaggle"
link "skk" ".skk"
link "textlintrc"
#  link "tmux.conf"
link "atcodertools.toml"
link "config/bat/config", "C:\Users\user\AppData\Roaming\bat\config"