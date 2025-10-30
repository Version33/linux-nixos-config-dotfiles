##############################################################################
# Terminal Utilities
#
# Purpose: Modern CLI tools and terminal enhancements
# Features:
#   - Modern replacements: ripgrep, fd, dust, procs, bat
#   - File management: yazi, ouch, zoxide
#   - System monitoring: gping, duf, ncdu, macchina
#   - Productivity: tealdeer, tokei, hexyl, pandoc
#   - Fun: cmatrix, pipes-rs, cava
##############################################################################

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    moreutils # Growing collection of the unix tools that nobody thought to write long ago when unix was young.
    file # Program that shows the type of files.
    upx # Ultimate Packer for eXecutables.
    dotenvx # Better dotenv–from the creator of `dotenv
    # sqlx-cli # CLI for managing databases, migrations, and enabling offline mode with sqlx::query!() and friends
    # mermaid-cli # Generation of diagrams from text in a similar manner as markdown.
    # posting # Modern API client that lives in your terminal.
    # license-generator # Command-line tool for generating license files
    # jujutsu # Git-compatible DVCS that is both simple and powerful.
    # jjui # TUI for Jujutsu VCS.
    # just # Handy way to save and run project-specific commands.
    # xh # Friendly and fast tool for sending HTTP requests.
    # process-compose # Simple and flexible scheduler and orchestrator to manage non-containerized applications
    # mcfly # terminal history
    # zellij # Terminal workspace with batteries included.
    tmux # Terminal multiplexer
    progress # Tool that shows the progress of coreutils programs
    # noti # Monitor a process and trigger a notification.
    # topgrade # Upgrade all the things.
    ripgrep # Utility that combines the usability of The Silver Searcher with the raw speed of grep.
    rewrk # More modern http framework benchmarker supporting HTTP/1 and HTTP/2 benchmarks.
    # wrk2 # Constant throughput, correct latency recording variant of wrk.
    procs # Modern replacement for ps written in Rust.
    tealdeer # Very fast implementation of tldr in Rust.
    skim # Command-line fuzzy finder written in Rust
    # monolith # Bundle any web page into a single HTML file.
    # taskwarrior3 # Highly flexible command-line tool to manage TODO lists.
    # asciinema # Terminal session recorder and the best companion of asciinema.org
    # asciinema-agg # Command-line tool for generating animated GIF files from asciicast v2 files produced by asciinema terminal recorder.
    # aria # Lightweight, multi-protocol, multi-source, command-line download utility.
    # wormhole-william # End-to-end encrypted file transfers.
    # magic-wormhole-rs # Rust implementation of Magic Wormhole, with new features and enhancements.
    macchina # Fast, minimal and customizable system information fetcher.
    # dogdns # Command-line DNS client
    # sd # Intuitive find & replace CLI (sed alternative)
    ouch # Command-line utility for easily compressing and decompressing files and directories
    duf # Disk Usage/Free Utility
    ncdu # Disk usage analyzer with an ncurses interface
    du-dust # du, but more intuitive.
    fd # Simple, fast and user-friendly alternative to find
    # jq # Lightweight and flexible command-line JSON processor
    # trash-cli # Command line interface to the freedesktop.org trashcan
    zoxide # Fast cd command that learns your habits
    tokei # Count your code, quickly
    # fzf # Command-line fuzzy finder written in Go
    hexyl # Command-line hex viewer
    mdcat # Cat for markdown
    pandoc # Conversion between documentation formats
    # lsd # Next gen ls command
    lsof # Tool to list open files
    gping # Ping, but with a graph
    viu # Command-line application to view images from the terminal written in Rust
    tre-command # Tree command, improved
    yazi # Blazing fast terminal file manager written in Rust, based on async I/O
    chafa # Terminal graphics for the 21st century

    cmatrix # Simulates the falling characters theme from The Matrix movie
    pipes-rs # Over-engineered rewrite of pipes.sh in Rust
    rsclock # Simple terminal clock written in Rust
    cava # Console-based Audio Visualizer for Alsa
    figlet # Program for making large letters out of ordinary text
  ];
}
