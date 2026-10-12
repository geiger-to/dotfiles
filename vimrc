set nocompatible

" Enable mouse support
set mouse=a
if has('mouse_sgr')
  set ttymouse=sgr
endif

" Plugins
call plug#begin('~/.vim/plugged')

" Use a bunch of sensible defaults for vim,
" approved the by the reverend Tim Pope
Plug 'tpope/vim-sensible'

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

" Quickly maximize the current split
Plug 'regedarek/ZoomWin'

" Auto-detect indentation settings
Plug 'tpope/vim-sleuth'

" Add a useful status bar
Plug 'bling/vim-airline'

" Add .gitignore contents to wildignore
Plug 'vim-scripts/gitignore'

" file explorer with NERDTree
Plug 'preservim/nerdtree'

" Outline tags in a pane
Plug 'preservim/tagbar'

" Add auto-closing of pairs for ruby and vim
Plug 'tpope/vim-endwise'

" Add support for easy alignment
Plug 'junegunn/vim-easy-align'

" Add support for easy alignment
Plug 'AndrewRadev/splitjoin.vim'

" Add support for syntax error detection.
Plug 'dense-analysis/ale', has('nvim') ? { 'on': [] } : {}

" Visually expand regions
Plug 'terryma/vim-expand-region'

" DB access
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'

" Color schemes
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

" Trial
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'christoomey/vim-tmux-navigator'


call plug#end()

if !has('nvim')
  packadd! comment
endif

augroup vimrc
  autocmd!
augroup END

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

set undofile
if !has('nvim')
  let &undodir = expand('~/.cache/vim/undo')
  call mkdir(&undodir, 'p')
endif

" Share the system clipboard with vim
set clipboard=unnamed
vnoremap <LeftRelease> <LeftRelease>ygv

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
autocmd vimrc CursorHold,CursorHoldI * silent! wa

" Automatically balance splits
autocmd vimrc VimResized * wincmd =

" Most PHP is 4 spaces these days
autocmd vimrc FileType php setlocal softtabstop=4 tabstop=4 shiftwidth=4

" Don't wrap on HTML. That shit gets so long it's not funny.
autocmd vimrc FileType html,htmldjango,htmljinja,slim,html.handlebars setlocal textwidth=0 wrapmargin=0

" Speed up the slowness when dealing with synax highlighting ruby
autocmd vimrc FileType ruby setlocal re=1 foldmethod=manual

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
noremap : ;

" Open/Close NERDTree
nnoremap <leader>e :NERDTreeToggle<CR>

" Fast [w]rites and [q]uits
nnoremap <Leader>w :w!<CR>
nnoremap <Leader>x :wq!<CR>
nnoremap <Leader>q :q!<CR>

" Fast [r]emoval of files
nnoremap <Leader>rm :w!<CR>:call delete(expand('%'))<CR>:bdelete<CR>

" [O]pen the containing folder of a file in Finder
nnoremap <Leader>fo :silent !open -Rg %<CR>:redraw!<CR>

" Copy the filename or filepath to the clipboard
nnoremap <Leader>fn :let @*=expand("%")<CR>
nnoremap <Leader>fp :let @*=expand("%:p")<CR>

" Toggle search highlighting
nnoremap <Leader><Space> :set hlsearch!<CR><esc>

" Quickly create new splits. These have a nice, simple
" way of opening up that's similar to sublime.
nnoremap <Leader>v :botright vnew<CR><C-W>l
nnoremap <Leader>s :belowright new<CR><C-W>j

" Quickly change indent
vnoremap <C-l> >gv
vnoremap <C-h> <gv

" Quickly toggle code comments
nmap \\ gcc
xmap \\ gc

" [G]it integration
nnoremap <Leader>gg :Git<CR>

" Git [d]iff in the gutter. There's some sort of bug with the background
" colour that's fixed with running it this way. Adding the first
" statement doesn't fix anything if I do it inline...
nnoremap <Leader>gd :hi clear SignColumn<CR> :GitGutterToggle<CR>

" Fuzzy filename searching with ctrl-[p]
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git"'
nnoremap <Leader>p :Files<CR>

" Quickly bring up ripgrep for search
nnoremap <Leader>a :Rg<Space>

" Quickly [m]aximize a split
nnoremap <Leader>m :ZoomWin<CR>

" Show an [o]utline of the file with tagbar
nnoremap <Leader>o :TagbarToggle<CR>

" Start Easy Align's interactive mode
vnoremap <silent> <Space> :EasyAlign<CR>

" DadBod
nnoremap <leader>db :DBUI<CR>

" Disable these mappings which I tend to just
" fat-finger and end up getting in my way
map K k

" But [K] is very useful, so keep it around
nnoremap <Leader>k K

" Configuration

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

" Use powerline fonts (built-in to Iterm2) in airline
let g:airline_powerline_fonts = 1

" ChangeBackground changes the background mode based on macOS's `Appearance`
" setting. We also refresh the statusline colors to reflect the new mode.
function! ChangeBackground()
  let l:dark = system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
  if exists('g:colors_name') && g:colors_name ==# (l:dark ? 'catppuccin_mocha' : 'catppuccin_latte')
    return
  endif

  if l:dark
    set background=dark   " for the dark version of the theme
    colorscheme catppuccin_mocha
    let g:airline_theme = 'catppuccin_mocha'
  else
    set background=light  " for the light version of the theme
    colorscheme catppuccin_latte
    let g:airline_theme = 'catppuccin_latte'
  endif

  try
    execute "AirlineRefresh"
  catch
  endtry
endfunction

" initialize the colorscheme for the first run
call ChangeBackground()

" change the color scheme if we receive a SigUSR1
if has('nvim')
  autocmd vimrc Signal SIGUSR1 call ChangeBackground()
else
  autocmd vimrc SigUSR1 * call ChangeBackground()
endif
autocmd vimrc FocusGained * call ChangeBackground()
