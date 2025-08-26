{
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
  ];

  home.packages = with pkgs; [
    neofetch
    libsForQt5.qt5ct
    pkgs.libsForQt5.breeze-qt5
    libsForQt5.breeze-icons
    pkgs.noto-fonts-monochrome-emoji
    nautilus
    loupe
    prismlauncher
  ];
}
