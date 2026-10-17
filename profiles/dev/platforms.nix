{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    hub
    gh
  ];

  # opencode settings are intentionally not declared here: its config is
  # user-mutable (out-of-store link to dotfiles/opencode/opencode.json, wired
  # in users/benesamaritan/dotfiles.nix). This module still manages its skills
  # dir.
  programs.antigravity-cli = {
    enableMcpIntegration = true; # merge programs.mcp.servers into antigravity
    settings = {
      context.fileName = [
        "AGENTS.md"
        "GEMINI.md"
        "CLAUDE.md"
      ];
    };
  };
}
