
{ pkgs, ... }:

{ 
  environment.systemPackages = [ pkgs.kanshi ];

  systemd.user.services.kanshi = {
    description = "Kanshi output autoconfig";
    wantedBy = [ "graphical-session.target" ]; 
    partOf = [ "graphical-session.target" ];
    
    serviceConfig = {
      ExecStart = "${pkgs.kanshi}/bin/kanshi"; 
      Restart = "always";
      RestartSec = "3s";
    };
  };
}

