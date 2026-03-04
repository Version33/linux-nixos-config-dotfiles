{
  flake.modules.nixos.mouse =
    { pkgs, ... }:
    let
      # libratbag 0.18 lacks G502 X Plus support entirely — the G502X_PLUS quirk
      # (needed for profile layout and LEDs) was added post-release on master.
      # Build from master commit that includes PR #1693 (wired) and #1728 (wireless).
      libratbag-g502xplus = pkgs.libratbag.overrideAttrs (_old: {
        version = "0.18-unstable-2026-01-03";
        src = pkgs.fetchFromGitHub {
          owner = "libratbag";
          repo = "libratbag";
          rev = "874c01732a7d3c074baefd8055c0d3efe8c9a935";
          hash = "sha256-O9DxwAieUEy+otwDSM2412vCCQJkHIrDOPVYevg0l44=";
        };
      });

      # piper 0.8 lacks the G502 X Plus SVG diagram and svg-lookup.ini entry.
      # Both were added post-release on master (logitech-g502-x-plus.svg).
      piper-g502xplus = pkgs.piper.overrideAttrs (_old: {
        version = "0.8-unstable-2026-01-03";
        src = pkgs.fetchFromGitHub {
          owner = "libratbag";
          repo = "piper";
          rev = "48056eb1788cdfbdda67a2360c53b7157782a9b3";
          hash = "sha256-jF7qowV4Ub5MqQBlTDuf7x83RTfMQ/J5DSD74lP02pU=";
        };
      });
    in
    {
      # ratbagd daemon — provides DBus interface for libratbag device access
      services.ratbagd = {
        enable = true;
        package = libratbag-g502xplus;
      };

      environment.systemPackages = [ piper-g502xplus ];
    };
}
