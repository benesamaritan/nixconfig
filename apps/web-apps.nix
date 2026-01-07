{ pkgs, ... }:

let
  makeWebApp = name: url: iconName: profileID:
    let
      slug = pkgs.lib.strings.toLower (builtins.replaceStrings [ " " ] [ "-" ] name);
      profileDir = "$HOME/.config/chromium-webapps/${profileID}";
      
      launcher = pkgs.writeShellScript "launch-${slug}" ''
        ${pkgs.chromium}/bin/chromium \
          --app="${url}" \
          --user-data-dir="${profileDir}" \
          --class="${slug}"
      '';
    in
    pkgs.makeDesktopItem {
      name = slug;
      desktopName = name;
      exec = "${launcher}";
      icon = iconName;
      categories = [ "Network" ];
    };
in
{
  home.packages = with pkgs; [
    papirus-icon-theme

    (makeWebApp "Google Gemini Chat"      "https://gemini.google.com"       "google"           "google-suite")
    (makeWebApp "Google Drive"            "https://drive.google.com"        "google-drive"     "google-suite")
    (makeWebApp "Google Classroom"        "https://classroom.google.com"    "google-classroom" "google-suite")

    (makeWebApp "Github Classroom"        "https://classroom.github.com"    "github"           "github-suite")
    (makeWebApp "Github Copilot Chat"     "https://github.com/copilot"      "github-copilot"   "github-suite")

    (makeWebApp "Zoom"             "https://app.zoom.us/wc/join"     "Zoom"             "zoom")
    (makeWebApp "Canva"            "https://www.canva.com"           "canva"            "canva")
    (makeWebApp "WhatsApp"         "https://web.whatsapp.com"        "whatsapp"         "whatsapp")
    (makeWebApp "Telegram"         "https://web.telegram.org"        "telegram"         "telegram")
    (makeWebApp "Graphite"         "https://editor.graphite.art"     "graphite"         "graphite")
    (makeWebApp "Figma"            "https://www.figma.com"           "figma"            "figma")

  ];
}
