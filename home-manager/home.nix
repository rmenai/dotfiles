{pkgs, ...}: {
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    git
    gh

    # Dev tools
    tmux
    sesh
    devenv
    direnv
    stow

    # CLI
    yazi
    ffmpeg
    poppler
    p7zip
    unzip
    zip
    imagemagick
    ripgrep
    wl-clipboard
    xclip
    undollar
    ripgrep
    btop
    jq
    fd

    # # Dev languages
    # python314
    # nodejs_23
    # rustup
    # luajit
    # ocaml
    # opam
    # dune_3
    # ocamlPackages.utop
    # luajitPackages.luarocks
    # tree-sitter
    # bun
    # gnumake
    # gcc
    #
    # # Linters
    # stylua
    # cpplint
    # alejandra
    # asmfmt
    # black
    # isort
    # clang-tools
    # shellharden
    # ocamlPackages.ocamlformat
    #
    # # Lsp
    # # opam install ocaml-lsp-server
    # # rustup component add rust-analyzer
    # bash-language-server
    # lua-language-server
    # pyright
    # nixd
    #
    # # Debuggers
    # python312Packages.debugpy
    # lldb_19
    #
    # # Fonts
    # jetbrains-mono
    # font-awesome
    # font-manager
    # noto-fonts
  ];

  programs.zsh = {
    enable = true;
  };

  programs.bat = {
    enable = true;
    extraPackages = builtins.attrValues {
      inherit
        (pkgs.bat-extras)
        batgrep
        batdiff
        batman
        ;
    };
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.activation.batCacheRebuild = {
    after = ["linkGeneration"];
    before = [];
    data = ''
      ${pkgs.bat}/bin/bat cache --build
    '';
  };
}
