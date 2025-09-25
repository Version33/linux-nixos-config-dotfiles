{ pkgs, ... }:
# work related packages will go here
{
  environment.systemPackages = with pkgs; [
    hello
  ];
}
