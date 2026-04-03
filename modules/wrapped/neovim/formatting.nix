{
  neovimModules = [
    {
      config.vim.formatter.conform-nvim = {
        enable = true;
        setupOpts = {
          format_on_save = {
            timeout_ms = 500;
            lsp_format = "fallback";
          };
          formatters_by_ft = {
            lua = [ "stylua" ];
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
            sh = [ "shfmt" ];
          };
        };
      };
    }
  ];
}
