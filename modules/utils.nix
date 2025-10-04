{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mold # Faster drop-in replacement for existing Unix linkers (unwrapped)
    gcc # GNU Compiler Collection, version 14.3.0 (wrapper script)
    clang # C language family frontend for LLVM (wrapper script)
    lld # LLVM linker (unwrapped)
    lldb # Next-generation high-performance debugger
    musl # Efficient, small, quality libc implementation
    # jdk # Open-source Java Development Kit
    # dioxus-cli # CLI tool for developing, testing, and publishing Dioxus apps
    # surrealdb # Scalable, distributed, collaborative, document-graph database, for the realtime web
    surrealdb-migrations # Awesome SurrealDB migration tool, with a user-friendly CLI and a versatile Rust library that enables seamless integration into any project
    surrealist # Visual management of your SurrealDB database
    trunk # Build, bundle & ship your Rust WASM application to the web
    gparted
  ];
}
