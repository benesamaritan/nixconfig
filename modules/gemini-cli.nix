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
    npmDepsHash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB="; 
    # Update this on error
    dontNpmBuild = true;
  };
in
{
  home.packages = [ gemini-cli ];
  home.shellAliases = {
    gem = "gemini";
  };
}
