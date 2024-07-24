-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- vim.api.nvim_del_keymap("n", "<leader>ft")
-- vim.api.nvim_del_keymap("n", "<c-_>")
-- Toggle in current
local map = vim.keymap.set

map("n", "<c-/>", "<Plug>(comment_toggle_linewise_current)")
map("n", "<c-_>", "<Plug>(comment_toggle_linewise_current)")
map("x", "<c-/>", "<Plug>(comment_toggle_linewise_visual)")
map("x", "<c-_>", "<Plug>(comment_toggle_linewise_visual)")

map("n", "<leader><leader>", "<C-^>", { silent = true })
map("n", "<CR>", "za", { silent = true })

map("n", "}", "<cmd>cnext<cr>", { silent = true })
map("n", "{", "<cmd>cprevious<cr>", { silent = true })

map("n", "<A-j>", "")
map("n", "<A-k>", "")
map("i", "<A-j>", "")
map("i", "<A-k>", "")
map("v", "<A-j>", "")
map("v", "<A-k>", "")

-- LSP mappings
map("n", "gd", vim.lsp.buf.definition)
map("n", "K", vim.lsp.buf.hover)
map("n", "gi", vim.lsp.buf.implementation)
map("n", "gr", vim.lsp.buf.references)
-- map("n", "gds", vim.lsp.buf.document_symbol)
map("n", "gws", vim.lsp.buf.workspace_symbol)
map("n", "<leader>cl", vim.lsp.codelens.run)
map("n", "<leader>sh", vim.lsp.buf.signature_help)
map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "<leader>fd", function()
  vim.lsp.buf.format({ async = true })
end)
map("n", "<leader>ca", vim.lsp.buf.code_action)

-- all workspace diagnostics
map("n", "<leader>aa", vim.diagnostic.setqflist)

-- all workspace errors
map("n", "<leader>ae", function()
  vim.diagnostic.setqflist({ severity = "E" })
end)

-- all workspace warnings
map("n", "<leader>aw", function()
  vim.diagnostic.setqflist({ severity = "W" })
end)

-- buffer diagnostics only
map("n", "<leader>d", vim.diagnostic.setloclist)

map("n", "[v", function()
  vim.diagnostic.goto_prev({ wrap = false })
end)

map("n", "]v", function()
  vim.diagnostic.goto_next({ wrap = false })
end)

-- Example mappings for usage with nvim-dap. If you don't use that, you can
-- skip these
map("n", "<leader>dc", function()
  require("dap").continue()
end)

map("n", "<leader>dr", function()
  require("dap").repl.toggle()
end)

map("n", "<leader>dK", function()
  require("dap.ui.widgets").hover()
end)

map("n", "<leader>dt", function()
  require("dap").toggle_breakpoint()
end)

map("n", "<leader>dso", function()
  require("dap").step_over()
end)

map("n", "<leader>dsi", function()
  require("dap").step_into()
end)

map("n", "<leader>dl", function()
  require("dap").run_last()
end)
