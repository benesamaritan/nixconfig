{ pkgs, ... }:

let
  gemini-cli = pkgs.buildNpmPackage rec {
    pname = "gemini-cli";
    version = "0.2.0";
    src = pkgs.fetchFromGitHub {
      owner = "google-gemini";
      repo = "gemini-cli";
      rev = "v${version}";
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Update this on error
    };
    npmDepsHash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB="; # Update this on error
    dontNpmBuild = true;
  };
in
{
  home.packages = [ gemini-cli ];
  
  # Optional: A shorter alias if you prefer
  home.shellAliases = {
    gem = "gemini";
  };
}
