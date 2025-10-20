##############################################################################
# Firewall Configuration
#
# Purpose: Basic firewall configuration using nftables
# Features:
#   - Firewall enabled by default
#   - No ports open by default (secure default)
# Usage: Uncomment allowedTCPPorts/allowedUDPPorts to open specific ports
##############################################################################

_:

{
  # Open ports in the firewall.
  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ 3000 ];
  # networking.firewall.allowedUDPPorts = [ 3000 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
