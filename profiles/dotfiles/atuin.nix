{ ... }:
{
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    daemon.enable = true;
    settings = {
      style = "compact";
      show-preview = true;
      exit-mode = "return-original";
      enter-accept = true;
      theme = {
        name = "catppuccin-mocha-pink";
      };
      search = {
        filters = [ "global" "host" "session" "session-preload" "workspace" "directory" ];
      };
      sync = {
        records = true;
      };
    };
  };
}
