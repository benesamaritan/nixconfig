{ ... }:
{
    programs.bash.initExtra = ''
        if [ -f "$HOME/.local/state/nix/profile/etc/profile.d/hm-session-vars.sh" ]; then
            source "$HOME/.local/state/nix/profile/etc/profile.d/hm-session-vars.sh"
        fi
    '';
}
