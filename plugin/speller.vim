" This spellcheck mapping is fetched from 
" http://vim.wikia.com/wiki/Toggle_spellcheck_with_function_keys

" Spell Check
let g:myLangList=["nospell","sv","en"]
function! ToggleSpell()
    let b:myLang = exists('b:myLang') ? b:myLang+1 : 1
    if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
    if b:myLang==0
        setlocal nospell
        nunmap <buffer> <space>
    else
        execute "setlocal spell spelllang=".get(g:myLangList, b:myLang)
        nmap <buffer> <space> z=
    endif
    echo "spell checking language:" g:myLangList[b:myLang]
endfunction

hi SpellBad ctermfg=White

nmap <silent> <F12> :call ToggleSpell()<CR>
inoremap <F12> <ESC>:call ToggleSpell()<CR>a
