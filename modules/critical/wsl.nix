{
  inputs,
  config,
  ...
}: {
  flake.modules.nixos.windows = {pkgs, ...}: {
    imports = [
      inputs.nixos-wsl.nixosModules.default
    ];
    environment.systemPackages = with pkgs; [
      rust-analyzer
      nixd
      nil
    ];

    wsl.enable = true;
    wsl.defaultUser = "nixos";
    wsl.startMenuLaunchers = true;
    hardware.graphics.enable = true;

    environment.sessionVariables = {
      XDG_RUNTIME_DIR = "/mnt/wslg/runtime-dir";
      WAYLAND_DISPLAY = "wayland-0";
    };
  };
}
