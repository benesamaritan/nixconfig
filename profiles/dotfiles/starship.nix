{ ... }: {
  programs.starship = {
    enable = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      format = "$all";
      palette = "catppuccin_mocha";
      command_timeout = 3600;

      palettes.catppuccin_mocha = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };

      os.disabled = false;
      username.show_always = true;

      directory = {
        home_symbol = "󱂵 ";
        read_only = " 󰌾 ";
        format = " [$path]($style) ";
        truncation_length = 5;
        truncation_symbol = "…/";
        fish_style_pwd_dir_length = 2;
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = "󰝚 ";
          "Pictures" = " ";
          "Developer" = "󰲋 ";
        };
      };

      direnv.disabled = true;
      line_break.disabled = false;
      character = {
        disabled = false;
        success_symbol = "[❯](bold fg:pink)";
        error_symbol = "[❯](bold fg:red)";
        vimcmd_symbol = "[❮](bold fg:green)";
        vimcmd_replace_one_symbol = "[❮](bold fg:lavender)";
        vimcmd_replace_symbol = "[❮](bold fg:lavender)";
        vimcmd_visual_symbol = "[❮](bold fg:yellow)";
      };

      cmd_duration = {
        disabled = true;
        show_milliseconds = true;
        show_notifications = true;
        format = " in [$duration](bold yellow) ";
      };

      bun.symbol = " ";
      c.symbol = " ";
      cmake.symbol = " ";
      dart.symbol = " ";
      docker_context.symbol = " ";
      elixir.symbol = " ";
      fossil_branch.symbol = " ";
      git_branch.symbol = " ";
      git_commit.tag_symbol = "  ";
      golang.symbol = " ";
      gradle.symbol = " ";
      guix_shell.symbol = " ";
      hg_branch.symbol = " ";
      hostname.ssh_symbol = " ";
      java.symbol = " ";
      kotlin.symbol = " ";
      lua.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      meson.symbol = "󰔷 ";
      nim.symbol = "󰆥 ";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      package.symbol = "󰏗 ";
      php.symbol = " ";
      python.symbol = " ";
      rlang.symbol = "󰟔 ";
      rust.symbol = "󱘗 ";
      status.symbol = " ";
      swift.symbol = " ";

      os.symbols = {
        Alpine = " ";
        Arch = " ";
        CachyOS = " ";
        Debian = " ";
        Fedora = " ";
        FreeBSD = " ";
        Gentoo = " ";
        Ios = "󰀷 ";
        Linux = " ";
        Mabox = " ";
        Macos = " ";
        Mint = " ";
        NixOS = " ";
        Nobara = " ";
        RockyLinux = " ";
        Ubuntu = " ";
        Unknown = " ";
        Void = " ";
        Windows = "󰍲 ";
        Zorin = " ";
      };
    };
  };
}
