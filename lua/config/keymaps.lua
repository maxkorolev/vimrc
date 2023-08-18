-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.api.nvim_del_keymap("n", "<leader>ft")
-- vim.api.nvim_del_keymap("n", "<c-_>")
-- Toggle in current
vim.keymap.set("n", "<c-/>", "<Plug>(comment_toggle_linewise_current)")
vim.keymap.set("n", "<c-_>", "<Plug>(comment_toggle_linewise_current)")
vim.keymap.set("x", "<c-/>", "<Plug>(comment_toggle_linewise_visual)")
vim.keymap.set("x", "<c-_>", "<Plug>(comment_toggle_linewise_visual)")

vim.keymap.set("n", "<leader><leader>", "<C-^>", { silent = true })
vim.keymap.set("n", "<CR>", "za", { silent = true })

vim.keymap.set("n", "}", "<cmd>cnext<cr>", { silent = true })
vim.keymap.set("n", "{", "<cmd>cprevious<cr>", { silent = true })

vim.keymap.set("n", "<A-j>", "")
vim.keymap.set("n", "<A-k>", "")
vim.keymap.set("i", "<A-j>", "")
vim.keymap.set("i", "<A-k>", "")
vim.keymap.set("v", "<A-j>", "")
vim.keymap.set("v", "<A-k>", "")
