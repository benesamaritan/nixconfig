{ pkgs, ... }:

let
  makeWebApp = name: url: icon: pkgs.makeDesktopItem {
    name = name;
    desktopName = name;
    exec = "${pkgs.chromium}/bin/chromium --app=${url}";
    icon = icon;
    categories = [ "Network" ];
  };
in
{
  home.packages = [
    (makeWebApp "Google Classroom" "https://classroom.google.com" "education-school")
    (makeWebApp "Google Drive" "https://drive.google.com" "folder-cloud")
    (makeWebApp "Github Classroom" "https://classroom.github.com" "vcs-git")
    (makeWebApp "WhatsApp" "https://web.whatsapp.com" "network-chat")
    (makeWebApp "Telegram" "https://web.telegram.org" "telegram")
  ];
}
