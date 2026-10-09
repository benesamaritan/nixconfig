{
  lib,
  pkgs,
  ...
}:

{
  programs = {
    # VSCodium reads MCP from a dedicated mcp.json (not settings.json).
    # enableMcpIntegration merges the shared declaration into it; secret
    # file-refs are wrapped so the token is read at startup, never stored.
    # Needs an AI agent extension (e.g. Copilot Chat) to do anything with them.
    vscodium = {
      enable = true;
      profiles.default = {
        enableMcpIntegration = true;
        extensions = pkgs.nix4vscode.forOpenVsx [
          # Pairs with opencode CLI 1.x. Uses the same opencode.json + skills
          # dir, so MCP/skills parity is automatic. If it cannot find the
          # binary, point the extension at the nix store path explicitly.
          "sst-dev.opencode-v2"
        ];
      };
    };
    helix = {
      enable = true;
      # Editor behavior migrated from the (now inactive) dotfiles/helix
      # config.toml. Theme stays catppuccin-mocha via the catppuccin module.
      settings.editor = {
        auto-format = true;
        line-number = "relative";
        mouse = true;
        true-color = true;
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        file-picker = {
          hidden = true;
          max-depth = 10;
        };
        soft-wrap = {
          enable = true;
          max-wrap = 20;
        };
        smart-tab.enable = false;
        statusline = {
          left = [ "mode" "spinner" ];
          center = [ "file-name" ];
          right = [ "diagnostics" "selections" "position" "file-type" ];
          separator = "│";
          mode = {
            normal = "NOR";
            insert = "INS";
            select = "SEL";
          };
          diagnostics = [ "warning" "error" ];
          workspace-diagnostics = [ "warning" "error" ];
        };
        whitespace.render = {
          space = "all";
          tab = "all";
          nbsp = "all";
          nnbsp = "none";
          tabpad = "all";
          newline = "none";
        };
        whitespace.characters = {
          space = "_";
          nbsp = "⍽";
          nnbsp = "␣";
          tab = "→";
          tabpad = "·";
        };
        indent-guides = {
          render = true;
          character = "▏";
          skip-levels = 1;
        };
        gutters.layout = [ "diff" "diagnostics" "line-numbers" "spacer" ];
      };
      # Pin each language to its nix-provided server (stable store paths,
      # no reliance on helix built-in defaults).
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
            formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
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
      enable = true;
      defaultEditor = true;
      enableMcpIntegration = true;
      # OpenCode as an in-editor ACP agent. Same binary and config as the
      # terminal (opencode.json, skills dir), so MCP/skills parity is
      # automatic. Start via the Agent Panel / new-thread menu.
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
#         "caddyfile"
#         "dockerfile"

        "html"
        "emmet"
        "scss"
        "php"
        "sql"
        "blade"
        "laravel"
        "astro"
#         "robots-txt"
#         "templ"
#         "twig"
#         "less"
        "codebook"
#         "graphql"
        "tsgo"
#         "color-highlight"
#         "design-tokens"
        "mdx"
#         "live-server"
#         "npm-package-json-checker"
      ];
    };
  };
}
