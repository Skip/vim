let b:CommentType = "cpp"
let b:beginOfCommentSingle = "// "
let b:endOfCommentSingle = ""
let b:beginOfCommentMulti = "/*"
let b:endOfCommentMulti = "*/"

" обновить тэги, ctags_highlight
nmap <F4> :wa<cr>:!~/.vim/utils/generate_tags.sh<cr>:UpdateTypesFileOnly<cr>
imap <F4> <esc>:wa<cr>:!~/.vim/utils/generate_tags.sh<cr>:UpdateTypesFileOnly<cr>a

" обновить cscope
nmap <leader>9 :!~/.vim/utils/generate_cscope.sh<cr>:cs kill 0<cr>:cs add cscope.out<cr>
imap <leader>9 <esc>:!~/.vim/utils/generate_cscope.sh<cr>:cs kill 0<cr>:cs add cscope.out<cr>a

