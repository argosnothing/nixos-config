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
    git --no-pager diff
    git add .
    nh os ${command} ${settings.absoluteflakedir}/#nixosConfigurations.${settings.hostname};
    gen=$( nixos-rebuild list-generations | grep True \
    | awk '{print "Generation:", $1, "nixpkgs:", $4, "Kernel:", $5}')
    git commit -m "$gen"
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
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 6";
      flake = "${settings.absoluteflakedir}";
    };

    environment.systemPackages = [
      (pkgs.writeShellScriptBin "rebuilds" (rebuild "switch"))
      (pkgs.writeShellScriptBin "rebuildb" (rebuild "boot"))
    ];
  };
}
