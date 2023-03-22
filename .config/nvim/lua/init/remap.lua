-- Moved the leader setup to the packer.lua, because of lazy.nvim
-- vim.g.mapleader = " "

-- Own Mappings
vim.keymap.set("n", "<Leader>q", ":q<Cr>")
vim.keymap.set("n", "<Leader>w", ":w!<Cr>")
vim.keymap.set("n", "<Leader>bd", ":bd<Cr>")

-- In insert mode, it is quicker to exit to the normal mode
-- just by quickly typing 'jk'
vim.keymap.set("i", "jk", "<esc>")

-- Split navigations
-- vim.keymap.set("n", "<C-j>", "<C-W><C-J>")
-- -- <C-K> Conflicts with the lsp.lua's same mapping...
-- vim.keymap.set("n", "<C-k>", "<C-W><C-K>")
-- vim.keymap.set("n", "<C-l>", "<C-W><C-L>")
-- vim.keymap.set("n", "<C-h>", "<C-W><C-H>")

-- Use tmux navigations instead. These are needed to be defined here
-- because Lazy plugin somehow messes These
vim.keymap.set("n", "<C-j>", ":<C-U>TmuxNavigateDown<CR>", { silent = true })
-- <C-K> Conflicts with the lsp.lua's same mapping...
vim.keymap.set("n", "<C-k>", ":<C-U>TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", ":<C-U>TmuxNavigateRight<CR>", { silent = true })
vim.keymap.set("n", "<C-h>", ":<C-U>TmuxNavigateLeft<CR>", { silent = true })

-- Easier way to scroll buffers
vim.keymap.set("n", "<Home>", ":bprevious<CR>")
vim.keymap.set("n", "<End>", ":bnext<CR>")

-- Toggle pastemode by using <F2>
-- http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste
vim.keymap.set("n", "<F2> :set invpaste", "paste?<CR>")
-- set pastetoggle=<F2>
-- set showmode


-- The ones below are from ThePrimeagen
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Some Twitch stuff. This file is from ThePrimeagen
-- vim.keymap.set("n", "<leader>vwm", function()
--     require("vim-with-me").StartVimWithMe()
-- end)
-- vim.keymap.set("n", "<leader>svwm", function()
--     require("vim-with-me").StopVimWithMe()
-- end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })


vim.keymap.set("n", "<Up>", "<C-W>+")
vim.keymap.set("n", "<Down>", "<C-W>-")
vim.keymap.set("n", "<Left>", "<C-W><")
vim.keymap.set("n", "<Right>", "<C-W>>")
