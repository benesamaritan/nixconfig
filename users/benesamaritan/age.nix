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
    # Raw GitHub token for the github MCP server (the github-token secret
    # above wraps it in nix.conf syntax, which the server cannot parse).
    secrets.github-mcp-token = {
      file = ../../secrets/github-mcp-token.age;
      path = "${config.home.homeDirectory}/.config/agenix/github-mcp-token";
    };
    # OmniRoute API key (localhost:20128), referenced from the user's
    # ~/.config/opencode/opencode.jsonc via {file:…} so it never lands in git
    # or in plaintext on disk.
    secrets.omniroute-key = {
      file = ../../secrets/omniroute-key.age;
      path = "${config.home.homeDirectory}/.config/agenix/omniroute-key";
    };
  };

  # The token file must stay out of the nix store, so reference the decrypted
  # secret with !include instead of nix.settings. The include target does not
  # exist at build time, so skip Home Manager's config validation.
  nix.extraOptions = "!include ${config.age.secrets.github-token.path}";
  nix.checkConfig = false;
}
