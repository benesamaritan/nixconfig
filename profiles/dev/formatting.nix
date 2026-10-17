{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    pkgs.nixfmt           # Nix (helix formatter)
    stylua                # Lua (helix formatter)
    prettier              # Markdown (helix formatter) + JS/TS/Astro fallback
    biome                 # JS/TS lint + format CLI
    blade-formatter       # Laravel Blade templates (CLI)
  ];
}
