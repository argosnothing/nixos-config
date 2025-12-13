{
  flake.modules.nixos.code-cursor = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [code-cursor-fhs];
    my.home.persist = {
      directories = [".config/Cursor"];
    };
  };
}
