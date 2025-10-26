{
  flake.modules.nixos.zed = {
    pkgs,
    self,
    ...
  }: {
    environment.systemPackages = [
      self.packages.${pkgs.system}.zeditor
    ];
    my.persist.home.directories = [
      ".config/zed"
      ".local/share/zed"
    ];
  };
}
