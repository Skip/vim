
" avoid reinclusion
if exists("g:loaded_vimcu_vim")
    finish
endif
let g:loaded_vimcu_vim = 1

function! SingleLineComment(lineno)
    let line = getline(a:lineno)

    " skip empty line
    if line =~ "^[ \t]*$"
        return 0
    endif

    if &filetype == "c" || &filetype == "asm"
        let line = substitute(line, '^\([ \t]*\)', '\1' . "/* ", '')
        let line = substitute(line, "$", " */", "")
    elseif &filetype == "cpp"
        let line = substitute(line, '^\([ \t]*\)', '\1' . "// ", '')
    elseif &filetype == "make" || &filetype == "sh"
        let line = substitute(line, '^\([ \t]*\)', '\1' . "# ", '')
    elseif &filetype == "vim"
        let line = substitute(line, '^\([ \t]*\)', '\1' . "\" ", '')
    endif

    " let line = substitute(line, "^", "/* ", "")

    call setline(a:lineno, line)
endfunction

function! MultiLineComment(line1, line2)
    if &filetype == "c" || &filetype == "asm"
        call append(a:line2, "#endif /* 0 */")
        call append(a:line1 - 1, "#if 0")
    elseif &filetype == "cpp"
        for lnum in range(a:line1, a:line2)
            call SingleLineComment(lnum)
        endfor
    elseif &filetype == "make" || &filetype == "sh"
        for lnum in range(a:line1, a:line2)
            call SingleLineComment(lnum)
        endfor
    elseif &filetype == "vim"
        for lnum in range(a:line1, a:line2)
            call SingleLineComment(lnum)
        endfor
    endif
endfunction

function! SingleLineUnComment(lineno)
    let line = getline(a:lineno)

    " skip empty line
    if line =~ "^[ \t]*$"
        return 0
    endif

    if &filetype == "c" || &filetype == "asm"
        let line = substitute(line, escape("/* ", "*"), "", "")
        let line = substitute(line, escape(" */", "*")."$", "", "")
    elseif &filetype == "cpp"
        let line = substitute(line, escape("// ", "*"), "", "")
    elseif &filetype == "make" || &filetype == "sh"
        let line = substitute(line, escape("# ", "*"), "", "")
    elseif &filetype == "vim"
        let line = substitute(line, escape("\" ", "*"), "", "")
    endif

    " let line = substitute(line, "^".escape("/* ", "*"), "", "")

    call setline(a:lineno, line)
endfunction

function! MultiLineUnComment(line1, line2)
    if &filetype == "c" || &filetype == "asm"
        execute a:line2."d"
        execute a:line1."d"
    elseif &filetype == "cpp"
        for lnum in range(a:line1, a:line2)
            call SingleLineUnComment(lnum)
        endfor
    elseif &filetype == "make" || &filetype == "sh"
        for lnum in range(a:line1, a:line2)
            call SingleLineUnComment(lnum)
        endfor
    elseif &filetype == "vim"
        for lnum in range(a:line1, a:line2)
            call SingleLineUnComment(lnum)
        endfor
    endif
endfunction

function! DoComment(line1, line2)
    if a:line1 != a:line2
        call MultiLineComment(a:line1, a:line2)
    else
        call SingleLineComment(a:line1)
    endif
endfunction

function! DoUnComment(line1, line2)
    if a:line1 != a:line2
        call MultiLineUnComment(a:line1, a:line2)
    else
        call SingleLineUnComment(a:line1)
    endif
endfunction

" assign function to user defined command Commend and UnComment
command! -range DoComment call DoComment(<line1>, <line2>)
command! -range DoUnComment call DoUnComment(<line1>, <line2>)

