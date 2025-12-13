{
  flake.modules.nixos.cursor-editor = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [code-cursor-fhs];
  };
}
