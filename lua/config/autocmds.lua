-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Set a 120 character color column visual guide
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.api.nvim_set_option_value("colorcolumn", "120", {})
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Manually triggered setup commands
-- TODO: Set up custom function for this
vim.api.nvim_create_autocmd("User", {
  callback = function()
    -- in case pylsp is not working as expected, try reinstalling through Mason
    -- vim.cmd.PylspInstall { 'pylsp-mypy' }
    -- vim.cmd.PylspInstall { 'pylsp-rope' }
    -- vim.cmd 'MasonToolsClean'  -- Depends on mason-tools-installer plugin
  end,
})
