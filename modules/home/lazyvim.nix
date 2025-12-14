{ pkgs, inputs, ... }:
{
  imports = [
    inputs.lazyvim.homeManagerModules.default
  ];

  programs.lazyvim = {
    enable = true;
    
    extras = {
      coding.yanky.enable = true;
      editor.fzf.enable = true;
      
      lang.git.enable = true;
      lang.json.enable = true;
      lang.markdown = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
      lang.nix = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
      lang.python = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
      lang.yaml = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
    };

    plugins = {
      "opencode" = ''
        return {
          "NickvanDyke/opencode.nvim",
          name = "opencode.nvim",
          dir = "${pkgs.vimUtils.buildVimPlugin {
            name = "opencode-nvim";
            src = inputs.opencode-nvim;
          }}",
          lazy = false,
          dependencies = { "folke/snacks.nvim" },
          keys = {
            { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
            { "<leader>ac", function() require("opencode").toggle() end, desc = "Toggle Opencode", mode = { "n", "v" } },
            { "<leader>af", function() require("opencode").toggle() end, desc = "Focus Opencode", mode = { "n", "v" } },
            { "<leader>ab", function() require("opencode").prompt("@buffer") end, desc = "Add current buffer", mode = { "n" } },
            { "<leader>as", function() require("opencode").ask("@this: ", { submit = true }) end, desc = "Send to Opencode", mode = { "v" } },
            { "<leader>aC", function() require("opencode").select() end, desc = "Opencode Actions", mode = { "n" } },
            { "<S-C-u>", function() require("opencode").command("session.half.page.up") end, desc = "Opencode page up", mode = { "n" } },
            { "<S-C-d>", function() require("opencode").command("session.half.page.down") end, desc = "Opencode page down", mode = { "n" } },
          },
          config = function()
            vim.g.opencode_opts = {
              -- Add any custom options here
            }
            vim.o.autoread = true
          end,
        }
      '';
    };
  };
}
