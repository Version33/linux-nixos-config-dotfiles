{ pkgs, lib, ... }:

{
  # Linux Kernel
  boot = {
    kernel.sysctl."kernel.sysrq" = 1; # Enable all SysRq functions
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.udev.log_priority=3"
      "systemd.show_status=auto"
      "fbcon=nodefer"
      "vt.global_cursor_default=0"
      "lsm=landlock,lockdown,yama,integrity,apparmor,bpf"
      "usbcore.autosuspend=-1"
      "video4linux"
      "acpi_rev_override=5"
    ];

    # Disable unnecessary GPU drivers and hardware
    kernelPatches = [
      {
        name = "disable-unused-drivers";
        patch = null;
        structuredExtraConfig = with lib.kernel; {
          # NVIDIA Drivers
          DRM_NOUVEAU = lib.mkForce no; # Open-source NVIDIA driver
          DRM_NOUVEAU_SVM = lib.mkForce (option no); # Nouveau Shared Virtual Memory
          DRM_NOVA = lib.mkForce no; # Rust nouveau driver that fails to build
        };
      }
    ];
  };

  security = {
    forcePageTableIsolation = true;
    # lockKernelModules = true;
    # protectKernelImage = true;
    unprivilegedUsernsClone = true;
    virtualisation.flushL1DataCache = "cond";
  };

  # systemd.package = pkgs.systemd.override { withSelinux = true; };

  # environment.systemPackages = with pkgs; [
  #   policycoreutils
  # ];
}
