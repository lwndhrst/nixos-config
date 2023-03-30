{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    # List of available plugins in the overlay:
    # https://github.com/NixNeovim/NixNeovimPlugins/blob/main/plugins.md
    #
    # Plugins are still configured via lua for now:
    # https://github.com/lwndhrst/dotfiles-nvim
    plugins = with pkgs.vimExtraPlugins; [
      plenary-nvim

      # LSP and completion stuff
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-luasnip
      LuaSnip

      # Formatter
      formatter-nvim

      # Treesitter
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
        nix
        lua
        rust
        toml
        markdown
        javascript
        css
        html
      ]))

      # Misc
      nvim-web-devicons
      telescope-nvim
      nvim-tree-lua
      lualine-nvim
      dashboard-nvim
      harpoon

      # Latex
      vimtex

      # Themes
      rose-pine
    ];
  };
}
