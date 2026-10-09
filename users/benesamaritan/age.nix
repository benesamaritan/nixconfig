{ config, pkgs, ... }:

{
  # Required to generate nix.conf (used only for build-time validation, not
  # installed into the profile — Determinate Nix remains the active nix).
  nix.package = pkgs.nix;

  age = {
    # Decrypt with the passphrase-less machine key so activation and the
    # login-time agenix user service work unattended.
    identityPaths = [ "${config.home.homeDirectory}/.ssh/id_age" ];
    secrets.github-token = {
      file = ../../secrets/github-token.age;
      # Persistent location: the default is $XDG_RUNTIME_DIR/agenix/..., which
      # nix would not expand inside !include. The symlink target is refreshed
      # at every activation and login (agenix user service).
      path = "${config.home.homeDirectory}/.config/agenix/github-token";
    };
    # Raw API key for the 9router opencode provider, referenced from
    # programs.opencode.settings via {file:…} so it never lands in the store.
    secrets.nine-router-key = {
      file = ../../secrets/opencode-9router-key.age;
      path = "${config.home.homeDirectory}/.config/agenix/opencode-9router-key";
    };
  };

  # The token file must stay out of the nix store, so reference the decrypted
  # secret with !include instead of nix.settings. The include target does not
  # exist at build time, so skip Home Manager's config validation.
  nix.extraOptions = "!include ${config.age.secrets.github-token.path}";
  nix.checkConfig = false;
}
