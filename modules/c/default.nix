{ pkgs, ... }:

{
  home.packages = with pkgs; [
    llvmPackages.clang

    # clangd (LSP), etc.
    clang-tools
  ];
}
