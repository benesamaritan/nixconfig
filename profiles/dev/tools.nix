{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # bruno                  # API testing tool
    koji                     # Interactive CLI for conventional commit
    tokei                    # Count LoC
    glow                     # Render MD on terminal
    # dbeaver

    # Language servers (no Home Manager modules; wired per editor in editors.nix)
    marksman                 # Markdown
    taplo                    # TOML, and Cross-Config
    lua-language-server      # Lua
    nil                      # Nix
    intelephense             # PHP, WordPress, Laravel (formats via LSP; premium licence optional)
    typescript-language-server # JavaScript, TypeScript, React (formats via LSP)
    astro-language-server    # Astro (formats via LSP)
    gopls                    # Go (formats via LSP)
    tailwindcss-language-server # Tailwind CSS (activates on projects with a tailwind config)

    # Formatters and linters (helix auto-format uses these where the LSP can't)
    nixfmt-rfc-style         # Nix (helix formatter)
    stylua                   # Lua (helix formatter)
    prettier                 # Markdown (helix formatter) + JS/TS/Astro fallback
    biome                    # JS/TS lint + format CLI
    blade-formatter          # Laravel Blade templates (CLI)

    # Nix tools (no Home Manager modules)
    manix                     # search nix options
    nix-tree                  # dependencies tree on nix store
    nix-bash-completions
    nix-health

    # Platforms (no nixpkgs vercel CLI; use npm i -g vercel per project)
    lazydocker               # Docker TUI (matches the lzd alias)
    cloudflared              # Cloudflare tunnels and DNS
    wrangler                 # Cloudflare Workers

    # Database CLIs (lazysql already covers interactive TUI use)
    mycli                    # MySQL/MariaDB
    pgcli                    # PostgreSQL
    sqlite                   # SQLite

    # Downloads and archives
    wget
    curl
    aria2
    unzip
    unrar

    # Theming assets
    papirus-icon-theme
  ];

  programs = {
    yazi = {
      enable = true;         # File Manager for terminal
      shellWrapperName = "y";
    };
    lazygit.enable = true;
    lazysql.enable = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      eval "$(atuin init bash)"
      eval "$(starship init bash)"
      export GPG_TTY=$(tty)
    '';
  };

  programs = {
    direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
    };
    devenv = {
      enable = true;
      enableBashIntegration = true;
    };
  };

  programs = {
    nh = {
      enable = true;
      clean.enable = true;
    };
    nix-index = {
      enable = true;
      enableBashIntegration = true;
    };
    nix-index-database.comma.enable = true;
  };
}
