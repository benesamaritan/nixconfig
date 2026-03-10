{
  ...
}:

{
  home.sessionPath = [
    # ADD path for GO, NPM, Docker, vscode (+oss), gemini, eclipse, winboat, railway, etc
    "$HOME/.cache/X11/xcompose"
    "$HOME/.local/share/cargo"
    "$HOME/.local/share/bun/bin"
  ];
  home.shellAliases = {
    cd = "z";
    cat = "bat";
    ls = "eza --icons";
    ll = "eza -l --icons --git -a";
    lt = "eza --tree --level=2 --icons";
    g = "git";
    gi = "git init";
    gs = "git status";
    ga = "git add .";
    gc = "git commit -m";
    gp = "git push --set-upstream";
    gf = "git fetch && git pull --rebase";
    gcl = "git clone";
    gb = "git branch";
    gco = "git checkout";
    gu = "git submodule update --init --recursive";
    x = "hx .";
    yz = "yazi";
    lzg = "lazygit";
    lzd = "lazydocker";
    lzs = "lazysql";
    lzn = "lazynpm";
    lzw = "lazyworktree";
    lzj = "lazyjournal";
    gem = "gemini";
    oc = "opencode";
    dp = "dolphin .";
    dx = "devbox";
    dv = "devenv";
  };
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
    XCOMPOSECACHE = "$HOME/.cache/X11/xcompose";
    CARGO_HOME = "$HOME/.local/share/cargo";
    BUN_INSTALL = "$HOME/.local/share/bun";
  };
}
