{
  neovimModules = [
    {
      config.vim = {
        # LazyVim: folke/which-key.nvim — helix preset with group labels
        binds.whichKey = {
          enable = true;
          setupOpts = {
            preset = "helix";
            notify = false;
            spec = [
              {
                mode = [
                  "n"
                  "x"
                ];
                "<leader><tab>" = {
                  group = "tabs";
                };
                "<leader>b" = {
                  group = "buffer";
                };
                "<leader>c" = {
                  group = "code";
                };
                "<leader>d" = {
                  group = "debug";
                };
                "<leader>f" = {
                  group = "file/find";
                };
                "<leader>g" = {
                  group = "git";
                };
                "<leader>gh" = {
                  group = "hunks";
                };
                "<leader>q" = {
                  group = "quit/session";
                };
                "<leader>s" = {
                  group = "search";
                };
                "<leader>sn" = {
                  group = "noice";
                };
                "<leader>u" = {
                  group = "ui";
                };
                "<leader>w" = {
                  group = "windows";
                  proxy = "<c-w>";
                };
                "<leader>x" = {
                  group = "diagnostics/quickfix";
                };
                "[" = {
                  group = "prev";
                };
                "]" = {
                  group = "next";
                };
                "g" = {
                  group = "goto";
                };
                "gs" = {
                  group = "surround";
                };
                "z" = {
                  group = "fold";
                };
              }
            ];
          };
        };

        # LazyVim: folke/todo-comments.nvim
        notes.todo-comments.enable = true;

        # LazyVim: folke/flash.nvim
        utility.motion.flash-nvim.enable = true;

        # LazyVim: MagicDuck/grug-far.nvim
        utility.grug-far-nvim = {
          enable = true;
          setupOpts.headerMaxWidth = 80;
        };
      };
    }
  ];
}
