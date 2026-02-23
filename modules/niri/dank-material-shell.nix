{ pkgs, inputs, ... }:

{	
  imports = [
    inputs.dms-plugin-registry.modules.default
  ];

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
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;

    plugins = {
      dankPomodoroTimer.enable = true;
      dankKDEConnect.enable = true;
      niriWindows.enable = true;
      calculator.enable = true;
      prayerTimes.enable = true;
      sshConnections.enable = true;
      dockerManager.enable = true;
      nixMonitor.enable = true;
      niriScreenshot.enable = true;
      webSearch.enable = true;
      commandRunner.enable = true;
      dankBitwarden.enable = true;
      animeCalendar.enable = true;
      dankBatteryAlerts.enable = true;
      dankLauncherKeys.enable = true;
      dankClight.enable = true;
      dankNotepadModule.enable = true;
      displayMirror.enable = true;
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

  programs.dsearch = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
  };

  environment.systemPackages = with pkgs; [
    cliphist
    libsForQt5.qt5ct
    kdePackages.qt6ct
  ];
}
