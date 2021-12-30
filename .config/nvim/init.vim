set nocompatible
filetype off

call plug#begin(stdpath('data') . '/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'itchyny/lightline.vim'
Plug 'mattn/emmet-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'majutsushi/tagbar'
Plug 'godlygeek/tabular'
"Plug 'sheerun/vim-polyglot'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'dracula/vim'
Plug 'sirtaj/vim-openscad'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'jvirtanen/vim-hcl'
Plug 'hashivim/vim-terraform'
call plug#end()

let mapleader = ","
let g:mapleader = ","

set encoding=utf8
set ffs=unix,dos,mac

set rtp+=~/.fzf
set hidden

set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set listchars=tab:>.,trail:.,extends:#,nbsp:.,eol:$

set relativenumber
set ruler

set expandtab
set tabstop=8
set softtabstop=2
set shiftwidth=2
set autoindent
set nowrap

set tw=79
set cc=+1

if has('signcolumn')
  set signcolumn=yes
endif

set history=700
set scrolloff=3
set cmdheight=2
set laststatus=2
set updatetime=250
set shortmess+=c

set splitbelow
set splitright

set wildmenu
set wildmode=list:longest
set wildignore=*.o,*~,*.pyc,node_modules/

set magic
set showmatch
set ignorecase
set smartcase
set hlsearch
set incsearch

set noerrorbells
set novisualbell
set t_vb=
set tm=500

set nobackup
set nowritebackup
set nowb
set noswapfile

set completeopt=menu,menuone,noinsert

autocmd FileType ruby,javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd FileType java,python setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType javscript,typescript,json setlocal tw=120
autocmd FileType go setlocal tabstop=4 softtabstop=4 shiftwidth=0 noexpandtab

autocmd BufNewFile,BufRead *.handlebars,*.html.erb setlocal filetype=html
autocmd BufNewFile,BufRead *.ldif.j2 setlocal filetype=ldif.jinja2
autocmd BufNewFile,BufRead *.ino setlocal filetype=c
autocmd BufNewFile,BufRead *.ui setlocal filetype=xml.ui foldmethod=marker
autocmd BufNewFile,BufRead *.gjs setlocal filetype=javascript

nmap <silent> <leader>n :nohlsearch<cr>
nmap <silent> <leader>s :set list!<cr>

" Theme
if has("termguicolors")
  set termguicolors
endif

set background=dark
colorscheme dracula

if g:colors_name == 'dracula'
  " Identifiers are not special in dracula theme, so assign them a different
  " color for certain file types.
  autocmd FileType yaml hi! link Identifier DraculaGreen
  autocmd FileType yaml.ansible hi! link YamlConstant Keyword
end

let g:lightline = {
      \ 'colorscheme': 'dracula'
      \ }

" Telescope mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" vim-svelte
let g:svelte_preprocessor_tags = [
  \ { 'name': 'ts', 'tag': 'script', 'as': 'typescript' }
  \ ]

let g:svelte_preprocessors = ['ts']

lua require'lsp'
