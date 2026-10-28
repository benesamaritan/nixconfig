{ pkgs, ... }:

let
  mkLiteral = v: { _type = "literal"; value = v; };
in
{
  programs.rofi = {
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji
      rofi-power-menu
      rofi-games
      rofi-nerdy
      rofi-systemd
      rofi-obsidian
      rofi-screenshot
      rofi-file-browser
      pinentry-rofi
      todofi-sh
    ];
    # `configuration` block contents
    settings = {
      font = "IosevkaTermSlab Nerd Font";
      lines = 10;
      fixed-num-lines = true;
      padding = mkLiteral "10px";
      modes = "combi";
      combi-modes = "drun,window,calc,emoji,file-browser-extended";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      location = 0;
    };
    # top-level theme/window/widget sections (written to a custom theme file)
    theme = {
      entry = {
        placeholder = "";
        text-color = mkLiteral "#cdd6f4";
        placeholder-color = mkLiteral "#6c7086";
        padding = mkLiteral "8px 0 8px 8px";
      };

      inputbar = {
        children = mkLiteral "[ entry ]";
      };

      "*" = {
        text-color = mkLiteral "#cdd6f4";
        separatorcolor = mkLiteral "#313244";
        selected-normal-background = mkLiteral "rgba(245,194,231, 40%)";
        normal-background = mkLiteral "rgba(30,30,46, 0%)";
        alternate-normal-background = mkLiteral "rgba(30,30,46, 0%)";
      };

      mainbox = {
        border = mkLiteral "2px";
        border-color = mkLiteral "rgba(88,91,112, 20%)";
        border-radius = 10;
        padding = mkLiteral "10px";
      };

      window = {
        border-radius = 11;
        border = mkLiteral "1px solid";
        border-color = mkLiteral "#f5c2e7";
        background-color = mkLiteral "rgba(30,30,46,95%)";
        padding = 0;
        width = mkLiteral "30%";
      };

      listview = {
        lines = 10;
      };

      element = {
        padding = mkLiteral "10px 10px";
        height = 50;
        border-radius = 5;
        children = mkLiteral "[ element-text, element-icon ]";
      };

      element-text = {
        text-color = mkLiteral "#cdd6f4";
      };

      "#scrollbar" = {
        handle-color = mkLiteral "#585b70";
        handle-width = 4;
        padding = 0;
      };
    };
  };
}
