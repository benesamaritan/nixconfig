{
  config,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    hub                      # GitHub CLI wrapper (no Home Manager module)
  ];

  programs.opencode = {
    enable = true; # AI Agent on terminal
    enableMcpIntegration = true; # merge programs.mcp.servers into opencode
    # Provider/model/agent config migrated from the hand-maintained
    # opencode.json so HM can own that file. The API key stays out of the
    # store via {file:…} pointing at the agenix-decrypted secret.
    settings = {
      lsp = true;
      model = "9router/oc/muse-spark-1.3-contributor-free";
      provider."9router" = {
        npm = "@ai-sdk/openai-compatible";
        options = {
          baseURL = "http://127.0.0.1:20128/v1";
          apiKey = "{file:${config.age.secrets.nine-router-key.path}}";
        };
        models = {
          "oc/muse-spark-1.2-contributor-free" = {
            name = "oc/muse-spark-1.2-contributor-free";
            modalities = {
              input = [ "text" "image" ];
              output = [ "text" ];
            };
          };
          "oc/muse-spark-1.3-contributor-free" = {
            name = "oc/muse-spark-1.3-contributor-free";
            modalities = {
              input = [ "text" "image" ];
              output = [ "text" ];
            };
          };
          "oc/union-alpha" = {
            name = "oc/union-alpha";
            modalities = {
              input = [ "text" "image" ];
              output = [ "text" ];
            };
          };
        };
      };
      agent.explorer = {
        description = "Fast explorer subagent for codebase exploration";
        mode = "subagent";
        model = "9router/ag/gemini-3.8-flash-high";
      };
    };
  };

  programs.gh = {
    enable = false;
    extensions = pkgs.gh-dash;
    settings.git_protocol = "ssh";
  };

  programs.antigravity-cli = {
    enable = true;
    enableMcpIntegration = true; # merge programs.mcp.servers into antigravity
    settings = {
      context.fileName = [
        "AGENTS.md" 
        "GEMINI.md" 
        "CLAUDE.md"
      ];
    };
  };
}
