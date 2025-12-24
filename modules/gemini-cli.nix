{ pkgs, ... }:

let
  gemini-cli = pkgs.buildNpmPackage rec {
    pname = "gemini-cli";
    version = "0.2.0";
    src = pkgs.fetchFromGitHub {
      owner = "google-gemini";
      repo = "gemini-cli";
      rev = "v${version}";
      hash = "sha256-97OppYbjSavel3Dvlk7Kzdj+4wl+YKvnBkk8TQlsF7s="; 
      # Update hash above on error
    };
    npmDepsHash = "sha256-YpZ6iMq7KUk5EgNh6BRYfzz1RbBO5pkF5Dd5ZL01LeM="; 
    # Update npmDepsHash on error
    dontNpmBuild = true;
  };
in
{
  home.packages = [ gemini-cli ];
  home.shellAliases = {
    gem = "gemini";
  };
}
