let &runtimepath=expand('~/.vim').','.&runtimepath

:execute pathogen#infect()

" Change the backup file directory
set backupdir=/tmp

" Chrome uses non-fixed width fonts for the default characters.
let g:NERDTreeDirArrowExpandable = '→'
let g:NERDTreeDirArrowCollapsible = '↓'
let g:NERDTreeShowBookmarks = 1

" Be modern.
set nocompatible

" Enable basic editor features.
filetype plugin indent on
syntax on

" Colorscheme
colorscheme desert

" Make the tabbing correct for most things.
set shiftwidth=2
set tabstop=2
set expandtab

" Stop that silly double space after the period.  When doing gq.
set nojoinspaces

" Highlight search results.
set hlsearch

" Make sure we're doing vertical diff, even if the window is skinny.
set diffopt+=vertical

nnoremap <leader>t :NERDTree $HOME/empty<cr>

" Find the current file in NERDTree.
map <leader>f :NERDTreeFind<cr>

" Query
map <leader>q {V}:Query 1<cr>}

" Underscore-camel conversion.
command! -range U2c <line1>,<line2>s/\(_\|\<\)\([a-z]\)\([a-z]*\)/\u\2\3/g
" Camel-underscore conversion.
command! -range C2u <line1>,<line2>g/.*/s/[A-Z]/\l&/|s/[A-Z]/_\l&/g
" Underscore-java proto conversion.
command! -range U2p <line1>,<line2>s/\<\([a-z]\+\)/get\u\1/g | <line1>,<line2>s/_\([a-z]\+\)/\u\1/g | <line1>,<line2>s/get[a-zA-Z]\+\>/&()/g

function! CopyToTmux()
  let l:filename=tempname()
  execute "silent '<,'>w " . l:filename
  execute "silent !tmux load-buffer " . l:filename
endfunction
command! -nargs=* -range CopyToTmux call CopyToTmux()

function! StripWhitespaceFromLine(line)
  return substitute(a:line, '\s*$', '', '')
endfunction

function! PasteFromTmux()
  let lines_to_paste = split(system("tmux show-buffer"), '\n')
  call map(lines_to_paste, 'StripWhitespaceFromLine(v:val)')
  call append(line('.'), lines_to_paste)
endfunction

" paste from tmux onto following line
command! PasteFromTmux call PasteFromTmux()

function! ExecuteQuery(select)
  let l:filename=tempname()
  execute "silent '<,'>w " . l:filename
  execute "silent !tmux load-buffer " . l:filename
  execute "silent !tmux paste-buffer -t -."
  if a:select
    execute "silent !tmux select-window -t -."
  endif
  :redraw!
endfunction
command! -nargs=* -range Query call ExecuteQuery(<f-args>)

" Statusline
set statusline=%r\ %f\ %m\ %=%c\ %l:%L
" Show the number of selected lines in the bottom command line.
set showcmd
set laststatus=2

" Tab/Enter to autocomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

function! ShowLocations()
  execute "lfile $HOME/tmp/locations"
  execute "lopen"
endfunction
nnoremap <leader>l :call ShowLocations()<CR>
