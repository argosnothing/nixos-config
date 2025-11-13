{
  flake.modules.nixos.yazi = {pkgs, ...}: {
    hj = {
      packages = [
        pkgs.yazi
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
