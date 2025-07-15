{ config, lib, pkgs, ... }: {
  options.features.apps.tools.core = {
    enable = lib.mkEnableOption "CLI tools and utilities";
  };

  config = lib.mkIf config.features.apps.tools.core.enable {
    home.packages = with pkgs; [
      ripgrep
      xclip
      xsel
      unzip
      zip
      git
      gh

      btop
      bottom
      bandwhich

      tokei
      ripgrep-all
      atuin
    ];

    features.dotfiles = {
      paths = {
        ".config/btop" = lib.mkDefault "btop";
        ".config/atuin" = lib.mkDefault "atuin";
        ".config/git" = lib.mkDefault "git";
      };
    };
  };
}
