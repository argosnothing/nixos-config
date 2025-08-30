{pkgs, ...}: {
  imports = [
    ../home.nix
  ];

  home.packages = with pkgs; [
    neofetch
    pkgs.libsForQt5.breeze-qt5
    pkgs.noto-fonts-monochrome-emoji
    libsForQt5.qt5ct
    libsForQt5.breeze-icons
    prismlauncher
    r2modman
  ];
}