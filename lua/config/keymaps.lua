-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader><leader>", "<C-^>", { silent = true })
vim.keymap.set("n", "<CR>", "za", { silent = true })

vim.keymap.set("n", "}", "<cmd>cnext<cr>", { silent = true })
vim.keymap.set("n", "{", "<cmd>cprevious<cr>", { silent = true })
