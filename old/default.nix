{...}: {
  imports = [
    ./misc
    ./services
    ./style
    ./shell
    ./gui
    ./critical
    ./impermanence

    ./cachix.nix
    ./fonts.nix
    ./icons.nix
    ./monitors.nix
  ];
}
