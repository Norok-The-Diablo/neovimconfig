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
" Confirm You Want To Close Unsaved File
set confirm
" Enable Spellchecking
set spell
" Set History Higher
set history=10000
" Hide Tilde's
set fillchars=eob:\
" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
" Make Vim Act Normal In Windows
set nocompatible
" Turn On Syntax
syntax on
let g:is_posix=1
" Enable Autocompletion
set wildmode=longest,list,full
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Make It So When You Split It Goes To The Right
set splitbelow splitright
" Make Hopping Around Split Windows Easier
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Remap S Which Is Equal To The Command cc To A Find And Replace Function
nnoremap S :%s//g<Left><Left>
" Delete Whitespace On Save
autocmd BufWritePre * %s/\s\+$//e
" Setup GDB Alias
autocmd VimEnter * packadd termdebug
" Backup History
if has('win64') || has('win32') || has('win16')
  if !isdirectory('C:\Users\%USERNAME%\AppData\Local\Temp\.nvim-undo-dir')
    silent! call mkdir('C:\Users\%USERNAME%\AppData\Local\Temp\.nvim-undo-dir', '', 0700)
    set undodir=$HOME\AppData\Local\Temp\.nvim-undo-dir
  endif
else
  if !isdirectory('/tmp/.nvim-undo-dir')
    silent! call mkdir('/tmp/.nvim-undo-dir', '', 0700)
    set undodir=/tmp/.nvim-undo-dir
  endif
endif
set undofile
" Plugins
call plug#begin()
" Plug 'github/copilot.vim'
  Plug 'numToStr/Comment.nvim'
  Plug 'EtiamNullam/deferred-clipboard.nvim'
  Plug 'CRAG666/code_runner.nvim'
  Plug 'alec-gibson/nvim-tetris'
  Plug 'luochen1990/rainbow'
  Plug 'ThePrimeagen/vim-be-good'
  Plug 'seandewar/killersheep.nvim'
  Plug 'tpope/vim-fugitive'
  Plug 'tamton-aquib/duck.nvim'
  Plug 'chrisgrieser/nvim-genghis'
  Plug '907th/vim-auto-save'
  Plug 'mistweaverco/Screenshot.nvim'
  Plug 'gbprod/stay-in-place.nvim'
  Plug 'tpope/vim-surround'
  Plug 'Norok-The-Diablo/minesweeper.nvim'
  Plug 'tpope/vim-commentary'
  Plug 'alanfortlink/blackjack.nvim'
  Plug 'tc50cal/vim-terminal'
  Plug 'NvChad/nvim-colorizer.lua'
  Plug 'jghauser/mkdir.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'seandewar/nvimesweeper'
  Plug 'frabjous/knap'
  Plug 'karb94/neoscroll.nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'archibate/lualine-time'
  Plug 'stevearc/dressing.nvim'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'catppuccin/nvim'
  Plug 'goolord/alpha-nvim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  Plug 'preservim/nerdtree' |
              \ Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()
" Install vim-plug if not found
if has('win64') || has('win32') || has('win16')
  if empty(glob('C:\Users\%USERNAME%\AppData\Local\nvim\autoload\plug.vim'))
    silent !curl -fLo autoload\plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif
else
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif
endif
" Run PlugInstall and PlugClean if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC | PlugClean
\| endif
" Update Plugins
autocmd VimEnter * silent! UpdateRemotePlugins
" Theme
colorscheme catppuccin-mocha
set background=dark
lua << EOF
require('lualine').setup {
    options = {
        theme = 'catppuccin',
        icons_enabled = true
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'location'},
        lualine_z = {'ctime'}
  },
  extensions = {
  'nerdtree'
  }
}
EOF
" Fireneovim
lua << EOF
vim.g.firenvim_config.localSettings["https?://github\\.com/"] = { takeover = 'once' }
vim.g.firenvim_config.localSettings["https?://gitlab\\.com/"] = { takeover = 'once' }
vim.g.firenvim_config.localSettings['.*'] = { takeover = 'never' }
EOF
if exists('g:started_by_firenvim') && g:started_by_firenvim == 1
  set laststatus=0
  set noruler
else
  set title
  autocmd VimEnter * NERDTree | wincmd p
  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
endif
" Setup The Plugins
let g:rainbow_conf = {
  \ 'guifgs': ['#ec9ca4', '#89cedc', '#b6bdf9', '#a4dc94', '#e4cce4', '#8cacf4', '#f4c4c4', '#c4a4f4']
\ }
let $LANG='en_US.UTF-8'
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable='+'
let g:NERDTreeDirArrowCollapsible='~'
lua require('neoscroll').setup()
lua require('killersheep').setup()
lua require('Comment').setup()
lua require('gitsigns').setup()
lua require'alpha'.setup(require'alpha.themes.dashboard'.config)
lua require('colorizer').attach_to_buffer(0, { mode = 'background', css = true})
let g:rainbow_active = 1
let g:coc_disable_startup_warning = 1
silent! let g:auto_save = 1
" Clipboard
lua << EOF
require('deferred-clipboard').setup {
  fallback = 'unnamedplus', -- or your preferred setting for clipboard
}
EOF
" Code Runner
if has('win64') || has('win32') || has('win16')
  lua << EOF
  require('code_runner').setup( {
    filetype = {
      python = 'python3',
      perl = 'perl',
      lua = 'lua',
      ruby = 'ruby',
      php = 'php',
      go = 'go run',
      javascript = 'node',
      java = {
        'cd $dir &&',
        'javac $fileName'
      },
      typescript = {
        'cd $dir &&',
        'tsc $fileName &&',
        'node $fileNameWithoutExt.js'
      },
      rust = {
        'cd $dir &&',
        'rustc $fileName &&',
        '$dir/$fileNameWithoutExt.exe'
      },
    },
  }
  )
EOF
else
  lua << EOF
  require('code_runner').setup( {
    filetype = {
      python = 'python3',
      go = 'go run',
      perl = 'perl',
      lua = 'lua',
      ruby = 'ruby',
      php = 'php',
      javascript = 'node',
      java = {
        'cd $dir &&',
        'javac $fileName &&',
        'java $fileNameWithoutExt'
      },
      typescript = {
        'cd $dir &&',
        'tsc $fileName &&',
        'node $fileNameWithoutExt.js'
      },
      rust = {
        'cd $dir &&',
        'rustc $fileName &&',
        '$dir/$fileNameWithoutExt'
      },
      cpp = {
        'cd $dir &&',
        'g++ $fileName &&',
        '$dir/$fileNameWithoutExt'
      },
    },
  }
  )
EOF
endif
" Configure Plugin Keybinds
" Knap And Markdown Preview
if has('win64') || has('win32') || has('win16')
  nmap <F5> <Plug>MarkdownPreview
  nmap <F6> <Plug>MarkdownPreviewStop
  nmap <F7> <Plug>MarkdownPreviewToggle
else
  " F5 processes the document once, and refreshes the view
  inoremap <silent> <F5> <C-o>:lua require('knap').process_once()<CR>
  vnoremap <silent> <F5> <C-c>:lua require('knap').process_once()<CR>
  nnoremap <silent> <F5> :lua require('knap').process_once()<CR>
  " F6 closes the viewer application, and allows settings to be reset
  inoremap <silent> <F6> <C-o>:lua require('knap').close_viewer()<CR>
  vnoremap <silent> <F6> <C-c>:lua require('knap').close_viewer()<CR>
  nnoremap <silent> <F6> :lua require('knap').close_viewer()<CR>
  " F7 toggles the auto-processing on and off
  inoremap <silent> <F7> <C-o>:lua require('knap').toggle_autopreviewing()<CR>
  vnoremap <silent> <F7> <C-c>:lua require('knap').toggle_autopreviewing()<CR>
  nnoremap <silent> <F7> :lua require('knap').toggle_autopreviewing()<CR>
  " F8 invokes a SyncTeX forward search, or similar, where appropriate
  inoremap <silent> <F8> <C-o>:lua require('knap').forward_jump()<CR>
  vnoremap <silent> <F8> <C-c>:lua require('knap').forward_jump()<CR>
  nnoremap <silent> <F8> :lua require('knap').forward_jump()<CR>
endif
" Nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" Coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ check_back_space() ? '\<Tab>' :
  \ coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
if has('patch-8.1.1564')
  set signcolumn=number
else
  set signcolumn=no
endif
let g:coc_global_extensions = ['coc-pairs', 'coc-json', 'coc-tsserver', 'coc-html', 'coc-snippets', 'coc-css', 'coc-cssmodules', 'coc-r-lsp', 'coc-discord', 'coc-clangd', 'coc-python', 'coc-java', 'coc-texlab', 'coc-xml', 'coc-yaml']

" --- Notes About Installing Plugins ---
" :PlugInstall :PlugClean :UpdateRemotePlugins
" :CocInstall coc-pairs coc-json coc-tsserver coc-html coc-snippets coc-css coc-cssmodules coc-discord coc-clangd coc-python coc-java coc-r-lsp coc-texlab coc-xml coc-yaml
