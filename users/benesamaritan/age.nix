{ config, pkgs, ... }:

{
  nix.package = pkgs.nix;

  age = {
    identityPaths = [ "${config.home.homeDirectory}/.ssh/id_age" ];
    secrets.github-token = {
      file = ../../secrets/github-token.age;
      path = "${config.home.homeDirectory}/.config/agenix/github-token";
    };
    secrets.github-mcp-token = {
      file = ../../secrets/github-mcp-token.age;
      path = "${config.home.homeDirectory}/.config/agenix/github-mcp-token";
    };
    secrets.omniroute-key = {
      file = ../../secrets/omniroute-key.age;
      path = "${config.home.homeDirectory}/.config/agenix/omniroute-key";
    };
    secrets.trilium-mcp-token = {
      file = ../../secrets/trilium-mcp-token.age;
      path = "${config.home.homeDirectory}/.config/agenix/trilium-mcp-token";
    };
  };

  nix.extraOptions = "!include ${config.age.secrets.github-token.path}";
  nix.checkConfig = false;
}
