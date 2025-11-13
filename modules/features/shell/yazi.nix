{
  flake.modules.nixos.yazi = {pkgs, ...}: {
    hm = {
      programs.yazi = {
        enable = true;
      };
    };
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
