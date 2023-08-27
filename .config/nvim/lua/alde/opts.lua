-- Vim Options

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
vim.o.expandtab = true
vim.o.tabstop = 8
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.autoindent = true
vim.o.wrap = false

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

-- Clipboard
vim.opt.clipboard = 'unnamedplus'
