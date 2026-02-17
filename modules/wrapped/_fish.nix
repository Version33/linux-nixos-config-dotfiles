{
  inputs,
  lib,
  ...
}:
{
  perSystem =
    { pkgs, ... }:
    let
      configFile = pkgs.writeText "config.fish" ''
        set -g fish_greeting

        # starship prompt
        ${lib.getExe pkgs.starship} init fish | source

        # direnv hook
        ${lib.getExe pkgs.direnv} hook fish | source

        # aliases
        alias lgit "lazygit"
        alias conf "z ~/.config"
        alias nixos "z /etc/nixos"
        alias nswitch "sudo nixos-rebuild switch --flake /etc/nixos#k0or"
        alias nsgc "sudo nix-store --gc"
        alias ngc "sudo nix-collect-garbage -d"
        alias ngc7 "sudo nix-collect-garbage --delete-older-than 7d"
        alias ngc14 "sudo nix-collect-garbage --delete-older-than 14d"

        function format-nix
          for f in *.nix
            sudo nixfmt $f
          end
        end

        function reboot-to-windows
          sudo efibootmgr --bootnext 0000
          sudo systemctl reboot
        end
      '';
    in
    {
      packages.fish = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.fish;
        runtimeInputs = [
          pkgs.starship
        ];
        flags = {
          "-C" = "source ${configFile}";
        };
      };
    };

  flake.modules.nixos.wrapped-fish =
    { pkgs, ... }:
    {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
}
