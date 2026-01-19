##############################################################################
# Gaming Hardware
#
# Purpose: Hardware support for gaming peripherals and devices
# Features:
#   - Steam Controller and Steam Deck controller support
#   - udev rules for Steam hardware devices
##############################################################################

_:

{
  # Enable udev rules for Steam hardware (controllers, Steam Deck, etc.)
  hardware.steam-hardware.enable = true;
}
