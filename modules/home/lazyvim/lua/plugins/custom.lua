-- Custom plugin configurations for LazyVim
-- See https://www.lazyvim.org for more info

return {
  -- Use catppuccin colorscheme (provided by Nix)
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  -- Configure catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = false,
      integrations = {
        telescope = true,
        nvimtree = true,
        treesitter = true,
        gitsigns = true,
      },
    },
  },

  -- Configure telescope for better defaults
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
      },
    },
  },

  -- Configure neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },
}
