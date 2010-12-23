if exists("g:loaded_quickfix_plugin")
    finish
endif
let g:loaded_quickfix_plugin = 1

if has("quickfix")

    command! -bang -nargs=? QFix call QFixToggle(<bang>0)

    function! QFixToggle(forced)
        if exists("g:qfix_win") && a:forced == 0
            cclose
            unlet g:qfix_win
        else
            if winheight(0) <= 30
                let l:height = winheight(0) / 2
            elseif winheight(0) >= 50
                let l:height = winheight(0) / 3
            else
                let l:height = 15
            endif

            execute 'copen'.l:height
            unlet l:height
            let g:qfix_win = bufnr("$")
        endif
    endfunction

    " открыть окно с сообщениями (результаты поиска, сообщения компилятора)
    nmap <C-E> :QFix<cr>
    imap <C-E> <esc>:QFix<cr>

    " перейти к следующей ошибке
    nmap <F8> :cnext<cr>zz
    imap <F8> <esc>:cnext<cr>zzi

    " перейти к предыдущей ошибке
    nmap <F7> :cprev<cr>zz
    imap <F7> <esc>:cprev<cr>zzi

endif " has("quickfix")

