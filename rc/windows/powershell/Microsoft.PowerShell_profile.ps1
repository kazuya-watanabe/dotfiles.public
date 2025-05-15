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

if (Get-Command diff.exe -ErrorAction SilentlyContinue) {
    function diff {
        &diff.exe -u @args
    }
}

if (Get-Command fd.exe -ErrorAction SilentlyContinue) {
    function fd {
        &fd.exe --follow --hidden @args
    }

    $env:FZF_DEFAULT_COMMAND = 'fd --hidden --follow --type f'
}

if (Get-Command git.exe -ErrorAction SilentlyContinue) {
    Set-Alias g git.exe

    function gf {
        &git.exe flow @args
    }
}

if (Get-Command lsd.exe -ErrorAction SilentlyContinue) {
  Remove-Item alias:ls

  function ls {
    &lsd.exe --group-directories-first @args
  }


  function ll {
    ls -Al @args
  }
} else {
  Set-Alias ll ls
}

if (Get-Command less.exe -ErrorAction SilentlyContinue) {
    $env:PAGER = 'less'
    $env:LESS = '-iFJMRX'
}

if (Get-Command vim.exe -ErrorAction SilentlyContinue) {
    $env:VISUAL = 'vim'
    $env:EDITOR = 'vim'
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
