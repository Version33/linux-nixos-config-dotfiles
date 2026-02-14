{

  flake.modules.nixos.linux-kernel =
    { pkgs, lib, ... }:
    {
      # Linux Kernel
      boot = {
        kernel.sysctl."kernel.sysrq" = 1; # Enable all SysRq functions
        kernelPackages = pkgs.linuxKernel.packages.linux_zen;
        kernelParams = [
          "quiet"
          "splash"
          "loglevel=5"
          # "usbcore.autosuspend=-1"
        ];
      };

      security = {
        unprivilegedUsernsClone = true;
      };

    };

}
