{ config, pkgs, ... }:

let
  pname = "logseq";
  version = "0.10.9";
  
  src = pkgs.fetchurl {
    url = "https://github.com/logseq/logseq/releases/download/${version}/Logseq-linux-x64-${version}.AppImage";
    hash = "sha256-XROuY2RlKnGvK1VNvzauHuLJiveXVKrIYPppoz8fCmc=";
  };

  appIcon = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/logseq/logseq/master/resources/icons/logseq.png";
    hash = "sha256-LAS62Znvdbh0vRhbhMTfVgSGaF9aNsKAEiTvm2dkIAY=";
  };

  appimage = pkgs.appimageTools.wrapType2 {
    inherit pname version src;
    extraPkgs = pkgs: with pkgs; [ libsecret libappindicator-gtk3 ];
  };

  desktopItem = pkgs.makeDesktopItem {
    name = "logseq";
    desktopName = "Logseq";
    exec = "${appimage}/bin/logseq %u";
    icon = appIcon;
    comment = "Privacy-first, open-source knowledge base";
    categories = [ "Office" "Utility" ];
    terminal = false;
  };

in
{
  home.packages = [
    appimage
    desktopItem
    #pkgs.logseq.override { electron_27 = pkgs.electron_34; }
  ];
}
