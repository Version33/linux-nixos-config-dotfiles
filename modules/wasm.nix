{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wasmedge # Lightweight, high-performance, and extensible WebAssembly runtime for cloud native, edge, and decentralized applications
    wasmer # Universal WebAssembly Runtime
    lunatic # Erlang inspired runtime for WebAssembly
    wasmi # Efficient WebAssembly interpreter
    # wasm3 # Fastest WebAssembly interpreter, and the most universal runtime
  ];
}
