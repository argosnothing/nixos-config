{
  flake.modules.nixos.kitty = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (config.my.fonts) size;
  in {
    environment.systemPackages = [pkgs.kitty];
    my.persist.home = {
      directories = [".config/kitty"];
      cache.directories = [".cache/kitty"];
    };
    hj.files.".config/kitty/kitty.conf".source = config.impure-dir + "/kitty/kitty.conf";
    hj.files.".config/kitty/nix.conf" = {
      text = ''
        font_size ${toString size}
        shell ${lib.getExe pkgs.fish}
      '';
    };
  };
}
