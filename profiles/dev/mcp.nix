{
  config,
  lib,
  pkgs,
  pkgs-stable,
  inputs,
  ...
}:

let
  # opencode's user-mutable config (dotfiles/opencode/opencode.json) references
  # these servers by bare name, so they must be resolvable on PATH. The
  # programs.mcp config below embeds absolute nix-store paths, which the
  # hand-maintained file can't know. The @modelcontextprotocol/servers
  # packages all ship lib/node_modules/.../README.md, so aggregate them into a
  # single env exposing only bin/ to avoid a buildEnv collision.
  mcpBin = pkgs.buildEnv {
    name = "mcp-servers-bin";
    paths = [
      pkgs-stable.mcp-server-filesystem
      pkgs-stable.mcp-server-fetch
      pkgs-stable.mcp-server-memory
      pkgs-stable.mcp-server-sequential-thinking
      pkgs-stable.mcp-server-time
      pkgs-stable.mcp-server-git
      pkgs.github-mcp-server
      pkgs.context7-mcp
      pkgs.bun
    ];
    pathsToLink = [ "/bin" ];
  };
in

{
  home.packages = [ mcpBin ];

  programs.mcp = {
    servers = {
      filesystem = {
        command = lib.getExe pkgs-stable.mcp-server-filesystem;
        args = [ "${config.home.homeDirectory}/repos" ];
      };
      fetch.command = lib.getExe pkgs-stable.mcp-server-fetch;
      memory.command = lib.getExe pkgs-stable.mcp-server-memory;
      sequential-thinking.command = lib.getExe pkgs-stable.mcp-server-sequential-thinking;
      time.command = lib.getExe pkgs-stable.mcp-server-time;
      context7.command = lib.getExe pkgs.context7-mcp;
      github = {
        command = lib.getExe pkgs.github-mcp-server;
        args = [ "stdio" ];
        env.GITHUB_PERSONAL_ACCESS_TOKEN.file = config.age.secrets.github-mcp-token.path;
      };
      devenv = {
        command = lib.getExe pkgs.devenv;
        args = [ "mcp" ];
      };
      chromedevtools = {
        command = "${pkgs.bun}/bin/bunx";
        args = [ "-y" "chrome-devtools-mcp@latest" ];
        env.CHROME_PATH = "${inputs.helium-flake.packages.x86_64-linux.helium}/bin/helium";
        env.CHROME_DEBUG_PORT = "9222";
      };
      codegraph = {
        command = "${pkgs.bun}/bin/bunx";
        args = [ "@colbymchenry/codegraph" "serve" "--mcp" ];
      };

      # jscpd = {
      #   command = "${pkgs.bun}/bin/bunx";
      #   args = [ "jscpd" "--mcp" ];
      # };
      # dbx = {
      #   command = "${pkgs.bun}/bin/bunx";
      #   args = [ "-y" "@dbx-app/mcp-server" ];
      # };
    };
  };
}
