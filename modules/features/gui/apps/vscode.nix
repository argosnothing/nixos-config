{
  flake.modules.nixos.vscode = {pkgs, ...}: {
    hm = {
      programs.vscode = {
        enable = true;
        package = pkgs.vscode.fhs;
      };
    };
    my.persist = {
      home.directories = [
        ".config/Code"
        ".vscode"
      ];
    };
  };
}
