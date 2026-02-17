{
  flake.modules.nixos.ssh-agent = _: {
    programs.ssh.startAgent = true;
  };
}
