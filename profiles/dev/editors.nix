{
  pkgs,
  config,
  ...
}:

{
  programs.mcp = {
    enable = true;
    servers = {
      filesystem = {
        command = "npx";
        args = [
          "-y"
          "@modelcontextprotocol/server-filesystem"
          "/home/benesamaritan/repositories"
        ];
      };
    };
  };
  programs = {
    helix.enable = true;
    vscodium.enable = true;
    zed-editor = {
      enable = true;
      defaultEditor = true;
      enableMcpIntegration = true;
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
