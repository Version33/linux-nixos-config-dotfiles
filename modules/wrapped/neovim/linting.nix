{
  flake.modules.neovim.linting = {
    # LazyVim: mfussenegger/nvim-lint
    config.vim.diagnostics.nvim-lint = {
      enable = true;
      lint_after_save = true;
      # LazyVim's base set is minimal; language modules add their linters
      linters_by_ft = { };
    };
  };
}
