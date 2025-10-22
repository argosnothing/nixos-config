{
  pkgs,
  lib,
  inputs,
  config,
  username,
  ...
}: let
  inherit (config.my.modules.gui) winboat;
  inherit (lib) mkIf mkEnableOption;
in {
  options.my.modules.gui.winboat = {
    enable = mkEnableOption "Enable Winboat";
  };
  config = mkIf winboat.enable {
    users.users.${username} = {
      extraGroups = ["docker"];
    };
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm = {
            enable = false;
          };
        };
      };
      docker = {
        enable = true;
        enableOnBoot = true;
      };
    };
    my.persist.home.directories = [
      ".winboat"
      ".config/winboat"
      "Windows"
    ];
    environment.systemPackages = [
      inputs.winboat.winboat
      pkgs.freerdp
    ];
  };
}
