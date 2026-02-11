{
  flake.modules.nixos.yazi = {pkgs, ...}: {
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
    my.persist.home.directories = [
      ".config/yazi"
      ".local/state/yazi"
    ];
  };
}
