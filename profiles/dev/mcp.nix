{ config, lib, pkgs, ... }:

{
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
