set nocompatible

" Hi. :)
color solarized

" Visual tweaks
set number                         " Show line numbers
set colorcolumn=80                 " Highlight the 80th column for help with
set guifont=Menlo:h12              " I line Menlo :)
set cursorline                     " Highlight the line that the cursor is one
set spell                          " Highlight spelling mistakes
set hidden                         " Keep closed buffers around.
set nobackup                       " Ignore the backup and swap file. These settings
set noswapfile                     " tend to become nuisances rather than helpful.
set clipboard=unnamed              " Share the system clipboard with vim
set nowrap                         " Do not wrap long lines
set background=dark                " Prefer dark backgrounds like a true programmer
set list listchars=tab:·\ ,trail:• " Show invisibles properly

" Whitespace
set textwidth=80                   " Try to keep files within 80 or so lines
set expandtab                      " Prefer spaces
set tabstop=4                      " Prefer files with four spaces
set shiftwidth=4
set softtabstop=4

" Searching
set gdefault                       " Automatically add the /g to replacements
set ignorecase                     " Ignore case when searching...
set smartcase                      " but use smart case

" Allow per-project settings
set exrc
set secure

" Context-dependent cursor in the terminal
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Auto commands
autocmd CursorHold,CursorHoldI * silent! wa      " Auto-save
autocmd VimResized,BufNew * wincmd =             " Auto balance splits

" Helpful mappings
let mapleader = " "       " Use space as the leader key

" Because ESC is just too far away
inoremap jj <ESC>

" Open the containing folder of a file
nnoremap <Leader>o :!open %:p:h<CR>

" Fast writes and quits
nnoremap <Leader>w :w!<CR>
nnoremap <Leader>q :q!<CR>
nnoremap <Leader>wq :wq!<CR>

" Toggle search highlighting
nnoremap <Leader><Space> :set hlsearch!<CR><esc>

" Quickly create new splits
nnoremap <Leader>v :botright vnew<CR><C-W>l
nnoremap <Leader>s :belowright new<CR><C-W>j

" Quickly move around splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quickly change indent
vnoremap <C-l> >gv
vnoremap <C-h> <gv

" Initialize NeoBundle
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage itself
NeoBundleFetch 'Shougo/neobundle.vim'

" Install and build vimproc
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'mac' : 'make -f make_mac.mak',
\    },
\ }

" Functionality plugins
NeoBundle 'Shougo/unite.vim'            " Unite, the core of this setup
NeoBundle 'sheerun/vim-polyglot'        " Extra language support
NeoBundle 'tpope/vim-sensible'          " Sensible defaults for vim
NeoBundle 'tpope/vim-surround'          " Manipulate surrounding pairs
NeoBundle 'tpope/vim-fugitive'          " Git integration
NeoBundle 'regedarek/ZoomWin'           " Quickly maximize the current split
NeoBundle 'conormcd/matchindent.vim'    " Autodetect indent settings
NeoBundle 'bling/vim-airline'           " A prettier status bar
NeoBundle 'vim-scripts/gitignore'       " Add .gitigore contents to wildignore
NeoBundle 'scrooloose/nerdcommenter'    " Quickly comment lines
NeoBundle 'jiangmiao/auto-pairs'        " Auto-add matching pairs

" Add haml-coffee support
au BufRead,BufNewFile *.{hamlc} set ft=haml

" Plugin mappings
map \\ <plug>NERDCommenterToggle

" Git integration all under <Leader>g
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>ga :Gadd<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gdiff<CR>

" Ctrl[P]-style fuzzy file search
nnoremap <Leader>p :Unite -no-split -start-insert file_rec/async<CR>

" [B]rowse files
nnoremap <Leader>b :Unite -no-split -start-insert file<CR>

" [N]ew file
nnoremap <Leader>n :Unite -no-split -start-insert file/new<CR>

" [F]ind text in files
nnoremap <Leader>f :Unite -vertical -no-quit grep:.<CR>

" Quickly maximize windows
nnoremap <Leader>m :ZoomWin<CR>

" Airline configuration
let g:airline_left_sep = ''      " Disable airline's pretty separators. I'm
let g:airline_right_sep = ''     " too lazy to install the patched font.

" NERDCommenter configuration
let g:NERDSpaceDelims = 1        " Add spaces after comments
let g:NERDRemoveExtraSpaces = 1  " Remove spaces around comments on removal

" Unite configuration
let unite = neobundle#get('unite.vim')
function! unite.hooks.on_source(bundle)
  " Add fuzzy match and ranking for CtrlP-style functionality
  call unite#custom#source('file,file_mru,file_rec,file_rec/async',
      \ 'matchers', ['matcher_fuzzy', 'matcher_hide_hidden_files'])
  call unite#custom#source('file,file_mru,file_rec,file_rec/async',
      \ 'sorters', ['sorter_rank'])
endfunction

" Unite is nowhere near as fast as CtrlP for pure fuzzy match searches,
" but when vim is compiled with lua support and git is used for listing
" files we get pretty close.
let g:unite_source_rec_max_cache_files = 10000
let g:unite_source_rec_async_command = 'git ls-files'

" Enable remembering yanks, for the unite's history/yank source
let g:unite_source_history_yank_enable  =  1

" Unite checks if the command is executable, but unfortunately
" `git grep` will return false in that case, so hack around it.
let g:unite_source_grep_command = 'git'
let g:unite_source_grep_default_opts = '--no-pager grep -inH --no-color'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_max_candidates = 5000

" Make unite friendlier when it is open
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  nmap <buffer> <ESC>   <Plug>(unite_exit)
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

" Let NeoBundle ensure everything is properly installed
NeoBundleCheck
