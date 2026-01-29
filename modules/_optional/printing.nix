{ ... }:
{

  flake.modules.nixos.printing = _: {

    # Enable CUPS to print documents.
    services.printing.enable = true;
    # services.avahi = {
    #   enable = true;
    #   nssmdns4 = true;
    # };

  };

}
