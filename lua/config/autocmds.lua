-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Set a 120 character color column visual guide
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.api.nvim_set_option_value("colorcolumn", "120", {})
  end,
})

-- wrap and check for spelling in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
