{ pkgs, ... }:

{
  home.packages = with pkgs; [
    llvmPackages_15.libcxxClang

    # clangd (LSP), etc.
    clang-tools_15
  ];
}
