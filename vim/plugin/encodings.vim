if exists("g:loaded_encodings_plugin")
    finish
endif
let g:loaded_encodings_plugin = 1

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

