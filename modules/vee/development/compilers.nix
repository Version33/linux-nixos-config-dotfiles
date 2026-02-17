{
  flake.modules.nixos.compilers =
    { pkgs, ... }:
    {
      # Compilers, linkers, and build tools
      environment.systemPackages = with pkgs; [
        comma
        mold
        gcc
        clang
        lld
        lldb
        musl
        trunk
      ];
    };
}
