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

## Guidelines for Improvement
1. **Cleanup WIP Code**:
   - Finalize or remove WIP files; uncomment/enable only active modules; document why others are disabled.

2. **Enhance Security**:
   - Move hashed passwords to secrets (e.g., via agenix).
   - Review exposed configs in version control.

3. **Add Overlays**:
   - Define overlays in `flake.nix` for custom packages from inputs (e.g., zen-browser).

4. **Improve Documentation**:
   - Expand this README with more examples, troubleshooting, and module descriptions.
   - Add inline comments in `.nix` files for complex logic.

5. **Testing and Validation**:
   - Add `nix flake check` to CI or scripts.
   - Test rebuilds in VMs (e.g., with `nixos-rebuild build-vm`).

6. **Best Practices**:
   - Keep `stateVersion` updated but conservative.
   - Use consistent formatting (e.g., nixpkgs-fmt).
   - Add scripts for common tasks (e.g., `rebuild.sh`).

7. **Maintenance**:
   - Regularly update inputs and test compatibility.
   - Backup configs and test restores.

## Troubleshooting
- If rebuild fails, check `nix.log` or run `journalctl -u nix-daemon`.
- For home-manager issues, ensure standalone mode is set.

## Contributing
- Follow the modular structure.
- Test changes locally before committing.

## License
[Add license if applicable, e.g., MIT]
