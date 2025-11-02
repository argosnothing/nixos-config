{
  flake.modules.nixos.rust = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [rustup];
    my.persist = {
      home.directories = [
        ".rustup"
        ".cargo"
      ];
    };
  };
}
