" Put here to get pathogen work (copied from
"   https://github.com/scrooloose/syntastic)
" This needs to be among the first things to called in vimrc.
execute pathogen#infect()


" ===========================================================================
" Some general things
" ===========================================================================
" Turn filetype detection, plugins and indent on
filetype plugin indent on

" Wrapping and tabs. These are mostly needed for programming stuff but
" we set it on this general vimrc to make it global since I like it!
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set softtabstop=4
set autoindent

" briefly jump to the matching bracket
set showmatch

" always show statusline
set laststatus=2

" highlight previous search pattern
set hlsearch

" display incomplete commands
set showcmd

" do incremental searching
set incsearch

" set lenght of historyfile (.viminfo), defaults to 20
set history=1000

" Disable audio and visual error bells
set noerrorbells visualbell t_vb=

" Vim5 and later versions support syntax highlighting.
if has("syntax")
    syntax on
endif

" The default leader is backslash which is two keys on an swedish keyboard.
" Switch to ' instead.
let mapleader = "'"

" ===========================================================================
" ctags
" ===========================================================================
" This could be used to generate the initial tags-file
"   $ ctags -R t
" After that the tags-file is automatically updated by the AutoTag plugin.
"   http://vim.wikia.com/wiki/VimTip804
set tags=tags;


" ===========================================================================
" MiniBufExplorer
" ===========================================================================
" Make it possible to switch buffer in MiniBufExplorer without saving first.
set hidden
" To handle buffers easily I use the MiniBufExplorer plugin. Read the
" plugin for info on how to configure.
" Since the <C-TAB> is not mappable in the terminal I use these mappings to
" move between buffers:
map § :bnext<CR>
map ½ :bprevious<CR>

" To avoid autoscrolling when switching buffers (I did not have this problem
" before but now I have it and its anoying /Ulf 2013-04-25). From
"   http://vim.wikia.com/wiki/Avoid_scrolling_when_switch_buffers
au BufLeave * if !&diff | let b:winview = winsaveview() | endif
au BufEnter * if exists('b:winview') && !&diff | call winrestview(b:winview) | endif


" ===========================================================================
" Help
" ===========================================================================
" Jump to (help) tag and back
map ä <c-]>
map Ä <c-t>


" ===========================================================================
" Formatting
" ===========================================================================
" To make paragraph formatting use shorter key-sequence
" See :help gw
"map Q gwap
map Q gq}


" ===========================================================================
" Diff
" ===========================================================================
" How will vimdiff will work and look
set diffopt=filler,context:1
if &diff
  colorscheme pablo
endif


" ===========================================================================
" Folding
" ===========================================================================
" Folding stuff from:
"   http://stackoverflow.com/questions/357785/
set foldmethod=indent
set foldlevelstart=99
nnoremap <space> za


" ===========================================================================
" Trailing whitespace
" ===========================================================================
" I do not like to have a lot of trailing whitespace at the end of lines.
" Highlight it to make it obvious and easy to remove!
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/


" ===========================================================================
" Line numbering
" ===========================================================================
" The function cycles between 3 states:
"   * No line numbering at all
"   * Line numbers starts from 1 at the first line in the file
"   * Relative numbering where 0 is at the cursor
"
" The cycling is mapped to the F11-key in normal mode.
function! ToggleLineNumbering()
    if &number
        set relativenumber
    elseif &relativenumber
        set norelativenumber!
    else
        set number
    endif
endfunction
nnoremap <F11> :call ToggleLineNumbering()<CR>


" ===========================================================================
" Syntastic
" ===========================================================================
" Make Syntastic only check the file on <F6>. It takes an annoyingly long time
" to do the flake8 check at write so its disabled by default.
let g:syntastic_mode_map = { 'mode': 'passive' }
nnoremap <F6> :SyntasticToggleMode<CR>


" ===========================================================================
" Gundo
" ===========================================================================
" Configure the Gundo plugin and map <F5> to toggel it.
nnoremap <F5> :GundoToggle<CR>
" Put the preview window below the main textarea
let g:gundo_preview_bottom = 1



" ===========================================================================
" Textwidth
" ===========================================================================
" If textwidth is not set (could be set by ftplugin/ or syntax/ files for
" example) then set it.
function! ToggleColorColumn()
    if &textwidth == 0
        set textwidth=78
        set colorcolumn=+1
        echo "textwidth=".&textwidth
    elseif &colorcolumn != ""
        set colorcolumn=""
        echo
    else
        set colorcolumn=+1
        echo "textwidth=".&textwidth
    endif
endfunction
function! AlterTextWidth(n)
    if &textwidth == 0
        " If textwidth is not set at all then default it to 78 and turn on the
        " colorcolumn
        set textwidth=78
        set colorcolumn=+1
        echo "textwidth=".&textwidth
    elseif &colorcolumn != ""
        " Only alter the textwidth if colorcolumn is set
        let s:x = &textwidth + a:n
        exe "set textwidth=".s:x
        if a:n > 0
            echo "Increasing textwidth to ".&textwidth
        else
            echo "Decreasing textwidth to ".&textwidth
        endif
    endif
endfunction
nnoremap <F10> :call ToggleColorColumn()<CR>
nnoremap <S-F10> :call AlterTextWidth(+1)<CR>
nnoremap <C-F10> :call AlterTextWidth(-1)<CR>


" ===========================================================================
" Simplyfy editing of vimrc
" ===========================================================================
" This is from:
"   http://learnvimscriptthehardway.stevelosh.com/chapters/07.html
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>



" Highlight Word
"
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily. You can search for it, but that only
" gives you one color of highlighting. Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.

function! HiInterestingWord(n)
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID. Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
endfunction

" Mappings
nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>


hi def InterestingWord1 cterm=bold ctermfg=8 ctermbg=1
hi def InterestingWord2 cterm=bold ctermfg=8 ctermbg=2
hi def InterestingWord3 cterm=bold ctermfg=0 ctermbg=3
hi def InterestingWord4 cterm=bold ctermfg=8 ctermbg=4
hi def InterestingWord5 cterm=bold ctermfg=8 ctermbg=5
hi def InterestingWord6 cterm=bold ctermfg=8 ctermbg=6
hi def InterestingWord7 cterm=bold ctermfg=0 ctermbg=7


" ===========================================================================
" Scrolling
" ===========================================================================
" Make shift-up-down scroll the window up-down 2 lines without moving the
" cursor
map <S-Up> 2<C-Y>
map <S-Down> 2<C-E>
" Scroll window before the cursor reaches the top and bottom of the window.
set scrolloff=2
