{ pkgs, ... }:

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
}
