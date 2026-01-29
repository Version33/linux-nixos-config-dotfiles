{ ... }:
{

  flake.modules.nixos.gaming-hardware = _: {
    # Enable udev rules for Steam hardware (controllers, Steam Deck, etc.)
    hardware.steam-hardware.enable = true;
  };

}
