{ config, lib, pkgs, ... }:

let
  # opencode's user-mutable config (dotfiles/opencode/opencode.json) references
  # these servers by bare name, so they must be resolvable on PATH. The
  # programs.mcp config below embeds absolute nix-store paths, which the
  # hand-maintained file can't know. The @modelcontextprotocol/servers
  # packages all ship lib/node_modules/.../README.md, so aggregate them into a
  # single env exposing only bin/ to avoid a buildEnv collision.
  mcpBin = pkgs.buildEnv {
    name = "mcp-servers-bin";
    paths = with pkgs; [
      mcp-server-filesystem
      mcp-server-fetch
      mcp-server-memory
      mcp-server-sequential-thinking
      mcp-server-time
      context7-mcp
      github-mcp-server
    ];
    pathsToLink = [ "/bin" ];
  };
in

{
  home.packages = [ mcpBin ];

  programs.mcp = {
    servers = {
      filesystem = {
        command = lib.getExe pkgs.mcp-server-filesystem;
        args = [ "${config.home.homeDirectory}/repos" ];
      };
      fetch.command = lib.getExe pkgs.mcp-server-fetch;
      memory.command = lib.getExe pkgs.mcp-server-memory;
      sequential-thinking.command = lib.getExe pkgs.mcp-server-sequential-thinking;
      time.command = lib.getExe pkgs.mcp-server-time;
      context7.command = lib.getExe pkgs.context7-mcp;
      github = {
        command = lib.getExe pkgs.github-mcp-server;
        args = [ "stdio" ];
        env.GITHUB_PERSONAL_ACCESS_TOKEN.file = config.age.secrets.github-mcp-token.path;
      };
      # devenv project tooling. Runs in the client's cwd (a devenv project).
      devenv = {
        command = lib.getExe pkgs.devenv;
        args = [ "mcp" ];
      };
      # Git history/diff/blame. Scoped to one repo; repeat --repository
      # per repo or point it at a parent checkout as needed.
      # git = {
      #   command = lib.getExe pkgs.mcp-server-git;
      #   args = [
      #     "--repository"
      #     "${config.home.homeDirectory}/repos/benesamaritan/nixconfig"
      #   ];
      # };
    };
  };
}
