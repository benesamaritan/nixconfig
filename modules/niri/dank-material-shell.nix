{ pkgs, ... }:

{	
  programs.dms-shell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
    enableVPN = false;
    enableSystemMonitoring = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;

    plugins =
    let
      dmsPlugins = pkgs.fetchFromGitHub {
        owner = "AvengeMedia";
        repo = "dms-plugins";
        rev = "8fa7c52";
        hash = "sha256-0RXRgUXXoX+C0q+drsShjx2rCTdmqFzOCR/1rGB/W2E=";
      };
    in
    {
      DankPomodoro = {
        enable = true;
        src = "${dmsPlugins}/DankPomodoro";
      };
      DankNiriWindows = {
        enable = true;
        src = pkgs.fetchFromGitHub {
          owner = "rochacbruno";
          repo = "DankNiriWindows";
          rev = "b845277";
          hash = "sha256-rdZAnkRyfycI2a2wjSiepQwRI49zKbwoRzpz1+c6ZJA=";
        };
      };
    };
  };

  systemd.user.services.cliphist = {
    description = "Clipboard history watcher";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
      Restart = "always";
      RestartSec = "3s";
    };
  };

  environment.systemPackages = with pkgs; [
    cliphist
    libsForQt5.qt5ct
    kdePackages.qt6ct
  ];
}
