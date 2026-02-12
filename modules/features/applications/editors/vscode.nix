{inputs, ...}: {
  flake.modules.nixos.vscode = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.self.packages.${pkgs.system}.vscode
    ];
    my.persist.home.directories = [
      ".config/Code"
      ".vscode"
      ".rustup"
      ".cargo"
    ];
  };
}
