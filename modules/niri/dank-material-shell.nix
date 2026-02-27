{ pkgs, inputs, ... }:

{	
  imports = with inputs; [
    dms.nixosModules.default
    dms-plugin-registry.modules.default
    nix-monitor.nixosModules.default
  ];

  programs.dms-shell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
    enableVPN = false;
    enableCalendarEvents = false;
    enableSystemMonitoring = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;

    plugins = {
      dankPomodoroTimer.enable = true;
      dankKDEConnect.enable = true;
      niriWindows.enable = true;
      calculator.enable = true;
      prayerTimes.enable = true;
      sshConnections.enable = true;
      webSearch.enable = true;
      commandRunner.enable = true;
      dankBitwarden.enable = true;
      dankBatteryAlerts.enable = true;
      dankLauncherKeys.enable = true;
      dankNotepadModule.enable = true;
      niriScreenshot.enable = false;
      dockerManager.enable = false;
      animeCalendar.enable = false;
      displayMirror.enable = false;
      dankClight.enable = false;
      nixMonitor.enable = false;
    };
  };

  programs.nix-monitor = {
    enable = false;
    rebuildCommand = [ 
      "bash" "-c" 
      "cd ~/repo/github.com/benesamaritan/nixconfig && 
       sudo nixos-rebuild switch --flake .#sol 2>&1 && 
       home-manager switch --flake .#bye 2>&1"
    ];
    gcCommand = [ 
      "bash" "-c" 
      "sudo nix-collect-garbage -d 2>&1" 
    ];
    nixpkgsChannel = "nixos-25.11";  
    updateInterval = 600;
    remoteRevisionCommand = [
      "${pkgs.bash}/bin/bash" "-l" "-c"
      "${pkgs.curl}/bin/curl -s https://api.github.com/repos/NixOS/nixpkgs/git/ref/heads/nixos-unstable 2>/dev/null | ${pkgs.jq}/bin/jq -r '.object.sha' 2>/dev/null | cut -c 1-7 || echo 'N/A'"
    ];
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
