-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
--
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "*",
--   -- group = vim.api.nvim_create_augroup("colorextend", { clear = true }),
--   callback = function()
--     --     vim.api.nvim_exec(
--     --       [[
--     --    call onedark#extend_highlight("Function", { "gui": "bold" })
--     -- ]],
--     --       false
--     --     )
--     -- vim.api.cmd("onedark#extend_highlight('Function', { 'gui': 'bold' })")
--     vim.api.nvim_call_function("onedark#extend_highlight", {
--       "Function",
--       { gui = "bold" },
--     })
--     local notify = require("notify")
--     notify("tadaaaaaaa", "info")
--   end,
-- })
-- Server capabilities spec:
-- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#serverCapabilities
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "rust" },
  command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.scala" },
  callback = function()
    vim.lsp.buf.format({ async = true })
  end,
})
