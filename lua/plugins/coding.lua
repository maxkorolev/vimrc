return {

  -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
  {
    "numToStr/Comment.nvim",
    lazy = false,
  },
  {
    "echasnovski/mini.comment",
    enabled = false,
  },
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },

  -- { "ray-x/cmp-treesitter" },

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
        "rust",
        "vim",
        "yaml",
        "hocon",
      },
    },
    init = function()
      require("nvim-treesitter.install").compilers = { "clang", "gcc" }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    init = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "johmsalas/text-case.nvim",
    config = function()
      require("textcase").setup({})
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    -- enabled = false,
    dependencies = {
      -- { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
      { "ray-x/cmp-treesitter" },
    },

    init = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "supermaven" },
          -- { name = "vsnip" },
          { name = "treesitter" },
        },
        -- snippet = {
        --   expand = function(args)
        --     -- Comes from vsnip
        --     vim.fn["vsnip#anonymous"](args.body)
        --   end,
        -- },
        mapping = cmp.mapping.preset.insert({
          -- None of this made sense to me when first looking into this since there
          -- is no vim docs, but you can't have select = true here _unless_ you are
          -- also using the snippet stuff. So keep in mind that if you remove
          -- snippets you need to remove this select
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          -- I use tabs... some say you should stick to ins-completion but this is just here as an example
          -- ["<Tab>"] = function(fallback)
          --   if cmp.visible() then
          --     cmp.select_next_item()
          --   else
          --     fallback()
          --   end
          -- end,
          -- ["<S-Tab>"] = function(fallback)
          --   if cmp.visible() then
          --     cmp.select_prev_item()
          --   else
          --     fallback()
          --   end
          -- end,
        }),
      })
    end,
  },
  { "nathangrigg/vim-beancount" },
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- {
      --   "j-hui/fidget.nvim",
      --   opts = {},
      -- },
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
      local metals_config = require("metals").bare_config()
      metals_config.init_options.enableSemanticDB = false

      -- Example of settings
      metals_config.settings = {
        excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
        enableSemanticHighlighting = false,
        scalafmtConfigPath = ".scalafmt.conf",
      }

      -- *READ THIS*
      -- I *highly* recommend setting statusBarProvider to either "off" or "on"
      --
      -- "off" will enable LSP progress notifications by Metals and you'll need
      -- to ensure you have a plugin like fidget.nvim installed to handle them.
      --
      -- "on" will enable the custom Metals status extension and you *have* to have
      -- a have settings to capture this in your statusline or else you'll not see
      -- any messages from metals. There is more info in the help docs about this
      metals_config.init_options.statusBarProvider = "off"

      -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
      -- metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- metals_config.on_attach = function(client, bufnr)
      --   require("metals").setup_dap()
      -- end

      metals_config.find_root_dir = function()
        return vim.fn.getcwd()
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          local map = vim.keymap.set
          require("metals").initialize_or_attach(metals_config)

          map("n", "<leader>i", function()
            require("metals").organize_imports()
          end)

          map("n", "<leader>ws", function()
            require("metals").hover_worksheet()
          end)

          -- vim.cmd([[hi! link LspReferenceText CursorColumn]])
          -- vim.cmd([[hi! link LspReferenceRead CursorColumn]])
          -- vim.cmd([[hi! link LspReferenceWrite CursorColumn]])
          -- vim.cmd([[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]])
          -- vim.cmd([[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]])
          -- vim.cmd([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
        end,
        group = nvim_metals_group,
      })
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    enabled = not os.getenv("METALS"),
    opts = {
      tools = {
        runnables = {
          use_telescope = true,
        },
        inlay_hints = {
          auto = true,
          show_parameter_hints = false,
          parameter_hints_prefix = "",
          other_hints_prefix = "",
        },
      },

      -- all the opts to send to nvim-lspconfig
      -- these override the defaults set by rust-tools.nvim
      -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
      server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        settings = {
          -- to enable rust-analyzer settings visit:
          -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
          ["rust-analyzer"] = {
            -- enable clippy on save
            checkOnSave = {
              command = "clippy",
            },
          },
        },
        on_attach = function(_, bufnr)
          local rt = require("rust-tools")
          -- Hover actions
          vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
          -- Code action groups
          vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    enabled = not os.getenv("METALS"),
    -- cond = function()
    --   return vim.bo.filetype ~= "scala" or vim.bo.filetype ~= "sbt"
    -- end,
  },
  {
    "neovim/nvim-lspconfig",
    keys = {
      { "<leader>i", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
      { "<leader>rn", "<cmd>TypescriptRenameFile<CR>", desc = "Rename File" },
    },
    opts = {
      -- make sure mason installs the server
      servers = {
        ---@type lspconfig.options.tsserver
        tsserver = {
          enabled = false,
        },
        vtsls = {
          on_attach = function(client)
            client.server_capabilities.semanticTokensProvider = nil
            --     client.server_capabilities.hoverProvider = false
            --     client.server_capabilities.signatureHelpProvider = false
          end,
          -- explicitly add default filetypes, so that we can extend
          -- them in related extras
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = false },
                parameterNames = { enabled = false },
                parameterTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        pyright = {},
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    keys = {
      { "<leader>c", "<cmd>CodeCompanionChat<CR>", desc = "Code Companion Chat" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
    },
    config = function()
      require("codecompanion").setup({
        workspace_file = "workspace-schema.json", -- Path to your workspace file
        strategies = {
          chat = {
            adapter = "anthropic",
            keymaps = {
              close = {
                modes = { n = "q" },
              },
              stop = {
                modes = { n = "<C-c>", i = "<C-c>" },
              },
              -- Add further custom keymaps here
            },
          },
          inline = {
            adapter = "anthropic",
          },
        },
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              make_vars = true,
              make_slash_commands = true,
              show_result_in_chat = true,
            },
          },
        },
      })
    end,
  },
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({

        keymaps = {
          accept_suggestion = "<Tab>",
          clear_suggestion = "<S-Tab>",
        },
      })
    end,
  },
  {
    "frankroeder/parrot.nvim",
    enabled = false,
    dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
    -- optionally include "folke/noice.nvim" or "rcarriga/nvim-notify" for beautiful notifications
    config = function()
      require("parrot").setup({
        -- Providers must be explicitly added to make them available.
        providers = {
          openai = {
            api_key = os.getenv("OPENAI_API_KEY"),
          },
        },
      })
    end,
  },
  {
    "yetone/avante.nvim",
    enabled = false,
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      -- for example
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        temperature = 0,
        max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      },
      file_selector = {
        --- @alias FileSelectorProvider "native" | "fzf" | "telescope" | string
        provider = "fzf",
        -- Options override for custom providers
        provider_opts = {},
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  -- {
  --   "lukas-reineke/lsp-format.nvim",
  --   config = function()
  --     -- lsp format on save
  --     require("lsp-format").setup({})
  --     require("lspconfig").gopls.setup({ on_attach = require("lsp-format").on_attach })
  --   end,
  -- },
}
