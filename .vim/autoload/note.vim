let s:DEFAULT_NOTE_DIRECTORY = '~/Documents/Notes'
let s:DEFAULT_NOTE_FILENAME = '%Y-%m/%Y-%m-%d.md'
let s:DEFAULT_NOTE_TEMPLATE = s:DEFAULT_NOTE_DIRECTORY . '/.template.md'

function! s:get_settings(path) abort
    let l:note_directory = get(g:, 'note_directory', s:DEFAULT_NOTE_DIRECTORY)
    let l:note_filename = get(g:, 'note_filename', s:DEFAULT_NOTE_FILENAME)
    let l:note_template = get(g:, 'note_template', s:DEFAULT_NOTE_TEMPLATE)

    if a:path !=# ''
        let l:filename = expand(a:path)
    else
        let l:filename = expand(l:note_directory . '/' . strftime(l:note_filename))
    endif

    let l:dir = fnamemodify(l:filename, ':h')
    return {'filename': l:filename, 'dir': l:dir, 'template': expand(l:note_template)}
endfunction

function! s:ensure_dir(dir) abort
    if a:dir !=# ''
        call mkdir(expand(a:dir), 'p')
    endif
endfunction

function! s:open_file(path) abort
    execute 'edit ' . fnameescape(a:path)
endfunction

function! s:apply_template_if_needed(filename, template) abort
    if filereadable(expand(a:filename)) || !filereadable(a:template)
        return
    endif

    let l:lines = readfile(a:template)
    if empty(l:lines)
        return
    endif

    call append(0, l:lines)

    let l:replacements = {
                \ '{{\s*date\s*}}': strftime("%x"),
                \ '{{\s*time\s*}}': strftime("%X"),
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
endfunction

function! note#note(path = '') abort
    let l:opts = s:get_settings(a:path)
    call s:ensure_dir(l:opts.dir)
    call s:open_file(l:opts.filename)
    call s:apply_template_if_needed(l:opts.filename, l:opts.template)
endfunction
