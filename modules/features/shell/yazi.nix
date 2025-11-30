{
  flake.modules.nixos.yazi = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [yazi];
    hj = {
      packages = [
      ];
      xdg.config.files = {
        #"yazi/keymap.toml" = {
        #  source = .config/yazi/keymap.toml;
        #};
      };
    };
    my.persist.home.directories = [
      ".config/yazi"
      ".local/state/yazi"
    ];
  };
}
