{ config, pkgs, ... }:

{
  # Kanata runs as the user here (NixOS ran it as root). On a local logind
  # session no host setup is needed — systemd grants the active session
  # device access via ACLs, and the service below starts at login via
  # default.target. Only if the journal ever shows permission denied,
  # fall back to the classic static setup (needs sudo + re-login):
  #
  #   sudo groupadd -f uinput
  #   sudo usermod -aG input,uinput "$USER"
  #   echo 'KERNEL=="uinput", GROUP="uinput", MODE:="0660", OPTIONS+="static_node=uinput"' \
  #     | sudo tee /etc/udev/rules.d/99-kanata.rules
  #   sudo udevadm control --reload-rules && sudo udevadm trigger
  systemd.user.services.kanata = {
    Unit = {
      Description = "Kanata keyboard remapper";
      After = [ "graphical-session.target" ];
    };
    Install.WantedBy = [ "default.target" ];
    Service = {
      ExecStart = "${pkgs.kanata}/bin/kanata -c ${config.home.homeDirectory}/.config/kanata/kanata.kbd";
      Restart = "always";
      RestartSec = 3;
    };
  };
}
