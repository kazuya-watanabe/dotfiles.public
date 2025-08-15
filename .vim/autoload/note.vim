function! note#note(path = '') abort
    let s:default_note_directory = '~/Documents/Notes'
    let s:default_note_filename = '%Y-%m/%Y-%m-%d.md'
    let s:default_note_template = s:default_note_directory .. '/.template.md'

    let l:note_directory = get(g:, 'note_directory', s:default_note_directory)
    let l:note_filename = get(g:, 'note_filename', s:default_note_filename)
    let l:note_template = get(g:, 'note_template', s:default_note_template)

    if a:path !=# ''
        let l:filename = expand(a:path)
    else
        let l:filename = expand(l:note_directory . '/' . strftime(l:note_filename))
    endif

    let l:dir = fnamemodify(l:filename, ':h')
    if l:dir !=# ''
        call mkdir(expand(l:dir), 'p')
    endif

    execute 'edit ' . fnameescape(l:filename)

    let l:expanded_template = expand(l:note_template)
    if !filereadable(expand(l:filename)) && filereadable(l:expanded_template)
        let l:lines = readfile(l:expanded_template)
        if !empty(l:lines)
            call append(0, l:lines)

            let l:date = strftime("%x")
            let l:time = strftime("%X")
            let l:user = ''
            let l:email= ''

            if executable('git')
                let l:gitusername = systemlist('git config user.name')
                if !empty(l:gitusername) && v:shell_error == 0
                    let l:user = join(l:gitusername, "\n")
                endif

                let l:gituseremail = systemlist('git config user.email')
                if !empty(l:gituseremail) && v:shell_error == 0
                    let l:email = join(l:gituseremail, "\n")
                endif
            endif

            let l:replacements = {
                        \ '{{\s*date\s*}}': l:date,
                        \ '{{\s*time\s*}}': l:time,
                        \ '{{\s*user\s*}}': l:user,
                        \ '{{\s*email\s*}}': l:email,
                        \ }

            let l:start = 1
            let l:end = line('$')
            for l:i in range(l:start, l:end)
                let l:line = getline(l:i)
                for [l:pat, l:rep] in items(l:replacements)
                    let l:line = substitute(l:line, l:pat, l:rep, 'g')
                endfor
                call setline(l:i, l:line)
            endfor
        endif
    endif
endfunction
