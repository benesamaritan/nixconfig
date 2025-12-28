{ config, pkgs, username, ... }: 
{
  environment.systemPackages = [ pkgs.kanata ];
  hardware.uinput.enable = true;

  systemd.services.kanata = {
    description = "Kanata Keyboard Remapper";
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig = {
      ExecStart = "${pkgs.kanata}/bin/kanata -c /home/${username}/dotfiles/kanata/kanata.kbd";
      Restart = "always";
      
      User = "root";
      Group = "root";
      
      ProtectHome = false; 
    };
  };
}
