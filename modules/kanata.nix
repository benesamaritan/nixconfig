{ pkgs, username, ... }: 

{
  environment.systemPackages = [ pkgs.kanata ];
  hardware.uinput.enable = true;
  users.users.${username}.extraGroups = [ 
    "input" 
    "uinput"
  ];

  systemd.services.kanata = {
    description = "Kanata Keyboard Remapper";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.kanata}/bin/kanata -qc /home/${username}/.config/kanata/kanata.kbd";
      Restart = "always";
      User = "root";
      Group = "root";
      ProtectHome = false; 
    };
  };}
