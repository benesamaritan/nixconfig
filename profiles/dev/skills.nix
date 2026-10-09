{ lib, pkgs, ... }:

let
  # Curated, process-oriented engineering skills (spec → plan → build →
  # verify → review → ship). Pinned; bump rev+hash to update.
  addyosmani-skills =
    (pkgs.fetchFromGitHub {
      owner = "addyosmani";
      repo = "agent-skills";
      rev = "1401c8b8030e023baeebb31781a6653fe8e93026";
      hash = "sha256-eeldNNDQjP/Uk/BIRo33Q/xzCdPV3kGRGqU3XyQZnFY=";
    })
    + "/skills";

  # Personal skills vendored in ./skills/ (e.g. 9router, sourced from
  # https://github.com/decolua/9router). Names must not collide with the
  # collection above.
  local-skills = ./skills;

  # One attrset entry per skill folder. NOTE: do not pass a derivation
  # (e.g. symlinkJoin) directly — the `either attrs path` option type
  # descends into derivations as attrsets and chokes on stdenv's internal
  # __ignoreNulls attribute. Plain paths are accepted.
  fromDir =
    dir:
    lib.mapAttrs' (name: _: lib.nameValuePair name (dir + "/${name}")) (
      lib.filterAttrs (_: type: type == "directory") (builtins.readDir dir)
    );

  all-skills = fromDir addyosmani-skills // fromDir local-skills;
in
{
  programs.opencode.skills = all-skills;
  programs.antigravity-cli.skills = all-skills;
}
