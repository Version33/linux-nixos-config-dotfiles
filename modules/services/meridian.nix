{ inputs, ... }:
{

  perSystem =
    { pkgs, ... }:
    let
      src = pkgs.fetchFromGitHub {
        owner = "rynfar";
        repo = "meridian";
        rev = "442e84c553fc3152f4e65af845340cdc8295c051";
        hash = "sha256-ZjdANZQHXjdGm9mH6jLdTjL3z6Rd/5/nsqPJgQSGPts=";
      };

      # Fixed-output derivation: bun fetches all deps with network access
      bunDeps = pkgs.stdenv.mkDerivation {
        name = "meridian-bun-deps";
        inherit src;

        nativeBuildInputs = [
          pkgs.bun
          pkgs.cacert
        ];

        buildPhase = ''
          export HOME=$TMPDIR
          export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
          bun install --frozen-lockfile
        '';

        installPhase = ''
          cp -r node_modules $out
        '';

        outputHashMode = "recursive";
        outputHashAlgo = "sha256";
        outputHash = "sha256-uCjNAgUXVsDkyF6tNtBkLUl11/X27BIyOflWZnetKdE=";
      };
    in
    {
      packages.meridian = pkgs.stdenv.mkDerivation {
        pname = "meridian";
        version = "1.34.0";
        inherit src;

        nativeBuildInputs = [
          pkgs.bun
          pkgs.makeWrapper
        ];

        buildPhase = ''
          cp -r ${bunDeps} node_modules
          chmod -R u+w node_modules
          bun build bin/cli.ts src/proxy/server.ts \
            --outdir dist \
            --target node \
            --splitting \
            --external @anthropic-ai/claude-agent-sdk \
            --entry-naming '[name].js'
        '';

        installPhase = ''
          mkdir -p $out/lib/meridian $out/bin
          cp -r dist package.json plugin $out/lib/meridian/
          cp -r ${bunDeps} $out/lib/meridian/node_modules
          makeWrapper ${pkgs.nodejs}/bin/node $out/bin/meridian \
            --add-flags "$out/lib/meridian/dist/cli.js" \
            --prefix NODE_PATH : "$out/lib/meridian/node_modules"
        '';

        meta = with pkgs.lib; {
          description = "Local Anthropic API proxy powered by your Claude Max subscription";
          homepage = "https://github.com/rynfar/meridian";
          license = licenses.mit;
          mainProgram = "meridian";
        };
      };
    };

  flake.modules.nixos.meridian =
    { pkgs, ... }:
    let
      inherit (inputs.self.packages.${pkgs.stdenv.hostPlatform.system}) meridian;
    in
    {
      environment.systemPackages = [
        meridian
        pkgs.claude-code
      ];

      systemd.user.services.meridian = {
        description = "meridian Claude Max proxy";
        path = [ pkgs.claude-code ];
        serviceConfig = {
          ExecStart = "${meridian}/bin/meridian";
          Restart = "on-failure";
        };
        # No wantedBy — service will not start on boot.
        # Start manually with: systemctl --user start meridian
      };
    };

}
