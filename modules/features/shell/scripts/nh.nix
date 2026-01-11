{config, ...}: let
  inherit (config.flake.settings) flakedir;
in {
  flake.modules.nixos.nh = {
    pkgs,
    config,
    ...
  }: let
    inherit (config.my) hostname;
    actualFlakedir = if hostname == "nixos" then "/home/nixos/nixos-config" else flakedir;
    rebuild = command: ''
      #!/bin/bash
      pushd ${actualFlakedir}
      alejandra . &>/dev/null
      nh os ${command} ${actualFlakedir}/#nixosConfigurations.${hostname};
      popd
    '';
  in {
    programs.nh = {
      enable = true;
      flake = "${actualFlakedir}";
    };

    environment.systemPackages = [
      (pkgs.writeShellScriptBin "rebuilds" (rebuild "switch"))
      (pkgs.writeShellScriptBin "rebuildb" (rebuild "boot"))
      (pkgs.writeShellScriptBin "rebuildt" (rebuild "test"))
    ];
  };
}
