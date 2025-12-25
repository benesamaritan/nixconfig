{ pkgs, inputs, ... }:

{
  home.packages = [ pkgs.tmux ];

  programs.tmux = {
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";
    disableConfirmationPrompt = true;
  };
}
