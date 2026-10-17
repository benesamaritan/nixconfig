{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    marksman                    # Markdown
    taplo                       # TOML, and Cross-Config
    lua-language-server         # Lua
    nil                         # Nix
    intelephense                # PHP, WordPress, Laravel
    typescript-language-server  # JavaScript, TypeScript, React
    astro-language-server       # Astro (formats via LSP)
    gopls                       # Go (formats via LSP)
    tailwindcss-language-server # Tailwind CSS (activates on projects with a tailwind config)
  ];
}