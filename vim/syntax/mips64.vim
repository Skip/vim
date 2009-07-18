" Vim syntax file
" Language:	C
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2008 Mar 19

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" A bunch of useful C keywords
syn keyword	cStatement	goto break return continue asm
syn keyword	cLabel		case default
syn keyword	cConditional	if else switch
syn keyword	cRepeat		while for do

syn keyword	cTodo		contained TODO FIXME XXX

" cCommentGroup allows adding matches for special things in comments
syn cluster	cCommentGroup	contains=cTodo

" String and Character constants
" Highlight special characters (those which have a backslash) differently
syn match	cSpecial	display contained "\\\(x\x\+\|\o\{1,3}\|.\|$\)"
if !exists("c_no_utf")
  syn match	cSpecial	display contained "\\\(u\x\{4}\|U\x\{8}\)"
endif
if exists("c_no_cformat")
  syn region	cString		start=+L\="+ skip=+\\\\\|\\"+ end=+"+ contains=cSpecial,@Spell
  " cCppString: same as cString, but ends at end of line
  syn region	cCppString	start=+L\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end='$' contains=cSpecial,@Spell
else
  if !exists("c_no_c99") " ISO C99
    syn match	cFormat		display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlLjzt]\|ll\|hh\)\=\([aAbdiuoxXDOUfFeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained
  else
    syn match	cFormat		display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlL]\|ll\)\=\([bdiuoxXDOUfeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained
  endif
  syn match	cFormat		display "%%" contained
  syn region	cString		start=+L\="+ skip=+\\\\\|\\"+ end=+"+ contains=cSpecial,cFormat,@Spell
  " cCppString: same as cString, but ends at end of line
  syn region	cCppString	start=+L\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end='$' contains=cSpecial,cFormat,@Spell
endif

syn match	cCharacter	"L\='[^\\]'"
syn match	cCharacter	"L'[^']*'" contains=cSpecial
if exists("c_gnu")
  syn match	cSpecialError	"L\='\\[^'\"?\\abefnrtv]'"
  syn match	cSpecialCharacter "L\='\\['\"?\\abefnrtv]'"
else
  syn match	cSpecialError	"L\='\\[^'\"?\\abfnrtv]'"
  syn match	cSpecialCharacter "L\='\\['\"?\\abfnrtv]'"
endif
syn match	cSpecialCharacter display "L\='\\\o\{1,3}'"
syn match	cSpecialCharacter display "'\\x\x\{1,2}'"
syn match	cSpecialCharacter display "L'\\x\x\+'"

"when wanted, highlight trailing white space
if exists("c_space_errors")
  if !exists("c_no_trail_space_error")
    syn match	cSpaceError	display excludenl "\s\+$"
  endif
  if !exists("c_no_tab_space_error")
    syn match	cSpaceError	display " \+\t"me=e-1
  endif
endif

" This should be before cErrInParen to avoid problems with #define ({ xxx })
if exists("c_curly_error")
  syntax match cCurlyError "}"
  syntax region	cBlock		start="{" end="}" contains=ALLBUT,cCurlyError,@cParenGroup,cErrInParen,cCppParen,cErrInBracket,cCppBracket,cCppString,@Spell fold
else
  syntax region	cBlock		start="{" end="}" transparent fold
endif

"catch errors caused by wrong parenthesis and brackets
" also accept <% for {, %> for }, <: for [ and :> for ] (C99)
" But avoid matching <::.
syn cluster	cParenGroup	contains=cParenError,cIncluded,cSpecial,cCommentSkip,cCommentString,cComment2String,@cCommentGroup,cCommentStartError,cUserCont,cUserLabel,cBitField,cOctalZero,cCppOut,cCppOut2,cCppSkip,cFormat,cNumber,cFloat,cOctal,cOctalError,cNumbersCom
if exists("c_no_curly_error")
  syn region	cParen		transparent start='(' end=')' contains=ALLBUT,@cParenGroup,cCppParen,cCppString,@Spell
  " cCppParen: same as cParen but ends at end-of-line; used in cDefine
  syn region	cCppParen	transparent start='(' skip='\\$' excludenl end=')' end='$' contained contains=ALLBUT,@cParenGroup,cParen,cString,@Spell
  syn match	cParenError	display ")"
  syn match	cErrInParen	display contained "^[{}]\|^<%\|^%>"
elseif exists("c_no_bracket_error")
  syn region	cParen		transparent start='(' end=')' contains=ALLBUT,@cParenGroup,cCppParen,cCppString,@Spell
  " cCppParen: same as cParen but ends at end-of-line; used in cDefine
  syn region	cCppParen	transparent start='(' skip='\\$' excludenl end=')' end='$' contained contains=ALLBUT,@cParenGroup,cParen,cString,@Spell
  syn match	cParenError	display ")"
  syn match	cErrInParen	display contained "[{}]\|<%\|%>"
else
  syn region	cParen		transparent start='(' end=')' contains=ALLBUT,@cParenGroup,cCppParen,cErrInBracket,cCppBracket,cCppString,@Spell
  " cCppParen: same as cParen but ends at end-of-line; used in cDefine
  syn region	cCppParen	transparent start='(' skip='\\$' excludenl end=')' end='$' contained contains=ALLBUT,@cParenGroup,cErrInBracket,cParen,cBracket,cString,@Spell
  syn match	cParenError	display "[\])]"
  syn match	cErrInParen	display contained "[\]{}]\|<%\|%>"
  syn region	cBracket	transparent start='\[\|<::\@!' end=']\|:>' contains=ALLBUT,@cParenGroup,cErrInParen,cCppParen,cCppBracket,cCppString,@Spell
  " cCppBracket: same as cParen but ends at end-of-line; used in cDefine
  syn region	cCppBracket	transparent start='\[\|<::\@!' skip='\\$' excludenl end=']\|:>' end='$' contained contains=ALLBUT,@cParenGroup,cErrInParen,cParen,cBracket,cString,@Spell
  syn match	cErrInBracket	display contained "[);{}]\|<%\|%>"
endif

"integer number, or floating point number without a dot and with "f".
syn case ignore
syn match	cNumbers	display transparent "\<\d\|\.\d" contains=cNumber,cFloat,cOctalError,cOctal
" Same, but without octal error (for comments)
syn match	cNumbersCom	display contained transparent "\<\d\|\.\d" contains=cNumber,cFloat,cOctal
syn match	cNumber		display contained "\d\+\(u\=l\{0,2}\|ll\=u\)\>"
"hex number
syn match	cNumber		display contained "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"
" Flag the first zero of an octal number as something special
syn match	cOctal		display contained "0\o\+\(u\=l\{0,2}\|ll\=u\)\>" contains=cOctalZero
syn match	cOctalZero	display contained "\<0"
syn match	cFloat		display contained "\d\+f"
"floating point number, with dot, optional exponent
syn match	cFloat		display contained "\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\="
"floating point number, starting with a dot, optional exponent
syn match	cFloat		display contained "\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
"floating point number, without dot, with exponent
syn match	cFloat		display contained "\d\+e[-+]\=\d\+[fl]\=\>"
if !exists("c_no_c99")
  "hexadecimal floating point number, optional leading digits, with dot, with exponent
  syn match	cFloat		display contained "0x\x*\.\x\+p[-+]\=\d\+[fl]\=\>"
  "hexadecimal floating point number, with leading digits, optional dot, with exponent
  syn match	cFloat		display contained "0x\x\+\.\=p[-+]\=\d\+[fl]\=\>"
endif

" flag an octal number with wrong digits
syn match	cOctalError	display contained "0\o*[89]\d*"
syn case match

if exists("c_comment_strings")
  " A comment can contain cString, cCharacter and cNumber.
  " But a "*/" inside a cString in a cComment DOES end the comment!  So we
  " need to use a special type of cString: cCommentString, which also ends on
  " "*/", and sees a "*" at the start of the line as comment again.
  " Unfortunately this doesn't very well work for // type of comments :-(
  syntax match	cCommentSkip	contained "^\s*\*\($\|\s\+\)"
  syntax region cCommentString	contained start=+L\=\\\@<!"+ skip=+\\\\\|\\"+ end=+"+ end=+\*/+me=s-1 contains=cSpecial,cCommentSkip
  syntax region cComment2String	contained start=+L\=\\\@<!"+ skip=+\\\\\|\\"+ end=+"+ end="$" contains=cSpecial
  syntax region  cCommentL	start="//" skip="\\$" end="$" keepend contains=@cCommentGroup,cComment2String,cCharacter,cNumbersCom,cSpaceError,@Spell
  if exists("c_no_comment_fold")
    " Use "extend" here to have preprocessor lines not terminate halfway a
    " comment.
    syntax region cComment	matchgroup=cCommentStart start="/\*" end="\*/" contains=@cCommentGroup,cCommentStartError,cCommentString,cCharacter,cNumbersCom,cSpaceError,@Spell extend
  else
    syntax region cComment	matchgroup=cCommentStart start="/\*" end="\*/" contains=@cCommentGroup,cCommentStartError,cCommentString,cCharacter,cNumbersCom,cSpaceError,@Spell fold extend
  endif
else
  syn region	cCommentL	start="//" skip="\\$" end="$" keepend contains=@cCommentGroup,cSpaceError,@Spell
  if exists("c_no_comment_fold")
    syn region	cComment	matchgroup=cCommentStart start="/\*" end="\*/" contains=@cCommentGroup,cCommentStartError,cSpaceError,@Spell extend
  else
    syn region	cComment	matchgroup=cCommentStart start="/\*" end="\*/" contains=@cCommentGroup,cCommentStartError,cSpaceError,@Spell fold extend
  endif
endif
" keep a // comment separately, it terminates a preproc. conditional
syntax match	cCommentError	display "\*/"
syntax match	cCommentStartError display "/\*"me=e-1 contained

syn keyword	cOperator	sizeof
if exists("c_gnu")
  syn keyword	cStatement	__asm__
  syn keyword	cOperator	typeof __real__ __imag__
endif
syn keyword	cType		int long short char void
syn keyword	cType		signed unsigned float double
if !exists("c_no_ansi") || exists("c_ansi_typedefs")
  syn keyword   cType		size_t ssize_t off_t wchar_t ptrdiff_t sig_atomic_t fpos_t
  syn keyword   cType		clock_t time_t va_list jmp_buf FILE DIR div_t ldiv_t
  syn keyword   cType		mbstate_t wctrans_t wint_t wctype_t
endif
if !exists("c_no_c99") " ISO C99
  syn keyword	cType		bool complex
  syn keyword	cType		int8_t int16_t int32_t int64_t
  syn keyword	cType		uint8_t uint16_t uint32_t uint64_t
  syn keyword	cType		int_least8_t int_least16_t int_least32_t int_least64_t
  syn keyword	cType		uint_least8_t uint_least16_t uint_least32_t uint_least64_t
  syn keyword	cType		int_fast8_t int_fast16_t int_fast32_t int_fast64_t
  syn keyword	cType		uint_fast8_t uint_fast16_t uint_fast32_t uint_fast64_t
  syn keyword	cType		intptr_t uintptr_t
  syn keyword	cType		intmax_t uintmax_t
endif
if exists("c_gnu")
  syn keyword	cType		__label__ __complex__ __volatile__
endif

syn keyword	cStructure	struct union enum typedef
syn keyword	cStorageClass	static register auto volatile extern const
if exists("c_gnu")
  syn keyword	cStorageClass	inline __attribute__
endif
if !exists("c_no_c99")
  syn keyword	cStorageClass	inline restrict
endif

if !exists("c_no_ansi") || exists("c_ansi_constants") || exists("c_gnu")
  if exists("c_gnu")
    syn keyword cConstant __GNUC__ __FUNCTION__ __PRETTY_FUNCTION__ __func__
  endif
  syn keyword cConstant __LINE__ __FILE__ __DATE__ __TIME__ __STDC__
  syn keyword cConstant __STDC_VERSION__
  syn keyword cConstant CHAR_BIT MB_LEN_MAX MB_CUR_MAX
  syn keyword cConstant UCHAR_MAX UINT_MAX ULONG_MAX USHRT_MAX
  syn keyword cConstant CHAR_MIN INT_MIN LONG_MIN SHRT_MIN
  syn keyword cConstant CHAR_MAX INT_MAX LONG_MAX SHRT_MAX
  syn keyword cConstant SCHAR_MIN SINT_MIN SLONG_MIN SSHRT_MIN
  syn keyword cConstant SCHAR_MAX SINT_MAX SLONG_MAX SSHRT_MAX
  if !exists("c_no_c99")
    syn keyword cConstant __func__
    syn keyword cConstant LLONG_MIN LLONG_MAX ULLONG_MAX
    syn keyword cConstant INT8_MIN INT16_MIN INT32_MIN INT64_MIN
    syn keyword cConstant INT8_MAX INT16_MAX INT32_MAX INT64_MAX
    syn keyword cConstant UINT8_MAX UINT16_MAX UINT32_MAX UINT64_MAX
    syn keyword cConstant INT_LEAST8_MIN INT_LEAST16_MIN INT_LEAST32_MIN INT_LEAST64_MIN
    syn keyword cConstant INT_LEAST8_MAX INT_LEAST16_MAX INT_LEAST32_MAX INT_LEAST64_MAX
    syn keyword cConstant UINT_LEAST8_MAX UINT_LEAST16_MAX UINT_LEAST32_MAX UINT_LEAST64_MAX
    syn keyword cConstant INT_FAST8_MIN INT_FAST16_MIN INT_FAST32_MIN INT_FAST64_MIN
    syn keyword cConstant INT_FAST8_MAX INT_FAST16_MAX INT_FAST32_MAX INT_FAST64_MAX
    syn keyword cConstant UINT_FAST8_MAX UINT_FAST16_MAX UINT_FAST32_MAX UINT_FAST64_MAX
    syn keyword cConstant INTPTR_MIN INTPTR_MAX UINTPTR_MAX
    syn keyword cConstant INTMAX_MIN INTMAX_MAX UINTMAX_MAX
    syn keyword cConstant PTRDIFF_MIN PTRDIFF_MAX SIG_ATOMIC_MIN SIG_ATOMIC_MAX
    syn keyword cConstant SIZE_MAX WCHAR_MIN WCHAR_MAX WINT_MIN WINT_MAX
  endif
  syn keyword cConstant FLT_RADIX FLT_ROUNDS
  syn keyword cConstant FLT_DIG FLT_MANT_DIG FLT_EPSILON
  syn keyword cConstant DBL_DIG DBL_MANT_DIG DBL_EPSILON
  syn keyword cConstant LDBL_DIG LDBL_MANT_DIG LDBL_EPSILON
  syn keyword cConstant FLT_MIN FLT_MAX FLT_MIN_EXP FLT_MAX_EXP
  syn keyword cConstant FLT_MIN_10_EXP FLT_MAX_10_EXP
  syn keyword cConstant DBL_MIN DBL_MAX DBL_MIN_EXP DBL_MAX_EXP
  syn keyword cConstant DBL_MIN_10_EXP DBL_MAX_10_EXP
  syn keyword cConstant LDBL_MIN LDBL_MAX LDBL_MIN_EXP LDBL_MAX_EXP
  syn keyword cConstant LDBL_MIN_10_EXP LDBL_MAX_10_EXP
  syn keyword cConstant HUGE_VAL CLOCKS_PER_SEC NULL
  syn keyword cConstant LC_ALL LC_COLLATE LC_CTYPE LC_MONETARY
  syn keyword cConstant LC_NUMERIC LC_TIME
  syn keyword cConstant SIG_DFL SIG_ERR SIG_IGN
  syn keyword cConstant SIGABRT SIGFPE SIGILL SIGHUP SIGINT SIGSEGV SIGTERM
  " Add POSIX signals as well...
  syn keyword cConstant SIGABRT SIGALRM SIGCHLD SIGCONT SIGFPE SIGHUP
  syn keyword cConstant SIGILL SIGINT SIGKILL SIGPIPE SIGQUIT SIGSEGV
  syn keyword cConstant SIGSTOP SIGTERM SIGTRAP SIGTSTP SIGTTIN SIGTTOU
  syn keyword cConstant SIGUSR1 SIGUSR2
  syn keyword cConstant _IOFBF _IOLBF _IONBF BUFSIZ EOF WEOF
  syn keyword cConstant FOPEN_MAX FILENAME_MAX L_tmpnam
  syn keyword cConstant SEEK_CUR SEEK_END SEEK_SET
  syn keyword cConstant TMP_MAX stderr stdin stdout
  syn keyword cConstant EXIT_FAILURE EXIT_SUCCESS RAND_MAX
  " Add POSIX errors as well
  syn keyword cConstant E2BIG EACCES EAGAIN EBADF EBADMSG EBUSY
  syn keyword cConstant ECANCELED ECHILD EDEADLK EDOM EEXIST EFAULT
  syn keyword cConstant EFBIG EILSEQ EINPROGRESS EINTR EINVAL EIO EISDIR
  syn keyword cConstant EMFILE EMLINK EMSGSIZE ENAMETOOLONG ENFILE ENODEV
  syn keyword cConstant ENOENT ENOEXEC ENOLCK ENOMEM ENOSPC ENOSYS
  syn keyword cConstant ENOTDIR ENOTEMPTY ENOTSUP ENOTTY ENXIO EPERM
  syn keyword cConstant EPIPE ERANGE EROFS ESPIPE ESRCH ETIMEDOUT EXDEV
  " math.h
  syn keyword cConstant M_E M_LOG2E M_LOG10E M_LN2 M_LN10 M_PI M_PI_2 M_PI_4
  syn keyword cConstant M_1_PI M_2_PI M_2_SQRTPI M_SQRT2 M_SQRT1_2
endif
if !exists("c_no_c99") " ISO C99
  syn keyword cConstant true false
endif

" Accept %: for # (C99)
syn region	cPreCondit	start="^\s*\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" end="//"me=s-1 contains=cComment,cCppString,cCharacter,cCppParen,cParenError,cNumbers,cCommentError,cSpaceError
syn match	cPreCondit	display "^\s*\(%:\|#\)\s*\(else\|endif\)\>"
if !exists("c_no_if0")
  if !exists("c_no_if0_fold")
    syn region	cCppOut		start="^\s*\(%:\|#\)\s*if\s\+0\+\>" end=".\@=\|$" contains=cCppOut2 fold
  else
    syn region	cCppOut		start="^\s*\(%:\|#\)\s*if\s\+0\+\>" end=".\@=\|$" contains=cCppOut2
  endif
  syn region	cCppOut2	contained start="0" end="^\s*\(%:\|#\)\s*\(endif\>\|else\>\|elif\>\)" contains=cSpaceError,cCppSkip
  syn region	cCppSkip	contained start="^\s*\(%:\|#\)\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>" contains=cSpaceError,cCppSkip
endif
syn region	cIncluded	display contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match	cIncluded	display contained "<[^>]*>"
syn match	cInclude	display "^\s*\(%:\|#\)\s*include\>\s*["<]" contains=cIncluded
"syn match cLineSkip	"\\$"
syn cluster	cPreProcGroup	contains=cPreCondit,cIncluded,cInclude,cDefine,cErrInParen,cErrInBracket,cUserLabel,cSpecial,cOctalZero,cCppOut,cCppOut2,cCppSkip,cFormat,cNumber,cFloat,cOctal,cOctalError,cNumbersCom,cString,cCommentSkip,cCommentString,cComment2String,@cCommentGroup,cCommentStartError,cParen,cBracket,cMulti
syn region	cDefine		start="^\s*\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$" end="//"me=s-1 keepend contains=ALLBUT,@cPreProcGroup,@Spell
syn region	cPreProc	start="^\s*\(%:\|#\)\s*\(pragma\>\|line\>\|warning\>\|warn\>\|error\>\)" skip="\\$" end="$" keepend contains=ALLBUT,@cPreProcGroup,@Spell

" Highlight User Labels
syn cluster	cMultiGroup	contains=cIncluded,cSpecial,cCommentSkip,cCommentString,cComment2String,@cCommentGroup,cCommentStartError,cUserCont,cUserLabel,cBitField,cOctalZero,cCppOut,cCppOut2,cCppSkip,cFormat,cNumber,cFloat,cOctal,cOctalError,cNumbersCom,cCppParen,cCppBracket,cCppString
syn region	cMulti		transparent start='?' skip='::' end=':' contains=ALLBUT,@cMultiGroup,@Spell
" Avoid matching foo::bar() in C++ by requiring that the next char is not ':'
syn cluster	cLabelGroup	contains=cUserLabel
syn match	cUserCont	display "^\s*\I\i*\s*:$" contains=@cLabelGroup
syn match	cUserCont	display ";\s*\I\i*\s*:$" contains=@cLabelGroup
syn match	cUserCont	display "^\s*\I\i*\s*:[^:]"me=e-1 contains=@cLabelGroup
syn match	cUserCont	display ";\s*\I\i*\s*:[^:]"me=e-1 contains=@cLabelGroup

syn match	cUserLabel	display "\I\i*" contained

" Avoid recognizing most bitfields as labels
syn match	cBitField	display "^\s*\I\i*\s*:\s*[1-9]"me=e-1 contains=cType
syn match	cBitField	display ";\s*\I\i*\s*:\s*[1-9]"me=e-1 contains=cType

if exists("c_minlines")
  let b:c_minlines = c_minlines
else
  if !exists("c_no_if0")
    let b:c_minlines = 50	" #if 0 constructs can be long
  else
    let b:c_minlines = 15	" mostly for () constructs
  endif
endif
if exists("c_curly_error")
  syn sync fromstart
else
  exec "syn sync ccomment cComment minlines=" . b:c_minlines
endif

" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
hi def link cFormat		cSpecial
hi def link cCppString		cString
hi def link cCommentL		cComment
hi def link cCommentStart	cComment
hi def link cLabel		Label
hi def link cUserLabel		Label
hi def link cConditional	Conditional
hi def link cRepeat		Repeat
hi def link cCharacter		Character
hi def link cSpecialCharacter	cSpecial
hi def link cNumber		Number
hi def link cOctal		Number
hi def link cOctalZero		PreProc	 " link this to Error if you want
hi def link cFloat		Float
hi def link cOctalError		cError
hi def link cParenError		cError
hi def link cErrInParen		cError
hi def link cErrInBracket	cError
hi def link cCommentError	cError
hi def link cCommentStartError	cError
hi def link cSpaceError		cError
hi def link cSpecialError	cError
hi def link cCurlyError		cError
hi def link cOperator		Operator
hi def link cStructure		Structure
hi def link cStorageClass	StorageClass
hi def link cInclude		Include
hi def link cPreProc		PreProc
hi def link cDefine		Macro
hi def link cIncluded		cString
hi def link cError		Error
hi def link cStatement		Statement
hi def link cPreCondit		PreCondit
hi def link cType		Type
hi def link cConstant		Constant
hi def link cCommentString	cString
hi def link cComment2String	cString
hi def link cCommentSkip	cComment
hi def link cString		String
hi def link cComment		Comment
hi def link cSpecial		SpecialChar
hi def link cTodo		Todo
hi def link cCppSkip		cCppOut
hi def link cCppOut2		cCppOut
hi def link cCppOut		Comment

setlocal iskeyword+=-
syntax case match

" 32-bit hex numbers, specific for oc2000.s viewing
syntax match mipsNumber /[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]/
syntax match mipsNumber /\<[-]\?\d\+\>/ " Decimal numbers
syntax match mipsLabelColon /:/ contained
syntax match mipsLabel /\w\+:/ contains=mipsLabelColon


" Registers
syntax match mipsRegister "\<zero\>"
syntax match mipsRegister "\<v0\>"
syntax match mipsRegister "\<v1\>"
syntax match mipsRegister "\<a0\>"
syntax match mipsRegister "\<a1\>"
syntax match mipsRegister "\<a2\>"
syntax match mipsRegister "\<a3\>"
syntax match mipsRegister "\<t0\>"
syntax match mipsRegister "\<t1\>"
syntax match mipsRegister "\<t2\>"
syntax match mipsRegister "\<t3\>"
syntax match mipsRegister "\<t4\>"
syntax match mipsRegister "\<t5\>"
syntax match mipsRegister "\<t6\>"
syntax match mipsRegister "\<t7\>"
syntax match mipsRegister "\<t8\>"
syntax match mipsRegister "\<t9\>"
syntax match mipsRegister "\<s0\>"
syntax match mipsRegister "\<s1\>"
syntax match mipsRegister "\<s2\>"
syntax match mipsRegister "\<s3\>"
syntax match mipsRegister "\<s4\>"
syntax match mipsRegister "\<s5\>"
syntax match mipsRegister "\<s6\>"
syntax match mipsRegister "\<s7\>"
syntax match mipsRegister "\<s8\>"
syntax match mipsRegister "\<k0\>"
syntax match mipsRegister "\<k1\>"
syntax match mipsRegister "\<gp\>"
syntax match mipsRegister "\<sp\>"
syntax match mipsRegister "\<fp\>"
syntax match mipsRegister "\<ra\>"
syntax match mipsRegister "\<at\>"

syntax match mipsRegister "\$zero"
syntax match mipsRegister "\$v0"
syntax match mipsRegister "\$v1"
syntax match mipsRegister "\$a0"
syntax match mipsRegister "\$a1"
syntax match mipsRegister "\$a2"
syntax match mipsRegister "\$a3"
syntax match mipsRegister "\$t0"
syntax match mipsRegister "\$t1"
syntax match mipsRegister "\$t2"
syntax match mipsRegister "\$t3"
syntax match mipsRegister "\$t4"
syntax match mipsRegister "\$t5"
syntax match mipsRegister "\$t6"
syntax match mipsRegister "\$t7"
syntax match mipsRegister "\$t8"
syntax match mipsRegister "\$t9"
syntax match mipsRegister "\$s0"
syntax match mipsRegister "\$s1"
syntax match mipsRegister "\$s2"
syntax match mipsRegister "\$s3"
syntax match mipsRegister "\$s4"
syntax match mipsRegister "\$s5"
syntax match mipsRegister "\$s6"
syntax match mipsRegister "\$s7"
syntax match mipsRegister "\$k0"
syntax match mipsRegister "\$k1"
syntax match mipsRegister "\$gp"
syntax match mipsRegister "\$sp"
syntax match mipsRegister "\$fp"
syntax match mipsRegister "\$ra"

let i = 0
while i < 32
    " This is for the regular registers
    execute 'syntax match mipsRegister "\$' . i . '\(\d\+\)\@!"'
    " And this is for the FP registers
    execute 'syntax match mipsRegister "\$f' . i . '\(\d\+\)\@!"'
    let i = i + 1
endwhile

" Directives
syntax match mipsDirective "\.2byte"
syntax match mipsDirective "\.4byte"
syntax match mipsDirective "\.8byte"
syntax match mipsDirective "\.aent"
syntax match mipsDirective "\.align"
syntax match mipsDirective "\.aascii"
syntax match mipsDirective "\.asciiz"
syntax match mipsDirective "\.byte"
syntax match mipsDirective "\.comm"
syntax match mipsDirective "\.cpadd"
syntax match mipsDirective "\.cpload"
syntax match mipsDirective "\.cplocal"
syntax match mipsDirective "\.cprestore"
syntax match mipsDirective "\.cpreturn"
syntax match mipsDirective "\.cpsetup"
syntax match mipsDirective "\.data"
syntax match mipsDirective "\.double"
syntax match mipsDirective "\.dword"
syntax match mipsDirective "\.dynsym"
syntax match mipsDirective "\.end"
syntax match mipsDirective "\.endr"
syntax match mipsDirective "\.ent"
syntax match mipsDirective "\.extern"
syntax match mipsDirective "\.file"
syntax match mipsDirective "\.float"
syntax match mipsDirective "\.fmask"
syntax match mipsDirective "\.frame"
syntax match mipsDirective "\.globl"
syntax match mipsDirective "\.gpvalue"
syntax match mipsDirective "\.gpword"
syntax match mipsDirective "\.half"
syntax match mipsDirective "\.kdata"
syntax match mipsDirective "\.ktext"
syntax match mipsDirective "\.lab"
syntax match mipsDirective "\.lcomm"
syntax match mipsDirective "\.loc"
syntax match mipsDirective "\.mask"
syntax match mipsDirective "\.nada"
syntax match mipsDirective "\.nop"
syntax match mipsDirective "\.option"
syntax match mipsDirective "\.origin"
syntax match mipsDirective "\.repeat"
syntax match mipsDirective "\.rdata"
syntax match mipsDirective "\.sdata"
syntax match mipsDirective "\.section"
syntax match mipsDirective "\.set"
syntax match mipsDirective "\.size"
syntax match mipsDirective "\.space"
syntax match mipsDirective "\.struct"
syntax match mipsDirective "\.text"
syntax match mipsDirective "\.type"
syntax match mipsDirective "\.verstamp"
syntax match mipsDirective "\.weakext"
syntax match mipsDirective "\.word"

" Arithmetic and Logical Instructions
syntax match mipsInstruction "\<abs\>"
syntax match mipsInstruction "\<add\>"
syntax match mipsInstruction "\<addu\>"
syntax match mipsInstruction "\<addi\>"
syntax match mipsInstruction "\<addiu\>"
syntax keyword mipsInstruction dadd daddu daddi daddiu
syntax keyword mipsInstruction and andi
syntax keyword mipsInstruction clo clz
syntax keyword mipsInstruction dclo dclz
syntax match mipsInstruction "\<div\>"
syntax match mipsInstruction "\<divu\>"
syntax match mipsInstruction "\<ddiv\>"
syntax match mipsInstruction "\<ddivu\>"
syntax match mipsInstruction "\<mul\>"
syntax keyword mipsInstruction mult multu mulo mulou madd maddu msub msubu
syntax keyword mipsInstruction dmult dmultu
syntax keyword mipsInstruction neg negu
syntax keyword mipsInstruction nor
syntax keyword mipsInstruction not
syntax keyword mipsInstruction or ori
syntax keyword mipsInstruction rem remu
syntax keyword mipsInstruction sll sllv sra srav srl srlv
syntax match mipsInstruction "\<dsll\>"
syntax match mipsInstruction "\<dsllv\>"
syntax match mipsInstruction "\<dsll32\>"
syntax match mipsInstruction "\<dsra\>"
syntax match mipsInstruction "\<dsrav\>"
syntax match mipsInstruction "\<dsra32\>"
syntax match mipsInstruction "\<dsrl\>"
syntax match mipsInstruction "\<dsrlv\>"
syntax match mipsInstruction "\<dsrl32\>"
syntax keyword mipsInstruction rol ror
syntax match mipsInstruction "\<sub\>"
syntax match mipsInstruction "\<subu\>"
syntax keyword mipsInstruction dsub dsubu
syntax keyword mipsInstruction xor xori

" Constant-Manipulating Instructions
syntax keyword mipsInstruction lui li
syntax keyword mipsInstruction slt sltu slti sltiu
syntax keyword mipsInstruction seq
syntax keyword mipsInstruction sge sgeu
syntax keyword mipsInstruction sgt sgtu
syntax keyword mipsInstruction sle sleu
syntax keyword mipsInstruction sne

" Branch Instructions
syntax keyword mipsInstruction b
syntax keyword mipsInstruction bc1f bc1t
syntax keyword mipsInstruction beq beqz
syntax keyword mipsInstruction bgez bgezal bgtz
syntax keyword mipsInstruction blez bltzal bltz
syntax keyword mipsInstruction bne bnez
syntax keyword mipsInstruction bge bgeu
syntax keyword mipsInstruction bgt bgtu
syntax keyword mipsInstruction ble bleu
syntax keyword mipsInstruction blt bltu
syntax keyword mipsInstruction beqzl bnezl bgezl beql bnel bgtzl blezl bltzl

" Jump Instructions
syntax keyword mipsInstruction j jal jalr jr

" Trap Instructions
syntax keyword mipsInstruction teq teqi
syntax keyword mipsInstruction tne tnei
syntax keyword mipsInstruction tge tgeu tgei tgeiu
syntax keyword mipsInstruction tlt tltu tlti tltiu

" Load Instructions
syntax keyword mipsInstruction la
syntax keyword mipsInstruction lb lbu lh lhu
syntax keyword mipsInstruction ldc1 ldc2
syntax keyword mipsInstruction ldl ldr
syntax keyword mipsInstruction lw lwc1 lwl lwr
syntax keyword mipsInstruction ld
syntax keyword mipsInstruction ulh ulhu ulw
syntax keyword mipsInstruction ll

" Store Instructions
syntax keyword mipsInstruction sb sh sw swc1 sdc1 swl swr sd ush usw sc
syntax keyword mipsInstruction sdl sdr

" Cache Instructions
syntax keyword mipsInstruction cache

" TLB Instructions
syntax keyword mipsInstruction tlbwi

syntax keyword mipsInstruction sync


" Data Movement Instructions
syntax keyword mipsInstruction move
syntax keyword mipsInstruction mfhi mflo
syntax keyword mipsInstruction mthi mtlo
syntax keyword mipsInstruction mfc0 mfc1
syntax keyword mipsInstruction dmfc0 dmfc1 dmfc2
syntax keyword mipsInstruction dmtc0 dmtc1 dmtc2
syntax keyword mipsInstruction cfc0 cfc1
syntax match mipsInstruction "mfc1\.d"
syntax keyword mipsInstruction mtc0 mtc1
syntax keyword mipsInstruction ctc0 ctc1
syntax keyword mipsInstruction movn movz movf movt

" Floating-Point Instructions
syntax match mipsInstruction "abs\.d"
syntax match mipsInstruction "abs\.s"
syntax match mipsInstruction "abs\.ps"
syntax match mipsInstruction "add\.d"
syntax match mipsInstruction "add\.s"
syntax match mipsInstruction "add\.ps"
syntax match mipsInstruction "ceil\.w\.d"
syntax match mipsInstruction "ceil\.w\.s"
syntax match mipsInstruction "c\.eq\.d"
syntax match mipsInstruction "c\.eq\.s"
syntax match mipsInstruction "c\.le\.d"
syntax match mipsInstruction "c\.le\.s"
syntax match mipsInstruction "c\.lt\.d"
syntax match mipsInstruction "c\.lt\.s"
syntax match mipsInstruction "cvt\.d\.s"
syntax match mipsInstruction "cvt\.d\.w"
syntax match mipsInstruction "cvt\.s\.d"
syntax match mipsInstruction "cvt\.s\.w"
syntax match mipsInstruction "cvt\.w\.d"
syntax match mipsInstruction "cvt\.w\.s"
syntax match mipsInstruction "div\.d"
syntax match mipsInstruction "div\.s"
syntax match mipsInstruction "div\.ps"
syntax match mipsInstruction "floor\.w\.d"
syntax match mipsInstruction "floor\.w\.s"
syntax match mipsInstruction "l\.d"
syntax match mipsInstruction "l\.s"
syntax match mipsInstruction "mov\.d"
syntax match mipsInstruction "mov\.s"
syntax match mipsInstruction "movf\.d"
syntax match mipsInstruction "movf\.s"
syntax match mipsInstruction "movt\.d"
syntax match mipsInstruction "movt\.s"
syntax match mipsInstruction "movn\.d"
syntax match mipsInstruction "movn\.s"
syntax match mipsInstruction "movz\.d"
syntax match mipsInstruction "movz\.s"
syntax match mipsInstruction "mul\.d"
syntax match mipsInstruction "mul\.s"
syntax match mipsInstruction "mul\.ps"
syntax match mipsInstruction "neg\.d"
syntax match mipsInstruction "neg\.s"
syntax match mipsInstruction "round\.w\.d"
syntax match mipsInstruction "round\.w\.s"
syntax match mipsInstruction "sqrt\.d"
syntax match mipsInstruction "sqrt\.s"
syntax match mipsInstruction "s\.d"
syntax match mipsInstruction "s\.s"
syntax match mipsInstruction "sub\.d"
syntax match mipsInstruction "sub\.s"
syntax match mipsInstruction "sub\.ps"
syntax match mipsInstruction "trunc\.w\.d"
syntax match mipsInstruction "trunc\.w\.s"

" Exception and Interrupt Instructions
syntax keyword mipsInstruction eret
syntax keyword mipsInstruction syscall
syntax keyword mipsInstruction break
syntax keyword mipsInstruction nop

hi def link mipsNumber         Number
hi def link mipsString         String
hi def link mipsLabel          Label
hi def link mipsRegister       Identifier
hi def link mipsDirective      Type
hi def link mipsInstruction    Statement
hi def link mipsDefine         PreProc
hi def link mipsInclude        PreProc
hi def link mipsIncluded       String

let b:current_syntax = "mips"
