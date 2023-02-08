-- Most of these are copied from the ThePrimeagen's 
-- I'll need to update these from my own .vimrc
-- [[ Setting options ]]
-- See `:help vim.o`


-- Make backspace behave in a sane manner
vim.o.backspace=[[indent,eol,start]]

-- vim.opt.listchars=tab:▸\ ,eol:¬
if vim.fn.has('multi_byte') == 1 and vim.o.encoding == 'utf-8' then
    vim.o.listchars = [[tab:▸ ,extends:❯,precedes:❮,nbsp:±,trail:…]]
else 
    vim.o.listchars = [[tab:> ,extends:>,precedes:<,nbsp:.,trail:_]]
end

-- Enable mouse mode
-- vim.o.mouse = 'a'

-- Make line numbers default
vim.wo.number = true
-- Enable relativenumber
vim.o.relativenumber = true

-- Enable break indent
vim.o.breakindent = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Save undo history
vim.o.undofile = true

-- Set highlight on search
vim.o.hlsearch = false
vim.opt.incsearch = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme onedark]]

vim.opt.scrolloff = 8

vim.opt.isfname:append("@-@")


vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


