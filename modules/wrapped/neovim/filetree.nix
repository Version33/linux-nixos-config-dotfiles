{
  neovimModules = [
    {
      config.vim.filetree.neo-tree = {
        enable = true;
        setupOpts = {
          close_if_last_window = true;
          enable_git_status = true;
          enable_diagnostics = true;
          filesystem = {
            filtered_items = {
              visible = false;
              hide_dotfiles = false;
              hide_gitignored = false;
            };
            follow_current_file = {
              enabled = true;
            };
          };
          window = {
            width = 30;
            mappings = {
              "<space>" = "none"; # don't override leader
            };
          };
        };
      };
    }
  ];
}
