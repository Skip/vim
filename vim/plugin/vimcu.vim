"***********************************************************************

  " Comment / UnComment
  "
  " Comment differently single line comments and multiple line comments.
  " Strings that begins and ends comments are contained in variables:
  " b:beginOfCommentSingle, b:endOfCommentSingle, b:beginOfCommentMulti,
  " b:endOfCommentMulti; these variables have to be defined in order to
  " use Comment and UnComment. The variable b:CommentType specify which
  " comment are available, this variable contains one or more of the
  " following flag 's', 'm'; 's' means that single line comments are
  " available, 'm' means that multiple line comments are available. If
  " 'm' is not set, multiple line comments are threaded line by line as
  " a single comment.

function! SingleLineComment(lineno)
  let line = getline(a:lineno)
  let line = substitute(line, "^", "/* ", "")
  let line = substitute(line, "$", " */", "")
  " let line = substitute(line, "^", b:beginOfCommentSingle, "")
  " let line = substitute(line, "$", b:endOfCommentSingle, "")
  call setline(a:lineno, line)
endfunction

function! MultiLineComment(line1, line2)
    call append(a:line2, "#endif /* 0 */")
    call append(a:line1 - 1, "#if 0")
endfunction

function! SingleLineUnComment(lineno)
  let line = getline(a:lineno)
  let line = substitute(line, "^".escape("/* ", "*"), "", "")
  let line = substitute(line, escape(" */", "*")."$", "", "")
  " let line = substitute(line, "^".escape(b:beginOfCommentSingle, "*"), "", "")
  " let line = substitute(line, escape(b:endOfCommentSingle, "*")."$", "", "")
  call setline(a:lineno, line)
endfunction

function! MultiLineUnComment(line1, line2)
    execute a:line2."d"
    execute a:line1."d"
endfunction

function! CommentC(line1, line2)
    if a:line1 != a:line2
        call MultiLineComment(a:line1, a:line2)
    else
        call SingleLineComment(a:line1)
    endif
endfunction

function! UnCommentC(line1, line2)
    if a:line1 != a:line2
        call MultiLineUnComment(a:line1, a:line2)
    else
        call SingleLineUnComment(a:line1)
    endif
endfunction

" assign function to user defined command Commend and UnComment
command! -range CommentC call CommentC(<line1>, <line2>)
command! -range UnCommentC call UnCommentC(<line1>, <line2>)

" default settings
let b:CommentType = "m"   " only single line comments enabled by default
let b:beginOfCommentSingle = "/* "
let b:endOfCommentSingle = " */"
let b:beginOfCommentMulti = "#if 0"
let b:endOfCommentMulti = "#endif /* 0 */"

