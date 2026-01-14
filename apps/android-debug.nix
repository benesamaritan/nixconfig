{ pkgs, ... }: 

{
  environment.systemPackages = [
    pkgs.android-tools
  ];

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0e8d", MODE="0660", GROUP="adbusers"
    SUBSYSTEM=="usb", ATTR{idVendor}=="22d9", MODE="0660", GROUP="adbusers"
    SUBSYSTEM=="usb", ATTR{idVendor}=="2d95", MODE="0660", GROUP="adbusers"
    SUBSYSTEM=="usb", ATTR{idVendor}=="0e8d", ATTR{idProduct}=="2000", MODE="0660", GROUP="adbusers"
    KERNEL=="ttyACM*", MODE="0660", GROUP="adbusers"
  '';

  users.users.bye.extraGroups = [ "adbusers" "plugdev" ];
}
