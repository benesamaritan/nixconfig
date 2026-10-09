{ pkgs, ... }:

{
  services.ssh-agent.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;
    enableBashIntegration = true;
    enableSshSupport = false;
  };
  
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
