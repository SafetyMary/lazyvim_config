-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Run some neovim commands after setup
vim.api.nvim_create_autocmd("SafeState", {
  callback = function()
    vim.api.nvim_set_option_value("colorcolumn", "120", {}) -- TODO: disable this in front page
    vim.cmd.setlocal({ "spell", "spelllang=en_us" })
  end,
})

-- Manually triggered setup commands
-- TODO: Set up custom function for this
vim.api.nvim_create_autocmd("User", {
  callback = function()
    -- in case pylsp is not working as expected, try reinstalling through Mason
    -- vim.cmd.PylspInstall { 'pyls-flake8' }
    -- vim.cmd.PylspInstall { 'pylsp-mypy' }
    -- vim.cmd.PylspInstall { 'pylsp-rope' }
    -- vim.cmd 'MasonToolsClean'  -- Depends on mason-tools-installer plugin
    -- vim.cmd.TSInstall { 'regex' }
  end,
})
