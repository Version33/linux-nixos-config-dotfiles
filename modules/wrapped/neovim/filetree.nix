{
  flake.modules.neovim.filetree = {
    config.vim.filetree.neo-tree = {
      enable = true;
      setupOpts = {
        sources = [
          "filesystem"
          "buffers"
          "git_status"
        ];
        open_files_do_not_replace_types = [
          "terminal"
          "Trouble"
          "trouble"
          "qf"
          "Outline"
        ];

        filesystem = {
          bind_to_cwd = false;
          follow_current_file.enabled = true;
          use_libuv_file_watcher = true;
        };

        window = {
          width = 30;
          mappings = {
            "l" = "open";
            "h" = "close_node";
            "<space>" = "none";
            "P" = "toggle_preview";
          };
        };

        default_component_configs = {
          indent = {
            with_expanders = true;
            expander_collapsed = "";
            expander_expanded = "";
            expander_highlight = "NeoTreeExpander";
          };
          git_status.symbols = {
            unstaged = "󰄱";
            staged = "󰱒";
          };
        };
      };
    };
  };
}
