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
        follow_current_file = { enabled = true },
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
            require("neo-tree.command").execute({ action = "close" })
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
              vim.cmd("cexpr []")
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
    "ThePrimeagen/harpoon",

    config = function()
      require("harpoon").setup({
        menu = {
          width = vim.api.nvim_win_get_width(0) - 50,
        },
      })
      vim.api.nvim_set_keymap("n", ";q", ":lua require('harpoon.mark').add_file()<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", ";s", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<S-i>", ":lua require('harpoon.ui').nav_next()<CR>", { silent = true })
      vim.api.nvim_set_keymap("n", "<S-o>", ":lua require('harpoon.ui').nav_prev()<CR>", { silent = true })
    end,
  },
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    "folke/trouble.nvim",
    enabled = false,
  },
  -- git
  { "romainl/vim-cool" },
  {
    "tpope/vim-fugitive",
    lazy = true,
    keys = {
      { "<Leader>gst", "<cmd>Git<cr>" },
      { "<Leader>gc", "<cmd>Git commit<cr>" },
      { "<Leader>ga", "<cmd>Git write<cr>" },
      { "<Leader>gl", "<cmd>Gclog<cr>" },
      { "<Leader>gol", "<cmd>0Gclog<cr>" },
      -- { "<Leader>gd", "<cmd>Gdiff<cr>" },
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
  {
    "sindrets/diffview.nvim",
    lazy = true,

    keys = {
      { "<Leader>gd", "<cmd>DiffviewOpen<cr>" },
    },
    opts = {
      keymaps = {
        view = {
          ["q"] = "<cmd>DiffviewClose<cr>",
        },
        file_panel = {
          ["q"] = "<cmd>DiffviewClose<cr>",
          -- ["<cr>"] = function()
          --   require("diffview.actions").goto_file_edit()
          -- end,
        },
        file_history_panel = {
          ["q"] = "<cmd>DiffviewClose<cr>",
        },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",

    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map( "n", "]g", gs.next_hunk, "Next Hunk")
        map( "n", "[g", gs.prev_hunk, "Prev Hunk")
        map( 'n', '<leader>gr', gs.reset_hunk, "Reset Hunk")
        map( "n", "<leader>gv", gs.preview_hunk, "Preview Hunk")
        map( { "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
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
  { "folke/which-key.nvim", enabled = false },

  {
    "tpope/vim-dadbod",
    opt = true,
    requires = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      require("config.dadbod").setup()
    end,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    keys = {
      { "<Leader>dbu", "<Cmd>DBUIToggle<Cr>", "Toggle UI" },
      { "<Leader>dbf", "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
      { "<Leader>dbr", "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer" },
      { "<Leader>dbq", "<Cmd>DBUILastQueryInfo<Cr>", "Last query info" },
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
