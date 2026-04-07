{
  neovimModules = [
    {
      config.vim = {
        # LazyVim: nvim-mini/mini.icons
        mini.icons.enable = true;

        # LazyVim: akinsho/bufferline.nvim
        tabline.nvimBufferline = {
          enable = true;
          mappings = {
            cycleNext = "<S-l>";
            cyclePrevious = "<S-h>";
          };
          setupOpts.options.numbers = "none";
        };

        # LazyVim: nvim-lualine/lualine.nvim
        statusline.lualine = {
          enable = true;
          # "auto" lets catppuccin register its lualine theme after the colorscheme loads.
          # Setting "catppuccin" directly causes a LualineNotices warning because lualine
          # validates the theme name before catppuccin has had a chance to register it.
          theme = "auto";
          globalStatus = true;
          # Override the default x section — nvf's default references vim_lsp and coc
          # which don't exist and cause LualineNotices warnings.
          activeSection.x = [
            ''
              {
                function()
                  local clients = vim.lsp.get_clients({ bufnr = 0 })
                  if vim.tbl_isempty(clients) then return "" end
                  local names = {}
                  for _, c in ipairs(clients) do table.insert(names, c.name) end
                  return table.concat(names, ", ")
                end,
                icon = " ",
                color = { fg = "#ffffff", gui = "bold" },
              }
            ''
            ''
              {
                "diagnostics",
                sources = { "nvim_lsp", "nvim_diagnostic" },
                symbols = { error = " ", warn = " ", info = " ", hint = " " },
                colored = true,
                update_in_insert = false,
                always_visible = false,
              }
            ''
          ];
        };

        # LazyVim: folke/noice.nvim
        ui.noice = {
          enable = true;
          setupOpts = {
            lsp.override = {
              "vim.lsp.util.convert_input_to_markdown_lines" = true;
              "vim.lsp.util.stylize_markdown" = true;
              "cmp.entry.get_documentation" = true;
            };
            routes = [
              {
                filter = {
                  event = "msg_show";
                  any = [
                    { find = "%d+L, %d+B"; }
                    { find = "; after #%d+"; }
                    { find = "; before #%d+"; }
                  ];
                };
                view = "mini";
              }
            ];
            presets = {
              bottom_search = true;
              command_palette = true;
              long_message_to_split = true;
            };
          };
        };

        # LazyVim: folke/trouble.nvim
        lsp.trouble.enable = true;

        # Notifications
        notify.nvim-notify.enable = true;

        # fzf-lua: primary fuzzy finder (preferred over telescope)
        fzf-lua = {
          enable = true;
          profile = "fzf-native";
        };

        # LazyVim: folke/snacks.nvim
        # Picker disabled — fzf-lua handles all finding
        utility.snacks-nvim = {
          enable = true;
          setupOpts = {
            bigfile = {
              enabled = true;
            }; # perf: disable features on large files
            quickfile = {
              enabled = true;
            }; # fast file rendering
            indent = {
              enabled = true;
            };
            input = {
              enabled = true;
            };
            notifier = {
              enabled = true;
            }; # snacks handles notifications
            picker = {
              enabled = false;
            }; # using fzf-lua

            # Dashboard — explicit sections to avoid lazy.stats reference
            dashboard = {
              enabled = true;
              preset = {
                header = ''
                  ███╗   ██╗██╗██╗  ██╗
                  ████╗  ██║██║╚██╗██╔╝
                  ██╔██╗ ██║██║ ╚███╔╝
                  ██║╚██╗██║██║ ██╔██╗
                  ██║ ╚████║██║██╔╝ ██╗
                  ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝'';
                keys = [
                  {
                    icon = " ";
                    key = "f";
                    desc = "Find File";
                    action = ":lua require('fzf-lua').files()";
                  }
                  {
                    icon = " ";
                    key = "n";
                    desc = "New File";
                    action = ":ene | startinsert";
                  }
                  {
                    icon = " ";
                    key = "g";
                    desc = "Find Text";
                    action = ":lua require('fzf-lua').live_grep()";
                  }
                  {
                    icon = " ";
                    key = "r";
                    desc = "Recent Files";
                    action = ":lua require('fzf-lua').oldfiles()";
                  }
                  {
                    icon = " ";
                    key = "c";
                    desc = "Config";
                    action = ":lua require('fzf-lua').files({ cwd = vim.fn.stdpath('config') })";
                  }
                  {
                    icon = " ";
                    key = "s";
                    desc = "Restore Session";
                    action = ":lua require('persistence').load()";
                  }
                  {
                    icon = "󰒲 ";
                    key = "q";
                    desc = "Quit";
                    action = ":qa";
                  }
                ];
              };
              # Omit "startup" section which requires lazy.stats
              sections = [
                { section = "header"; }
                {
                  section = "keys";
                  gap = 1;
                  padding = 1;
                }
                {
                  section = "recent_files";
                  indent = 2;
                  padding = 1;
                }
                {
                  section = "projects";
                  indent = 2;
                  padding = 1;
                }
              ];
            };
          };
        };
      };
    }
  ];
}
