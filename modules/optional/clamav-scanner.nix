{ ... }:

{
  # open source antivirus https://www.clamav.net/
  services.clamav.scanner = {
    enable = true;
    interval = "Sat *-*-* 04:00:00";
  };
}
