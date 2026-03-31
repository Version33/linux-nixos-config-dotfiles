#   systemctl --user start   meridian
#   systemctl --user stop    meridian
#   systemctl --user status  meridian
#   journalctl --user -u     meridian -f

#   ANTHROPIC_BASE_URL=http://127.0.0.1:3456 opencode

# One-time auth (if not already done):
#   claude login
{ ... }:

let
  meridianPkg =
    pkgs:
    let
      src = builtins.fetchGit {
        url = "/home/vee/Git/meridian/meridian-rust";
        rev = "6ee5351b85feaeeeb82a23893e6f2addeb01c30e";
      };
    in
    pkgs.rustPlatform.buildRustPackage {
      pname = "meridian";
      version = "0.1.0";
      inherit src;
      cargoLock.lockFile = "${src}/Cargo.lock";
    };

  nixosModule =
    { pkgs, ... }:
    {
      systemd.user.services.meridian = {
        description = "Meridian — Claude Max subscription proxy";
        path = [ pkgs.claude-code ];

        # No wantedBy: the unit exists but NEVER auto-starts.
        # Start manually with: systemctl --user start meridian

        serviceConfig = {
          ExecStart = "${meridianPkg pkgs}/bin/meridian";
          Restart = "on-failure";
          RestartSec = "5s";
          TimeoutStopSec = "10s";
          StandardOutput = "journal";
          StandardError = "journal";
          SyslogIdentifier = "meridian";
        };

        environment = {
          MERIDIAN_PORT = "3456";
          MERIDIAN_HOST = "127.0.0.1";
          RUST_LOG = "meridian=info";
        };
      };
    };

in
{
  perSystem =
    { pkgs, ... }:
    {
      packages.meridian = meridianPkg pkgs;
    };

  flake.modules.nixos.meridian = nixosModule;
}
