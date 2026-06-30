{inputs, ...}: {
  flake.modules.nixos.noctalia-greeter = {pkgs, ...}: {
    imports = [
      inputs.noctalia-greeter.nixosModules.default
    ];
    programs.noctalia-greeter = {
      enable = true;
      package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;

      greeter-args = "--session Niri";
    };
  };
}
