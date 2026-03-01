{
  pkgs,
  config,
  username,
  hostname,
  timezone,
  defaultLocale,
  extraLocale,
  xkb,
  description,
  groups,
  shell,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules
    ../../packages
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "${username}"
      ];
      auto-optimise-store = true;
      use-xdg-base-directories = true;
    };

    extraOptions = ''
      !include ${config.age.secrets.github-token.path}
    '';

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  time.timeZone = "${timezone}";

  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "wpa_supplicant";
    };
    hostName = "${hostname}";
  };

  hardware = {
    graphics.enable = true;
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  i18n = {
    defaultLocale = "${defaultLocale}";
    extraLocaleSettings = {
      LC_ADDRESS = "${extraLocale}";
      LC_IDENTIFICATION = "${extraLocale}";
      LC_MEASUREMENT = "${extraLocale}";
      LC_MONETARY = "${extraLocale}";
      LC_NAME = "${extraLocale}";
      LC_NUMERIC = "${extraLocale}";
      LC_PAPER = "${extraLocale}";
      LC_TELEPHONE = "${extraLocale}";
      LC_TIME = "${extraLocale}";
    };
  };

  services = {
    libinput.enable = true;
    pulseaudio.enable = false;
    pipewire.enable = true;
    xserver.xkb = {
      layout = "${xkb.layout}";
      variant = "${xkb.variant}";
    };

  };

  users.users."${username}" = {
    isNormalUser = true;
    description = "${description}";
    extraGroups = groups;
    hashedPasswordFile = config.age.secrets.master.path;
    shell = pkgs."${shell}";
  };

  programs.git = {
    enable = true;
    config.init.defaultBranch = "main";
  };

  system.stateVersion = "25.05";
}
