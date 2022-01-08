--
-- Alde's vim configuration
--
vim.o.encoding = 'utf8'
vim.o.fileformats = 'unix,dos,mac'

vim.v.mapleader = ','
vim.g.mapleader = ','

vim.o.hidden = true

vim.o.backspace = 'eol,start,indent'
vim.opt.whichwrap:append('<,>,h,l')
vim.opt.listchars = {
    tab = '>-',
    trail = '.',
    extends = '#',
    space = '.',
    nbsp = '-',
    eol = '$'
}

vim.o.relativenumber = true
vim.o.ruler = true

-- Indentation
vim.expandtab = true
vim.tabstop = 8
vim.softtabstop = 2
vim.shiftwidth = 2
vim.autoindent = true
vim.wrap = false

-- Columns
vim.o.textwidth = 79
vim.o.colorcolumn = '+1'
vim.o.signcolumn = 'yes'

-- Command
vim.o.history = 700
vim.o.scrolloff = 3
vim.o.cmdheight = 2
vim.o.laststatus = 2
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.opt.shortmess:append('c')

vim.o.splitbelow = true
vim.o.splitright = true

-- Wild menu
vim.o.wildmenu = true
vim.o.wildmode = 'list:longest'
vim.opt.wildignore = { '*.o', '*~', '*.pyc', 'node_modules/' }

-- Search
vim.o.magic = true
vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true

-- Annoyances
vim.o.errorbells = false
vim.o.visualbell = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- Completion
vim.opt.completeopt = { 'menu', 'menuone', 'noinsert' }


-- File specific configuration
vim.cmd [[
autocmd FileType ruby,javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType javascript,typescript,json setlocal textwidth=120
autocmd Filetype go setlocal tabstop=4 softtabstop=4 shiftwidth=0 noexpandtab
]]

vim.cmd [[
autocmd BufNewFile,BufRead *.handlebars,*.html.erb setlocal filetype=html
autocmd BufNewFile,BufRead *.ldif.j2 setlocal filetype=ldif.jinja2
autocmd BufNewFile,BufRead *.ino setlocal filetype=c
autocmd BufNewFile,BufRead *.ui setlocal filetype=xml.ui foldmethod=marker
autocmd BufNewFile,BufRead *.gjs setlocal filetype=javascript
]]

-- Bindings
vim.api.nvim_set_keymap('n', '<leader>n', ':nohlsearch<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>s', ':set list!<CR>', { noremap = true, silent = true })

require('plugins')
require('theme')
require('lsp')
require('telescope-config')
