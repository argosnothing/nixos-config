{
  pkgs,
  ...
}: {
  imports = [
    ../home.nix # Import shared home configuration
  ];

  # Add desktop-specific packages to the shared list
  home.packages = with pkgs; [
    neofetch
    microsoft-edge
    libsForQt5.qt5ct
    pkgs.libsForQt5.breeze-qt5
    libsForQt5.breeze-icons
    pkgs.noto-fonts-monochrome-emoji
    nautilus
    loupe
  ];
}
