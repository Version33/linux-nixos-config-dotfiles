{ ... }:
{

  flake.modules.nixos.tailscale =
    { pkgs, ... }:
    {
      # Services
      services.tailscale = {
        enable = true;
        useRoutingFeatures = "client"; # Enable subnet routing and exit nodes
      };

      # System packages
      environment.systemPackages = with pkgs; [
        tailscale
      ];

      # Networking
      # Allow Tailscale to manage its own firewall rules
      networking.firewall = {
        # Allow Tailscale UDP port
        allowedUDPPorts = [ 41641 ];
        # Trust Tailscale interface
        trustedInterfaces = [ "tailscale0" ];
      };
    };

}
