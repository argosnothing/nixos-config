{
  flake.modules.nixos.code-cursor = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [code-cursor-fhs];
    my.persist.home = {
      directories = [".config/Cursor"];
    };
  };
}
