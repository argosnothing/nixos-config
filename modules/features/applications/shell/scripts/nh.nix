{
  flake.modules.nixos.nh = {
    pkgs,
    config,
    ...
  }: let
    inherit (config.my) hostname;
    inherit (config.my) username;
    flakedir = "/home/${username}/nixos-config";

    actualHostname =
      if hostname == "nixos"
      then "wsl"
      else hostname;
    rebuild = command: ''
      #!/bin/bash
      pushd ${flakedir}
      alejandra . &>/dev/null
      nh os ${command} ${flakedir}/#nixosConfigurations.${actualHostname};
      popd
    '';
  in {
    programs.nh = {
      enable = true;
      flake = "${flakedir}";
    };
    hj.files.".local/bin/nht" = {
      source = config.impure-dir + "/.local/bin/nht";
      executable = true;
    };
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "rebuilds" (rebuild "switch"))
      (pkgs.writeShellScriptBin "rebuildb" (rebuild "boot"))
      (pkgs.writeShellScriptBin "rebuildt" (rebuild "test"))
    ];
  };
}
