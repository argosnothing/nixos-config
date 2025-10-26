{config, ...}: let
    inherit (config.flake.settings) flakedir;
in {
  flake.modules.nixos.nh = {
    pkgs,
    config,
    ...
  }: let
    inherit (config.my) hostname;
    rebuild = command: ''
      #!/bin/bash
      pushd ${flakedir}
      alejandra . &>/dev/null
      nh os ${command} ${flakedir}/#nixosConfigurations.${hostname};
      popd
    '';
  in {
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
