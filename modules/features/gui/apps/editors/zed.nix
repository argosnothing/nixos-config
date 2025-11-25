{config, ...}: let
  inherit (config) flake;
in {
  flake.modules.nixos.zed = {pkgs, ...}: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    my.persist.home.directories = [
      ".config/zed"
      ".local/share/zed"
    ];
    environment.systemPackages = with pkgs; [
      zed-editor
      nixd
      nil
    ];
    programs.nix-ld.enable = true;
    #hm = {
    #  home.packages = with flake.packages.${system}; [zeditor];
    #  stylix.targets.zed.enable = false;
    #};
  };
}
