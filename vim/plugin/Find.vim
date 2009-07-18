" :Find Makefile
" 1 ./src/Makefile
" 2 ./src/core/Makefile
" 3 ./src/api/Makefile
" ...
" 89 ./src/deelply/hidden/Makefile
" 90 ./Makefile
" Which ? (CR=nothing)
"
" :Find *stream*.c
" 1 ./src/core/i_stream.c
" 2 ./src/core/o_stream.c
" 3 ./src/core/streamio.c
" Which ? (CR=nothing)

function! Find(name)
  let l:list=system("find . -name '".a:name."' | grep -v \".svn/\" | perl -ne 'print \"$.\\t$_\"'")
  let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
  if l:num < 1
    echo "'".a:name."' not found"
    return
  endif
  if l:num != 1
    echo l:list
    let l:input=input("Which ? (CR=nothing)\n")
    if strlen(l:input)==0
      return
    endif
    if strlen(substitute(l:input, "[0-9]", "", "g"))>0
      echo "Not a number"
      return
    endif
    if l:input<1 || l:input>l:num
      echo "Out of range"
      return
    endif
    let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
  else
    let l:line=l:list
  endif
  let l:line=substitute(l:line, "^[^\t]*\t./", "", "")
  execute ":e ".l:line
endfunction

command! -nargs=1 Find :call Find("<args>")
