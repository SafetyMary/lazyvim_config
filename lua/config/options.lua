-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false

-- Options for the LazyVim statuscolumn
vim.g.lazyvim_statuscolumn = {
  folds_open = true, -- show fold sign when fold is open
  folds_githl = true, -- highlight fold sign with git sign color
}

vim.g.lazyvim_prettier_needs_config = false

-- have dedicated venv for hosting python with neovim package
vim.g.python3_host_prog = vim.fn.expand("~/.config/nvim/venv/bin/python3")

local opt = vim.opt

opt.autowrite = false -- disable auto saving
