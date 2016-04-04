set nocompatible

" Behaviour {{{

  " Show line numbers
  set number

  " Show common line limits
  set colorcolumn=80,120

  " Highlight the line that the cursor is on
  set cursorline

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

  " Show context above and below the cursor
  set scrolloff=5

  " Wrap lines when moving around the file
  set whichwrap+=<,>,h,l

  " Show a navigable menu for tab completion
  set wildmenu

  " Allow per-project settings
  set exrc
  set secure

  " Context-dependent cursor in the terminal
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif

  " Auto-save after a brief period of time
  autocmd CursorHold,CursorHoldI * silent! wa

  " Automatically balance splits
  autocmd VimResized,BufNew !nerdtree wincmd =

  " Most PHP is 4 spaces these days
  au FileType php setlocal softtabstop=4 tabstop=4 shiftwidth=4

  " Treat ES6 as straight up Javascript, yo.
  au BufNewFile,BufRead *.es6 set filetype=javascript

  " Don't wrap on HTML. That shit gets so long it's not funny.
  au FileType html,htmldjango,htmljinja,slim,html.handlebars setlocal textwidth=0 wrapmargin=0

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

" }}}

" Mappings {{{

  " Even better than the comma
  let mapleader = " "

  " Because ESC is just too far away
  inoremap jj <ESC>

  " And Shift-; is just too darn difficult
  noremap ; :

  " Fast [w]rites and [q]uits
  nnoremap <Leader>w :w!<CR>
  nnoremap <Leader>wq :wq!<CR>
  nnoremap <Leader>q :q!<CR>

  " Fast [r]emoval of files
  nnoremap <Leader>rm :w!<CR>:call delete(expand('%'))<CR>:bdelete<CR>

  " [O]pen the containing folder of a file in Finder
  nnoremap <Leader>fo :silent !open -Rg %<CR>:redraw!<CR>

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
  nnoremap <Leader>gp :Git push<CR>
  nnoremap <Leader>ga :Git commit --amend<CR>

  " Git [d]iff in the gutter. There's some sort of bug with the background
  " colour that's fixed with running it this way. Adding the first
  " statement doesn't fix anything if I do it inline...
  nnoremap <Leader>gd :hi clear SignColumn<CR> :GitGutterToggle<CR>

  " Fuzzy filename searching with ctrl-[p]
  let g:ctrlp_map = '<Leader>p'

  " Add a few oft-used ignores to CtrlP. They end up
  " just bogging it down for no real reason.
  let g:ctrlp_custom_ignore = {
  \ 'dir':  'node_modules\|bower_components',
  \ }

  " Grep with [a]g, aka the silver searcher
  nnoremap <Leader>a :Ag ''<Left>

  " Quickly [m]aximize a split
  nnoremap <Leader>m :ZoomWin<CR>

  " Show an [o]utline of the file with tagbar
  nnoremap <Leader>o :TagbarToggle<CR>

  " Start Easy Align's interactive mode
  vnoremap <silent> <Space> :EasyAlign<CR>

  " Disable these mappings which I tend to just
  " fat-finger and end up getting in my way
  map K k

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

  " Disable syntastic for HTML. It kind of sucks.
  let syntastic_mode_map = { 'passive_filetypes': ['html'] }
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
  NeoBundle 'ctrlpvim/ctrlp.vim'

  " Indicate the diff of the file in the gutter
  NeoBundle 'airblade/vim-gitgutter'

  " Add amazing git integration
  NeoBundle 'tpope/vim-fugitive'

  " Easily manipulate surrounding pairs
  NeoBundle 'tpope/vim-surround'

  " Enable . for plugin mappings
  NeoBundle 'tpope/vim-repeat'

  " Add support for even more languages
  NeoBundle 'sheerun/vim-polyglot'

  " Add searching with ag
  NeoBundle 'rking/ag.vim'

  " Quickly maximize the current split
  NeoBundle 'regedarek/ZoomWin'

  " Auto-detect indentation settings
  NeoBundle 'tpope/vim-sleuth'

  " Add a beautiful and useful status bar
  NeoBundle 'bling/vim-airline'

  " Add .gitignore contents to wildignore
  NeoBundle 'vim-scripts/gitignore'

  " Quickly comment lines
  NeoBundle 'scrooloose/nerdcommenter'

  " Outline tags in a pane
  NeoBundle 'majutsushi/tagbar'

  " Add auto-closing of pairs for ruby and vim
  NeoBundle 'tpope/vim-endwise'

  " Show netrw in the current split.
  NeoBundle 'tpope/vim-vinegar'

  " Add support for easy alignment
  NeoBundle 'junegunn/vim-easy-align'

  " Add support for syntax error detection.
  NeoBundle 'scrooloose/syntastic'

  " Use Emmet for rapid HTML writing
  NeoBundle 'mattn/emmet-vim'

  " Highlight matching HTML tags.
  NeoBundle 'Valloric/MatchTagAlways'

  " Visually expand regions
  NeoBundle 'terryma/vim-expand-region'

  " Auto-completion
  NeoBundle 'Valloric/YouCompleteMe'

  " Handlbars syntax support
  NeoBundle 'mustache/vim-mustache-handlebars'

  " Try out Sierra occasionally
  NeoBundle 'AlessandroYorba/Sierra'

  " Solarized is nice too.
  NeoBundle 'altercation/vim-colors-solarized'

  " She's a beaut!
  colorscheme solarized
  set background=dark

  " Let NeoBundle ensure everything is properly installed
  NeoBundleCheck

" }}}
