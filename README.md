# NixOS Configuration with Flakes and Home-Manager

This is a modular NixOS configuration using Nix flakes and home-manager in standalone mode. It manages both system-level (NixOS) and user-level (home-manager) configurations for a reproducible, declarative Linux environment.

## Features
- **Flake-based**: Leverages Nix flakes for reproducible builds and dependency management.
- **Modular Structure**: Organized into `modules/` (system modules), `apps/` (user applications), and `packages/` (system packages) for easy maintenance.
- **Custom Inputs**: Includes bleeding-edge software like niri (Wayland compositor), zen-browser, and theming with catppuccin.
- **Standalone Home-Manager**: User configs are managed separately from NixOS for flexibility.
- **Theming**: Consistent catppuccin theme across system and applications.

## Directory Structure
- `flake.nix`: Main flake definition with inputs and outputs.
- `hosts/`: Per-host configurations (e.g., `hosts/sol/configuration.nix`).
- `users/`: Per-user Home Manager configurations (e.g., `users/bye/home.nix`).
- `modules/`: System-level modules (e.g., fonts, printing, virtualization, niri WM).
- `apps/`: User applications and tools (e.g., GUIs, CLIs, web apps).
- `packages/`: System modules for packages (e.g., gaming, syncthing, kanata).
- `flake.lock`: Locked flake dependencies.

## Installation and Setup
1. **Prerequisites**: Ensure Nix is installed with flakes enabled (`nix.settings.experimental-features = ["nix-command" "flakes"]`).
2. **Clone and Build**:
   ```bash
   git clone <this-repo>
   cd nixconfig
   sudo nixos-rebuild switch --flake .#sol  # For system config
   home-manager switch --flake .#bye        # For user config
   ```
3. **Update**: Run `nix flake update` to refresh inputs, then rebuild.
4. **Secrets**: Sensitive data (e.g., passwords) should use agenix or sops-nix instead of hardcoding.

## Usage
- **Rebuild System**: `sudo nixos-rebuild switch --flake .#sol`
- **Rebuild User**: `home-manager switch --flake .#bye`
- **Check Flake**: `nix flake check` (add this for validation).
- **Modules**: Enable/disable in `modules/default.nix`, `apps/default.nix`, etc.

## Customization
- Add new modules in `modules/` and import in `modules/default.nix`.
- For packages, add to `packages/` subdirs and import in `packages/default.nix`.
- Use overlays in `flake.nix` for custom package modifications.
- To add a user: Create `vars/newuser.nix` with overrides and import in `flake.nix`.

## Troubleshooting
- If rebuild fails, check `nix.log` or run `journalctl -u nix-daemon`.
- For home-manager issues, ensure standalone mode is set.
