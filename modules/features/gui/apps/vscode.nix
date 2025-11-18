{
  flake.modules.nixos.vscode = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.vscode.fhs
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
