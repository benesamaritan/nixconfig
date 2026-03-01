{
  username,
  ...
}:

{
  services.syncthing = {
    enable = true;
    user = "${username}";
    openDefaultPorts = true;
  };
}
