" ex: set foldmethod=marker
set nocompatible

" Behaviour {{{

  " She's a beaut!
  color solarized

  " True programmers use dark backgrounds
  set background=dark

  " Show line numbers
  set number

  " Show common line limits
  set colorcolumn=80,120

  " Highlight the line that the cursor is on
  set cursorline

  " Underline spelling mistakes
  set spell

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

  " Wrap at 80 lines. It's still important.
  set textwidth=80

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

  " Show context above and below the curoser
  set scrolloff=3

  " Show a navigable menu for tab completion
  set wildmenu

  " Allow per-project settings
  set exrc
  set secure

  " Context-dependent cursor in the terminal
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"

  " Auto-save after a brief period of time
  autocmd CursorHold,CursorHoldI * silent! wa

  " Automatically balance spluts
  autocmd VimResized,BufNew !nerdtree wincmd =

" }}}

" Mappings {{{

  " Even better than the comma
  let mapleader = " "

  " Because ESC is just too far away
  inoremap jj <ESC>

  " And Shift-; is just too darn difficult
  noremap ; :
  noremap ;; :

  " Fast [w]rites and [q]uits
  nnoremap <Leader>w :w!<CR>
  nnoremap <Leader>wq :wq!<CR>
  nnoremap <Leader>q :q!<CR>

  " Fast [r]emoval of files
  nnoremap <Leader>frm :w!<CR>:call delete(expand('%'))<CR>:bdelete<CR>

  " [O]pen the containing folder of a file in Finder
  nnoremap <Leader>fo :silent !open -Rg %<CR>:redraw!<CR>

  " Toggle search highlighting
  nnoremap <Leader><Space> :set hlsearch!<CR><esc>

  " Quickly create new splits. These have a nice, simple
  " way of opening up that's similar to sublime.
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

  " Quickly toggle code comments
  map \\ <plug>NERDCommenterToggle

  " [G]it integration
  nnoremap <Leader>gs :Gstatus<CR>
  nnoremap <Leader>gc :Gcommit<CR>
  nnoremap <Leader>gb :Gblame<CR>
  nnoremap <Leader>gd :Gdiff<CR>
  nnoremap <Leader>ga :Git commit --amend<CR>

  " Git [d]iff in the gutter. There's some sort of bug with the background
  " colour that's fixed with running it this way. Adding the first
  " statement doesn't fix anything if I do it inline...
  nnoremap <Leader>d :hi clear SignColumn<CR> :GitGutterToggle<CR>

  " Fuzzy filename searching with ctrl-[p]
  let g:ctrlp_map = '<Leader>p'

  " [E]xplore the filesystem with NERDTree
  nnoremap <Leader>e :NERDTreeToggle<CR>

  " Grep with [a]g, aka the silver searcher
  nnoremap <Leader>a :Ag ''<Left>

  " Quickly [m]aximize a split
  nnoremap <Leader>m :ZoomWin<CR>

  " Show an [o]utline of the file with tagbar
  nnoremap <Leader>o :TagbarToggle<CR>

  " Disable these mappings which I tend to just
  " fat-finger and end up getting in my way
  map K k
  map J j

  " But [K] is very useful, so keep it around
  nnoremap <Leader>k K

" }}}

" Configuration {{{
"
  " Disable airline's pretty separators because
  " I'm too lazy to use the patched font.
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''

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
" }}}

" Bundles {{{

  " Initialize NeoBundle
  if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif

  call neobundle#rc(expand('~/.vim/bundle/'))

  " Let NeoBundle manage itself
  NeoBundleFetch 'Shougo/neobundle.vim'

  " Use a bunch of sensible defaults for vim,
  " approved the by the reverend Tim Pope
  NeoBundle 'tpope/vim-sensible'

  " The ever-famous, for fuzzy file searching
  NeoBundle 'kien/ctrlp.vim'

  " Integrate with bundler
  NeoBundle 'tpope/vim-bundler'

  " Indicate the diff of the file in the gutter
  NeoBundle 'airblade/vim-gitgutter'

  " Add amazing git integration
  NeoBundle 'tpope/vim-fugitive'

  " Easily manipulate surrounding pairs
  NeoBundle 'tpope/vim-surround'

  " Use NERDTree for browsing files
  NeoBundle 'scrooloose/nerdtree'

  " Add support for even more languages
  NeoBundle 'sheerun/vim-polyglot'

  " Add searching with ag
  NeoBundle 'rking/ag.vim'

  " Quickly maximize the current split
  NeoBundle 'regedarek/ZoomWin'

  " Auto-detect indentation settings
  NeoBundle 'conormcd/matchindent.vim'

  " Add a beautiful and useful status bar
  NeoBundle 'bling/vim-airline'

  " Add .gitignore contents to wildignore
  NeoBundle 'vim-scripts/gitignore'

  " Quickly comment lines
  NeoBundle 'scrooloose/nerdcommenter'

  " Outline tags in a pane
  NeoBundle 'majutsushi/tagbar'

  " Auto-generate tags files
  NeoBundle 'xolox/vim-misc'
  NeoBundle 'xolox/vim-easytags'

  " Auto close parenthesis and other commonly
  " used delimiters. Doesn't do shit for ruby or vim.
  NeoBundle 'jiangmiao/auto-pairs'

  " Add similar support for ruby and vim
  NeoBundle 'tpope/vim-endwise'

  " Let NeoBundle ensure everything is properly installed
  NeoBundleCheck

" }}}
