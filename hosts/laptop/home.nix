{
  pkgs,
  ...
}: {
  imports = [
    ../home.nix # Import shared home configuration
  ];

  # Add laptop-specific packages to the shared list
  home.packages = with pkgs; [
    nautilus
    loupe
  ];
}
