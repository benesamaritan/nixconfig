{ pkgs, inputs, ... }:

{
  imports = [ inputs.mango.hmModules.mango ];

  home.packages = [ inputs.mango.packages.${pkgs.system}.default ];

  wayland.windowManager.mango = {
    enable = true;
    settings = ''
      # see config.conf
    '';
    autostart_sh = ''
      # see autostart.sh
    '';
  };
}
