"don't load twice, we don't like that...
if exists("loaded_showfuncname")
    finish
endif
let loaded_showfuncname = 1

fun! ShowFuncName()
    let lnum = line(".")
    let col = col(".")
    echohl ModeMsg
    echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
    echohl None
    call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun

map <leader>f :call ShowFuncName()<CR>

