{ ... }:
{

  flake.modules.nixos.fido2 =
    { pkgs, ... }:
    {
      hardware.gpgSmartcards.enable = true;
    };

}
