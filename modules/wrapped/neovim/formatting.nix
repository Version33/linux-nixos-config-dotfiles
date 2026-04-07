{
  flake.modules.neovim.formatting = {
    config.vim.formatter.conform-nvim = {
      enable = true;
      setupOpts = {
        # LazyVim uses default_format_opts + format_on_save via its own system.
        # We declare format_on_save directly since we don't have LazyVim's format layer.
        default_format_opts = {
          timeout_ms = 3000;
          async = false;
          quiet = false;
          lsp_format = "fallback";
        };
        format_on_save = {
          timeout_ms = 3000;
          lsp_format = "fallback";
        };
        # LazyVim's base set — language extras add more
        formatters_by_ft = {
          lua = [ "stylua" ];
          sh = [ "shfmt" ];
          nix = [ "nixfmt" ];
          python = [ "ruff_format" ];
          javascript = [ "prettier" ];
          typescript = [ "prettier" ];
          javascriptreact = [ "prettier" ];
          typescriptreact = [ "prettier" ];
          css = [ "prettier" ];
          html = [ "prettier" ];
          json = [ "prettier" ];
          yaml = [ "prettier" ];
          markdown = [ "prettier" ];
          go = [ "gofmt" ];
          rust = [ "rustfmt" ];
        };
        formatters.injected = {
          options.ignore_errors = true;
        };
      };
    };
  };
}
