{

  flake.modules.nixos.linux-kernel =
    { pkgs, lib, ... }:
    {
      # Linux Kernel
      boot = {
        kernel.sysctl."kernel.sysrq" = 1; # Enable all SysRq functions
        kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
        kernelParams = [
          "quiet"
          "splash"
          "loglevel=5"
          # "usbcore.autosuspend=-1"
          # Shorten USB enumeration timeout to reduce boot delay from broken internal port (usb3-7)
          "usbcore.initial_descriptor_timeout=5"
        ];
      };

      security = {
        unprivilegedUsernsClone = true;
      };

    };

}
