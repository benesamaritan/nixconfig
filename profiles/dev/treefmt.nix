{ pkgs, ... }:

{
  # programs.treefmt = {
  #   enable = true;
  #   projectRootFile = "flake.nix"; # or any other root file
    
  #   programs = {
  #     nixpkgs-fmt.enable = true;
  #     gofmt.enable = true;
  #     prettier.enable = true;
  #   };
    
  #   # Custom configuration for php-cs-fixer
  #   settings.formatter.php-cs-fixer = {
  #     command = "${pkgs.php83Packages.php-cs-fixer}/bin/php-cs-fixer";
  #     options = [ "fix" ];
  #     includes = [ "*.php" ];
  #   };
  # };
}
