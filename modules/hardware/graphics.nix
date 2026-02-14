{

  flake.modules.nixos.graphics =
    { pkgs, ... }:
    {
      # Enable GPU Acceleration
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          # Video acceleration libraries
          libva
          libvdpau-va-gl
          mesa
        ];
        extraPackages32 = with pkgs.pkgsi686Linux; [
          mesa
          libvdpau-va-gl
        ];
      };
    };

}
