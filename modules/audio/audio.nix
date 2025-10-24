##############################################################################
# Audio Production Configuration
#
# Purpose: Configure system for professional audio production
# Features:
#   - Bitwig Studio DAW
#   - Realtime audio priorities (PAM limits)
#   - Unlimited memory locking for yabridge
#   - Low-latency audio support
# Note: Users must be in the 'audio' group for realtime privileges
##############################################################################

{ pkgs, inputs, ... }:

{
  nixpkgs.overlays = [
    inputs.audio-nix.overlays.default
  ];

  environment.systemPackages = with pkgs; [
    bitwig-studio-latest
  ];

  # Realtime audio configuration for professional audio work
  # This fixes yabridge memlock warnings and enables low-latency audio
  security.pam.loginLimits = [
    # Unlimited memory locking for audio group
    # This allows yabridge to lock shared memory buffers
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }

    # High realtime priority for audio group
    # Allows audio applications to run with realtime scheduling
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "99";
    }

    # Allow nice priority adjustment for audio group
    # Enables fine-tuning of process priorities
    {
      domain = "@audio";
      item = "nice";
      type = "-";
      value = "-19";
    }
  ];
}
