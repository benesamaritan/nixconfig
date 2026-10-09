{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ 
    inputs.zen-browser.homeModules.twilight 
    inputs.helium-flake.homeModules.default
  ];
  
  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [ pkgs.firefoxpwa ];
    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
  };

  programs.helium = {
    enable = true;
    flags = [
      "--ozone-platform-hint=auto"
      "--start-maximized"
    ];
    policies = {
      "BrowserSignin" = 0;
      "SyncDisabled" = true;
      "PasswordManagerEnabled" = false;
      "DefaultSearchProviderEnabled" = true;
      "ExtensionInstallForcelist" = [
        "mkgjnlllemldgamnbcgemcecicgmeaid"            # Chrome Webvine
        "cjpalhdlnbpafiamejdnhcphjbkeiagm"            # Ublock Origin
        "kghbmcgihmefcbjlfiafjcigdcbmecbf"            # heylogin
      ];
    };
  };
}
