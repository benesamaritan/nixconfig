# TODO

## Task Priority

### High Priority

- [] fix manix not able to look up home manager option and exclude nix darwin option search
- [] fix command-not-found: Missing package database in flake setup using either nix-index or nix-index-database
- [] nixfmt . : Passing directories or non-Nix files (such as ".") is deprecated and will be unsupported soon. Please use the `pkgs.nixfmt-tree` wrapper instead, or https://github.com/numtide/treefmt-nix for more flexibility
- [] nix shell : error: flake 'git+file:///home/bye/repo/github.com/benesamaritan/nixconfig' does not provide attribute 'packages.x86_64-linux.default' or 'defaultPackage.x86_64-linux'

### Medium Priority

- [] consolidate apps/* and packages/* that are compatible with home-manager to /profiles/{core,personal,work} and which aren't (nixos only) on modules/
- [] remove bloat (exlude unused pre-installed packages: top, sh, nano, ...)
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
        warning: Git tree '/home/bye/repo/github.com/benesamaritan/nixconfig' is dirty
        evaluation warning: lib.cli.toGNUCommandLineShell is deprecated, please use lib.cli.toCommandLineShell or lib.cli.toCommandLineShellGNU instead.
        evaluation warning: lib.cli.toGNUCommandLine is deprecated, please use lib.cli.toCommandLine or lib.cli.toCommandLineShellGNU instead.
        warning: error: unable to download 'https://devenv.cachix.org/igs4gm4zi3sfydbl9216f0kb1mgsk5r0.narinfo': Could not connect to server (7) Failed to connect to devenv.cachix.org port 443 after 317 ms: Could not connect to server; retrying in 295 ms
        warning: error: unable to download 'https://devenv.cachix.org/igs4gm4zi3sfydbl9216f0kb1mgsk5r0.narinfo': Could not connect to server (7) Failed to connect to devenv.cachix.org port 443 after 83 ms: Could not connect to server; retrying in 536 ms
        warning: error: unable to download 'https://devenv.cachix.org/igs4gm4zi3sfydbl9216f0kb1mgsk5r0.narinfo': Could not connect to server (7) Failed to connect to devenv.cachix.org port 443 after 87 ms: Could not connect to server; retrying in 1029 ms
        warning: error: unable to download 'https://devenv.cachix.org/igs4gm4zi3sfydbl9216f0kb1mgsk5r0.narinfo': Could not connect to server (7) Failed to connect to devenv.cachix.org port 443 after 78 ms: Could not connect to server; retrying in 2503 ms
        error: unable to download 'https://devenv.cachix.org/igs4gm4zi3sfydbl9216f0kb1mgsk5r0.narinfo': Could not connect to server (7) Failed to connect to devenv.cachix.org port 443 after 86 ms: Could not connect to server
- [] better integration of treefmt-nix in favor of nixfmt (on system-lv.nix) or nixfmt-tree
- [] better integration of devenv (including LSP, linter, debugger, etc) in favor of devShell configuration on flake.nix so that it could be imported on another project (need to evaluate template provided by devenv)
- [] fix hub not able to login
- [] fix steam not able to return to desktop (if logged in from login manager, greetd or sddm, etc)
- [] remove dead, empty, unused, redundant or not imported nix files
- [] caching for future build

### Low Priority

- [] hide [ble: ...] messages
- [] evaluate why there's a complete suite of plasma workspace if using xdg-desktop-portal-kde
- [] add puc keys to repo
- [] better shell aliases
- [] declare firefox extensions and zen browser mods for zen browser (browser.nix)
- [] migrate dms from nixosModule to homeModule
- [] integrate nix webapp flake in favor of web-apps.nix
- [] integrate nix gaming flake in favor of gaming.nix
- [] integrate affinity nix flake in favor of graphics.nix
- [] integrate vm nix flake in favor of virtualization.nix
- [] adopt code architecture
- [] fix wezterm config (separate repo) to enable zoom (text) without zooming (resize) terminal window
- [] create module for beginner user (using kde, flatpak, and gui oriented)

### Unsolvable

- [] evaluation warning: The xorg package set has been deprecated, 'xorg.libxcb' has been renamed to 'libxcb'
- [] evaluation warning: lib.cli.toGNUCommandLine is deprecated, please use lib.cli.toCommandLine or lib.cli.toCommandLineShellGNU instead.

## Done

- [x] create per-host configuration
- [x] create per-user configuration
- [x] clean up and remove unused modules (wm.nix)

## References:

- NixOS Options
- Home Manager Appendix (https://nix-community.github.io/home-manager/options.xhtml)
- https://github.com/0xc000022070/zen-browser-flake
- https://github.com/fufexan/nix-gaming
- https://danklinux.com/docs/dankmaterialshell/nixos-flake
