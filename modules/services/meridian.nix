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

      nodeModules = pkgs.stdenv.mkDerivation {
        name = "meridian-node-modules";
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
        installPhase = "mv node_modules $out";
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
          cp -r ${nodeModules} node_modules
          chmod -R u+w node_modules
          bun build bin/cli.ts --outdir dist --target node \
            --external @anthropic-ai/claude-agent-sdk \
            --entry-naming '[name].js'
        '';

        installPhase = ''
          mkdir -p $out/bin $out/lib/meridian
          cp -r dist package.json plugin $out/lib/meridian/
          ln -s ${nodeModules} $out/lib/meridian/node_modules
          makeWrapper ${pkgs.nodejs}/bin/node $out/bin/meridian \
            --add-flags "$out/lib/meridian/dist/cli.js"
        '';

        meta.mainProgram = "meridian";
      };
    };

  flake.modules.nixos.meridian =
    { pkgs, ... }:
    let
      meridian = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.meridian;
    in
    {
      environment.systemPackages = [ pkgs.claude-code ];

      systemd.user.services.meridian = {
        description = "meridian Claude Max proxy";
        path = [
          pkgs.claude-code
          pkgs.which
        ];
        serviceConfig = {
          ExecStart = "${meridian}/bin/meridian";
          Restart = "on-failure";
        };
      };
    };
}
