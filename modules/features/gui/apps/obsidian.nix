{
  flake.modules.nixos.obsidia = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [obsidian];
    my.persist.home = {
      directories = [".config/obsidian"];
    };
  };
}
