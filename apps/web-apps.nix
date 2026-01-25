{ pkgs, username, ... }:

let
  makeWebApp = name: url: domain: profileID: useFirefoxPwa: manifestUrl:
  let
    slug = pkgs.lib.strings.toLower (builtins.replaceStrings [ " " ] [ "-" ] name);
    iconDir = "/home/${username}/.local/share/icons/hicolor/128x128/apps";
    iconFile = "${iconDir}/${slug}.png";
    chromiumProfileDir = "/home/${username}/.config/chromium-webapps/${profileID}";
    # firefoxProfileDir = "/home/${username}/.config/firefox-pwas/${profileID}";
    useFlag = toString useFirefoxPwa;
    mUrl = toString manifestUrl;
    launcher = pkgs.writeShellScript "launch-${slug}" ''
      mkdir -p "${iconDir}"
      if [ ! -f "${iconFile}" ]; then
        ${pkgs.curl}/bin/curl -s "https://${domain}/favicon.ico" -o "${iconFile}" || \
        ${pkgs.curl}/bin/curl -s "https://www.google.com/s2/favicons?domain=${domain}&sz=128" -o "${iconFile}"
      fi
      if [ "${useFlag}" = "1" ]; then
        TARGET_MANIFEST="${if manifestUrl != "" then mUrl else url}"
        exec ${pkgs.firefoxpwa}/bin/firefoxpwa site install "$TARGET_MANIFEST" \
          --document-url "${url}" \
          --name "${name}" \
          --icon-url "file://${iconFile}" \
          --launch-now
      else
        exec ${pkgs.chromium}/bin/chromium \
          --app="${url}" \
          --user-data-dir="${chromiumProfileDir}" \
          --class="${slug}"
      fi
    '';
    desktop = pkgs.makeDesktopItem {
      name = slug;
      desktopName = name;
      exec = "${launcher}";
      icon = slug;
      categories = [ "Network" ];
    };
  in
    pkgs.runCommand "pkg-${slug}" { } ''
      mkdir -p $out/share/applications
      mkdir -p $out/bin
      cp -r ${desktop} $out/share/applications/${slug}.desktop
      cp -r ${launcher} $out/bin/${slug}
      chmod +x $out/bin/${slug}
    '';
  in

{
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [ 
      pkgs.firefoxpwa 
    ];
  };

  home.packages = [
    pkgs.firefoxpwa
    (makeWebApp "Google Gemini Chat"      "https://gemini.google.com"       "google.com"           "google-suite" 0 "")
    (makeWebApp "Google Drive"            "https://drive.google.com"        "drive.google.com"     "google-suite" 0 "")
    (makeWebApp "Google Classroom"        "https://classroom.google.com"    "classroom.google.com" "google-suite" 0 "")

    (makeWebApp "Github Classroom"        "https://classroom.github.com"    "github.com"           "github-suite" 0 "")
    (makeWebApp "Github Copilot Chat"     "https://github.com/copilot"      "github.com"           "github-suite" 0 "")

    (makeWebApp "Zoom"                    "https://app.zoom.us/wc/join"     "zoom.us"              "zoom"         0 "")
    (makeWebApp "Discord"                 "https://discord.com"             "discord.com"          "discord"      1 "")
    (makeWebApp "Canva"                   "https://www.canva.com"           "canva.com"            "canva"        1 "")
    (makeWebApp "WhatsApp"                "https://web.whatsapp.com"        "whatsapp.com"         "whatsapp"     0 "")
    (makeWebApp "Telegram"                "https://web.telegram.org/k"      "web.telegram.org"     "telegram"     1 "")
    (makeWebApp "Graphite"                "https://editor.graphite.art"     "graphite.art"         "graphite"     1 "")
    (makeWebApp "Figma"                   "https://www.figma.com"           "figma.com"            "figma"        1 "")
  ];
}
