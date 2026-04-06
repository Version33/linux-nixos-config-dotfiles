{
  neovimModules = [
    {
      config.vim = {
        # LazyVim: folke/which-key.nvim
        # Only set basic options here — spec is in luaConfigRC below because
        # which-key v3 expects positional mixed-tables ({ lhs, group=, icon= })
        # which toLuaObject cannot represent (it only produces pure dicts).
        binds.whichKey = {
          enable = true;
          setupOpts = {
            preset = "helix";
            notify = false;
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

        # which-key group spec with icons — must be Lua because the format
        # { "<leader>s", group = "search", icon = "…" } is a mixed array/dict
        # that Nix attrsets cannot produce via toLuaObject.
        luaConfigRC.whichkey-groups = ''
          local wk = require("which-key")
          wk.add({
            -- ── <leader> groups ────────────────────────────────────────
            { "<leader><tab>", group = "tabs",               icon = { icon = "󰓩 ", color = "purple" } },
            { "<leader>b",     group = "buffer",             icon = { icon = "󰈔 ", color = "cyan"   },
              expand = function() return require("which-key.extras").expand.buf() end },
            { "<leader>bm",    group = "move",               icon = { icon = "󰆤 ", color = "blue"   } },
            { "<leader>bs",    group = "sort",               icon = { icon = "󰒺 ", color = "blue"   } },
            { "<leader>c",     group = "code",               icon = { icon = "󰅩 ", color = "orange" } },
            { "<leader>d",     group = "debug",              icon = { icon = " ", color = "red"    } },
            { "<leader>dp",    group = "profiler",           icon = { icon = "󰓮 ", color = "red"    } },
            { "<leader>f",     group = "file/find",          icon = { icon = "󰍉 ", color = "cyan"   } },
            { "<leader>g",     group = "git",                icon = { icon = "󰊢 ", color = "red"    } },
            { "<leader>gh",    group = "hunks",              icon = { icon = " ", color = "yellow" } },
            { "<leader>l",     group = "lsp",                icon = { icon = " ", color = "blue"   } },
            { "<leader>lg",    group = "goto",               icon = { icon = "󰑮 ", color = "blue"   } },
            { "<leader>lt",    group = "toggle",             icon = { icon = "󰒓 ", color = "cyan"   } },
            { "<leader>lw",    group = "workspace",          icon = { icon = "󰈢 ", color = "blue"   } },
            { "<leader>n",     group = "notifications",      icon = { icon = "󰍡 ", color = "yellow" } },
            { "<leader>q",     group = "quit/session",       icon = { icon = "󰗼 ", color = "red"    } },
            { "<leader>s",     group = "search",             icon = { icon = "󰍉 ", color = "yellow" } },
            { "<leader>sn",    group = "noice",              icon = { icon = "󰈚 ", color = "blue"   } },
            { "<leader>t",     group = "todo",               icon = { icon = " ", color = "yellow" } },
            { "<leader>td",    group = "trouble",            icon = { icon = "󱖫 ", color = "green"  } },
            { "<leader>u",     group = "ui",                 icon = { icon = "󰙵 ", color = "cyan"   } },
            { "<leader>w",     group = "windows",            icon = { icon = "󰖲 ", color = "blue"   },
              proxy = "<c-w>",
              expand = function() return require("which-key.extras").expand.win() end },
            { "<leader>x",     group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
            -- ── standalone keymaps that need icons ────────────────────
            { "<leader>e", desc = "Explorer (Root Dir)", icon = { icon = " ", color = "cyan" } },
            { "<leader>E", desc = "Explorer (cwd)",      icon = { icon = " ", color = "cyan" } },
            -- ── non-leader groups ──────────────────────────────────────
            { "[",  group = "prev",     icon = { icon = " ", color = "cyan"   } },
            { "]",  group = "next",     icon = { icon = " ", color = "green"  } },
            { "g",  group = "goto",     icon = { icon = "󰑮 ", color = "blue"   } },
            { "gs", group = "surround", icon = { icon = "󰅪 ", color = "yellow" } },
            { "z",  group = "fold",     icon = { icon = "󰁅 ", color = "yellow" } },
          })
        '';
      };
    }
  ];
}
