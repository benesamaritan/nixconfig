{ config, lib, pkgs, ... }:

{
  # Model Context Protocol servers, written to ~/.config/mcp/mcp.json for
  # MCP-capable clients (opencode, zed, …). All servers below are free,
  # keyless, and ship as nixpkgs packages (pinned store paths — no npx,
  # no first-run downloads).
  programs.mcp = {
    enable = true;
    servers = {
      # Scoped file access (read/write/search) under ~/repositories.
      filesystem = {
        command = lib.getExe pkgs.mcp-server-filesystem;
        args = [ "${config.home.homeDirectory}/repositories" ];
      };
      # Fetch URLs and extract page content as markdown.
      fetch.command = lib.getExe pkgs.mcp-server-fetch;
      # Persistent knowledge-graph memory across sessions.
      memory.command = lib.getExe pkgs.mcp-server-memory;
      # Structured step-by-step reasoning.
      sequential-thinking.command = lib.getExe pkgs.mcp-server-sequential-thinking;
      # Current time and timezone conversion (uses system timezone).
      time.command = lib.getExe pkgs.mcp-server-time;
      # Git history/diff/blame. Scoped to one repo; repeat --repository
      # per repo or point it at a parent checkout as needed.
      # git = {
      #   command = lib.getExe pkgs.mcp-server-git;
      #   args = [
      #     "--repository"
      #     "${config.home.homeDirectory}/repositories/github/benesamaritan/nixconfig"
      #   ];
      # };
    };
  };
}
