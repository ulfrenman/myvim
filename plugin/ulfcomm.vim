" Vim global plugin to handle commenting and uncommenting of varius filetypes
" Maintainer:  Ulf Renman <ulf.renman@gmail.com>
" License:	   This file is placed in the public domain.

if exists("loaded_ulf_comment")
  finish
endif
let loaded_ulf_comment = 1


" Set default comments
let b:UlfComment="#"
let b:UlfEndComment=""
" Define specified commentstyle for certain files
au BufRead,BufNewFile *.sh,*.pl,*.tcl,*.py let b:UlfComment="#"  | let b:UlfEndComment=""
au BufRead,BufNewFile *.js                 let b:UlfComment="//" | let b:UlfEndComment=""
au BufRead,BufNewFile *.cc,*.php,*.cxx     let b:UlfComment="//" | let b:UlfEndComment=""
au BufRead,BufNewFile *.c,*.h,*.css        let b:UlfComment="/*" | let b:UlfEndComment="*/"
au BufRead,BufNewFile *.sql,*.lua          let b:UlfComment="--" | let b:UlfEndComment=""
au BufRead,BufNewFile *.tmpl               let b:UlfComment="##" | let b:UlfEndComment=""
au filetype vim                            let b:UlfComment='"'  | let b:UlfEndComment=""

if !hasmapto('<Plug>UlfcommCommentLines')
  map <unique> ö  <Plug>UlfcommCommentLines
endif
noremap <unique> <script> <Plug>UlfcommCommentLines  <SID>CommentLines
noremap <SID>CommentLines  :call <SID>CommentLines()<CR>

function s:CommentLines()
    exe ":s@^\\s*@\\0".b:UlfComment."@g"
    exe ":s@$@".b:UlfEndComment."@g"
    exe "+"
    echo "Adding comment on line"
endfun


if !hasmapto('<Plug>UlfcommUnCommentLines')
  map <unique> Ö  <Plug>UlfcommUnCommentLines
endif
noremap <unique> <script> <Plug>UlfcommUnCommentLines  <SID>UnCommentLines
noremap <SID>UnCommentLines  :call <SID>UnCommentLines()<CR>

function s:UnCommentLines()
    " Make local vars where * is prepended with \\ (escaped) so that the
    " matching is done correctly later on. Otherwise the * will be part of the
    " re-pattern as any-number-of-occurrences-selector.
    " See for example the *.css
    let l:TmpUlfComment = substitute(b:UlfComment, '*', '\\*','')
    let l:TmpUlfEndComment = substitute(b:UlfEndComment, '*', '\\*','')
    try
        exe ":s@\\(^\\s*\\)".l:TmpUlfComment."@\\1@g"
        exe ":s@".l:TmpUlfEndComment."$@@g"
        echo "Removing comment on line"
    catch /Pattern not found: .*\$/
        " The end-pattern did not match so undo the start-pattern replacemnet
        echo "No pattern to remove"
        silent undo
    catch /Pattern not found:/
        " The start-pattern did not match
        echo "No pattern to remove"
    endtry
    exe "+"
endfun
