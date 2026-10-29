{
    lib,
    ...
}:

{
  home.sessionPath = [
    "$HOME/.cache/X11/xcompose"
    "$HOME/.local/share/cargo"
    "$HOME/.local/share/bun/bin"
  ];
  home.shellAliases = {
    cd = "z";
    cat = "bat";
    ls = "eza";
    ll = "eza -l --git -a";
    lt = "eza --tree --level=2";
    g = "git";
    gi = "git init";
    gs = "git status";
    ga = "git add .";
    gc = "git commit -m";
    x = "hx .";
    yz = "yazi";
    lzg = "lazygit";
    lzs = "lazysql";
    oc = "opencode";
    dv = "devenv";
  };
  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
    XCOMPOSECACHE = "$HOME/.cache/X11/xcompose";
    CARGO_HOME = "$HOME/.local/share/cargo";
    BUN_INSTALL = "$HOME/.local/share/bun";
    HISTFILE = "$XDG_STATE_HOME/bash/history";
    GNUPGHOME = "$HOME/.local/share/gnupg";
    NPM_CONFIG_CACHE = "$XDG_CACHE_HOME/npm";
    NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";
    WINEPREFIX = "$XDG_DATA_HOME/wine";
    GTK2_RC_FILES = lib.mkForce "$XDG_CONFIG_HOME/gtk-2.0/gtkrc";
    XCURSOR_PATH = "$XDG_DATA_HOME/icons:/usr/share/icons";
    CODEX_HOME = "$XDG_CONFIG_HOME/codex";
    PI_CODING_AGENT_DIR = "$XDG_CONFIG_HOME/pi/agent";
  };
}
