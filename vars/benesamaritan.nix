{
  # nixpkgs ? null,
  # config,
  # pkgs,
  ...
}:

let

in

{
  username = "bye";
  description = "Bayu Saputro";
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
