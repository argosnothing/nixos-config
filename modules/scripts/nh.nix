{
  pkgs,
  config,
  settings,
  lib,
  ...
}: let
  rebuild = command: ''
    #!/bin/bash
    pushd ${settings.absoluteflakedir}
    alejandra . &>/dev/null
    nh os ${command} ${settings.absoluteflakedir}/#nixosConfigurations.${settings.hostname};
    popd
  '';
in {
  options = {
    custom.system.msc.nh.enable = lib.mkOption {
      default = true;
      type = lib.types.bool;
      description = "Enables, and configures nh for the system";
    };
  };

  config = lib.mkIf config.custom.system.msc.nh.enable {
    programs.nh = {
      enable = true;
      flake = "${settings.absoluteflakedir}";
    };

    environment.systemPackages = [
      (pkgs.writeShellScriptBin "rebuilds" (rebuild "switch"))
      (pkgs.writeShellScriptBin "rebuildb" (rebuild "boot"))
    ];
  };
}
