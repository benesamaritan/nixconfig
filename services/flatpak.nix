{ ... }:

{
  services.flatpak = {
    enable = true;
    uninstallUnmanaged = false;
    # Declaring remotes overrides the flathub default, so flathub is
    # re-declared explicitly. Packages from flatpark need
    # { appId = "…"; origin = "flatpark"; }.
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
      {
        name = "flatpark";
        location = "https://dl.flatpark.org/flatpark.flatpakrepo";
      }
    ];
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
    packages = [
      # Add Flathub app IDs for software with no nixpkgs build, e.g.
      # "org.mozilla.firefox"
    ];
  };
}
