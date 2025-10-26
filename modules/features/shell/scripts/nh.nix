{
  flake.modules.nixos.nh = {
    pkgs,
    flake,
    config,
    ...
  }: let
    inherit (flake.settings) flakedir;
    rebuild = command: ''
      #!/bin/bash
      pushd ${flakedir}
      alejandra . &>/dev/null
      nh os ${command} ${flakedir}/#nixosConfigurations.${config.my.hostname};
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
