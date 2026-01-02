{ pkgs, ... }:

{
  # 1. The Dnsmasq setup for .test domains
  services.dnsmasq = {
    enable = true;
    settings = {
      address = "/.test/127.0.0.1";
    };
  };

  # 2. (Optional) Open ports for web servers if you need external access
  #networking.firewall.allowedTCPPorts = [ 80 443 3000 8000 ];
}
