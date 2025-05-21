[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
$PSDefaultParameterValues['*:Encoding'] = 'utf8'

Import-Module PSReadLine
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -HistorySearchCursorMovesToEnd:$True
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key Ctrl+a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Key Ctrl+e -Function EndOfLine
Set-PSReadLineKeyHandler -Key Ctrl+b -Function BackwardChar
Set-PSReadLineKeyHandler -Key Ctrl+f -Function ForwardChar
Set-PSReadLineKeyHandler -Key Ctrl+p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Ctrl+n -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Ctrl+h -Function BackwardDeleteChar
Set-PSReadLineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit
Set-PSReadLineKeyHandler -Key Ctrl+k -Function KillLine
Set-PSReadLineKeyHandler -Key Ctrl+m -Function ValidateAndAcceptLine
Set-PSReadLineKeyHandler -Key Ctrl+l -Function ClearScreen
Set-PSReadLineKeyHandler -Key Ctrl+[ -Function ViCommandMode

Import-Module posh-git

Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t'
Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'

$env:EDITOR = 'vim'
$env:VISUAL = 'vim'
$env:PAGER = 'less'
$env:LESS = '-iFJMRX'
$env:FZF_DEFAULT_COMMAND = 'fd --hidden --follow --type f'

Remove-Item alias:curl
Remove-Item alias:diff -Force
Remove-Item alias:tee -Force
Remove-Item alias:wget

if (Get-Command -Name bat.exe -ErrorAction SilentlyContinue) {
    Remove-Item alias:cat
    Set-Alias cat bat.exe

    $env:FZF_DEFAULT_OPTS = '--style full --height 40% --layout=reverse --preview "bat --color=always --style=plain --line-range=:500 {}"'
} else {
    $env:FZF_DEFAULT_OPTS = '--style full --height 40% --layout=reverse'
}

function fd { &fd.exe --follow --hidden @args }
function rg { &rg.exe --follow --hidden @args }

Set-Alias g git.exe
function gC { &git.exe commit @args }
function gP { &git.exe push @args }
function gR { &git.exe rebase @args }
function gS { &git.exe stash @args }
function ga { &git.exe add @args }
function gb { &git.exe branch @args }
function gc { &git.exe checkout @args }
function gd { &git.exe diff @args }
function gf { &git.exe flow @args }
function gl { &git.exe log @args }
function gm { &git.exe merge @args }
function gp { &git.exe pull @args }
function gr { &git.exe reset @args }
function gs { &git.exe status @args }
function gt { &git.exe tag @args }

if (Get-Command lsd.exe -ErrorAction SilentlyContinue) {
  Remove-Item alias:ls

  function ls { &lsd.exe --group-directories-first @args }
  function la { &lsd.exe --group-directories-first -A @args }
  function ll { &lsd.exe --group-directories-first -Al @args }
} else {
  Set-Alias ll ls
}

function which() {
  param(
    [string]$command
  )
  Get-Command $command -ErrorAction SilentlyContinue
}

If (Get-Command fnm.exe -ErrorAction SilentlyContinue) {
  fnm env --use-on-cd | Out-String | Invoke-Expression
}

If (Get-Command starship -ErrorAction SilentlyContinue) {
  Invoke-Expression (&starship init powershell)
}

If (Get-Command -Name zoxide.exe -ErrorAction SilentlyContinue) {
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
}
