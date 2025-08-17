set nocompatible

" Plugins
call plug#begin('~/.vim/plugged')

" Use a bunch of sensible defaults for vim,
" approved the by the reverend Tim Pope
Plug 'tpope/vim-sensible'

" For fuzzy file searching
Plug 'ctrlpvim/ctrlp.vim'

" Indicate the diff of the file in the gutter
Plug 'airblade/vim-gitgutter'

" Add git integration
Plug 'tpope/vim-fugitive'

" Easily manipulate surrounding pairs
Plug 'tpope/vim-surround'

" Enable . for plugin mappings
Plug 'tpope/vim-repeat'

" Add support for even more languages
Plug 'sheerun/vim-polyglot'

" Add searching with ack
Plug 'mileszs/ack.vim'

" Quickly maximize the current split
Plug 'regedarek/ZoomWin'

" Auto-detect indentation settings
Plug 'tpope/vim-sleuth'

" Add a useful status bar
Plug 'bling/vim-airline'

" Add .gitignore contents to wildignore
Plug 'vim-scripts/gitignore'

" Quickly comment lines
Plug 'scrooloose/nerdcommenter'

" file explorer with NERDTree
Plug 'preservim/nerdtree'

" Outline tags in a pane
Plug 'preservim/tagbar'

" Add auto-closing of pairs for ruby and vim
Plug 'tpope/vim-endwise'

" Show netrw in the current split.
Plug 'tpope/vim-vinegar'

" Add support for easy alignment
Plug 'junegunn/vim-easy-align'

" Add support for easy alignment
Plug 'AndrewRadev/splitjoin.vim'

" Add support for syntax error detection.
Plug 'vim-syntastic/syntastic'

" Visually expand regions
Plug 'terryma/vim-expand-region'

" DB access
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'

" Color schemes
Plug 'flazz/vim-colorschemes'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

" Trial
Plug 'brooth/far.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

if has('nvim')
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-pack/nvim-spectre'
endif

call plug#end()

" Show line numbers
set number

" Show common line limits
set colorcolumn=80,120

" Underline spelling mistakes
set nospell

" Ignore backup files as these settings tend to become
" nuisances over time, rather than help.
set nobackup
set noswapfile

" Share the system clipboard with vim
set clipboard=unnamed

" Do not wrap lines
set nowrap

" Properly show invisibles
set list listchars=tab:·\ ,trail:•

" Wrap at 80 lines.
set textwidth=80
set termguicolors

" Indent with two spaces. These settings will most likely
" be autodetected by the autoindent plugin anyway.
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Search globally by default
set gdefault

" Case-insensitive searches by default until you type
" a captial letter, then switch to case-sensitive
set ignorecase
set smartcase

" Auto-reload files changed on disk
set autoread

" Show context above and below the cursor
set scrolloff=5

" Wrap lines when moving around the file
set whichwrap+=<,>,h,l

" Show a navigable menu for tab completion
set wildmenu

" Allow per-project settings
set exrc
set secure

" Auto-save after a brief period of time
autocmd CursorHold,CursorHoldI * silent! wa

" Automatically balance splits
autocmd VimResized,BufNew !nerdtree wincmd =

" Most PHP is 4 spaces these days
au FileType php setlocal softtabstop=4 tabstop=4 shiftwidth=4

" Don't wrap on HTML. That shit gets so long it's not funny.
au FileType html,htmldjango,htmljinja,slim,html.handlebars setlocal textwidth=0 wrapmargin=0

" Speed up the slowness when dealing with synax highlighting ruby
au FileType ruby setlocal re=1 foldmethod=manual

" Don't replace past buffer
function! RestoreRegister()
    let @" = s:restore_reg
    if &clipboard == "unnamed"
        let @* = s:restore_reg
    endif
    return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" Mappings

" Even better than the comma
let mapleader = " "

" Because ESC is just too far away
inoremap jj <ESC>

" And Shift-; is just too darn difficult
noremap ; :

" Open/Close NERDTree
nnoremap <leader>e :NERDTreeToggle<CR>

" Fast [w]rites and [q]uits
nnoremap <Leader>w :w!<CR>
nnoremap <Leader>wq :wq!<CR>
nnoremap <Leader>q :q!<CR>

" Fast [r]emoval of files
nnoremap <Leader>rm :w!<CR>:call delete(expand('%'))<CR>:bdelete<CR>

" [O]pen the containing folder of a file in Finder
nnoremap <Leader>fo :silent !open -Rg %<CR>:redraw!<CR>

" Copy the filename or filepath to the clipboard
nnoremap <Leader>fn :let @*=expand("%")<CR>
nnoremap <Leader>fp :let @*=expand("%:p")<CR>

" Quickly bring up "Far" for search
nnoremap <Leader>fs :F<Space>
nnoremap <Leader>fr :Far<Space>

let g:far#default_file_mask = '**/*'

" Toggle search highlighting
nnoremap <Leader><Space> :set hlsearch!<CR><esc>

" Quickly create new splits. These have a nice, simple
" way of opening up that's similar to sublime.
nnoremap <Leader>v :botright vnew<CR><C-W>l
nnoremap <Leader>s :belowright new<CR><C-W>j

" Afford quickly moving around splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quickly change indent
vnoremap <C-l> >gv
vnoremap <C-h> <gv

" Quickly toggle code comments
map \\ <plug>NERDCommenterToggle

" [G]it integration
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <Leader>ga :Gcommit --amend<CR>

" Git [d]iff in the gutter. There's some sort of bug with the background
" colour that's fixed with running it this way. Adding the first
" statement doesn't fix anything if I do it inline...
nnoremap <Leader>gd :hi clear SignColumn<CR> :GitGutterToggle<CR>

" Fuzzy filename searching with ctrl-[p]
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_max_files = 1000000

" Add a few oft-used ignores to CtrlP. They end up
" just bogging it down for no real reason.
let g:ctrlp_custom_ignore = {
\ 'dir':  'node_modules',
\ }

" Ctrl-P with ag
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" Use a common ctrlp cache
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

" Grep with [a]g, aka the silver searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif

" Quickly bring up "ag" and Far for search
nnoremap <Leader>a :Ack<Space>

" Quickly [m]aximize a split
nnoremap <Leader>m :ZoomWin<CR>

" Show an [o]utline of the file with tagbar
nnoremap <Leader>o :TagbarToggle<CR>

" Start Easy Align's interactive mode
vnoremap <silent> <Space> :EasyAlign<CR>

" DadBod
nnoremap <leader>db :DBUI<CR>

" Spectre
nnoremap <leader>S :Spectre<CR>

" Disable these mappings which I tend to just
" fat-finger and end up getting in my way
map K k

" But [K] is very useful, so keep it around
nnoremap <Leader>k K

" Configuration

" Add spaces after comments and remove them when removing comments
let g:NERDSpaceDelims = 1
let g:NERDRemoveExtraSpaces = 1

" Only show git gutter when requested,
" use the diff highlighting by default.
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 1

" Open tagbar on the left, just like nerdtree
let g:tagbar_left = 1

" Have tagbar automatically focus and close once a tag is selected
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

" Sort by the order in the file, not by name
let g:tagbar_sort = 0

" Disable syntastic for HTML. It kind of sucks.
let syntastic_mode_map = { 'passive_filetypes': ['html'] }

" Use powerline fonts (built-in to Iterm2) in airline
let g:airline_powerline_fonts = 1

colorscheme catppuccin_mocha

let g:airline_theme = 'catppuccin_mocha'

set background=dark
