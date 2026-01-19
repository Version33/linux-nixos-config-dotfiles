{ pkgs, ... }:

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

    # kernelPatches = [ {
    #      name = "selinux-config";
    #      patch = null;
    #      extraConfig = ''
    #              SECURITY_SELINUX y
    #              SECURITY_SELINUX_BOOTPARAM n
    #              SECURITY_SELINUX_DEVELOP y
    #              SECURITY_SELINUX_AVC_STATS y
    #              DEFAULT_SECURITY_SELINUX n
    #            '';
    # } ];
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
