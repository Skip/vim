if exists("g:loaded_diff_plugin")
    finish
endif
let g:loaded_diff_plugin = 1

if has("diff")

    function! DiffOrigToggle()
        if bufname('%') == ""
            echo "No original file"
            return
        endif

        if exists("g:diff_file")
            unlet g:diff_file
            diffoff!
            wincmd h
            bd
            syntax on
            set scrolloff=3
        else
            if &diff
                " do not run for (g)vimdiff
                echo "We already in diff mode"
            elseif getbufvar("%", "&mod") == 0
                echo "File not modified"
            else
                let g:diff_file = 1
                syntax off
                set scrolloff=999
                " Convenient command to see the difference between
                " the current buffer and the file it was loaded from,
                " thus the changes you made.

                " command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
                vert new | set bt=nofile | r # | 0d_ | diffthis | set foldcolumn=0 | wincmd p | diffthis | set foldcolumn=0
            endif
        endif
    endfunction

    nmap <C-g> :call DiffOrigToggle()<cr>
    imap <C-g> <esc>:call DiffOrigToggle()<cr>

endif " diff

