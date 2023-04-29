{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Clang, this package also includes clangd (LSP)
    llvmPackages_15.libclang

    # GCC
    # gcc12
  ];
}
