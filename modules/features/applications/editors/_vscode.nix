{inputs, ...}: {
  flake.modules.nixos.vscode = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.self.packages.${pkgs.system}.vscode
    ];
  };
}
