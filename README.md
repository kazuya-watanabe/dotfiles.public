# Dotfiles

## Installing Dotfiles

### macOS / Linux

```sh
find $(pwd) -mindepth 1 -maxdepth 1 -name '.??*' | grep -v '.git*' | xargs -I % ln -fns % ~/
```

### Windows

```powershell
New-Item -Force -ItemType Junction -Value "$(Get-Location)\.config" -Path "$env:USERPROFILE\.config"
New-Item -Force -ItemType Junction -Value "$(Get-Location)\.config\vim" -Path "$env:USERPROFILE\vimfiles"
New-Item -Force -ItemType Junction -Value "$(Get-Location)\.config\bat" -Path "$env:APPDATA\bat"
New-Item -Force -ItemType Junction -Value "$(Get-Location)\.config\fd" -Path "$env:APPDATA\fd"
New-Item -Force -ItemType Junction -Value "$(Get-Location)\.config\lf" -Path "$env:LOCALAPPDATA\lf"
New-Item -Force -ItemType Junction -Value "$(Get-Location)\rc\powershell" -Path "$env:USERPROFILE\Documents\WindowsPowerShell"
New-Item -Force -ItemType HardLink -Value "$(Get-Location)\.textlintrc" -Path "$env:USERPROFILE\.textlintrc"
New-Item -Force -ItemType HardLink -Value "$(Get-Location)\rc\windows-terminal\settings.json" -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
[System.Environment]::SetEnvironmentVariable('RIPGREP_CONFIG_PATH', "$env:USERPROFILE\.config\rg\ripgreprc", [System.EnvironmentVariableTarget]::User)
$CurrentPath = [System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable('PATH', "$(Join-Path -Path "$(python -m site --user-site)" -ChildPath "..\Scripts" -Resolve);" + "$([System.Environment]::GetEnvironmentVariable('PATH', [System.EnvironmentVariableTarget]::User))", [System.EnvironmentVariableTarget]::User)
```

---

## Installing Packages

### macOS

- Homebrew [^1]

```sh
cat rc/mac-brew-cask.list | xargs brew install --cask
cat rc/mac-brew-formula.list | xargs brew install --formula
```

### Windows

- Scoop [^2]

```powershell
Get-Content .\rc\windows-scoop-buckets.list | %{ scoop bucket add $_ }
Get-Content .\rc\windows-scoop-apps.list | %{ scoop install $_ }
```

### Fedora

```sh
cat rc/fedora-dnf.list | xargs sudo dnf install --allowerasing -y
```

### Node.js

```sh
cat rc/npm-global.list | xargs npm --global install
```

### Python

```sh
pip install --user --requirement rc/pip-requirements.txt
```

### PowerShell

```powershell
Get-Content .\rc\powershell-modules.list | %{ Install-Module -Force -Name $_ -Scope CurrentUser }
```

[^1]: [Homebrew](https://brew.sh/)

[^2]: [Scoop](https://scoop.sh/)
