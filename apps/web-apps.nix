{ pkgs, ... }:

let
  makeWebApp = name: url: domain: profileID:
    let
      slug = pkgs.lib.strings.toLower (builtins.replaceStrings [ " " ] [ "-" ] name);
      iconDir = "$HOME/.local/share/icons/hicolor/128x128/apps";
      iconFile = "${iconDir}/${slug}.png";
      profileDir = "$HOME/.config/chromium-webapps/${profileID}";
      launcher = pkgs.writeShellScript "launch-${slug}" ''
        mkdir -p "${iconDir}"
        if [ ! -f "${iconFile}" ]; then
          ${pkgs.curl}/bin/curl -s "https://www.google.com/s2/favicons?domain=${domain}&sz=128" -o "${iconFile}"
          # Touch directory to notify desktop environment of new file
          touch "${iconDir}"
        fi
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
      icon = slug;
      categories = [ "Network" ];
    };
in
{
  home.packages = with pkgs; [
    (makeWebApp "Google Gemini Chat"      "https://gemini.google.com"       "google.com"           "google-suite")
    (makeWebApp "Google Drive"            "https://drive.google.com"        "drive.google.com"     "google-suite")
    (makeWebApp "Google Classroom"        "https://classroom.google.com"    "classroom.google.com" "google-suite")

    (makeWebApp "Github Classroom"        "https://classroom.github.com"    "github.com"           "github-suite")
    (makeWebApp "Github Copilot Chat"     "https://github.com/copilot"      "github.com"           "github-suite")

    (makeWebApp "Zoom"             "https://app.zoom.us/wc/join"     "zoom.us"          "zoom")
    (makeWebApp "Canva"            "https://www.canva.com"           "canva.com"        "canva")
    (makeWebApp "WhatsApp"         "https://web.whatsapp.com"        "whatsapp.com"     "whatsapp")
    (makeWebApp "Telegram"         "https://web.telegram.org"        "telegram.org"     "telegram")
    (makeWebApp "Graphite"         "https://editor.graphite.art"     "graphite.art"     "graphite")
    (makeWebApp "Figma"            "https://www.figma.com"           "figma.com"        "figma")
  ];
}
