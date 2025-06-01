[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
$PSDefaultParameterValues['*:Encoding'] = 'utf8'

Import-Module PSReadLine
Set-PSReadLineOption -BellStyle None -EditMode Vi -HistorySearchCursorMovesToEnd:$True -PredictionSource History
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

$env:EDITOR = 'vim'
$env:VISUAL = 'vim'
$env:PAGER = 'less'
$env:LESS = '-iFJMRX'
$env:FZF_DEFAULT_COMMAND = 'fd --hidden --follow --type f'
$env:FZF_DEFAULT_OPTS = '--style full --height 40% --layout=reverse --preview "bat --color=always --style=plain --line-range=:500 {}"'
$env:PATH = "$(Join-Path -Path "$(python -m site --user-site)" -ChildPath "..\Scripts" -Resolve);$env:PATH"

Remove-Item alias:curl
Remove-Item alias:diff -Force
Remove-Item alias:ls
Remove-Item alias:tee -Force
Remove-Item alias:wget

Set-Alias g git.exe

function bat { &bat.exe --style=plain --color=always @args }
function fd { &fd.exe --follow --hidden @args }
function la { &lsd.exe --group-directories-first -A @args }
function ll { &lsd.exe --group-directories-first -Al @args }
function ls { &lsd.exe --group-directories-first @args }
function rg { &rg.exe --follow --hidden @args }
function which ([string]$command) { Get-Command $command -ErrorAction SilentlyContinue }

&fnm.exe env | Out-String | Invoke-Expression
&starship.exe init powershell --print-full-init | Out-String | Invoke-Expression
&zoxide.exe init powershell | Out-String | Invoke-Expression
