{ pkgs, ... }:
{
  home.packages = with pkgs; [
    p7zip
    poppler
    jq
    fd
  ];

  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
    shellWrapperName = "y";

    settings = {
      preview = {
        max_width = 1920;
        max_height = 1080;
      };
    };
  };

  catppuccin.yazi.enable = true;
}
