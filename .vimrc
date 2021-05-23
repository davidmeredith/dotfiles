
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" not compatible with vi (default is not compatible)
set nocompatible

" Plugins managed with vim-plug (https://github.com/junegunn/vim-plug)
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes for Plug urls
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://tpope.io/vim/sensible.git'
Plug 'https://tpope.io/vim/surround.git'
Plug 'https://tpope.io/vim/repeat.git'
"Plug 'ctrlpvim/ctrlp.vim' "Deprecated in favour of FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'preservim/nerdtree'
Plug 'junegunn/fzf.vim'
"Plug 'nvim-telescope/telescope.nvim' " replacement for FZF??

" https://github.com/mbbill/undotree 
Plug 'mbbill/undotree'

" Recommended colour scheme
"Plug 'gruvbox-community/gruvbox' "also set (colorscheme gruvbox)

" show indent level
Plug 'yggdroot/indentline' "also set (let g:indentLine_char = '▏' )
" quickly align things
Plug 'godlygeek/tabular'
" Airline 
Plug 'vim-airline/vim-airline'
" Airline themes
Plug 'vim-airline/vim-airline-themes'

" distraction free reading
"Plug 'junegunn/goyo.vim'


" Colour theme
" https://github.com/lifepillar/vim-solarized8
Plug 'lifepillar/vim-solarized8'

call plug#end()
" Save and reload .vimrc and use :PlugInstall to install newly installed plugins.
" (you can reload using ':so $MYVIMRC' or if you're editing .vimrc use ':so %')

" Plugins installed with pathogen (https://github.com/tpope/vim-pathogen)
" manage vims runtime path with ease using pathogen, see:
" https://github.com/tpope/vim-pathogen
" Basically install pathogen to ~/.vim/autoload/pathogen.vim then add line below
" then clone vim plugins into the '~/.vim/bundle' dir, e.g. following installs vim-sensible
"   cd ~/.vim/bundle && \
"   git clone https://github.com/tpope/vim-sensible.git
"execute pathogen#infect()


let g:indentLine_char = '▏'


filetype plugin indent on
syntax on
set exrc " run a .vimrc in a
set ignorecase
set smartcase
set smartindent
set incsearch
set softtabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set spelllang=en_gb
set nocompatible
set number                     " Show current line number
set relativenumber             " Show relative line numbers
set hidden
set noerrorbells
"set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set scrolloff=8

set signcolumn=yes
set colorcolumn=80
" set to 2 to give more space displaying messages
set cmdheight=1 

" Use clipboard as default register
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif
set background=dark
colorscheme flattened_dark "https://github.com/romainl/flattened
"colorscheme solarized8
"colorscheme gruvbox

" Dont need below as i use undodir
"set backup
"set backupdir=~/.vim-back
"set directory=~/.vim-back
"set writebackup

" Vim 8+ default plugin manager
" Any directory under ~/.vim/pack is considered a package.
" A package can hold plugins in two different directories, start and opt.
" The plugins under start/ folder are loaded on startup, while the plugins under
" opt/ folder are loaded manually by the user with the command :packadd.
" Don't striclty need tocall packloadall, but calling twice has no effect
" DMs packages:
" flattended_dark theme
" prettier vim plugin
packloadall


" The mac Cmd key is only visible to the MacVim GUI so you won't be able to use it in CLI Vim at all so prob best not to use it.

" n = Normal mode remap, nore = no recursive map, map
" Tab navigation like Firefox or Chrome
"nnoremap <C-tab>   :tabnext<CR>
"nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <S-left>  :tabprevious<CR>
nnoremap <S-right> :tabnext<CR>
nnoremap <C-t>     :tabnew .<CR>
"Close tab, but this overwrites C-ww for jumping between split panes
"nnoremap <C-w>     :tabclose<CR>



" i Insert norecursive remaps
inoremap <S-left>  <Esc>:tabprevious<CR>a
inoremap <S-right> <Esc>:tabnext<CR>a
inoremap <C-t>     <Esc>:tabnew .<CR>
"Close tab, but this overwrites C-ww for jumping between split panes
"inoremap <C-w>     <Esc>:tabclose<CR>a

" Fuzzy file search, deprecates Ctrl-P
" Remap FZF to Ctrl+p
set rtp+=/usr/local/opt/fzf
nmap <C-P> :FZF<CR>

" https://stackoverflow.com/questions/11122866/vim-default-leader-key-on-a-macbook
let mapleader = ' '
nnoremap <leader>[ :vertical resize +5<CR>
nnoremap <leader>] :vertical resize -5<CR>
" jump between windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeToggle<CR>

" delete visual selection into blackhole register without
" overwriting default register
vnoremap <leader>d "_d
" delete visual selection into blackhole register and paste
" default register before cursor without overwriting the default reg - great !
vnoremap <leader>p "_dP

" move visual selection up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" next greatest remap ever : primeagen, asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

" netrw
" :Vex  to open file in new v split
" :Ex   to open in current window
let g:netrw_altv=1
" set split size to 25%
let g:netrw_winsize = 25
" By default files will be opened in the same window as the netrw directory
" 4 open in previous window, 2 open in a new vertical split, 3 open new tab
let g:netrw_browse_split = 2
" use tree view (when in Ex, hit 'i' to cycle through view modes)
let g:netrw_liststyle = 1
let g:netrw_banner = 0

"" Created to be able to save a file opened with :edit where the
"" path contains directories that do not exist yet. This script
"" will create them and if they exist, `mkdir` will run without
"" throwing an error.
"command! M :call MakeDirsAndSaveFile()
"function! MakeDirsAndSaveFile()
"  " https://vi.stackexchange.com/questions/1942/how-to-execute-shell-commands-silently
"  :silent !mkdir -p %:h
"  :redraw!
"  " -----------
"  :write
"endfunction

" Config for nvim so it reads this file '.vimrc'
" see: ~/.config/nvim/init.vim
" https://vi.stackexchange.com/questions/12794/how-to-share-config-between-vim-and-neovim


" undotree Persistent undo
if has("persistent_undo")
   let target_path = expand('~/.vim/undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif


" Auto commands
"
"fun! TrimWhitespace()
"    let l:save = winsaveview()
"    keeppatterns %s/\s\+$//e
"    call winrestview(l:save)
"endfun
"
"augroup DAVEM
"    autocmd!
"    autocmd BufWritePre * :call TrimWhitespace()
"augroup END

