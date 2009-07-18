let b:CommentType = "java"
let b:beginOfCommentSingle = "// "
let b:endOfCommentSingle = ""
let b:beginOfCommentMulti = "/*"
let b:endOfCommentMulti = "*/"

nmap <F4> :!generate_tags_java.sh<cr>
imap <F4> <esc>:!generate_tags_java.sh<cr>a

" обновить cscope
nmap <leader>9 :!generate_cscope_java.sh<cr>:cs kill 0<cr>:cs add cscope.out<cr>
imap <leader>9 <esc>:!generate_cscope_java.sh<cr>:cs kill 0<cr>:cs add cscope.out<cr>a

