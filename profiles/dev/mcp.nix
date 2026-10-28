{
  config,
  lib,
  pkgs,
  pkgs-stable,
  inputs,
  ...
}:

let
  # codegraph: upstream prebuilt JS bundle (v1.6.2), but wrapped with Nix's
  # system Node.js. The nixpkgs codegraph package segfaults in glibc 2.44's
  # dl_main because its vendored Node binary is incompatible; the upstream
  # release's JS works fine with our system node.
  codegraph-fetch = pkgs.stdenv.mkDerivation {
    name = "codegraph";
    src = pkgs.fetchurl {
      url = "https://github.com/colbymchenry/codegraph/releases/download/v1.6.2/codegraph-linux-x64.tar.gz";
      sha256 = "0a5q6x7nx5mz136llq7yf5llmpvy1c08cdvjrhfgna1114bg82pg";
    };
    nativeBuildInputs = [ pkgs.nodejs_22 ];
    dontBuild = true;
    installPhase = ''
      # The release tarball may contain a top-level codegraph-linux-x64/ dir
      if [ -d codegraph-linux-x64 ]; then cd codegraph-linux-x64; fi
      mkdir -p $out/bin
      cp -r ./lib $out/lib
      cat > $out/bin/codegraph <<EOF
      #!/bin/sh
      exec ${pkgs.nodejs_22}/bin/node --liftoff-only --disable-warning=ExperimentalWarning "$out/lib/dist/bin/codegraph.js" "\$@"
      EOF
      chmod +x $out/bin/codegraph
    '';
  };

  mcpBin = pkgs.buildEnv {
    name = "mcp-servers-bin";
    paths = [
      pkgs-stable.mcp-server-filesystem
      pkgs-stable.mcp-server-fetch
      pkgs-stable.mcp-server-memory
      pkgs-stable.mcp-server-sequential-thinking
      pkgs-stable.mcp-server-time
      pkgs-stable.mcp-server-git
      pkgs.github-mcp-server
      pkgs.context7-mcp
      codegraph-fetch
      pkgs.bun
    ];
    pathsToLink = [ "/bin" ];
  };
in

{
  home.packages = [ mcpBin inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.agenix ];

  programs.mcp = {
    servers = {
      filesystem = {
        command = lib.getExe pkgs-stable.mcp-server-filesystem;
        args = [ "${config.home.homeDirectory}/repos" ];
      };
      fetch.command = lib.getExe pkgs-stable.mcp-server-fetch;
      memory.command = lib.getExe pkgs-stable.mcp-server-memory;
      sequential-thinking.command = lib.getExe pkgs-stable.mcp-server-sequential-thinking;
      time.command = lib.getExe pkgs-stable.mcp-server-time;
      context7.command = lib.getExe pkgs.context7-mcp;
      github = {
        command = lib.getExe pkgs.github-mcp-server;
        args = [ "stdio" ];
        env.GITHUB_PERSONAL_ACCESS_TOKEN.file = config.age.secrets.github-mcp-token.path;
      };
      devenv = {
        command = lib.getExe pkgs.devenv;
        args = [ "mcp" ];
      };
      chromedevtools = {
        command = "${pkgs.bun}/bin/bunx";
        args = [ "-y" "chrome-devtools-mcp@latest" ];
        env.CHROME_PATH = "${inputs.helium-flake.packages.x86_64-linux.helium}/bin/helium";
        env.CHROME_DEBUG_PORT = "9222";
      };
      codegraph = {
        command = "${codegraph-fetch}/bin/codegraph";
        args = [ "serve" "--mcp" ];
      };
#       jscpd = {
#         command = "${pkgs.bun}/bin/bunx";
#         args = [ "cpd" "--mcp" ];
#         env.NODE_OPTIONS = "--max-old-space-size=1024";
#       };
      dbx = {
        command = "${pkgs.bun}/bin/bunx";
        args = [ "-y" "@dbx-app/mcp-server" ];
      };
      trilium = {
        type = "http";
        url = "http://127.0.0.1:37840/mcp";
        headers.Authorization = "Bearer {file:${config.home.homeDirectory}/.config/agenix/trilium-mcp-token}";
      };
    };
  };
}
