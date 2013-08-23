set nocompatible
filetype off

set number
set ruler
set colorcolumn=80
syntax on

" Visual things
set linespace=5
set guifont=Menlo:h12
set cursorline

" Common tweaks
set history=1000
let mapleader = ","
inoremap jj <ESC>
set spell

" Share the system clipboard with vim
set clipboard=unnamed

" Context-dependent cursor in the terminal
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

set encoding=utf-8

" Whitespace stuff
set nowrap
set textwidth=79
set autoindent
set copyindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab

" Nice invisibles
set list listchars=tab:·\ ,trail:•
set fileformats=unix

" Searching
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <silent> <esc> :set hlsearch!<CR><esc>
nnoremap / /\v
vnoremap / /\v

" Tab completion
set wildmode=list:longest,list:full

set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,*/vendor/gems/*
set wildignore+=*.pyc,*.pyo,*.egg-info,*.egg,*/env/*
set wildignore+=*.cache.php,*.php.meta

" Status bar
set laststatus=2

" Per-project settings
set exrc
set secure

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Functionality plugins
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'ervandew/supertab'
Bundle 'vim-scripts/ZoomWin'
Bundle 'conormcd/matchindent.vim'
Bundle 'svermeulen/vim-quickfixdo'

" Syntax plugins
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-git'
Bundle 'pangloss/vim-javascript'
Bundle 'lepture/vim-jinja'
Bundle 'groenewege/vim-less'
Bundle 'juvenn/mustache.vim'
Bundle 'kchmck/vim-coffee-script'

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

" Add coffeescript support
au BufRead,BufNewFile *.coffee set ft=coffee

" Add haml-coffee support
au BufRead,BufNewFile *.hamlc set ft=haml

" add json syntax highlighting
au BufRead,BufNewFile *.json set ft=javascript

" Map .twig files as jinja templates
au BufRead,BufNewFile *.{twig} set ft=jinja

" Add .less highlighting
au BufRead,BufNewFile *.{less} set ft=less

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4

" PHP and more
au FileType php,css,html,jinja,javascript setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4

" Don't wrap HTML
au FileType html,jinja setlocal textwidth=0

" Ruby
au FileType ruby,coffee,haml,yaml setlocal expandtab shiftwidth=2 softtabstop=2

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Default color scheme
color solarized
set background=dark

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Show (partial) command in the status line
set showcmd

" Disable ctrlp's working path detection
let g:ctrlp_working_path_mode = ''

" Use git-grep for grepping
set grepprg=git\ grep\ -n\ $*

" Auto save files
autocmd CursorHold,CursorHoldI * silent! wa

" Balance window sizes automatically
autocmd VimResized,BufNew * wincmd =

" Fast resizing of splits
map <C-=> <C-w>=

" New splits
map <Leader>v :botright vnew<CR><C-W>l
map <Leader>s :belowright new<CR><C-W>j

" Split movement
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" New tab
map <Leader>t :tabnew<CR>

" Bindings
map  <Leader>/ <plug>NERDCommenterToggle
nmap <Leader>f :copen\|grep<space>
nmap <Leader>qf :Qfdo
nmap <Leader>m :ZoomWin<CR>
vmap <Leader>> >gv
vmap <Leader>< <gv

" Fugitive
nmap <Leader>gb :Gblame<CR>
nmap <Leader>gd :Gdiff<CR>
