{ pkgs, ... }:

let
  makeWebApp = name: url: domain: profileID: useFirefoxPwa: manifestUrl:
  let
    home = builtins.getEnv "HOME";
    slug = pkgs.lib.strings.toLower (builtins.replaceStrings [ " " ] [ "-" ] name);
    iconDir = "${home}/.local/share/icons/hicolor/128x128/apps";
    iconFile = "${iconDir}/${slug}.png";
    chromiumProfileDir = "${home}/.config/chromium-webapps/${profileID}";
    firefoxProfileDir = "${home}/.config/firefox-pwas/${profileID}";
    useFlag = builtins.toString useFirefoxPwa;
    mUrl = builtins.toString manifestUrl;
    launcher = pkgs.writeShellScript "launch-${slug}" ''
      mkdir -p "${iconDir}"
      if [ ! -f "${iconFile}" ]; then
        ${pkgs.curl}/bin/curl -s "https://${domain}/favicon.ico" -o "${iconFile}" || \
        ${pkgs.curl}/bin/curl -s "https://www.google.com/s2/favicons?domain=${domain}&sz=128" -o "${iconFile}"
      fi

      if [ "${useFlag}" = "1" ]; then
        if [ -n "${mUrl}" ]; then
          export MANIFEST_URL="${mUrl}"
        fi
        exec ${pkgs.firefoxpwa}/bin/firefoxpwa --class="${slug}" --url="${url}" --profile "${firefoxProfileDir}"
      else
        exec ${pkgs.chromium}/bin/chromium --app="${url}" --user-data-dir="${chromiumProfileDir}" --class="${slug}"
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
  home.packages = [
    (makeWebApp "Google Gemini Chat"      "https://gemini.google.com"       "google.com"           "google-suite" 0 "")
    (makeWebApp "Google Drive"            "https://drive.google.com"        "drive.google.com"     "google-suite" 0 "")
    (makeWebApp "Google Classroom"        "https://classroom.google.com"    "classroom.google.com" "google-suite" 0 "")

    (makeWebApp "Github Classroom"        "https://classroom.github.com"    "github.com"           "github-suite" 0 "")
    (makeWebApp "Github Copilot Chat"     "https://github.com/copilot"      "github.com"           "github-suite" 0 "")

    (makeWebApp "Zoom"                    "https://app.zoom.us/wc/join"     "zoom.us"              "zoom"         0 "")
    (makeWebApp "Discord"                 "https://discord.com"             "discord.com"          "discord"      0 "")
    (makeWebApp "Canva"                   "https://www.canva.com"           "canva.com"            "canva"        0 "")
    (makeWebApp "WhatsApp"                "https://web.whatsapp.com"        "whatsapp.com"         "whatsapp"     0 "")
    (makeWebApp "Telegram"                "https://web.telegram.org"        "web.telegram.org"     "telegram"     1 "https://web.telegram.org/manifest.json")
    (makeWebApp "Graphite"                "https://editor.graphite.art"     "graphite.art"         "graphite"     0 "")
    (makeWebApp "Figma"                   "https://www.figma.com"           "figma.com"            "figma"        0 "")
  ];
}
