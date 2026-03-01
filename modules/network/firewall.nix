{

  flake.modules.nixos.firewall = _: {
    # Open ports in the firewall.
    networking.firewall.enable = true;
    # networking.firewall.allowedTCPPorts = [ 22 3210 ];
    # networking.firewall.allowedUDPPorts = [ 3000 ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  };

}
