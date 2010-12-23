if exists("g:loaded_listchars_plugin")
    finish
endif
let g:loaded_listchars_plugin = 1

" показываем/скрываем табы, лишние завершающие пробелы
set listchars=eol:$,tab:>-,trail:-,precedes:<,extends:>

command! -bang -nargs=? ListChars call ListCharsToggle(<bang>0)

function! ListCharsToggle(forced)
    if exists("g:show_list") && a:forced == 0
        unlet g:show_list
        set nolist
        echo "nolist"
    else
        let g:show_list = 1
        set list
        echo "list"
    endif
endfunction

nnoremap <silent> <C-F3> :ListChars<cr>
inoremap <silent> <C-F3> <esc>:ListChars<cr>a

