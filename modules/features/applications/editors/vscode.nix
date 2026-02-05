{inputs, ...}: {
  flake.modules.nixos.vscode = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.vscode
    ];
    my.persist = {
      home.directories = [
        ".config/Code"
        ".vscode"
        ".rustup"
        ".cargo"
      ];
    };
  };
}
