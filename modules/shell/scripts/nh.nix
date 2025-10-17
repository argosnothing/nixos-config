{
  pkgs,
  config,
  lib,
  flakedir,
  hostname,
  ...
}: let
  rebuild = command: ''
    #!/bin/bash
    pushd ${flakedir}
    alejandra . &>/dev/null
    nh os ${command} ${flakedir}/#nixosConfigurations.${hostname};
    popd
  '';
in {
  options = {
    my.modules.shell.scripts.nh.enable = lib.mkOption {
      default = true;
      type = lib.types.bool;
      description = "Enables, and configures nh for the system";
    };
  };

  config = lib.mkIf config.my.modules.shell.scripts.nh.enable {
    programs.nh = {
      enable = true;
      flake = "${flakedir}";
    };

    environment.systemPackages = [
      (pkgs.writeShellScriptBin "rebuilds" (rebuild "switch"))
      (pkgs.writeShellScriptBin "rebuildb" (rebuild "boot"))
      (pkgs.writeShellScriptBin "rebuildt" (rebuild "test"))
    ];
  };
}
