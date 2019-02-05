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
" Emulate statusline, but use full- instead of relative-path
set statusline=%<[%-0.20{getcwd()}]\ %F\ %h%m%r%y%=%-14.(%l,%c%V%)\ %P

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
nnoremap § :bnext<CR>
nnoremap ½ :bprevious<CR>

" To avoid autoscrolling when switching buffers (I did not have this problem
" before but now I have it and its anoying /Ulf 2013-04-25). From
"   http://vim.wikia.com/wiki/Avoid_scrolling_when_switch_buffers
" A bug was reproted and fixed in the code by adding "unlet! b:winview |".
" This bug made SyncWin behave strangely. See here for bug info:
"   https://github.com/garbas/vim-snipmate/issues/161
" Still not working. Adding "UR_" to var since it seems to be conflicting in
" some weird way with something else. Seems to be working now.
au BufLeave * if !&diff | let b:UR_winview = winsaveview() | endif
au BufEnter * if exists('b:UR_winview') && !&diff | call winrestview(b:UR_winview) | unlet! b:UR_winview | endif

" MiniBufExpl Colors
function! SetMyMinibufColors()
    hi MBENormal               cterm=NONE ctermfg=2 ctermbg=0
    hi MBEChanged              cterm=NONE ctermfg=1 ctermbg=0
    hi MBEVisibleNormal        cterm=NONE ctermfg=2 ctermbg=0
    hi MBEVisibleChanged       cterm=NONE ctermfg=1 ctermbg=0
    hi MBEVisibleActiveNormal  cterm=NONE ctermfg=0 ctermbg=7
    hi MBEVisibleActiveChanged cterm=NONE ctermfg=1 ctermbg=7
endfunction
" Set the colors at startup
call SetMyMinibufColors()
" If the colorscheme is changed, set the colors for the MiniBuf again.
au ColorScheme * call SetMyMinibufColors()


" ===========================================================================
" Help
" ===========================================================================
" Jump to (help) tag and back
nnoremap ä <c-]>
nnoremap Ä <c-t>


" ===========================================================================
" Formatting
" ===========================================================================
" To make paragraph formatting use shorter key-sequence
" See :help gw
"map Q gwap
nnoremap Q gq}


" ===========================================================================
" Diff
" ===========================================================================
" How will vimdiff will work and look
set diffopt=vertical,filler,context:1
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
inoremap <F11> <ESC>:call ToggleLineNumbering()<CR>a


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
inoremap <F10> <ESC>:call ToggleColorColumn()<CR>a
nnoremap <S-C-F10> :call AlterTextWidth(+1)<CR>
nnoremap <C-F10> :call AlterTextWidth(-1)<CR>


" ===========================================================================
" Simplyfy editing of vimrc
" ===========================================================================
" This is from:
"   http://learnvimscriptthehardway.stevelosh.com/chapters/07.html
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>



" ===========================================================================
" Highlight Word
"
" This piece is copied and modified from:
"   https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
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

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " See if the a match with the given id and pattern (the thing under the
    " cursor) alredy eixts. If the match do exist just the match should be
    " removed, otherwise the new match should be created (and the old
    " removed).
    let match_exist = 0
    for i in getmatches()
        if i.id == mid && i.pattern == pat
            let match_exist += mid
        endif
    endfor

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Actually match the words, but only if no previous match exists.
    if match_exist == 0
        call matchadd("InterestingWord" . a:n, pat, 1, mid)
    endif

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
nnoremap <S-Up> 2<C-Y>
nnoremap <S-Down> 2<C-E>

" Scroll window before the cursor reaches the top and bottom of the window.
set scrolloff=2

" Bind all the window together for scrolling
"   http://stackoverflow.com/a/18466534/42580
let s:sync_win = 0
function SyncWin()

  let nr = winnr()
  let s:sync_win = 1 - s:sync_win

  if ! s:sync_win
    "windo set noscrollbind nocursorbind
    windo set noscrollbind
    exe nr . 'wincmd w'
    echo "scrollbind is OFF"
    return
  endif

  "windo set scrollbind cursorbind nowrap
  windo set scrollbind nowrap
  exe nr . 'wincmd w'
  "syncbind
  set scrollopt+=hor
  echo "scrollbind is ON"
endfunction
nnoremap <F2> :call SyncWin()<CR>


" ===========================================================================
" Window switching
" ===========================================================================
" Map <TAB> to cycle through the windows backwards and forward.
nnoremap <TAB> <C-W>w
nnoremap <S-TAB> <C-W>W

" Cycle buffer in the 'next'-window. An example that I created here:
" https://vi.stackexchange.com/a/13088/12372
"nnoremap <F8> <C-W>w:bnext<CR><C-W>W
"nnoremap <S-F8> <C-W>w:bprevious<CR><C-W>W


" ===========================================================================
" Mindstorms EV3 hack...
" ===========================================================================
" This is used when the brick is running ev3dev. It is used to automatically
" copy the file edited to the brick and run it. It is highly specialiced and
" could need some more work and generalization...
function! WriteDistributeAndRun(n)
    write
    silent !clear
    silent !echo "Copy file..."
    execute "silent !scp %:p ev3wifi:%:p"
    silent !echo "Run file..."
    execute "!ssh ev3wifi %:p"
    redraw! 
endfunction
command WX call WriteDistributeAndRun(1) 
