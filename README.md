# Dotfiles

## Installing Dotfiles

### macOS / Linux

```sh
find $(pwd) -mindepth 1 -maxdepth 1 -name '.??*' | grep -v '.git*' | xargs -I % ln -fns % ~/
```

### Windows

```powershell
(Get-Item -Path "$env:USERPROFILE\.config").Delete()
(Get-Item -Path "$env:APPDATA\bat").Delete()
(Get-Item -Path "$env:APPDATA\fd").Delete()
(Get-Item -Path "$env:LOCALAPPDATA\lazygit").Delete()
(Get-Item -Path "$env:LOCALAPPDATA\lf").Delete()
(Get-Item -Path "$env:USERPROFILE\vimfiles").Delete()
(Get-Item -Path "$env:USERPROFILE\Documents\WindowsPowerShell").Delete()
(Get-Item -Path "$env:USERPROFILE\.textlintrc").Delete()

New-Item -Force -ItemType Junction -Value "$(Get-Location)\.config" -Path "$env:USERPROFILE\.config"
New-Item -Force -ItemType Junction -Value "$(Get-Location)\.config\bat" -Path "$env:APPDATA\bat"
New-Item -Force -ItemType Junction -Value "$(Get-Location)\.config\fd" -Path "$env:APPDATA\fd"
New-Item -Force -ItemType Junction -Value "$(Get-Location)\.config\lazygit" -Path "$env:LOCALAPPDATA\lazygit"
New-Item -Force -ItemType Junction -Value "$(Get-Location)\.config\lf" -Path "$env:LOCALAPPDATA\lf"
New-Item -Force -ItemType Junction -Value "$(Get-Location)\.config\vim" -Path "$env:USERPROFILE\vimfiles"
New-Item -Force -ItemType Junction -Value "$(Get-Location)\rc\powershell" -Path "$env:USERPROFILE\Documents\WindowsPowerShell"
Copy-Item -Force -Path "$(Get-Location)\.textlintrc" -Destination "$env:USERPROFILE\.textlintrc"
```

---

## Installing Packages

### macOS

- Homebrew [^1]

[^1]: [Homebrew](https://brew.sh/)

```sh
bash rc/mac-brew.sh
```

### Windows

- Scoop [^2]

[^2]: [Scoop](https://scoop.sh/)

```powershell
Get-Content .\rc\windows-scoop.list | %{ if ($_ -ne "") { scoop $_ } }
Get-Content .\rc\powershell-modules.list | %{ Install-Module -Force -Name $_ -Scope CurrentUser }
```

### Fedora

```sh
bash rc/fedora-dnf.sh
bash rc/linux-brew.sh
```

### Node.js

```sh
cat rc/npm-global.list | xargs npm --global install
```

### Python

```sh
pip install --user --requirement rc/pip-requirements.txt
```
