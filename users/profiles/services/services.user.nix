{ pkgs, ... }:

{
  services.ssh-agent.enable = true;

  services.gpg-agent = {
    enable = false;
    enableBashIntegration = true;
    enableSshSupport = true;
  };
  
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
