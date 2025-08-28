{
  pkgs,
  ...
}: {
  imports = [
    ../home.nix # Import shared home configuration
  ];

  # Add P51-specific packages to the shared list
  home.packages = with pkgs; [
    loupe
  ];
}
