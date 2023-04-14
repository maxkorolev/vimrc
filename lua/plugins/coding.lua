return {

  {
    "echasnovski/mini.comment",

    opts = {
      mappings = {
        comment = "<C-_>",
        comment_line = "<C-_>",
        textobject = "<C-_>",
      },
    },
  },
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "scala",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
    init = function()
      require("nvim-treesitter.install").compilers = { "clang", "gcc" }
    end,
  },
  { "mfussenegger/nvim-dap" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
    },
  },
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  },
}
