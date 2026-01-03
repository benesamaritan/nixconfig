{ config, pkgs, username, ... }:

{
  services.syncthing = {
    enable = true;
    user = "${username}"; 
    dataDir = "/home/${username}/Sync";
    configDir = "/home/${username}/.config/syncthing";
    
    openDefaultPorts = true;

    # guiAddress = "0.0.0.0:8384"; 
    
    # Declarative Config
#    settings = {
#      devices = {
#        "android-phone" = { id = "INSERT-DEVICE-ID-FROM-PHONE-HERE"; };
#      };
#      folders = {
#        "Logseq-Graph" = {
#          path = "/home/your_username/Logseq";
#          devices = [ "android-phone" ];
#          ignorePerms = false; 
#        };
#      };
#    };
  };
}
