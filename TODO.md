# TODO

## Task Priority

### High Priority — Build & Flake

- [] fix manix not able to look up home manager option and exclude nix darwin option search
- [] nixfmt . : Passing directories or non-Nix files (such as ".") is deprecated and will be unsupported soon. Please use the `pkgs.nixfmt-tree` wrapper instead, or https://github.com/numtide/treefmt-nix for more flexibility
- [] nix shell : error: flake 'git+file:///home/benesamaritan/repos/benesamaritan/nixconfig' does not provide attribute 'packages.x86_64-linux.default' or 'defaultPackage.x86_64-linux'
- [] Add missing flake outputs: `packages.x86_64-linux.default`, `devShells`, `checks` (flake.nix outputs section)

### High Priority — Development Environment

- [] verify kanata starts at login after a reboot (`systemctl --user is-active kanata`; unit is enabled, config symlinked, runs unprivileged via session ACLs)
- [] find a way to enter isolated shell (nix develop, devbox shell, devenv shell) when no internet available
    - ❯ devbox shell
        Starting a devbox shell...
        bash: hash: hashing disabled
        bash: 1772223139426252 - : arithmetic syntax error: operand expected (error token is "- ")
    - ❯ devenv shell
        ✓ Configuring shell
          └ ✗ Evaluating shell 1086 files
            └ ✓ Querying  devenv-shell from cache.nixos.org
        Error:   × Evaluation error: Failed to realize shell derivation: warning: error: unable to download 'https://
          │ cache.nixos.org/ii4qmrgm0vkl3z7rnb9ilyx55xhv693f.narinfo': Could not connect to server (7) Failed to connect to
          │ cache.nixos.org port 443 after 25 ms: Could not connect to server; retrying in 2602 ms: error: unable to
          │ download 'https://cache.nixos.org/ii4qmrgm0vkl3z7rnb9ilyx55xhv693f.narinfo': Could not connect to server (7)
          │ Failed to connect to cache.nixos.org port 443 after 27 ms: Could not connect to server
    - ❯ nix develop
        warning: Git tree '/home/benesamaritan/repos/benesamaritan/nixconfig' is dirty
        evaluation warning: lib.cli.toGNUCommandLineShell is deprecated, please use lib.cli.toCommandLineShell or lib.cli.toCommandLineShellGNU instead.
        evaluation warning: lib.cli.toGNUCommandLine is deprecated, please use lib.cli.toCommandLine or lib.cli.toCommandLineShellGNU instead.
        warning: error: unable to download 'https://devenv.cachix.org/igs4gm4zi3sfydbl9216f0kb1mgsk5r0.narinfo': Could not connect to server (7) Failed to connect to devenv.cachix.org port 443 after 317 ms: Could not connect to server; retrying in 295 ms
        warning: error: unable to download 'https://devenv.cachix.org/igs4gm4zi3sfydbl9216f0kb1mgsk5r0.narinfo': Could not connect to server (7) Failed to connect to devenv.cachix.org port 443 after 83 ms: Could not connect to server; retrying in 536 ms
        warning: error: unable to download 'https://devenv.cachix.org/igs4gm4zi3sfydbl9216f0kb1mgsk5r0.narinfo': Could not connect to server (7) Failed to connect to devenv.cachix.org port 443 after 87 ms: Could not connect to server; retrying in 1029 ms
        warning: error: unable to download 'https://devenv.cachix.org/igs4gm4zi3sfydbl9216f0kb1mgsk5r0.narinfo': Could not connect to server (7) Failed to connect to devenv.cachix.org port 443 after 78 ms: Could not connect to server; retrying in 2503 ms
        error: unable to download 'https://devenv.cachix.org/igs4gm4zi3sfydbl9216f0kb1mgsk5r0.narinfo': Could not connect to server (7) Failed to connect to devenv.cachix.org port 443 after 86 ms: Could not connect to server

### Medium Priority — Tooling Integration

- [] better integration of treefmt-nix in favor of nixfmt / nixfmt-tree
- [] better integration of devenv (including LSP, linter, debugger, etc) so that it could be imported on another project (need to evaluate template provided by devenv)

### Medium Priority — Modularity & Configuration

- [] Modularize `services/user.nix` into component services (ssh-agent, kdeconnect, gpg-agent)
- [] Extract shared configuration patterns into reusable modules across profiles
- [] Add `systems` attribute to flake for cross-platform support (consider `flake-utils`)
- [] Add `direnv` integration with `.envrc` for automatic shell setup
- [] Review redundancy between `profiles/dev/tools.nix` and `profiles/personal/tools.nix`

### Low Priority

- [] better shell aliases
- [] declare firefox extensions and zen browser mods for zen browser (browser.nix)
- [] adopt code architecture
- [] fix wezterm config (separate repo) to enable zoom (text) without zooming (resize) terminal window
- [] create module for beginner user (using kde, flatpak, and gui oriented)

### Future Plans

- [] multi-user support: one `homeConfigurations.<name>` per user, generated
  from `users/` (groundwork done: `username` is already threaded from
  `flake.nix` via `extraSpecialArgs`). Still per-user: `age.identityPaths` +
  agenix recipients/secrets, git identity (still hardcoded), `home.homeDirectory`
- [] multi-machine support: per-host overrides for machine-specific bits (GPU
  vendor for `targets.genericLinux.gpu`, monitors/peripherals, host-only
  packages and services). Keep the shared config in `profiles/`; select
  `hosts/<name>/` differences by hostname so a fresh machine is still one
  `home-manager switch`
- [] Create setup guide (`CONTRIBUTING.md` or `SETUP.md`) for new machine setup
- [] Add CI/CD pipeline (GitHub Actions) with flake build/check validation
- [] Add `nix-update` or `nixpkgs-fmt` automation for dependency tracking
- [] Implement age key rotation schedule and secret validation
- [] Document secret recovery process for agenix

### Unsolvable

- [] evaluation warning: The xorg package set has been deprecated, 'xorg.libxcb' has been renamed to 'libxcb'
- [] evaluation warning: lib.cli.toGNUCommandLine is deprecated, please use lib.cli.toCommandLine or lib.cli.toCommandLineShellGNU instead.

## Done

- [x] create per-host configuration
- [x] create per-user configuration
- [x] clean up and remove unused modules (wm.nix)
- [x] fix command-not-found: use the nix-index-database flake for a prebuilt database
- [x] consolidate remaining tools into profiles
- [x] remove dead, empty, unused, redundant or not imported nix files
- [x] auto-import profile/service modules and restore orphaned `languages.nix` + `formatting.nix` (LSP servers/formatters)
- [x] caching for future build (binary substituters in flake nixConfig)

## References:

- NixOS Options
- Home Manager Appendix (https://nix-community.github.io/home-manager/options.xhtml)
- https://github.com/0xc000022070/zen-browser-flake
- https://github.com/fufexan/nix-gaming
- https://danklinux.com/docs/dankmaterialshell/nixos-flake
- https://github.com/numtide/treefmt-nix (formatting recommendation)
- https://github.com/nix-community/nixpkgs-fmt (formatting alternative)