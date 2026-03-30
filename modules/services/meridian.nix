{

  flake.modules.nixos.meridian =
    { pkgs, lib, ... }:
    let
      meridian = pkgs.buildNpmPackage rec {
        pname = "meridian";
        version = "1.21.1";

        src = pkgs.fetchFromGitHub {
          owner = "rynfar";
          repo = "meridian";
          rev = "v${version}";
          hash = "sha256-b1zyDKfHNTyEO/7FpclSGuJgFWCJ+Eh3iLkSX3E+C9s="; # build once → nix will tell you the real hash
        };

        npmDepsFetcherVersion = 2;
        npmFlags = [ "--legacy-peer-deps" ];
        npmDepsHash = "sha256-9Htz7ldkNFVDWsuhL2hPdWTb9f5awKlVaR8C45SPvgg="; # same trick — build once to get the real hash

        # Meridian's build step uses bun to bundle TypeScript → Node-compatible JS
        nativeBuildInputs = [ pkgs.bun ];

        # Override the default npm build to use bun (matches upstream's package.json "build" script)
        buildPhase = ''
          runHook preBuild
          bun build bin/cli.ts src/proxy/server.ts \
            --outdir dist \
            --target node \
            --splitting \
            --external @anthropic-ai/claude-agent-sdk \
            --entry-naming '[name].js'
          runHook postBuild
        '';

        # The package.json declares bin.meridian = "./dist/cli.js"
        # buildNpmPackage will wire that up automatically into $out/bin/meridian

        # Ensure Node.js is available at runtime (the built JS targets Node, not bun)
        postInstall = ''
          wrapProgram $out/bin/meridian \
            --prefix PATH : ${pkgs.nodejs_22}/bin
        '';

        meta = {
          description = "Local Anthropic API proxy powered by Claude Max subscription";
          homepage = "https://github.com/rynfar/meridian";
          license = lib.licenses.mit;
          mainProgram = "meridian";
        };
      };
    in
    {
      # User-level systemd service — off by default (no wantedBy).
      # Start manually:  systemctl --user start meridian
      # Stop:            systemctl --user stop meridian
      # Logs:            journalctl --user -u meridian -f
      systemd.user.services.meridian = {
        description = "Meridian – Claude Max to Anthropic API proxy";
        after = [ "network.target" ];

        # No wantedBy: the unit exists but never auto-starts.

        serviceConfig = {
          Type = "simple";
          ExecStart = "${meridian}/bin/meridian";
          Restart = "on-failure";
          RestartSec = "5s";
          TimeoutStopSec = "10s";
          StandardOutput = "journal";
          StandardError = "journal";
          SyslogIdentifier = "meridian";
        };

        environment = {
          MERIDIAN_HOST = "127.0.0.1";
          MERIDIAN_PORT = "3456";
          NODE_ENV = "production";
        };
      };
    };

}