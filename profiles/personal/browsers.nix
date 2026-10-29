{
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
    flags = [
      "--ozone-platform-hint=auto"
      "--start-maximized"
      "--remote-debugging-port=9222"
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
