{

  flake.modules.nixos.fido2 =
    {
      hardware.gpgSmartcards.enable = true;
    };

}
