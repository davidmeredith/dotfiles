
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
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/nerdtree'
" show indent level
Plug 'yggdroot/indentline'
let g:indentLine_char = '▏'
" quickly align things
Plug 'godlygeek/tabular'
" Airline
Plug 'vim-airline/vim-airline'
" Airline themes
Plug 'vim-airline/vim-airline-themes'

" distraction free reading
Plug 'junegunn/goyo.vim'


" Colour theme
" https://github.com/lifepillar/vim-solarized8
Plug 'lifepillar/vim-solarized8'

call plug#end()
" Save and reload .vimrc and use :PlugInstall to install newly installed plugins.
" (reload using ':so $MYVIMRC' or if you're editing .vimrc use ':so %') 

" Plugins installed with pathogen (https://github.com/tpope/vim-pathogen)
" manage vims runtime path with ease using pathogen, see:
" https://github.com/tpope/vim-pathogen
" Basically install pathogen to ~/.vim/autoload/pathogen.vim then add line below 
" then clone vim plugins into the '~/.vim/bundle' dir, e.g. following installs vim-sensible
"   cd ~/.vim/bundle && \
"   git clone https://github.com/tpope/vim-sensible.git
"execute pathogen#infect()

filetype plugin indent on
syntax on
set ignorecase
set smartcase
set incsearch
set softtabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set spelllang=en_gb
set nocompatible
set number                     " Show current line number
set relativenumber             " Show relative line numbers
set clipboard=unnamed
set background=dark
colorscheme flattened_dark "https://github.com/romainl/flattened
"colorscheme solarized8


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

" Tab navigation like Firefox or Chrome
"nnoremap <C-tab>   :tabnext<CR>
"nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <S-left>  :tabprevious<CR>
nnoremap <S-right> :tabnext<CR>
nnoremap <C-t>     :tabnew .<CR>
"Close tab, but this overwrites C-ww for jumping between split panes
"nnoremap <C-w>     :tabclose<CR>

inoremap <S-left>  <Esc>:tabprevious<CR>a
inoremap <S-right> <Esc>:tabnext<CR>a
inoremap <C-t>     <Esc>:tabnew .<CR>
"Close tab, but this overwrites C-ww for jumping between split panes
"inoremap <C-w>     <Esc>:tabclose<CR>a 

