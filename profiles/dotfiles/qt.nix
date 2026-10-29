{
    inputs,
    pkgs,
    ...
}:
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  # Catppuccin flavor for both qt5ct and qt6ct
  catppuccin.qt5ct.enable = true;

  qt.kvantum.settings = {
    General = {
      theme = "catppuccin-mocha-pink";
    };
  };

  # KWin Better Blur DX effect (installed via flake input)
  home.packages = with pkgs; [
    libsForQt5.qt5ct
    kdePackages.qt6ct
    inputs.better-blur-dx.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
