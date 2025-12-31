{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.apps.editors.neovim;
  mkLink = config.features.core.dotfiles.mkLink;
in
{
  options.features.apps.editors.neovim = {
    enable = lib.mkEnableOption "Neovim";
  };

  config = lib.mkIf cfg.enable {
    home = {
      shellAliases = {
        v = "nvim";
        vimdiff = "nvim -d";
        g = "nvim +Neogit";
      };

      sessionVariables = {
        EDITOR = "nvim";
        SUDO_EDITOR = "nvim";
      };
    };

    home.packages = with pkgs; [
      neovim-unwrapped # TODO: remove this when zellij fixes serialisation bug
      vimgolf
      lazygit
      curl
      fzf
    ];

    xdg = {
      desktopEntries.nvim-foot = {
        name = "Neovim (Foot)";
        exec = "foot nvim %F";
        terminal = false; # We are providing the terminal window ourselves
        categories = [
          "Application"
          "Utility"
          "TextEditor"
        ];
        mimeType = [ "text/plain" ];
      };

      mimeApps.defaultApplications = {
        # Text & Code
        "text/plain" = "nvim-foot.desktop";
        "text/markdown" = "nvim-foot.desktop";
        "text/x-cmake" = "nvim-foot.desktop";
        "text/x-csrc" = "nvim-foot.desktop"; # C
        "text/x-chdr" = "nvim-foot.desktop"; # C Header
        "text/x-c++src" = "nvim-foot.desktop"; # C++
        "text/x-python" = "nvim-foot.desktop";
        "text/x-go" = "nvim-foot.desktop";
        "text/x-rust" = "nvim-foot.desktop";
        "text/x-java" = "nvim-foot.desktop";
        "text/x-sh" = "nvim-foot.desktop";

        # Config files
        "application/json" = "nvim-foot.desktop";
        "application/yaml" = "nvim-foot.desktop";
        "application/toml" = "nvim-foot.desktop";
        "application/xml" = "nvim-foot.desktop";
        "application/x-shellscript" = "nvim-foot.desktop";

        # Nix
        "text/x-nix" = "nvim-foot.desktop";
      };
    };

    xdg.configFile."nvim".source = mkLink ./nvim;

    catppuccin = {
      nvim.enable = true;
      lazygit.enable = true;
    };
  };
}
