local Util = require("lazyvim.util")
return {

  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { ";a", "<leader>E", desc = "Explorer NeoTree (cwd)", remap = true },
    },
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = {
        width = 60,
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            --auto close
            require("neo-tree").close_all()
          end,
        },
      },
    },
  },

  {

    "nvim-telescope/telescope.nvim",
    keys = {
      { "<C-p>", "<leader>fF", desc = "Find Files (root dir)", remap = true },
      {
        "<leader>/",
        function()
          require("telescope.builtin").live_grep({ default_text = vim.fn.expand("<cword>") })
        end,
        desc = "Find in Files (Grep)",
        mode = "n",
      },
      { "<leader>/", Util.telescope("grep_string"), desc = "Find in Files (Grep)", mode = "v" },
      { "<leader><leader>", false },
      { "<leader><space>", false },
    },

    opts = {
      defaults = {
        layout_strategy = "center",
        layout_config = { width = 0.9, prompt_position = "bottom" },
        mappings = {
          i = {
            ["<Esc>"] = function(...)
              return require("telescope.actions").close(...)
            end,
            ["<C-s>"] = function(...)
              return require("telescope.actions").add_to_qflist(...)
            end,
          },
        },
      },
      pickers = {
        lsp_definitions = { show_line = false },
        lsp_references = { show_line = false },
      },
    },
  },
  {
    "folke/trouble.nvim",
    enabled = false,
  },
  { "romainl/vim-cool" },
  {
    "tpope/vim-fugitive",
    keys = {
      { "<Leader>gst", "<cmd>Git<cr>" },
      { "<Leader>gc", "<cmd>Git commit<cr>" },
      { "<Leader>ga", "<cmd>Git write<cr>" },
      { "<Leader>gl", "<cmd>Gclog<cr>" },
      { "<Leader>gol", "<cmd>0Gclog<cr>" },
      { "<Leader>gd", "<cmd>Gdiff<cr>" },
      { "<Leader>gp", "<cmd>Git pull<cr>" },
      { "<Leader>gP", "<cmd>Git push<cr>" },
      { "<Leader>gf", "<cmd>Git fetch<cr>" },
      { "<silent><Leader>gh", "<cmd>diffget //2<cr>" },
      { "<silent><Leader>gl", "<cmd>diffget //3<cr>" },
    },
  },
  {
    "sodapopcan/vim-twiggy",
    dependencies = {
      { "vim-fugitive" },
    },
    keys = {
      { "<Leader>gt", "<cmd>Twiggy<cr>", desc = "Twiggy" },
    },

    init = function()
      vim.g.twiggy_num_columns = 50
      vim.g.twiggy_split_position = "topleft"
      vim.g.twiggy_local_branch_sort = "mru"
      vim.g.twiggy_remote_branch_sort = "date"
    end,
  },

  {
    "tveskag/nvim-blame-line",
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", { pattern = "*", command = "EnableBlameLine" })
    end,
  },

  { "kevinhwang91/nvim-bqf", ft = "qf" },
  { "itchyny/vim-cursorword" },
  { "kana/vim-operator-user" },
  {
    "kana/vim-operator-replace",
    keys = {
      { "p", "<Plug>(operator-replace)", desc = "Replace", mode = "x" },
      { "p", "<Plug>(operator-replace)", desc = "Replace", mode = "v" },
    },
  },

  {
    "907th/vim-auto-save",
    init = function()
      vim.g.auto_save = 1
      vim.g.auto_save_events = { "BufLeave", "FocusLost" }
    end,
  },
}
