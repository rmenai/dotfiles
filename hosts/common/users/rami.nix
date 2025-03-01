{
  config,
  pkgs,
  inputs,
  ...
}: {
  systemd.tmpfiles.rules = [
    "d /persist/home/ 0777 root root -"
    "d /persist/home/rami 0700 rami users -"
  ];

  programs.zsh.enable = true;

  users.users.rami = {
    isNormalUser = true;
    description = "Rami Menai";
    hashedPassword = "***REMOVED***";
    extraGroups = ["networkmanager" "wheel" "libwirtd" "audio" "video" "plugdev" "input" "kvm" "qemu-libvirtd"];
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
    shell = pkgs.zsh;
  };

  environment.persistence."/persist" = {
    users.rami = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        ".dotfiles"
        ".gnupg"
        ".ssh"
        ".nixops"
        ".zen"
        ".cargo"
        ".rustup"
        ".opam"
        ".cache"
        ".local/share/keyrings"
        ".local/share/direnv"
        ".local/share/hyprland"
        ".local/share/nvim"
        ".local/share/sddm"
        ".local/share/zinit"
        ".local/share/zoxide"
        ".local/share/tmux"
        ".local/state/home-manager"
        ".local/state/nix"
        ".local/state/nvim"
        ".config/gh"
      ];
      files = [
        ".zsh_history"
      ];
    };
  };

  home-manager.users.rami = import ../../../home/rami/${config.networking.hostName}.nix;
}
