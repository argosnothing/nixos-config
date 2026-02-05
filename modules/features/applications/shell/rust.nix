{
  flake.modules.nixos.rust = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      rustup
      gcc
      gnumake
      cmake
      man-pages
    ];
    my.persist = {
      home.directories = [
        ".rustup"
        ".cargo"
      ];
    };
  };
}
