{
  flake.modules.nixos.chrome = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      google-chrome
    ];
    my.persist.home.directories = [
      ".config/google-chrome"
    ];
  };
}
