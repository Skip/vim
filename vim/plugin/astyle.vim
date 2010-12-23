if exists("loaded_astyle_plugin")
    finish
endif
let loaded_astyle_plugin = 1

function! ExecAstyle()
    set equalprg=~/.vim/utils/astyle.sh
    exe "normal gg=G"
    set equalprg=
endfunction

nmap <leader>= :call ExecAstyle()<cr>

