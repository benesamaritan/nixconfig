{
  lib,
  pkgs,
  ...
}:

{
  programs = {
    helix = {
      defaultEditor = true;
      languages = {
        language-server = {
          nil.command = lib.getExe pkgs.nil;
          marksman = {
            command = lib.getExe pkgs.marksman;
            args = [ "server" ];
          };
          taplo = {
            command = lib.getExe pkgs.taplo;
            args = [ "lsp" "stdio" ];
          };
          lua-language-server.command = lib.getExe pkgs.lua-language-server;
          intelephense.command = lib.getExe pkgs.intelephense;
          typescript-language-server = {
            command = lib.getExe pkgs.typescript-language-server;
            args = [ "--stdio" ];
          };
          astro-ls = {
            # Binary is astro-ls, not astro-language-server.
            command = "${pkgs.astro-language-server}/bin/astro-ls";
            args = [ "--stdio" ];
          };
          gopls.command = lib.getExe pkgs.gopls;
          tailwindcss-ls = {
            command = lib.getExe pkgs.tailwindcss-language-server;
            args = [ "--stdio" ];
          };
        };
        language = [
          {
            name = "nix";
            language-servers = [ "nil" ];
            formatter.command = lib.getExe pkgs.nixfmt;
          }
          {
            name = "markdown";
            language-servers = [ "marksman" ];
            formatter = {
              command = lib.getExe pkgs.prettier;
              args = [ "--parser" "markdown" ];
            };
          }
          {
            name = "toml";
            language-servers = [ "taplo" ];
          }
          {
            name = "lua";
            language-servers = [ "lua-language-server" ];
            formatter = {
              command = lib.getExe pkgs.stylua;
              args = [ "-" ];
            };
          }
          {
            name = "php";
            language-servers = [ "intelephense" ];
          }
          {
            name = "javascript";
            language-servers = [ "typescript-language-server" "tailwindcss-ls" ];
          }
          {
            name = "jsx";
            language-servers = [ "typescript-language-server" "tailwindcss-ls" ];
          }
          {
            name = "typescript";
            language-servers = [ "typescript-language-server" "tailwindcss-ls" ];
          }
          {
            name = "tsx";
            language-servers = [ "typescript-language-server" "tailwindcss-ls" ];
          }
          {
            name = "astro";
            language-servers = [ "astro-ls" "tailwindcss-ls" ];
          }
          {
            name = "go";
            language-servers = [ "gopls" ];
          }
        ];
      };
    };
    zed-editor = {
      defaultEditor = false;
      enableMcpIntegration = true;
      mutableUserSettings = true;
      userSettings.agent_servers.OpenCode = {
        command = lib.getExe pkgs.opencode;
        args = [ "acp" ];
        type = "custom";
      };
      extensions = [
        "catppuccin-blur"
        "catppuccin-icons"
        "emoji-completions"

        "nix"
        "github-actions"
        "lua"
        "emmylua"
        "toml"
        "tombi"
        "git-firefly"
        "make"
        "env"
        "caddyfile"
        "dockerfile"

        "html"
        "emmet"
        "scss"
        "php"
        "sql"
        "blade"
        "laravel"
        "astro"
        "robots-txt"
        "templ"
        "twig"
        "less"
        "codebook"
        "graphql"
        "tsgo"
        "color-highlight"
        "design-tokens"
        "mdx"
      ];
    };
    vscodium = {
      profiles.default = {
        enableMcpIntegration = true;
        mutableUserSettings = true;
        extensions = pkgs.nix4vscode.forOpenVsx [
          "sst-dev.opencode-v2"
        ];
      };
    };
  };
}
