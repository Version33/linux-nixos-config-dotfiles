{
  neovimModules = [
    {
      config.vim = {
        # LazyVim: Saghen/blink.cmp
        autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
          setupOpts = {
            keymap.preset = "default";
            completion = {
              documentation.auto_show = true;
              documentation.auto_show_delay_ms = 200;
              menu.auto_show = true;
            };
            fuzzy.prebuilt_binaries.download = false;
          };
        };

        # LazyVim: nvim-mini/mini.pairs
        mini.pairs = {
          enable = true;
          setupOpts = {
            modes = {
              insert = true;
              command = true;
              terminal = false;
            };
            skip_unbalanced = true;
          };
        };

        # LazyVim: nvim-mini/mini.ai
        mini.ai = {
          enable = true;
          setupOpts.n_lines = 500;
        };

        # LazyVim: nvim-mini/mini.surround
        mini.surround = {
          enable = true;
          # Default mappings: gsa=add, gsd=delete, gsr=replace, gsf=find, gsF=find_left, gsh=highlight, gsn=update_n_lines
        };
      };
    }

    # LazyVim: folke/ts-comments.nvim — no native nvf option, use extraPlugins
    (
      { pkgs, ... }:
      {
        config.vim.extraPlugins.ts-comments-nvim = {
          package = pkgs.vimPlugins.ts-comments-nvim;
          setup = ''require("ts-comments").setup({})'';
        };
      }
    )

    # LazyVim: folke/lazydev.nvim — LuaLS completions for Neovim config dev
    (
      { pkgs, ... }:
      {
        config.vim.extraPlugins.lazydev-nvim = {
          package = pkgs.vimPlugins.lazydev-nvim;
          setup = ''
            require("lazydev").setup({
              library = {
                { path = "''${3rd}/luv/library", words = { "vim%.uv" } },
              },
            })
          '';
        };
      }
    )
  ];
}
