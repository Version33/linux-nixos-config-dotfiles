{ inputs, ... }:
{
  # Claude Desktop for Linux
  flake-file.inputs.claude-desktop.url = "github:k3d3/claude-desktop-linux-flake";

  flake.modules.nixos.llm =
    { pkgs, config, ... }:
    {
      # Core service: Ollama with ROCm GPU acceleration for AMD GPUs
      services.ollama = {
        enable = false;
        package = pkgs.ollama-rocm;
        loadModels = [
          "llama3.2:3b"
          "phi4-reasoning:14b"
          "dolphin3:8b"
          "smallthinker:3b"
          "gemma3n:e4b"
          "deepcoder:14b"
          "qwen3:14b"
          "qwen3-coder:30b"
          "nomic-embed-text"
          "deepseek-r1:32b"
        ];
        # Specify which AMD GPU to use (RX 9070 XT = gfx1201 = RDNA 4)
        rocmOverrideGfx = "12.0.1";
      };

      # Optional services - uncomment if needed:
      # services.searx = {
      #   enable = true;
      #   settings = {
      #     server = {
      #       port = 7777;
      #       bind_address = "127.0.0.1";
      #       secret_key = "@SEARX_SECRET_KEY@";
      #     };
      #     search = {
      #       formats = [
      #         "html"
      #         "json"
      #       ];
      #     };
      #   };
      #   environmentFile = "${config.users.users.vee.home}/.config/.env.searxng";
      # };

      # services.n8n = {
      #   enable = true;
      # };

      # services.open-webui = {
      #   enable = true;
      #   port = 8888;
      #   host = "127.0.0.1";
      # };

      environment.systemPackages = with pkgs; [
        # Essential: Terminal interface for Ollama
        # oterm

        # Essential: ROCm monitoring and utilities to verify GPU usage
        # rocmPackages.rocm-smi
        # rocmPackages.rocminfo

        # Optional: Uncomment additional tools as needed
        # alpaca  # GUI for Ollama (currently broken in nixpkgs)
        # gpt4all  # Alternative GUI with AMD/ROCm support
        # aichat
        # fabric-ai
        # aider-chat
        # opencode
        # codex
      ];
    };

}
