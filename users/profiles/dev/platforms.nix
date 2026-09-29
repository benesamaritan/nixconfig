{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # cachix
    opencode                 # AI Agent on terminal
    hub                      # GitHub CLI wrapper
    publii                   # Static Site CMS
    surge-cli                # Surge.sh CDN CLI
  ];

  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-dash
    ];
    settings = {
      git_protocol = "ssh";
    };
  };

  programs.antigravity-cli = {
    enable = true;
    settings = {
      context.fileName = [
        "AGENTS.md" 
        "CONTEXT.md" 
        "GEMINI.md" 
        "CLAUDE.md"
      ];
    };
  };
}
