{

  flake.modules.nixos.virtualisation =
    { pkgs, ... }:
    {
      # Enable Kasm
      # services.kasmweb = {
      #   enable = true;
      #   listenPort = 9999;
      # };

      # Enable Containerd
      # virtualisation.containerd.enable = true;

      # Enable Docker
      # virtualisation.docker = {
      #   enable = true;
      #   rootless = {
      #     enable = true;
      #     setSocketVariable = true;
      #     daemon.settings.features.cdi = true;
      #   };
      # };
      # users.extraGroups.docker.members = [ "xnm" ];

      # Enable Podman - a daemonless container engine for developing, managing, and running OCI Containers on your Linux System
      virtualisation.podman = {
        enable = true;

        # Create a `docker` alias for podman, to use it as a drop-in replacement
        dockerCompat = true;
        dockerSocket.enable = true;

        # Required for containers under podman-compose to be able to talk to each other.
        defaultNetwork.settings.dns_enabled = true;
      };
      environment.variables.DBX_CONTAINER_MANAGER = "podman";
      users.extraGroups.podman.members = [ "vee" ];

      environment.systemPackages = with pkgs; [
        docker # Open source project to pack, ship and run any application as a lightweight container
        nerdctl # Docker-compatible CLI for containerd

        # firecracker # Secure, fast, minimal micro-container virtualization
        # firectl # Command-line tool to run Firecracker microVMs
        # flintlock # Create and manage the lifecycle of MicroVMs backed by containerd

        distrobox # Wrapper around podman or docker to create and start containers
        qemu # Generic and open source machine emulator and virtualizer
        lima # Linux virtual machines with automatic file sharing and port forwarding

        podman-compose # Implementation of docker-compose with podman backend
        podman-tui # Podman Terminal UI

        docker-compose # Docker CLI plugin to define and run multi-container applications with Docker
        # lazydocker # Simple terminal UI for both docker and docker-compose
        # docker-credential-helpers # Suite of programs to use native stores to keep Docker credentials safe
      ];
    };

}
