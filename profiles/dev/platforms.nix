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
    enable = true;
    enableMcpIntegration = true;
    settings = {
      lsp = {
        nil = {
          command = [ "nil" ];
          extensions = [ ".nix" ];
        };
      };
      provider."9router" = {
        npm = "@ai-sdk/openai-compatible";
        options = {
          baseURL = "http://127.0.0.1:20128/v1";
          apiKey = "{file:${config.age.secrets.omniroute-key.path}}";
        };
        models = {
          open = {
            name = "open";
            modalities = {
              input = [ "text" "image" ];
              output = [ "text" ];
            };
          };
          premium = {
            name = "premium";
            modalities = {
              input = [ "text" "image" ];
              output = [ "text" ];
            };
          };
          "9r-free" = {
            name = "9r-free";
            modalities = {
              input = [ "text" "image" ];
              output = [ "text" ];
            };
          };
          "9r-code" = {
            name = "9r-code";
            modalities = {
              input = [ "text" "image" ];
              output = [ "text" ];
            };
          };
          "9r-plan" = {
            name = "9r-plan";
            modalities = {
              input = [ "text" "image" ];
              output = [ "text" ];
            };
          };
        };
      };
      model = "9router/open";
      agent.explorer = {
        description = "Fast explorer subagent for codebase exploration";
        mode = "subagent";
        model = "9router/kgw/kilo-auto/free";
      };
    };
  };

  programs.antigravity-cli = {
    enableMcpIntegration = true;
    settings = {
      context.fileName = [
        "AGENTS.md"
        "GEMINI.md"
        "CLAUDE.md"
      ];
    };
  };
}
