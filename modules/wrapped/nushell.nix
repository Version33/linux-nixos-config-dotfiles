{
  inputs,
  lib,
  ...
}:
{
  perSystem =
    { pkgs, ... }:
    let
      envFile = pkgs.writeText "env.nu" ''
        source ${pkgs.runCommand "starship-init.nu" { } "${lib.getExe pkgs.starship} init nu > $out"}
        source ${pkgs.writeText "direnv.nu" ''
          $env.config = (
            $env.config | upsert hooks.env_change.PWD (
              ($env.config.hooks?.env_change?.PWD? | default []) | append {
                |before, after|
                let export = (${lib.getExe pkgs.direnv} export json 2>/dev/null | str join)
                if ($export | is-not-empty) {
                  $export | from json | load-env
                }
              }
            )
          )
        ''}
      '';

      configFile = pkgs.writeText "config.nu" ''
        $env.config = {
          show_banner: false
        }

        alias lgit = lazygit
        alias conf = z ~/.config
        alias nixos = z /etc/nixos
        alias nswitch = sudo nixos-rebuild switch --flake /etc/nixos#k0or
        alias nsgc = sudo nix-store --gc
        alias ngc = sudo nix-collect-garbage -d
        alias ngc7 = sudo nix-collect-garbage --delete-older-than 7d
        alias ngc14 = sudo nix-collect-garbage --delete-older-than 14d

        def format-nix [] {
          ls *.nix | each { |f| sudo nixfmt $f.name }
        }

        def reboot-to-windows [] {
          sudo efibootmgr --bootnext 0000
          sudo systemctl reboot
        }
      '';
    in
    {
      packages.nushell = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.nushell;
        runtimeInputs = [
          pkgs.direnv
          pkgs.starship
        ];
        flags = {
          "--config" = toString configFile;
          "--env-config" = toString envFile;
        };
      };
    };

  flake.modules.nixos.wrapped-nushell =
    { pkgs, ... }:
    {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };


    };
}
