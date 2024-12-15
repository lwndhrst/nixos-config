{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    # List of available plugins in the overlay (pkgs.vimExtraPlugins):
    # https://github.com/NixNeovim/NixNeovimPlugins/blob/main/plugins.md
    #
    # Plugins are still configured via lua for now:
    # https://github.com/lwndhrst/dotfiles-nvim
    plugins = with pkgs; [
      vimPlugins.plenary-nvim

      # LSP and completion stuff
      vimPlugins.nvim-lspconfig
      vimPlugins.nvim-cmp
      vimPlugins.cmp-nvim-lsp
      vimPlugins.cmp-buffer
      vimPlugins.cmp-path
      vimPlugins.cmp-cmdline
      vimPlugins.cmp_luasnip
      vimPlugins.luasnip
      
      (vimPlugins.nvim-treesitter.withPlugins (p: with p; [
        bash
        c
        c_sharp
        cmake
        cpp
        css
        gdscript
        glsl
        html
        javascript
        lua
        markdown
        nix
        odin
        python
        rust
        toml
        typst
      ]))

      # Formatting
      vimPlugins.conform-nvim

      # Misc
      vimPlugins.telescope-nvim
      vimPlugins.oil-nvim
      vimPlugins.harpoon2
      vimPlugins.lualine-nvim
      vimPlugins.dashboard-nvim
      vimPlugins.nvim-colorizer-lua
      vimPlugins.todo-comments-nvim

      # Latex
      vimPlugins.vimtex

      # Themes
      vimPlugins.rose-pine
    ];
  };
}
