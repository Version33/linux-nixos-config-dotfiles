##############################################################################
# Tailscale VPN
#
# Purpose: Zero-config mesh VPN for secure peer-to-peer networking
# Features:
#   - Automatic NAT traversal (no port forwarding needed)
#   - WireGuard-based encrypted mesh network
#   - Perfect for gaming (Minecraft), file sharing, remote access
#   - Free tier supports up to 100 devices
# Notes:
#   - After enabling, run: sudo tailscale up
#   - Authenticate via the URL provided
#   - Access other devices via their Tailscale IP (100.x.x.x)
#   - For Minecraft: Connect to <tailscale-ip>:25565
##############################################################################

{ pkgs, ... }:

{
  # ========================================================================
  # Configuration
  # ========================================================================

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
}
