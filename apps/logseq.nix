{ pkgs, ... }:

let
  pname = "logseq";
  version = "0.10.9"; 
  src = pkgs.fetchurl {
    url = "https://github.com/logseq/logseq/releases/download/${version}/Logseq-linux-x64-${version}.AppImage";
    hash = "sha256-XROuY2RlKnGvK1VNvzauHuLJiveXVKrIYPppoz8fCmc=";
  };
  
  appimageContents = pkgs.appimageTools.extract { inherit pname version src; };
in
{
  home.packages = [
    (pkgs.appimageTools.wrapType2 {
      inherit pname version src;
      extraPkgs = pkgs: with pkgs; [ 
        libsecret
        libappindicator-gtk3 
      ];
      extraInstallCommands = ''
        install -m 444 -D ${appimageContents}/Logseq.desktop $out/share/applications/Logseq.desktop
        install -m 444 -D ${appimageContents}/Logseq.png \
          $out/share/icons/hicolor/512x512/apps/Logseq.png
        substituteInPlace $out/share/applications/Logseq.desktop \
          --replace 'Exec=AppRun' 'Exec=${pname}'
      '';
    })
  ];
}
