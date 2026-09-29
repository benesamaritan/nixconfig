{
  ...
}:

{
  systemd.user.enable = true;
  
  systemd.user.services.kanata = {
    Unit = {
      Description = "Kanata Daemon";
    };
    Service = {
      ExecStart = "${pkgs.kanata}/bin/kanata -qc ~/.config/kanata/kanata.kbd";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  # systemd.user.services.thunderbird = {
  #   Unit = {
  #     Description = "Thunderbird Email Client";
  #     After = [ "graphical-session.target" ];
  #   };
  #   Service = {
  #     ExecStart = "${pkgs.thunderbird}/bin/thunderbird";
  #     Restart = "on-failure";
  #   };
  #   Install = {
  #     WantedBy = [ "default.target" ];
  #   };
  # };
}
