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
  };
}
