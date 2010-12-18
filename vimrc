"------------------------------------------------------------------------------
" Skip VIM settings (version 7 or higher)
"
" using plugins:
"       bufexplorer - exploring buffers
"       AddIfndefGuard - adding header guard
"       omnicppcomplete - autocomplete word in structures and etc...
"       taglist - tags browsing
"       vimcu - comments (simple, but usefull)
"       keys a la windows :)
"------------------------------------------------------------------------------

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

if v:version < 700
    echoerr "This vimrc is for vim 7 and above"
    finish
endif



"------------------------------------------------------------------------
"                    Базовые настройки для редактора
"------------------------------------------------------------------------


" Включаем несовместимость настроек, я использую только VIM
set nocompatible

" Размер табуляции по умолчанию
" 4 пробела на tab, используем для всего только пробелы
set shiftwidth=4
set softtabstop=4
set tabstop=4
set shiftround

" Преобразование Tab в пробелы
" Setting 'expandtab' does not affect any existing tabs.  In other words, any
" tabs in the document remain tabs.  If you want to convert tabs to spaces,
" use the ":retab" command.  Use these commands: >
"
"   :set expandtab
"   :%retab
set expandtab

" Выключаем надоедливый "звонок"
set noerrorbells
set visualbell
set vb t_vb=

if has("virtualedit")
    set virtualedit=all
endif " has("virtualedit")

" allow to use backspace instead of "x"
set backspace=indent,eol,start whichwrap+=<,>,[,]

set linebreak

" backspace in Visual mode deletes selection
vnoremap <BS> d

" Включаем "умные" отступы
set smartindent

" Никаких копий или своп файлов - надо использовать сервер контроля версий
set nobackup
set noswapfile

if has("cmdline_hist")
    " keep lines of command line history
    set history=200
endif

" show the cursor position all the time
set ruler

" display incomplete commands
set showcmd

" do incremental searching
set incsearch

" Включаем нумерацию строк
if has("linebreak")
    set number
endif " has("linebreak")

" The screen will not be redrawn while executing macros,
" registers and other commands that have not been typed.
" Also, updating the window title is postponed.
set lazyredraw

" Когда выключена нумерация строк или даже с ней, не совсем удобно,
" что редактируемый текст прилипает к левому краю окна вима.
" Проблему эту можно решить, сделав видимой колонку фолдинга:
if has("folding")
    set foldcolumn=0
endif " has("folding")

" Поддержка мыши
set mouse=a
set mousemodel=popup

" Не выгружать буфер, когда переключаемся на другой
" Это позволяет редактировать несколько файлов в один и тот же момент без необходимости сохранения каждый раз
" когда переключаешься между ними
set hidden


" показывать подробный вывод в браузере файлов
let g:netrw_longlist=1

let g:netrw_liststyle=1

" открывать окно браузера файлов в том же самом окне
let g:netrw_browse_split=0

let g:netrw_keepdir=1

" спрятать скрытые файлы
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_hide=1

if has("multi_byte_encoding")
    " настройки кодировок
    " используемая в vim (обычно соответствует locale)
    set encoding=utf-8
    " кодировка терминала (обычно соответствует locale)
    set termencoding=utf-8
    " используемая кодировка для файла
    " vim может пытаться автоматически определять (слева направо)
    set fileencodings=utf-8,koi8-r,cp1251,cp866
endif " has("multi_byte_encoding")

set ttyfast

if has("statusline")
    " Формат строки состояния
    set laststatus=2

    if &diff
        set statusline=%F
    else
        set statusline=
        set statusline+=%F\                                                     " full path to the file in the buffer
        set statusline+=%y%m%r[%{&fileencoding}]                                " status flags
        set statusline+=%<[%{strftime(\"%d.%m.%y\",getftime(expand(\"%:p\")))}] "
        set statusline+=%k%=%-14.(%l,%v%)\                                      " cursor position
        set statusline+=%P                                                      " percentage through file of displayed window
    endif
endif " has("statusline")

" отключаем replace mode
" map R <Esc>
imap <Ins> <Esc>i

if has("mksession")
    " Сохранить сессию
    " set sessionoptions-=options
    nmap <F1> :mksession!<cr>
    imap <F1> <esc>:mksession!<cr>a
    let g:SessionMgr_AutoManage = 0
endif " has("mksession")





" vim -b : edit binary using xxd-format!
" удобно редактировать файлы в hex формате
" для больших файлов (например, 700 мб avi) лучше использовать
" другие средства, т.к. файл полностью втягивается в ОЗУ
if &binary
    augroup Binary
        au!
        au BufReadPre  * let &bin=1
        au BufReadPost * if &bin | %!xxd
        au BufReadPost * set ft=xxd | endif
        au BufWritePre * if &bin | %!xxd -r
        au BufWritePre * endif
        au BufWritePost * if &bin | %!xxd
        au BufWritePost * set nomod | endif
    augroup END
endif

function! HexToggle()
    if exists("g:hex_view")
        bd
        unlet g:hex_view
    else
        wincmd n | wincmd o | set bt=nofile | setlocal filetype=xxd | r # | 0d_ | %!xxd
        set readonly
        let g:hex_view = 1
    endif
endfunction





"------------------------------------------------------------------------
"                          Горячие клавишы
"------------------------------------------------------------------------


" сохранить файл с sudo
command! Wsudo set buftype=nowrite | silent execute ':%w !sudo tee %' | set buftype= | e! %

" добавить header guard
nmap <S-F4> :call AddIfndefGuard()<CR>
imap <S-F4> <ESC>:call AddIfndefGuard()<CR>i

" F2 - быстрое сохранение
nmap <F2> :w<cr>
imap <F2> <esc>:w<cr>a

" Shift + F2 - сохранение всех файлов
nmap <S-F2> :wa<cr>
imap <S-F2> <esc>:wa<cr>a

" вкл/выкл отображения найденных соответствий
imap <S-F1> <Esc>:set<Space>hls!<CR>a
nmap <S-F1> :set<Space>hls!<CR>

" вкл/выкл подсветки слова, на котором расположен курсор
imap <C-F10> <Esc>:set invhls<CR>:exec "let @/='\\<".expand("<cword>")."\\>'"<CR>a
nmap <C-F10> :set invhls<CR>:exec "let @/='\\<".expand("<cword>")."\\>'"<CR>

" более привычный PgUp & PgDn
nmap <PageUp> <C-u><C-u>
imap <PageUp> <C-o><C-u><C-o><C-u>
nmap <PageDown> <C-d><C-d>
imap <PageDown> <C-o><C-d><C-o><C-d>

" С-q - выход из Vim
nmap <C-Q> :qa<cr>
imap <C-Q> <esc>:qa<cr>


" Some people find spaces and tabs at the end of a line useless, wasteful, and
" ugly.  To remove whitespace at the end of every line, execute the following
" command: (c) vim help
" удаляем лишние пробелы, табы в конце строк

" nmap <S-F7> :%s/\s\+$//<cr>
" imap <S-F7> <esc>:%s/\s\+$//<cr>
nnoremap <silent> <S-F7> :call <SID>StripTrailingWhitespaces()<CR>
inoremap <silent> <S-F7> <esc>:call <SID>StripTrailingWhitespaces()<CR>a


" показываем/скрываем табы, лишние завершающие пробелы
set listchars=eol:$,tab:>-,trail:-,precedes:<,extends:>
function! ListCharsToggle()
    if exists("g:show_list")
        unlet g:show_list
        set nolist
        echo "nolist"
    else
        let g:show_list = 1
        set list
        echo "list"
    endif
endfunction
nnoremap <silent> <C-F3> :call ListCharsToggle()<cr>
inoremap <silent> <C-F3> <esc>:call ListCharsToggle()<cr>a



" < & > - делаем отступы для блоков
" так, чтобы не пропадало выделение - удобно
vmap < <gv
vmap > >gv


" ходить по длинным строкам с зажатым Alt
nmap <a-down> gj
nmap <a-up> gk
imap <a-up> <esc>gka
imap <a-down> <esc>gja

" enable eclipse style moving of lines
nmap <c-j> mz:m+<CR>`z==
nmap <c-k> mz:m-2<CR>`z==
imap <c-j> <Esc>:m+<CR>==gi
imap <c-k> <Esc>:m-2<CR>==gi
vmap <c-j> :m'>+<CR>gv=`<my`>mzgv`yo`z
vmap <c-k> :m'<-2<CR>gv=`>my`<mzgv`yo`z

nmap <leader>= :call ExecAstyle()<cr>
function! ExecAstyle()
    set equalprg=~/.vim/utils/astyle.sh
    exe "normal gg=G"
    set equalprg=
endfunction

" вставить новую строку находясь в нормальном режиме
" внизу текущей строки
nmap f o<esc>k
" вверху текущей строки
nmap <S-f> O<esc>j
" вставить пробел из нормального режима
nmap <space> i<space><esc>


" при пролистывании стрелками курсор не доходит до последней строки
" на эту величину
set scrolloff=3


if has("syntax")

    nmap <leader>s :set spell!<CR>
    set spelllang=ru,en

    " вкл/выкл подсвечивание всех символов свыше 80
    function! Highlight_80_symbol_toggle()
        if exists("g:show_80")
            unlet g:show_80
            match NONE '\%>80v.\+'
            echo "highlight 80 symbol off"
        else
            let g:show_80 = 1
            match ErrorMsg '\%>80v.\+'
            echo "highlight 80 symbol on"
        endif
    endfunction

    nmap <C-s>d :call Highlight_80_symbol_toggle()<cr>

    function! Highlight_cursor_line_toggle()
        if !exists("s:highlight_cursor")
            match Todo /^.*\%#.*$/
            let s:highlight_cursor = 1
        else
            match None
            unlet s:highlight_cursor
        endif
    endfunction

    map <C-f> <esc>:call Highlight_cursor_line_toggle()<cr>
endif " has("syntax")




"------------------------------------------------------------------------
"                       поиск в файлах, буферах и пр.
"------------------------------------------------------------------------
" используется plugin grep.vim
" добавил в plugin возможность использовать моё окно для просмотра
" результатов QFix()

let Grep_Default_Filelist = '*.[cC] *.[hH] *.[sS] *.[cC][pP][pP] *.[cC][cC]'

let Grep_Skip_Dirs = '.svn .git CVS .hg'

" найти слово под курсором

" первый вариант
" map <S-F8> :vim <cword> **/*.c **/*.h <Bar> cw 15<CR>
" imap <S-F8> <esc>:vim <cword> **/*.c **/*.h <Bar> cw 15<CR>

" второй вариант
" nmap <S-F8> :execute "vimgrep /" . expand("<cword>") . "/j **/*.c **/*.h" <Bar> QFix<CR>
" imap <S-F8> <esc>:execute "vimgrep /" . expand("<cword>") . "/j **/*.c **/*.h" <Bar> QFix<CR>

" поиск слова с использованием plugin'a grep.vim
nmap <S-F8> :Rgrep<cr>
imap <S-F8> <esc>:Rgrep<cr>

func! InsertFileName()
    let cmd = getcmdline() . expand("%:p:t")
    " place the cursor on the )
    call setcmdpos(strlen(cmd))
    return cmd
endfunc

cmap <C-r><C-f> <C-\>eInsertFileName()<cr>




"------------------------------------------------------------------------
"                       работа с буферами обмена, строками
"------------------------------------------------------------------------

" нажимать перед вставкой из внешнего клипбоарда
set pastetoggle=<S-F11>

" C-y - удаление текущей строки
nmap <C-y> dd
imap <C-y> <esc>ddi

" C-d - дублирование текущей строки
imap <C-d> <esc>yypi

"source $VIMRUNTIME/mswin.vim

" taken from /usr/local/share/vim/vim71/mswin.vim file
" Set options and add mapping such that Vim behaves a lot like MS-Windows
"
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last change:  2006 Apr 02

" bail out if this isn't wanted (mrsvim.vim uses this).
if exists("g:skip_loading_mswin") && g:skip_loading_mswin
  finish
endif

" set the 'cpoptions' to its Vim default
if 1    " only do this when compiled with expression evaluation
  let s:save_cpo = &cpoptions
endif
set cpo&vim

" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
behave mswin

" CTRL-X and SHIFT-Del are Cut
"vnoremap <C-X> "+x
vnoremap <C-X> "+xgV
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
"vnoremap <C-C> "+yi
vnoremap <C-C> "+ygV
vnoremap <C-Insert> "+yi

" CTRL-V and SHIFT-Insert are Paste
map <C-V>               "+gP
map <S-Insert>          "+gP

cmap <C-V>              <C-R>+
cmap <S-Insert>         <C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

imap <S-Insert>         <C-V>
vmap <S-Insert>         <C-V>

" Use CTRL-B to do what CTRL-V used to do
noremap <C-B>           <C-V>


" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  " set guioptions-=a
endif


" restore 'cpoptions'
set cpo&
if 1
  let &cpoptions = s:save_cpo
  unlet s:save_cpo
endif




"------------------------------------------------------------------------------
"                                   работа с табами
"------------------------------------------------------------------------------

nmap <F3> :tabnew<cr>
imap <F3> <esc>:tabnew<cr>

nmap <C-F4> :tabclose<cr>
imap <C-F4> <esc>:tabclose<cr>

set guitablabel=%t




"------------------------------------------------------------------------------
"                                   cscope
"------------------------------------------------------------------------------

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


"------------------------------------------------------------------------------
"                           работа с ошибками и компилятором
"------------------------------------------------------------------------------

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

" F9 - "saveall + make" команда
nmap <F9> :wa<cr>:make!<cr>
imap <F9> <esc>:wa<cr>:make!<cr>

" ctrl+F9 - "make clean" команда
nmap <C-F9> :make! clean<cr>
imap <C-F9> <esc>:make! clean<cr>

" shift+F9 - "saveall + make clean + make" команда
nmap <S-F9> :wa<cr>:make! clean<cr>:make!<cr>
imap <S-F9> <esc>:wa<cr>:make! clean<cr>:make!<cr>




"------------------------------------------------------------------------------
"                                 работа с буферами
"------------------------------------------------------------------------------
" используется плагин bufexplorer

" F5 - просмотр списка буферов
nmap <F5> :BufExplorer<cr>
imap <F5> <esc>:BufExplorer<cr>

" F10 - удалить буфер
nmap <F10> :bd<cr>
imap <F10> <esc>:bd<cr>

" предыдущий буфер
nmap <C-Left> :bp<cr>
imap <C-Left> <esc>:bp<cr>i

" следующий буфер
nmap <C-Right> :bn<cr>
imap <C-Right> <esc>:bn<cr>i

let g:bufExplorerSortBy='mru'




"------------------------------------------------------------------------------
"                            выбор кодировки файла
"------------------------------------------------------------------------------

if has("wildmenu") && has("multi_byte")
    set wildmenu
    set wcm=<Tab>
    menu Encoding.koi8-r :e ++enc=8bit-koi8-r<CR>
    menu Encoding.windows-1251 :e ++enc=8bit-cp1251<CR>
    menu Encoding.ibm-866 :e ++enc=8bit-ibm866<CR>
    menu Encoding.utf-8 :e ++enc=2byte-utf-8 <CR>
    menu Encoding.ucs-2le :e ++enc=ucs-2le<CR>
    nmap <C-s>f :emenu Encoding.<TAB>
endif " has("wildmenu") && has("multi_byte")




"------------------------------------------------------------------------------
"                          выбор символа окончания файла
"------------------------------------------------------------------------------

if has("wildmenu") && has("multi_byte")
    set wildmenu
    set wcm=<Tab>
    menu EndOfLine.dos :e ++fileformat=dos<CR>
    menu EndOfLine.unix :e ++fileformat=unix<CR>
    menu EndOfLine.macos :e ++fileformat=mac<CR>
    nmap <C-s>e :emenu EndOfLine.<TAB>
endif " has("wildmenu") && has("multi_byte")



"------------------------------------------------------------------------------
"                               работа с diff
"------------------------------------------------------------------------------

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

    if has("scrollbind")
        set scrollbind
        set scrollopt="ver,hor,jump"
    endif

    if &diff
        au VimEnter * windo set foldcolumn=0
        au VimEnter * windo syntax off
        au VimEnter * windo set diffopt=filler,context:8
        if v:version >= 703 && has("gui_running")
            au VimEnter * windo set cc=0
        endif
    endif

endif " diff


"------------------------------------------------------------------------------
"                                 работаем с тэгами
"------------------------------------------------------------------------------
" используется плагин taglist

" F4 - обновить тэги
" параметры ctags соответствуют требованиям плагина omnicppcomplete
"nmap <F4> :call generate_tags()<cr>
"imap <F4> <esc>:call generate_tags.sh<cr>a

" F11 - показать окно Taglist и перейти туда (выход отлично работает по q)
nmap <F11> :TlistOpen<cr>
imap <F11> <esc>:TlistOpen<cr>

" закрывать откно Taglist при выборе тэга
let g:Tlist_Close_On_Select=1

let Tlist_Enable_Fold_Column = 0

let Tlist_Show_One_File = 1

" использую свою, статическую сборку exuberant-ctags
if (hostname() == "skip.nkbvs.tsure.ru")
    let Tlist_Ctags_Cmd = "/home/skip/.vim/utils/ctags_i686"
elseif (hostname() == "skip-note")
    let Tlist_Ctags_Cmd = "/home/skip/.vim/utils/ctags_pentium_dual_core"
else
    let Tlist_Ctags_Cmd = "/home/skip/.vim/utils/ctags_i686"
endif


" если тэгов много, то будет открываться окно с вариантами
" если тэг один, то будет произведене сразу переход
nmap <C-]> g<C-]>zz
imap <C-]> <esc>g<C-]>zzi
imap <C-t> <esc><C-t>zzi

" открыть тэг в новом табе и начать редактирование
map <c-w>] <c-w>]:tab split<cr>gT:q<cr>gt




"------------------------------------------------------------------------------
"                             Работа с комментариями
"------------------------------------------------------------------------------

map <F6> :DoComment<cr>j
map <S-F6> :DoUnComment<cr>j
imap <F6> <esc>:DoComment<cr>ja
imap <S-F6> <esc>:DoUnComment<cr>ja




"------------------------------------------------------------------------------
"                             Работа с автодополнениями
"------------------------------------------------------------------------------

" используются plugin'ы omnicppcomplete, supertab

set completeopt="menuone,preview"

" Tab для omni completion
"imap <S-Tab> <C-X><C-O>

let OmniCpp_MayCompleteScope = 1
let OmniCpp_ShowPrototypeInAbbr = 1



"------------------------------------------------------------------------------
"                             Работа с файловой системой
"------------------------------------------------------------------------------
" используется plugin NERD_tree (перешел на netrw)

" let g:NERDTreeMapActivateNode="<cr>"
" let g:NERDTreeQuitOnOpen=1
" let g:NERDTreeHijackNetrw=0

" обозреватель файлов, используется плагин NERD_tree
" nmap <F12> :NERDTreeToggle<cr>
" imap <F12> <esc>:NERDTreeToggle<cr>
nmap <F12> :e.<cr>
imap <F12> <esc>:e.<cr>





"-----------------------------------------------------------------------------
"-----------------------------------------------------------------------------
"-----------------------------------------------------------------------------


if has("wildmenu")
    set wildmenu
    "set wildmode=list,full
    set wildmode=list:longest,full
endif " wildmenu


" Search pattern for the tag command is remembered for
" "n" command.  Otherwise Vim only puts the pattern in
" the history for search pattern, but doesn't change the
" last used search pattern.
set cpoptions+=t


" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    if $TERM == "xterm" || $TERM == "xterm-linux"
        " Если ваш терминал поддерживает 256 цветов (вроде все новые
        " версии на данный момент), лучше это поставить:
        set t_Co=256
        " Make sure you put this _before_ the ":syntax enable" command,
        " otherwise the colors will already have been set.
        set background=dark
        syntax enable
        colorscheme ir_black
        set hlsearch

        " теперь сможем выделять зажав шифт и используя стрелки, pgup, pgdown
        set keymodel=startsel
    elseif $TERM == "linux"
        syntax enable
        colorscheme default
        set hlsearch
    else
        " unknown - try to enable syntax
        syntax enable
        set hlsearch
    endif

    " extended C syntax in c.vim for gcc
    let c_gnu = 1

endif

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype on
    filetype indent on
    filetype plugin on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!


        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif

    augroup END

    autocmd FileType c,cpp,java,asm,make,sh,vim autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

    au FileType automake,make setlocal list noexpandtab

    autocmd BufWinEnter * if getbufvar('%', '&buftype') == "quickfix" | set nocursorline | endif

    if v:version >= 703 && has("gui_running")
        au BufWinEnter * if getbufvar('%', '&filetype') == "cpp" ||
                    \ getbufvar('%', '&filetype') == "c"         ||
                    \ getbufvar('%', '&filetype') == "asm" | set cc=81 | else | set cc=0 | endif
    endif

    " for rtos baget 2.0 asm dump file viewing
    au BufRead oc2000.s setlocal ts=8 sts=8 sw=8 noexpandtab

    au BufEnter *.atoll set ft=atoll
    au BufEnter *akefile* set ft=make

else

    set autoindent        " always set autoindenting on

endif " has("autocmd")

set maxmem=2000000 " Maximum value 2000000. Use this to work without a limit.
set maxmemtot=2000000 " Maximum value 2000000. Use this to work without a limit.
set maxmempattern=2000000 " Maximum value 2000000. Use this to work without a limit.


" vim-autocomplpop plugin settings
" let g:acp_enableAtStartup = 0
" let g:acp_ignorecaseOption = 0
" let g:acp_behaviorKeywordLength = 5
" let g:acp_mappingDriven = 1
" autocmd FileType c,cpp,java,asm AcpEnable

set shm+=I

" let b:TypesFileLanguages = ['c', 'cpp'] " ctags_highlighting

" let g:EchoFuncLangsUsed = ["c","cpp"]
let g:EchoFuncLangsUsed = ["c"]

nmap <C-_>   mF:call SmartTag#SmartTag("goto")<CR>
imap <C-_>   <esc>mF:call SmartTag#SmartTag("goto")<CR>

set cinoptions=l1,g0

autocmd BufEnter svn-commit.tmp call setpos('.', [0, 1, 1, 0])

function! QfMakeConv()
    if &enc != &tenc
        let qflist = getqflist()
        for i in qflist
            let i.text = iconv(i.text, &tenc, &enc)
        endfor
        call setqflist(qflist)
    endif
endfunction

au QuickfixCmdPost make call QfMakeConv()

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

" if &enc != &tenc
    " set viminfo='100,<50,s10,h,n~/viminfo_koi8r
    " echo &viminfo
" endif

if v:version >= 703
    set conceallevel=0
endif

" Change name_with_underscores to NamesInCameCase for visually selected text.
" mnemonic *c*amelCase
vmap <leader>cc :s/_\([a-z]\)/\u\1/g<CR>

" Change CamelCase to name_with_underscore for visually selected text.
" mnemonic *u*nderscores.
vmap <leader>cu :s/\<\@!\([A-Z]\)/\_\l\1/g<CR>gul

noremap  <expr> <Home> (col('.') == matchend(getline('.'), '^\s*')+1 ? '0'  : '^')
" noremap  <expr> <End>  (col('.') == match(getline('.'),    '\s*$')   ? '$'  : 'g_')
" vnoremap <expr> <End>  (col('.') == match(getline('.'),    '\s*$')   ? '$h' : 'g_')
imap <Home> <C-o><Home>
" imap <End>  <C-o><End>

" select previously inserted text
nnoremap gp `[v`]

set formatprg=par\ w80
