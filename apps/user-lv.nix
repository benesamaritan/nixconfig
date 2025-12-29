{ pkgs, inputs, username, git, ... }:

{
  home.packages = with pkgs; [
    alacritty
    duf
    dust
    tokei
    glow
    btop
    kanshi
    atuin
    starship
    wl-clipboard
    manix
    nh
    disktui
    woeusb-ng
    mediawriter
    thunderbird
    vscodium
    inputs.zen-browser.packages.${pkgs.system}.beta
    anytype
    appimage-run # use which command to look up path to be put onto lutris or other tools
    flatpak
  ];

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  programs.fish = {
    enable = true;
      interactiveShellInit = ''
        set fish_greeting
        atuin init fish | source
        starship init fish | source
      '';
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "${git.user}";
        email = "${git.email}";
      };
    init.defaultBranch = "main";
    };
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    icons = "auto";
    git = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
