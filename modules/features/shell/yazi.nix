{
  flake.modules.nixos.yazi = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [yazi];
    # hj = {
    #   packages = [
    #   ];
    #   xdg.config.files = {
    #     #"yazi/keymap.toml" = {
    #     #  source = .config/yazi/keymap.toml;
    #     #};
    #   };
    #   xdg.config.files."mimeapps.list".text = ''
    #     [Default Applications]
    #     inode/directory=yazi.desktop
    #     x-directory/normal=yazi.desktop

    #     [Added Associations]
    #     inode/directory=yazi.desktop
    #     x-directory/normal=yazi.desktop
    #   '';
    # };
    my.default = {
      apps = {
        "inode/directory" = "yazi.desktop";
        "x-directory/normal" = "yazi.desktop";
      };
    };
    my.persist.home.directories = [
      ".config/yazi"
      ".local/state/yazi"
    ];
  };
}
