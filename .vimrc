" Settings
" Show Line Numbers
set number relativenumber
" Wrap Text
set wrap
" Set Text Encoding
set encoding=utf-8
" Status Bar
set laststatus=2
" No Startup Text
set shortmess=I
" Show Current Command
set showcmd
" Avoid Wrapping A Line In The Middle Of A Word
set linebreak
" Make Searching Better
set hlsearch
set incsearch
vnoremap <C-c> "+y
map <C-p> "+P
" Enable Colors In The Terminal
set termguicolors
" Highlight The Line Currently Under Cursor
set cursorline
" Make Update Time Smaller
set updatetime=250
" Enable Mouse
set mouse=a
set mousehide
" Show The File Currently Being Edited
set title
" Confirm You Want To Close Unsaved File
set confirm
" Enable Spellchecking
set spell
" Set History Higher
set history=10000
" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
" Make Vim Act Normal In Windows
set nocompatible
" Turn On Syntax
syntax enable
filetype plugin on
let g:is_posix=1
" Enable Autocompletion
set wildmode=longest,list,full
" Make It So When You Split It Goes To The Right
set splitbelow splitright
" Make Hopping Around Split Windows Easier
map <C-h> <cmd>wincmd h <CR>
map <C-j> <cmd>wincmd j <CR>
map <C-k> <cmd>wincmd k <CR>
map <C-l> <cmd>wincmd l <CR>
" Remap S Which Is Equal To The Command cc To A Find And Replace Function
nnoremap S :%s//g<Left><Left>
" Delete Whitespace On Save
autocmd BufWritePre * %s/\s\+$//e
" Backup History
if has('win64') || has('win32') || has('win16')
  if !isdirectory('$LOCALAPPDATA\Temp\.vim-undo-dir')
    silent! call mkdir('$LOCALAPPDATA\Temp\.vim-undo-dir', '', 0700)
    set undodir=$LOCALAPPDATA\Temp\.vim-undo-dir
  endif
else
  if !isdirectory('/tmp/.vim-undo-dir')
    silent! call mkdir('/tmp/.vim-undo-dir', '', 0700)
    set undodir=/tmp/.vim-undo-dir
  endif
endif
set undofile
" Have GDB Alias
autocmd VimEnter * packadd termdebug
" Grab Coc Settings
if has('win64') || has('win32') || has('win16')
  if empty(glob('~\vimfiles\coc-settings.json'))
    silent ! powershell -Command "
    \   New-Item -Path ~\vimfiles -Name autoload -Type Directory -Force;
    \   Invoke-WebRequest
    \   -Uri 'https://raw.githubusercontent.com/tbrsvn/vimconfig/main/vimfiles/coc-settings.json'
    \   -OutFile ~\vimfiles\coc-settings.json
    \ "
  endif
else
  if empty(glob('~/.vim/coc-settings.json'))
    silent !curl -fLo ~/.vim/coc-settings.json --create-dirs
      \ https://raw.githubusercontent.com/tbrsvn/vimconfig/main/.vim/coc-settings.json
  endif
endif
" Install Vim-Plug If Not Found
if has('win64') || has('win32') || has('win16')
  if empty(glob('~\vimfiles\autoload\plug.vim'))
    silent ! powershell -Command "
    \   New-Item -Path ~\vimfiles -Name autoload -Type Directory -Force;
    \   Invoke-WebRequest
    \   -Uri 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    \   -OutFile ~\vimfiles\autoload\plug.vim
    \ "
  endif
else
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif
endif
" Plugins
call plug#begin()
  Plug 'luochen1990/rainbow'
  Plug 'tpope/vim-fugitive'
  Plug 'vimwiki/vimwiki'
  Plug '907th/vim-auto-save'
  Plug 'tpope/vim-surround'
  Plug 'yegappan/mru'
  Plug 'vim-airline/vim-airline'
  Plug 'tpope/vim-commentary'
  Plug 'tc50cal/vim-terminal'
  Plug 'lervag/vimtex'
  Plug 'xianzhon/vim-code-runner'
  Plug 'ryanoasis/vim-devicons'
  Plug 'pbrisbin/vim-mkdir'
  Plug 'mhinz/vim-startify'
  Plug 'mbbill/undotree'
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  Plug 'preservim/nerdtree' |
              \ Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()
" Run PlugInstall And PlugClean If There Are Missing Plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC | PlugClean
  \| endif
" Theme
colorscheme catppuccin_mocha
set background=dark
" Setup The Plugins
let $LANG='en_US.UTF-8'
let g:rainbow_conf = {
  \ 'guifgs': ['#ec9ca4', '#89cedc', '#b6bdf9', '#a4dc94', '#e4cce4', '#8cacf4', '#f4c4c4', '#c4a4f4']
\ }
let g:airline_theme = 'catppuccin_mocha'
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable='+'
let g:NERDTreeDirArrowCollapsible='~'
silent! autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
let g:rainbow_active = 1
silent! let g:auto_save = 1
let g:coc_disable_startup_warning = 1
let MRU_Auto_Close = 1
let MRU_Use_Current_Window = 1
" Code Runner
let g:CodeRunnerCommandMap = {
  \ 'python' : 'python3 $fileName',
  \ 'go' : 'go run $fileName',
  \ 'perl' : 'perl $fileName',
  \ 'lua' : 'lua $fileName',
  \ 'ruby' : 'ruby $fileName',
  \ 'php' : 'php $fileName',
  \ 'javascript' : 'node $fileName'
  \ }
nmap <leader>r <plug>CodeRunner
" Configure Plugin Shortcuts
" MRU
nnoremap <leader>m :MRU<CR>
" Setup Tab Shortcuts
nnoremap <silent>    <C-t> :tabnew<CR>:NERDTreeToggle<CR>
nnoremap <silent>    <C-w> <Cmd>BufferClose<CR>
nnoremap <silent>    <A-,> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <A-.> <Cmd>BufferNext<CR>
" Undo Tree
nnoremap <leader>ut :UndotreeToggle<CR>
" Markdown Previewer
nmap <F5> <Plug>MarkdownPreview
nmap <F6> <Plug>MarkdownPreviewStop
nmap <F7> <Plug>MarkdownPreviewToggle
" Nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" Coc
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <Tab>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ CheckBackspace() ? '<Tab>' :
  \ coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <leader>o <cmd>CocOutline<CR>
if has('patch-8.1.1564')
  set signcolumn=number
else
  set signcolumn=no
endif
let g:coc_global_extensions = ['coc-pairs', 'coc-json', 'coc-tsserver', 'coc-html', 'coc-snippets', 'coc-css', 'coc-cssmodules', 'coc-r-lsp', 'coc-discord', 'coc-clangd', 'coc-python', 'coc-java', 'coc-texlab', 'coc-xml', 'coc-yaml']
