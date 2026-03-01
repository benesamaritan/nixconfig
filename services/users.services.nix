{ pkgs, ... }:

{
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  # systemd.user.services.keepassxc = {
  #   Unit = {
  #     Description = "KeePassXC Password Manager";
  #     After = [ "graphical-session.target" ];
  #   };
  #   Service = {
  #     ExecStart = "${pkgs.keepassxc}/bin/keepassxc --minimized";
  #   };
  #   Install = {
  #     WantedBy = [ "default.target" ];
  #   };
  # };

  systemd.user.services.thunderbird = {
    Unit = {
      Description = "Thunderbird Email Client";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.thunderbird}/bin/thunderbird";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.services.easyeffects = {
    Unit = {
      Description = "EasyEffects Audio Processor";
      After = [ "pipewire-pulse.service" ];
      PartOf = [ "pipewire-pulse.service" ];
    };
    Service = {
      ExecStart = "${pkgs.easyeffects}/bin/easyeffects --gapplication-service";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
