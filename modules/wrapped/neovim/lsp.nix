{
  neovimModules = [
    {
      config.vim = {
        lsp = {
          enable = true;
          formatOnSave = false; # handled by conform.nvim
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
      };
    }
  ];
}
