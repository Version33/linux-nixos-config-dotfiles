{ inputs, lib, ... }:
{
  perSystem =
    {
      pkgs,
      self',
      ...
    }:
    {
      # Helper script to check binary outputs
      packages.nix-check-bin = pkgs.writeShellApplication {
        name = "nix-check-bin";
        text = ''
          $EDITOR "$(nix build "$1" --no-link --print-out-paths)/bin"
        '';
      };

      # Shell environment bundle with all wrapped programs
      packages.environment = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = self'.packages.nushell;
        runtimeInputs = [
          # nix
          pkgs.nil
          pkgs.nixd
          pkgs.statix
          pkgs.alejandra
          pkgs.deadnix
          pkgs.manix
          pkgs.nix-tree
          pkgs.nix-output-monitor
          pkgs.nix-inspect

          # core
          pkgs.file
          pkgs.unzip
          pkgs.zip
          pkgs.wget
          pkgs.killall

          # wrapped
          self'.packages.git
          self'.packages.ssh
          self'.packages.kitty
          pkgs.starship
          self'.packages.vscode
          self'.packages.opencode
          self'.packages.nix-check-bin
        ];

        env = {
          EDITOR = "nvim";
          VISUAL = "nvim";
          PAGER = "bat";
        };
      };
    };

  # Add environment wrapper to system
  flake.modules.nixos.wrapped-environment =
    {
      self,
      pkgs,
      ...
    }:
    {
      # Required for the wrapped shell to be accepted as a login shell
      environment.shells = [ self.packages.${pkgs.stdenv.hostPlatform.system}.environment ];

      # System-wide aliases
      environment.shellAliases = {
        reboot-to-windows = "sudo efibootmgr --bootnext 0000 && systemctl reboot";
      };
    };
}
