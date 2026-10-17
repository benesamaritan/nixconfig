{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [ starship ];

  programs = {
    mcp.enable = true;
    antigravity-cli.enable = true;
    opencode.enable = true;
    helix.enable = true;
    zed-editor.enable = true;
    vscodium.enable = true;
    yazi.enable = true;
    bash.enable = true;
    direnv.enable = true;
    devenv.enable = true;
    nh.enable = true;
    nix-index.enable = true;
    lazygit.enable = true;
    lazysql.enable = true;
  };

  programs = {
    zen-browser.enable = true;
    helium.enable = true;
    bat.enable = true;
    atuin.enable = true;
#     starship.enable = true;
    zoxide.enable = true;
    fzf.enable = true;
    eza.enable = true;
    tealdeer.enable = true;
    fastfetch.enable = true;
    ripgrep.enable = true;
    fd.enable = true;
    television.enable = true;
  };

  programs = {
    onlyoffice.enable = true;
    thunderbird.enable = false;
    obs-studio.enable = true;
    wezterm.enable = true;
  };
}
