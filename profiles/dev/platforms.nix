{
  config,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    hub
    gh
  ];

  programs.opencode = {
    enableMcpIntegration = true;
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

  programs.antigravity-cli = {
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
