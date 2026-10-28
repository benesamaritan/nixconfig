{ inputs, pkgs, ... }:

let
  link = name: {
    source = ./${name};
  };
in
{
  xdg = {
    enable = true;
    autostart.enable = true;
    autostart.readOnly = false;
    autostart.entries = [
      # Zen Browser: point to its packaged .desktop file
      "${inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default}/share/applications/zen-twilight.desktop"
      
      # 9router: generate a .desktop file via makeDesktopItem
      (pkgs.makeDesktopItem {
        desktopName = "9router";
        name = "9router";
        exec = "${pkgs.bun}/bin/bunx 9router";
        terminal = false;
        categories = [ "Development" ];
      } + "/share/applications/9router.desktop")
    ];
    configFile = {
#       "niri"            = link "niri";
      "nvim"            = link "nvim";
      "kanata"          = link "kanata";
      "wezterm"         = link "wezterm";
      "alacritty"       = link "alacritty";
    };
  };
}
