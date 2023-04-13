{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Rust Toolchain Manager
    rustup

    # Rust LSP
    rust-analyzer
  ];
}
