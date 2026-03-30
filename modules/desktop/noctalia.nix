{ self, inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
        inherit pkgs;
        settings = # nix run nixpkgs#noctalia-shell ipc call state all > ./modules/desktop/noctalia.json
          (builtins.fromJSON
            (builtins.readFile ./noctalia.json)).settings;
      };
    };
}
