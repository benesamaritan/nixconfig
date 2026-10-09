{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    opencode                 # AI Agent on terminal
    hub                      # GitHub CLI wrapper
  ];

  programs.gh = {
    enable = false;
    extensions = pkgs.gh-dash;
    settings.git_protocol = "ssh";
  };

  programs.antigravity-cli = {
    enable = true;
    settings = {
      context.fileName = [
        "AGENTS.md" 
        "GEMINI.md" 
        "CLAUDE.md"
      ];
    };
  };
}
