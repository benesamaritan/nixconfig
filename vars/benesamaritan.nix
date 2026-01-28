{ nixpkgs ? null, ... }:

{
  username = "bye";
  description = "Bayu Saputro";
  hashPasswd = "$6$KyNQWAqeKj9uX3G6$zoWMV0vtTLO1cEbnUDKnFGSIy.MGPnoCDQ3mmZisqx2qrr.Ywyp3ajoLhni2OQTWZ4kKAVMNcKSuKzIWPmhx7.";
  groups = [
    "networkmanager"
    "wheel"
  ];
  shell = "fish";
  git = {
    user = "benesamaritan";
    email = "243715333+benesamaritan@users.noreply.github.com";
  };
}
