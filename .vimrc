" Dave's vim config ('~/.dotfiles/.vimrc')
" Symlinks:
"  '~/.config/nvim/init.vim' (nvim)
"  '~/.vimrc' (for gvim & ideavim)

" Note ~/.vim dir is a synmlink: ~/.vim@ -> /Users/davidmeredith/.dotfiles/vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" I'm going to start moving some config into lua
lua require('basic')


" Add parent dir to the list of dirs searched for when using gf, :find, :sfind,
" :tabfind (default is '.,,' ie dot for relative to current file and 
" two commas for current directory)
set path+=**

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu
" Ignore files
set wildignore+=*.pyc
set wildignore+=*.class
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/target/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

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

if !exists('g:vscode')
    " only add commentary if not in vscode
    Plug 'https://github.com/tpope/vim-commentary'
endif

Plug 'https://tpope.io/vim/sensible.git'
Plug 'https://tpope.io/vim/surround.git'
Plug 'https://tpope.io/vim/repeat.git'

if !exists('g:vscode')
    " telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    "Plug 'ctrlpvim/ctrlp.vim' "Deprecated in favour of FZF
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    "Plug 'preservim/nerdtree'

    " Rooter makes fzf look up for a project directory instead of searching 
    " from pwd (default). Also respects .gitignore so not to look into spedified dirs.  
    Plug 'airblade/vim-rooter'

    " https://github.com/mbbill/undotree 
    Plug 'mbbill/undotree'

    " Treesitter
    " Useful commands:
    " :h nvim-treesitter-commands
    " :TSInstall <language_to_install>
    " TSInstallInfo 
    ":checkhealth nvim_treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

    " nvim-tree
    "Plug 'kyazdani42/nvim-web-devicons' " for file icons
    "Plug 'kyazdani42/nvim-tree.lua'
endif


" show indent level
Plug 'yggdroot/indentline' "also set (let g:indentLine_char = '▏' )
" quickly align things
"Plug 'godlygeek/tabular'
" Airline 
Plug 'vim-airline/vim-airline'
" Airline themes
Plug 'vim-airline/vim-airline-themes'

" Colour theme
" https://github.com/lifepillar/vim-solarized8
" Plug 'lifepillar/vim-solarized8'
Plug 'gruvbox-community/gruvbox' "also set (colorscheme gruvbox)


" https://www.chrisatmachine.com/Neovim/12-git-integration/
if !exists('g:vscode')
    Plug 'mhinz/vim-signify'
    " I don't need vim-fugitve, use the CLI for git rather than in vim. 
    "Plug 'tpope/vim-fugitive'
    " I don't need gv.vim (git log browser), use CLI instead. Requires fugitive. 
    "Plug 'junegunn/gv.vim'
    " Can't use rhubarb, requires fugitive. 
    "Plug 'tpope/vim-rhubarb'
endif
call plug#end()
" Save, reload and source .vimrc and use :PlugInstall to install newly installed plugins.
" (you can reload using ':so $MYVIMRC' or if you're editing .vimrc use ':so %')

" Plugins installed with pathogen (https://github.com/tpope/vim-pathogen)
" manage vims runtime path with ease using pathogen, see:
" https://github.com/tpope/vim-pathogen
" Basically install pathogen to ~/.vim/autoload/pathogen.vim then add line below
" then clone vim plugins into the '~/.vim/bundle' dir, e.g. following installs vim-sensible
"   cd ~/.vim/bundle && \
"   git clone https://github.com/tpope/vim-sensible.git
"execute pathogen#infect()

" Remaps (ensure leader key is mapped before defining it)
let mapleader = ' '

" Treesitter 
" Treesitter folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" Treesitter highlighting
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF


" default updatetime 4000ms is not good for async update (from signify repo)
if !exists('g:vscode')
    set updatetime=100
endif

" Signify config for viewing and moving over git changes
if !exists('g:vscode')
    " Change these if you want
    let g:signify_sign_add               = '+'
    let g:signify_sign_delete            = '_'
    let g:signify_sign_delete_first_line = '‾'
    let g:signify_sign_change            = '~'
    " I find the numbers disctracting
    let g:signify_sign_show_count = 0
    let g:signify_sign_show_text = 1
    " Jump though hunks
    "nmap <leader>gj <plug>(signify-next-hunk)
    "nmap <leader>gk <plug>(signify-prev-hunk)
    "nmap <leader>gJ 9999<leader>gJ
    "nmap <leader>gK 9999<leader>gk
    " below is more friendly for intellij remap/keymap
    nmap ]v <plug>(signify-next-hunk)
    nmap [v <plug>(signify-prev-hunk)

    " Useful commands
    " :SignifyToggle
    " :SignifyToggleHighlight
endif

" Git commit browser junegunn/gv.vim 
" useful commands:
" :GV to open commit browser (You can pass git log options to the command, e.g. :GV -S foobar -- plugins).
" :GV! will only list commits that affected the current file

" Airline buffer-tabs (lists buffers in a tab like row in top left)
" Note that I remap tab and shift-tab to bnext and bprev below
let g:airline#extensions#tabline#enabled = 1

let g:indentLine_char = '▏'

" VSCode config
if exists('g:vscode')
    " Don't need tpope's commentary for vscode, use vscode's plugin instead
    xmap gc  <Plug>VSCodeCommentary
    nmap gc  <Plug>VSCodeCommentary
    omap gc  <Plug>VSCodeCommentary
    nmap gcc <Plug>VSCodeCommentaryLine
endif


filetype plugin indent on
syntax on
set exrc " run a .vimrc in a
set mouse=a
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
" colorscheme flattened_dark "https://github.com/romainl/flattened
"colorscheme liquidcarbon
"colorscheme solarized8
colorscheme gruvbox

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

" Remaps
" n = Normal mode remap, 
" nore = no recursive map, 
" so inoremap means = i Insert mode norecursive remaps
" so nnoremap means = n Normal mode norecursive remaps

" Insert undo break points on ,.!? chars (the '<c-g>u' part breaks the undo 
" sequence and starts new change)
" Can't use these remaps because intellij ideavim can't handle them:
"inoremap , ,<c-g>u
"inoremap . .<c-g>u
"inoremap ! !<c-g>u
"inoremap ? ?<c-g>u

" Vim Tab navigation (note, this is different to my shell nav remaps 
" with <S-Cmd-]> and <S-Cmd-[> which I also use for browser)
"nnoremap <C-tab>   :tabnext<CR>
"nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <S-left>  :tabprevious<CR>
nnoremap <S-right> :tabnext<CR>
nnoremap <C-t>     :tabnew .<CR>
"Close tab, but this overwrites <C-ww> for jumping between split panes
"nnoremap <C-w>     :tabclose<CR>
"
" Tab for buffer-next and shift-TAB for buffer-prev 
nnoremap <TAB>  :bnext<CR>
nnoremap <S-TAB>  :bprev<CR>

" Remap Esc. You need to map these to some infrequent key pair, 
" but if you need to type jj in sentences, then you can but just do it slowly. 
inoremap jj <Esc>
"inoremap jk <Esc>
"nnoremap <C-c> <Esc>
" Note, for vscode that uses neovim, you will still need to add the 
" following to its keybindings.json file (replace single quotes with double)a:
" {
"    'command': 'vscode-neovim.compositeEscape1',
"    'key': 'j',
"    'when': 'neovim.mode == insert && editorTextFocus',
"    'args': 'j'
"}

inoremap <S-left>  <Esc>:tabprevious<CR>a
inoremap <S-right> <Esc>:tabnext<CR>a
inoremap <C-t>     <Esc>:tabnew .<CR>
"Close tab, but this overwrites C-ww for jumping between split panes
"inoremap <C-w>     <Esc>:tabclose<CR>a

" Fuzzy file search, deprecates Ctrl-P
" Remap FZF to Ctrl+p
set rtp+=/usr/local/opt/fzf
nmap <C-P> :FZF<CR>
" note you can then do "vim `FZF`" on the CLI

" Telescope remaps to find files/grep
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Splits
nnoremap <leader>[ :vertical resize +5<CR>
nnoremap <leader>] :vertical resize -5<CR>
nnoremap <leader>+ :resize +5<CR>
nnoremap <leader>- :resize -5<CR>
" jump between splits
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Clean Delete
" Delete visual selection into blackhole register without
" overwriting default register
vnoremap <leader>d "_d
" Clean Delete Paste 
" Delete visual selection into blackhole register and paste
" default register before cursor without overwriting the default reg - great !
vnoremap <leader>p "_dP

" Move visual selection up and down
" so, for J, move (:m) end of visual selection ('>) one line down then enter
" (<CR> / carridage return) and select previous vis selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Yank into clipboard 
nnoremap <leader>y "*y
vnoremap <leader>y "*y
" copy whole file into clipboard
nnoremap <leader>Y gg"+yG

" netrw
" :Vex  to open in new v split
" :Ex   to open in current window
let g:netrw_altv=1
" set split size to 25%
let g:netrw_winsize = 25
"  netrw_browse_split: when browsing, <cr> will open the file by:
"=0: re-using the same window  (default)
"=1: horizontally splitting the window first
"=2: vertically   splitting the window first
"=3: open file in new tab
let g:netrw_browse_split = 0
" use tree view (when in Ex, hit 'i' to cycle through view modes)
let g:netrw_liststyle = 1
let g:netrw_banner = 0


" If you use virtual environments putting these varibles in your config will 
" ensure pynvim and node-with-nvim plugins are always available. 
let g:python3_host_prog = expand("/Users/davidmeredith/.pyenv/shims/python")
"let g:python3_host_prog = expand("~/.miniconda/envs/neovim/bin/python3.8") " <- example
"
"let g:node_host_prog = expand("<path to node with neovim installed>")
"let g:node_host_prog = expand("~/.nvm/versions/node/v12.16.1/bin/node") " <- example



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



" undotree Persistent undo
" toggle undotree panel
nnoremap <leader>u :UndotreeToggle<CR>
" Press ? in undotree window for quick help
" Undo history is sorted by timestamp. 
" Markers:
"   Current state: > number <
"   Redo state:  { number }  (the next state that would be restored by :redo or <ctrl-r>
"   Most recent: [ number ]
"   Saved changes marked with 's' and 'S' indicates most recent save
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

