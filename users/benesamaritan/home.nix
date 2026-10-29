{
    lib,
    inputs,
    username,
    ...
}:

{
    imports = [
        ./age.nix
        ./programs.nix
        ./genericLinux.nix
        ../../services
        ../../profiles/personal
        ../../profiles/dev
        ../../profiles/work
        ../../profiles/dotfiles
        inputs.agenix.homeManagerModules.default
        inputs.nix-index-database.homeModules.default
        inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ];

    news.display = "show";

    nix.settings.use-xdg-base-directories = true;

    programs.home-manager = {
        enable = true;
        path = lib.mkDefault "$HOME/.config/home-manager";
    };

    home = {
        stateVersion = "25.05";
        username = username;
        homeDirectory = "/home/${username}";
        shell.enableShellIntegration = true;
        overwriteBackup = true;
        preferXdgDirectories = true;
        shellAliases = {
            ".." = "cd ..";
            cls = "clear";
            ff = "fastfetch";
            ns = "nh search";
            nhs = "nh home switch .";
        };
        sessionVariables = {
            TERMINAL = "alacritty";
            BROWSER = "zen";
            PATH = "$XDG_STATE_HOME/nix/profile/bin:$PATH";
            GNUPGHOME = "$HOME/.local/share/gnupg";
        };
        file.".config/nixpkgs/config.nix".text = ''
            { allowUnfree = true; }
        '';
        file.".local/share/nix/trusted-settings.json".text = builtins.toJSON {
            "extra-substituters" = [
                "https://devenv.cachix.org"
                "https://catppuccin.cachix.org"
                "https://cache.forall.systems"
            ];
            "extra-trusted-public-keys" = [
                "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
                "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
                "cache.forall.systems:5PmD7QO4MSF8YgyRZtkSGXRDo96H3bybIf2SsQh8ScI="
            ];
        };
    };

    programs.git = {
        settings = {
            user = {
                name = "benesamaritan";
                email = "243715333+benesamaritan@users.noreply.github.com";
            };
            submodule.recurse = true;
            commit.gpgSign = true;
        };
        signing = {
            key = "3C703A64157458C1";
            signByDefault = true;
        };
    };
}
