{
  # LazyVim: folke/persistence.nvim — session management
  flake.modules.neovim.session =
    { pkgs, ... }:
    {
      config.vim.extraPlugins.persistence-nvim = {
        package = pkgs.vimPlugins.persistence-nvim;
        setup = ''
          require("persistence").setup({
            dir = vim.fn.stdpath("state") .. "/sessions/",
            options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
            pre_save = nil,
            save_empty = false,
          })
        '';
      };
    };
}
