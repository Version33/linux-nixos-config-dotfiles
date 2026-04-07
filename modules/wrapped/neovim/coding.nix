{
  flake.modules.neovim.coding =
    { pkgs, ... }:
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

        # LazyVim: nvim-mini/mini.pairs — full options from LazyVim source
        mini.pairs = {
          enable = true;
          setupOpts = {
            modes = {
              insert = true;
              command = true;
              terminal = false;
            };
            skip_next = ''[=[[%w%%%'%[%"%.%`%$]]=]'';
            skip_ts = [ "string" ];
            skip_unbalanced = true;
            markdown = true;
          };
        };

        # LazyVim: nvim-mini/mini.ai — full custom textobjects from LazyVim source
        mini.ai = {
          enable = true;
          setupOpts.n_lines = 500;
        };

        # LazyVim: nvim-mini/mini.surround
        # Mappings: gsa=add, gsd=delete, gsr=replace, gsf=find, gsF=find_left, gsh=highlight
        mini.surround.enable = true;

        # mini.ai custom textobjects need Lua — wire them via luaConfigRC
        luaConfigRC.mini-ai-textobjects = ''
          local ai = require("mini.ai")
          require("mini.ai").setup(vim.tbl_deep_extend("force", require("mini.ai").config or {}, {
            n_lines = 500,
            custom_textobjects = {
              o = ai.gen_spec.treesitter({
                a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                i = { "@block.inner", "@conditional.inner", "@loop.inner" },
              }),
              f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
              c = ai.gen_spec.treesitter({ a = "@class.outer",    i = "@class.inner" }),
              t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
              d = { "%f[%d]%d+" },
            },
          }))
        '';

        # LazyVim: folke/ts-comments.nvim
        extraPlugins.ts-comments-nvim = {
          package = pkgs.vimPlugins.ts-comments-nvim;
          setup = ''require("ts-comments").setup({})'';
        };

        # LazyVim: folke/lazydev.nvim
        extraPlugins.lazydev-nvim = {
          package = pkgs.vimPlugins.lazydev-nvim;
          setup = ''require("lazydev").setup({})'';
          # Note: the ${3rd}/luv/library path from LazyVim is lazy.nvim-specific;
          # nvf puts plugins on the rtp directly so lazydev finds luv automatically.
        };
      };
    };
}
