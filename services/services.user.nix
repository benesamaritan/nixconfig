{ config, pkgs, ... }:

{
  services.ssh-agent.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;
    enableBashIntegration = true;
    enableSshSupport = false;
  };
  
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  # The kdeconnect plasmoid (loaded by plasmashell, a systemd user unit)
  # imports the QML module shipped inside the same package. Nix puts it in
  # lib/qt-6/qml, which Plasma never searches — expose it through the systemd
  # user manager environment so the shell process inherits it. Referencing
  # config.services.kdeconnect.package keeps plugin and plasmoid on the same
  # build across nixpkgs updates.
  systemd.user.sessionVariables.QML2_IMPORT_PATH =
    "${config.services.kdeconnect.package}/lib/qt-6/qml";
}
