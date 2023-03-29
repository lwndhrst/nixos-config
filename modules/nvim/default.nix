{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    # list of available plugins in the overlay:
    # https://github.com/NixNeovim/NixNeovimPlugins/blob/main/plugins.md
    #
    # plugins are still configured via lua for now:
    # https://github.com/lwndhrst/dotfiles-nvim
    plugins = with pkgs.vimExtraPlugins; [
      plenary-nvim

      # lsp and completion stuff
      nvim-lspconfig
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-cmp
      LuaSnip
      cmp-luasnip

      # formatter
      formatter-nvim

      # treesitter
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

      # misc
      nvim-web-devicons
      telescope-nvim
      nvim-tree-lua
      lualine-nvim
      dashboard-nvim
      harpoon

      # latex
      vimtex

      # themes
      gruvbox-material
      catppuccin
      rose-pine
    ];
  };
}
