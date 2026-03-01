{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    inputs.devenv.packages.${pkgs.stdenv.hostPlatform.system}.default
    cachix
    devbox
    opencode                 # AI Agent on terminal
    gemini-cli
    # copilot-cli
    hub                      # GitHub CLI wrapper
    publii                   # Static Site CMS
    h                        # Fast project navigation
    surge-cli                # Surge.sh CDN CLI
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      eval "$(h --setup ~/repo)"
      eval "$(devbox global shellenv --init-hook)"
    '';
  };

  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-dash
    ];
    settings = {
      git_protocol = "ssh";
    };
  };
}
