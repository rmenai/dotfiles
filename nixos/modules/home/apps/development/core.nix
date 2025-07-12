{ config, lib, pkgs, ... }: {
  options.features.apps.development.core = {
    enable = lib.mkEnableOption "Development tools and utilities";
  };

  config = lib.mkIf config.features.apps.development.core.enable {
    home.packages = with pkgs; [
      devenv
      direnv
      jc

      dua
      hyperfine
      dust

      gcc
      gnumake
      mold

      luajit
      clang-tools
      nixd
      shellharden
      markdownlint-cli
      lua-language-server
      lldb_19
      stylua
      cpplint
      alejandra
      asmfmt
    ];
  };
}
