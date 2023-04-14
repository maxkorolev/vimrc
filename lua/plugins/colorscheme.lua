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
    "navarasu/onedark.nvim",
    opts = {
      highlights = {
        ["@punctuation.bracket"] = { fg = "$green" },
        ["@punctuation.special"] = { fg = "$green" },
        ["@symbol"] = { fg = "$green" },
        ["@function"] = { fg = "$green", fmt = "bold" },
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

        -- ["@type"] = { fg = "$blue" },

        -- TSKeyword = { fg = "$green" },
      },
    },
  },
}
