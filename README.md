# nixconfig

Personal Nix configuration for a regular Linux machine (non-NixOS). Nix is used as
the package manager (via [determinate-nix](https://determinate.systems/)) together
with standalone Home Manager. There is no NixOS host configuration here anymore.

## Requirements

- Determinate Nix (or any Nix with flakes enabled)
- Home Manager (invoked through the flake)

## Usage

```sh
home-manager switch --flake .#benesamaritan
# or
nh home switch
```

Build without activating:

```sh
home-manager build --flake .#benesamaritan
```

## Directory structure

- `flake.nix` — inputs and the `homeConfigurations."benesamaritan"` output.
- `users/<name>/home.nix` — entry point for a user; imports profiles and services.
- `profiles/` — composable Home Manager bundles:
  - `dev/` — shell config, CLI tools, editors (helix, vscode, zed).
  - `personal/` — fonts, CLI tools, browsers (zen, helium), productivity, theming.
  - `work/` — work-specific tools (import currently commented out).
- `services/` — Home Manager user services (ssh-agent, gpg-agent, kdeconnect).
- `secrets.nix` + `secrets/` — agenix-encrypted secrets kept for reference; not
  wired into any active module.

## Theming

Catppuccin (mocha, pink accent) is applied through the `catppuccin` flake.

## Notes

- Dotfiles (wezterm, helix, starship, ...) are linked out-of-store from a separate
  `dotfiles` repository via `mkOutOfStoreSymlink` in `users/benesamaritan/home.nix`.
- `programs.nix-index` uses the prebuilt database from the `nix-index-database`
  flake, so `command-not-found` works without generating a local index.

## Legacy

The previous NixOS configuration (`hosts/`, `modules/`, agenix secrets) is preserved
on the `legacy-nixos` branch.
