{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.zed = {
    pkgs,
    config,
    ...
  }: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    my.persist.home.directories = [
      ".local/share/zed"
    ];

    hj.files = let
      dotsDir = config.impure-dir;
    in {
      ".config/zed/keymap.json".source = dotsDir + "/zed/keymap.json";
      ".config/zed/keymap_backup.json".source = dotsDir + "/zed/keymap_backup.json";
      ".config/zed/settings.json".source = dotsDir + "/zed/settings.json";
      ".config/zed/tasks.json".source = dotsDir + "/zed/tasks.json";
      ".config/zed/themes/noctalia.json".source = dotsDir + "/zed/themes/noctalia.json";
    };
    programs.nix-ld.enable = true;
    hj.packages = with flake.packages.${system}; [zeditor];
  };
}
