{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    hub                      # GitHub CLI wrapper (no Home Manager module)
  ];

  programs.opencode.enable = true; # AI Agent on terminal

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
