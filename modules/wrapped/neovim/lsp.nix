{
  flake.modules.neovim.lsp = {
    config.vim = {
      lsp = {
        enable = true;
        formatOnSave = false; # handled by conform.nvim
        inlayHints.enable = true; # LazyVim enables inlay hints by default
      };

      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix.enable = true;
        lua.enable = true;
        bash.enable = true;

        ts.enable = true;
        css.enable = true;
        html.enable = true;

        python.enable = true;
        rust.enable = true;
        go.enable = true;

        markdown.enable = true;
        yaml.enable = true;
      };

      # LazyVim diagnostic display config
      luaConfigRC.lsp-diagnostics = ''
        vim.diagnostic.config({
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN]  = " ",
              [vim.diagnostic.severity.HINT]  = " ",
              [vim.diagnostic.severity.INFO]  = " ",
            },
          },
        })
      '';
    };
  };
}
