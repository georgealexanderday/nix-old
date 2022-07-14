{ config, pkgs, ... }:

{
  home.username = "g";
  home.homeDirectory = "/home/g";
  home.stateVersion = "21.11";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    wally-cli
    google-chrome
    rnix-lsp
    vscode
    fzf
    fd
    gcc
    ripgrep
    elixir
    xclip
    elixir_ls
    inotify-tools
    tmux
    neovim
    gnumake
    dive
    direnv
    exercism
    polychromatic
    htop
    pfetch
    (python39.withPackages(ps: with ps; [
      python-lsp-server
      pylsp-mypy
      python-lsp-black
      conda
      poetry debugpy
    ]))
  ];
  
  home.sessionVariables = {
    ERL_AFLAGS="-kernel shell_history enabled";    
  };

  programs.fish = {
    enable = true;
  };
  
  programs.git = {
    enable = true;
    userName = "georgealexanderday";
    userEmail = "georgealexanderday1@gmail.com";
  };
  
  programs.bat = {
    enable = true;
    config = {
      theme = "Nord";    
    };    
  };
  
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;        
    };
  };
  
  programs.helix = {
    enable = true;
    settings = {
      theme = "nord";    
      editor = {
        line-number= "relative";
      };
    };    
  };

  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        "TERM" = "xterm-256color";    
      };
      window = {
        padding = {
          x = 16;
          y = 16;
        };
        dimensions = {
          columns = 133;
          lines = 40;    
        };
        dynamic_padding = true;
      };
      font = {
        size = 12.0;
        normal.family = "FiraCode Nerd Font";
        normal.style = "Regular";
      };
      colors = {
        primary = {
          background = "0x2E3440";
          foreground = "0xD8DEE9";
        };

        cursor = {
          text = "0x2E3440";
          cursor = "0xD8DEE9";
        };

        normal = {
          black = "0x3B4252";
          red = "0xBF616A";
          green = "0xA3BE8C";
          yellow = "0xEBCB8B";
          blue = "0x81A1C1";
          magenta = "0xB48EAD";
          cyan = "0x88C0D0";
          white = "0xE5E9F0";
        };

        bright = {
          black = "0x4C566A";
          red = "0xBF616A";
          green = "0xA3BE8C";
          yellow = "0xEBCB8B";
          blue = "0x81A1C1";
          magenta = "0xB48EAD";
          cyan = "0x8FBCBB";
          white = "0xECEFF4";
        };
      };
    };
  };
}
