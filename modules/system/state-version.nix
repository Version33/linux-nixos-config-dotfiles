{
  flake.modules = {
    nixos.state-version = {
      system.stateVersion = "25.05";
    };

    homeManager.state-version = {
      home.stateVersion = "25.05";
    };
  };
}
