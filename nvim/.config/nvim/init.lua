vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true

require("config.lazy")

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.breakindent = true


vim.keymap.set("n", "<space>w", ":w<CR>")
vim.keymap.set("n", "<space>q", ":q<CR>")
vim.keymap.set("n", "<space>h", ":noh<CR>")
vim.keymap.set("n", "<space>v", ":vsplit<CR>")
vim.keymap.set("n", "<space>Q", ":q!<CR>")
vim.keymap.set("n", "<space><space>", "<C-6>")

vim.opt.clipboard = "unnamedplus"

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
