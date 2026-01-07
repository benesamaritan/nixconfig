{config, pkgs, ...}:

{
  services.samba = {
    enable = true;
    package = pkgs.sambaFull;
    openFirewall = true;
    settings = {
      global = {
        "load printers" = "yes";
        "printing" = "cups";
        "printcap name" = "cups";
      };
      "printers" = {
        "comment" = "All Printers";
        "path" = "/var/spool/samba";
        "public" = "yes";
        "browseable" = "yes";
        "guest ok" = "yes";
        "writable" = "no";
        "printable" = "yes";
        "create mode" = 0700;
      };
    };
  };

  services.printing.enable = true;

  systemd.tmpfiles.rules = [
    "d /var/spool/samba 1777 root root -"
  ];
}
