-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Do no auto format on save
vim.g.autoformat = false

-- have dedicated venv for hosting python with neovim package
vim.g.python3_host_prog = vim.fn.expand("~/.config/nvim/venv/bin/python3")

local opt = vim.opt

opt.autowrite = false -- disable auto saving

-- use basedpyright instead of pyright
vim.g.lazyvim_python_lsp = "basedpyright"
