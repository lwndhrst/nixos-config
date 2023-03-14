{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    enableCompletion = true;

    plugins = [ ];

    oh-my-zsh = {
      enable = true;
      plugins = [ ];
    };

    initExtra = ''
      # Spaceship Theme
      source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup

      # Spaceship async jobs aren't working correctly, so disable them for now
      export SPACESHIP_PROMPT_ASYNC=false

      autoload -U promptinit; promptinit
    '';
  };
}
