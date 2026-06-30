{
  flake.modules.nixos.yazi = {
    config,
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [yazi];
    hj.files.".config/yazi/keymap.toml".source = config.impure-dir + "/yazi/keymap.toml";
  };
}
