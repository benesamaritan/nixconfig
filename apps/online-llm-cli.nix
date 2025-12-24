{ pkgs, inputs, ... }:

{
  programs.gh = {
    enable = true;
    extensions = [ pkgs.gh-copilot ];
    settings = {
      git_protocol = "ssh";
      aliases = {
        co = "copilot";
        ce = "copilot explain";
        cs = "copilot suggest";
      };
    };
  };
  home.packages = [ 
    pkgs.gemini-cli
    inputs.opencode.packages.${pkgs.system}.default
  ];
  home.shellAliases = {
    gem = "gemini";
  };
}
