{
  flake.modules.nixos.yazi = {
    config,
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [yazi];
    my.default = {
      apps = {
        "inode/directory" = "yazi.desktop";
        "x-directory/normal" = "yazi.desktop";
      };
      associations = {
        "inode/directory" = ["yazi.desktop"];
        "x-directory/normal" = ["yazi.desktop"];
      };
    };
    hj.files.".config/yazi/keymap.toml".source = config.impure-dir + "/yazi/keymap.toml";
    my.persist.home.directories = [
      ".config/yazi"
      ".local/state/yazi"
    ];
  };
}
