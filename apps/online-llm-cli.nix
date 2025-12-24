{ pkgs, inputs, ... }:

{
  # GitHub CLI configuration with Copilot integration
  programs.gh = {
    enable = true;
    
    # Add GitHub Copilot CLI extension for AI-assisted command suggestions
    extensions = [ pkgs.gh-copilot ];
    
    settings = {
      # Use SSH protocol for Git operations
      git_protocol = "ssh";
      
      # Shell aliases for quick access to Copilot features
      aliases = {
        # 'gh co' - general GitHub Copilot commands
        co = "copilot";
        
        # 'gh ce' - explain shell commands or code snippets
        ce = "copilot explain";
        
        # 'gh cs' - suggest commands to accomplish tasks
        cs = "copilot suggest";
      };
    };
  };
  
  # AI-powered CLI tools packages
  home.packages = [ 
    # gemini-cli - command-line interface for Google's Gemini AI model
    pkgs.gemini-cli
    
    # OpenCode - open-source alternative to GitHub Copilot for code assistance
    inputs.opencode.packages.${pkgs.system}.default
  ];
  
  # Shell alias for quick access to Gemini CLI
  home.shellAliases = {
    gem = "gemini";
  };
}
