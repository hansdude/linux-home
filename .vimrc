let &runtimepath=expand('~/.vim').','.&runtimepath

:execute pathogen#infect()

function! VisualSelectionSize()
    if mode() == "V"
        exe "normal \<ESC>gv"
        return (line("'>") - line("'<") + 1) . ' lines'
    else
        return ''
    endif
endfunction

:colorscheme desert
:syntax on
:set guifont=Droid\ Sans\ Mono\ 16
:set nobackup
:set nowritebackup
:set tabstop=4
:set shiftwidth=4
:set expandtab
:set mouse=a
:set number
:set laststatus=2
:set statusline=%f%m%=%{VisualSelectionSize()}%8l:%c/%-8L
:map <F2> ggVG"+y
:map <F3> "+yiw

:filetype off
:filetype plugin indent on
:filetype plugin on
:filetype indent on

" Fix vim-fugitive missing swap directory issue.
:set directory+=,~/tmp,$TMP
