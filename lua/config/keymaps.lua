-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

-- Resize window, in addition to using <ctrl> arrow keys
-- NOTE: currently zellij is stopping the use of CTRL-j (fixed in 0.41.2)
-- https://github.com/zellij-org/zellij/pull/3746
map("n", "<C-k>", "<cmd>resize +2<cr>", { desc = "Increase Window Height", remap = true })
map("n", "<C-j>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height", remap = true })
map("n", "<C-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width", remap = true })
map("n", "<C-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width", remap = true })
