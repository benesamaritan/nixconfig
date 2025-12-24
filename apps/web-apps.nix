{ pkgs, ... }:

let
  # Helper function to create desktop entries for web applications
  # Opens websites as standalone Chromium windows for app-like experience
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
    # Google Classroom - educational platform for assignments and course management
    (makeWebApp "Google Classroom" "https://classroom.google.com" "education-school")
    
    # Google Drive - cloud storage and file synchronization service
    (makeWebApp "Google Drive" "https://drive.google.com" "folder-cloud")
    
    # GitHub Classroom - educational tool for managing programming assignments via GitHub
    (makeWebApp "Github Classroom" "https://classroom.github.com" "vcs-git")
    
    # WhatsApp Web - messaging application for text, voice, and video communication
    (makeWebApp "WhatsApp" "https://web.whatsapp.com" "network-chat")
    
    # Telegram Web - cloud-based instant messaging with end-to-end encryption
    (makeWebApp "Telegram" "https://web.telegram.org" "telegram")
  ];
}
