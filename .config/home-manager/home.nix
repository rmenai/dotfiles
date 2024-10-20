{ pkgs, ... }:

let
  homeDir = builtins.getEnv "HOME";
  user = builtins.getEnv "USER";
  jsonFile = builtins.readFile "${homeDir}/.config/zsh/themes/catppuccin_mocha.omp.json";
  themeConfig = builtins.fromJSON (builtins.unsafeDiscardStringContext jsonFile);
in

{
  home = {
    stateVersion = "24.05";
    username = user;
    homeDirectory = homeDir;
    packages = with pkgs; [
      zsh
      oh-my-posh
      neovim
      tmux
      gh
      wslu
      
      ripgrep
      fd
      fzf
      python312
      python312Packages.pip
      python312Packages.cmake
      nodejs_20
      yarn
      rustup
      rustc
      gnumake42
      gccgo14
      unzip

      ccls
      tree-sitter
    ];
    sessionVariables = {
      EDITOR = "neovim";
      SUDO_EDITOR = "neovim";
    };
  };

  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
      shellAliases = {
        ll = "ls -alF";
        la = "ls -A";
        l = "ls -CF";
        ls = "ls --color=auto";
        dir = "dir --color=auto";
        vdir = "vdir --color=auto";
        grep = "grep --color=auto";
        fgrep = "fgrep --color=auto";
        egrep = "egrep --color=auto";
      };
      antidote = {
        enable = true;
        plugins = [
          "zsh-users/zsh-syntax-highlighting"
          "zsh-users/zsh-autosuggestions"
          # "zsh-users/zsh-history-substring-search"
          "hlissner/zsh-autopair"
          # "jeffreytse/zsh-vi-mode"
        ];
      };
      initExtra = ''
        # Source Nix environment script if it exists
        if [[ -r "${homeDir}/.profile" ]]; then
          source "${homeDir}/.profile"
        fi
      '';
    };
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      settings = themeConfig;
    };
    git = {
      enable = true;
      userName = "Rami Menai";
      userEmail = "rami@menai.me";
    };
  };
}

