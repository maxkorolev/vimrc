return {
  -- add gruvbox
  -- { "flazz/vim-colorschemes" },
  -- { "navarasu/onedark.nvim" },
  -- { "joshdick/onedark.vim" },
  -- { "rafi/awesome-vim-colorschemes" },
  -- { "rakr/vim-one" },
  -- { "doums/darcula" },
  -- { "marko-cerovac/material.nvim" },
  -- { "jonathanfilip/vim-lucius" },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
      -- Tomorrow-Night-Eighties
      -- codeschool
    },
  },

  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "soft", -- can be "hard", "soft" or empty string
      })
    end,
  },
  { "sainnhe/everforest", config = true },
  { "KeqiZeng/NightElf", config = true },

  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require("onedark").setup({
        highlights = {
          ["@punctuation.bracket"] = { fg = "$green" },
          ["@punctuation.special"] = { fg = "$green" },
          ["@symbol"] = { fg = "$green" },
          ["@function"] = { fg = "$green", fmt = "bold" },
          ["@function.builtin"] = { fg = "$green", fmt = "bold" },
          ["@function.macro"] = { fg = "$green", fmt = "bold" },
          ["@property"] = { fg = "$fg" },
          ["@keyword"] = { fg = "$red" },
          ["@keyword.operator"] = { fg = "$red" },
          ["@keyword.function"] = { fg = "$red" },
          ["@repeat"] = { fg = "$red" },
          ["@parameter"] = { fg = "$fg" },
          ["@conditional"] = { fg = "$red" },
          ["@include"] = { fg = "$red" },
          ["@type"] = { fg = "$blue" },
          ["@constructor"] = { fg = "$blue", fmt = "bold" },
          ["@tag"] = { fg = "$green" },
          ["@tag.attribute"] = { fg = "$fg" },
          ["@string"] = { fg = "$yellow" },
          ["@method"] = { fg = "$blue", fmt = "bold" },
        },
      })
    end,
  },
}
