{ ... }:
{

  flake.modules.nixos.info-fetchers =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        fastfetch # replaced neofetch
        onefetch
        ipfetch
        cpufetch
        ramfetch
        starfetch
        octofetch
        htop
        bottom
        btop
        zfxtop
        kmon

        # vulkan-tools
        # opencl-info
        # clinfo
        # vdpauinfo
        # libva-utils
        nvtopPackages.amd
        wlr-randr
        gpu-viewer
        dig
        speedtest-rs
      ];
    };

}
