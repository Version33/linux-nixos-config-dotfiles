#   systemctl --user start   meridian
#   systemctl --user stop    meridian
#   systemctl --user status  meridian
#   journalctl --user -u     meridian -f

#   ANTHROPIC_BASE_URL=http://127.0.0.1:3456 opencode

# One-time auth (if not already done):
#   claude login
{ inputs, ... }:

{
  flake-file.inputs.meridian.url = "git+file:///home/vee/Git/meridian/meridian-rust";

  flake.modules.nixos.meridian =
    { pkgs, ... }:
    {
      systemd.user.services.meridian = {
        description = "Meridian — Claude Max subscription proxy";
        path = [ pkgs.claude-code ];

        # No wantedBy: the unit exists but NEVER auto-starts.
        # Start manually with: systemctl --user start meridian

        serviceConfig = {
          ExecStart = "${inputs.meridian.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/meridian";
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
}
