-------------------------------------------------------------------------------
-- These are example settings to use with nvim-metals and the nvim built-in
-- LSP. Be sure to thoroughly read the `:help nvim-metals` docs to get an
-- idea of what everything does. Again, these are meant to serve as an example,
-- if you just copy pasta them, then should work,  but hopefully after time
-- goes on you'll cater them to your own liking especially since some of the stuff
-- in here is just an example, not what you probably want your setup to be.
--
-- Unfamiliar with Lua and Neovim?
--  - Check out https://github.com/nanotee/nvim-lua-guide
--
-- The below configuration also makes use of the following plugins besides
-- nvim-metals, and therefore is a bit opinionated:
--
-- - https://github.com/hrsh7th/nvim-cmp
--   - hrsh7th/cmp-nvim-lsp for lsp completion sources
--   - hrsh7th/cmp-vsnip for snippet sources
--   - hrsh7th/vim-vsnip for snippet sources
--
-- - https://github.com/wbthomason/packer.nvim for package management
-- - https://github.com/mfussenegger/nvim-dap (for debugging)
-------------------------------------------------------------------------------
local api = vim.api
local cmd = vim.cmd
local map = vim.keymap.set

----------------------------------
-- OPTIONS -----------------------
----------------------------------
-- global
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }

-- Autocmd that will actually be in charging of starting the whole thing
-- local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
-- api.nvim_create_autocmd("FileType", {
--   -- NOTE: You may or may not want java included here. You will need it if you
--   -- want basic Java support but it may also conflict if you are using
--   -- something like nvim-jdtls which also works on a java filetype autocmd.
--   pattern = { "scala", "sbt", "java" },
--   callback = function()
--     require("metals").initialize_or_attach(metals_config)
--
--     map("n", "<leader>i", function()
--       require("metals").organize_imports()
--     end)
--
--     map("n", "<leader>ws", function()
--       require("metals").hover_worksheet()
--     end)
--
--     vim.cmd([[hi! link LspReferenceText CursorColumn]])
--     vim.cmd([[hi! link LspReferenceRead CursorColumn]])
--     vim.cmd([[hi! link LspReferenceWrite CursorColumn]])
--     vim.cmd([[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]])
--     vim.cmd([[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]])
--     vim.cmd([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
--   end,
--   group = nvim_metals_group,
-- })

local hocon_group = vim.api.nvim_create_augroup("hocon", { clear = true })
vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead" },
  { group = hocon_group, pattern = "*/resources/*.conf", command = "set ft=hocon" }
)
