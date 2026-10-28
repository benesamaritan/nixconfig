{ lib, ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "small";
        position = "left";
      };
      modules = [
        { type = "custom"; format = "\u001b[90m┌─Hardware────────────────────────────────────────────────┐"; }
        { type = "cpu"; showPeCoreCount = false; temp = false; key = "└─├─󰻠"; }
        { type = "memory"; key = "  ├─󰑭"; }
        { type = "localip"; showSpeed = true; key = "  └─󰩟"; }
        { type = "custom"; format = "\u001b[90m└─────────────────────────────────────────────────────────┘"; }
        { type = "custom"; format = "\u001b[90m┌─(Actually) GNU+Linux────────────────────────────────────┐"; }
        { type = "os"; key = "{icon}"; }
        { type = "kernel"; key = "└─├─"; }
        { type = "packages"; key = "  ├─󰏖"; }
        { type = "de"; key = "  ├─"; }
        { type = "wm"; key = "  ├─"; }
        { type = "wallpaper"; key = "  ├─󰸉"; }
        { type = "theme"; key = "  ├─󰉼"; }
        { type = "icons"; key = "  ├─󰀻"; }
        { type = "terminal"; key = "  └─"; }
        { type = "custom"; format = "\u001b[90m└─────────────────────────────────────────────────────────┘"; }
        { type = "custom"; format = "\u001b[90m┌─OS Age + Uptime─────────────────────────────────────────┐"; }
        { type = "command"; key = "  󰅐 Age"; text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days"; }
        { type = "uptime"; key = "  󰅐 Uptime"; }
        { type = "custom"; format = "\u001b[90m└─────────────────────────────────────────────────────────┘"; }
      ];
    };
  };
}
