##############################################################################
# VM Configuration
#
# Purpose: Configure resources for VMs built with nixos-rebuild build-vm
# Features:
#   - Memory allocation
#   - CPU cores
#   - Disk size
##############################################################################

{ ... }:

{
  # VM-specific configuration (only applies when building VMs with build-vm)
  virtualisation.vmVariant = {
    # Configure available memory for the VM (in MB)
    virtualisation.memorySize = 8192; # 8GB - adjust as needed

    # Configure number of CPU cores for the VM
    virtualisation.cores = 8; # adjust based on your system

    # Configure disk size for the VM (in MB)
    virtualisation.diskSize = 20480; # 20GB - adjust as needed

    # Optional: use EFI boot in VM (recommended for testing secure boot setups)
    # virtualisation.useEFIBoot = true;

    # Optional: enable graphics acceleration in VM
    virtualisation.qemu.options = [
      "-vga virtio"
      "-display gtk,gl=on"
    ];
  };
}
