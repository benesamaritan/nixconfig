{
  ...
}:

{
  services.printing.enable = false;

  services.samba = {
    enable = false;
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
        "public" = "no";
        "browseable" = "yes";
        "guest ok" = "yes";
        "writable" = "no";
        "printable" = "yes";
        "create mode" = 0700;
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/spool/samba 1777 root root -"
  ];
}
