" WARNING! this plugin disabled
let g:loaded_cscope_plugin = 1

if exists("g:loaded_cscope_plugin")
    finish
endif
let g:loaded_cscope_plugin = 1

if has("cscope")
    set csprg=/home/skip/.vim/utils/cscope

    " The value of 'csto' determines the order in which |:cstag| performs a search.
    " If 'csto' is set to zero, cscope database(s) are searched first, followed
    " by tag file(s) if cscope did not return any matches.  If 'csto' is set to
    " one, tag file(s) are searched before cscope database(s).
    set csto=0

    " If 'cscopetag' set, the commands ":tag" and CTRL-] as well as "vim -t" will
    " always use |:cstag| instead of the default :tag behavior.  Effectively, by
    " setting 'cst', you will always search your cscope databases as well as your
    " tag files.  The default is off.
    " set cst

    " If 'cscopeverbose' is not set (the default), messages will not be printed
    " indicating success or failure when adding a cscope database.  Ideally, you
    " should reset this option in your |.vimrc| before adding any cscope databases,
    " and after adding them, set it.  From then on, when you add more databases
    " within Vim, you will get a (hopefully) useful message should the database fail
    " to be added.
    set nocsverb

    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    "set csverb

    " использовать окно QFix() для просмотра результата некоторых операций
    set cscopequickfix=s-,c-,d-,t-,i-,e-


    " If you use cscope as well as ctags, |:cstag| allows you to search one or
    " the other before making a jump.  For example, you can choose to first
    " search your cscope database(s) for a match, and if one is not found, then
    " your tags file(s) will be searched.  The order in which this happens
    " is determined by the value of |csto|.  See |cscope-options| for more
    " details.
    "
    " |:cstag| performs the equivalent of ":cs find g" on the identifier when
    " searching through the cscope database(s).
    "
    " |:cstag| performs the equivalent of |:tjump| on the identifier when searching
    " through your tags file(s).
    "imap <M-]> <esc>:cstag <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>] :cstag <C-R>=expand("<cword>")<CR><CR>

    " 0 or s: Find this C symbol
    "nmap <leader>0 :cs find s <C-R>=expand("<cword>")<CR><CR>
    "imap <leader>0 <esc>:cs find s <C-R>=expand("<cword>")<CR><CR>

    " 1 or g: Find this definition
    nmap <leader>1 :cs find g <C-R>=expand("<cword>")<CR><CR>
    imap <leader>1 <esc>:cs find g <C-R>=expand("<cword>")<CR><CR>

    " 2 or d: Find functions called by this function
    nmap <leader>2 :cs find d <C-R>=expand("<cword>")<CR><CR>:QFix<cr>
    imap <leader>2 <esc>:cs find d <C-R>=expand("<cword>")<CR><CR>:QFix<cr>

    " 3 or c: Find functions calling this function
    nmap <leader>3 :cs find c <C-R>=expand("<cword>")<CR><CR>:QFix<cr>
    imap <leader>3 <esc>:cs find c <C-R>=expand("<cword>")<CR><CR>:QFix<cr>

    " 4 or t: Find this text string
    nmap <leader>4 :cs find t <C-R>=expand("<cword>")<CR><CR>:QFix<cr>
    imap <leader>4 <esc>:cs find t <C-R>=expand("<cword>")<CR><CR>:QFix<cr>

    " 6 or e: Find this egrep pattern
    nmap <leader>6 :cs find e <C-R>=expand("<cword>")<CR><CR>:QFix<cr>
    imap <leader>6 <esc>:cs find e <C-R>=expand("<cword>")<CR><CR>:QFix<cr>

    " 7 or f: Find this file
    nmap <leader>7 :cs find f <C-R>=expand("<cfile>")<CR><CR>
    imap <leader>7 <esc>:cs find f <C-R>=expand("<cfile>")<CR><CR>

    " 8 or i: Find files #including this file
    nmap <leader>8 :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:QFix<cr>
    imap <leader>8 <esc>:cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:QFix<cr>

    if has("wildmenu")
        set wildmenu
        set wcm=<Tab>
        menu Cscope.find_c_symbol :cs find s <C-R>=expand("<cword>")<CR><CR>
        menu Cscope.find_definition :cs find g <C-R>=expand("<cword>")<CR><CR>
        menu Cscope.find_functions_called_by_this_function :cs find d <C-R>=expand("<cword>")<CR><CR>
        menu Cscope.find_functions_calling_this_function :cs find c <C-R>=expand("<cword>")<CR><CR>
        menu Cscope.find_text_string :cs find t <C-R>=expand("<cword>")<CR><CR>
        menu Cscope.find_egrep_pattern :cs find e <C-R>=expand("<cword>")<CR><CR>
        menu Cscope.find_file :cs find f <C-R>=expand("<cfile>")<CR><CR>
        menu Cscope.find_files_including_this_file :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
        nmap <leader>5 :emenu Cscope.<TAB>
    endif " wildmenu

    " обновить cscope
    " nmap <leader>9 :!generate_cscope.sh<cr>:cs reset<cr>
    " imap <leader>9 <esc>:!generate_cscope.sh<cr>:cs reset<cr>a


endif " has("cscope")

