{
  flake.modules.nixos.obsidian = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [obsidian];
    my.persist.home = {
      directories = [".config/obsidian"];
    };
  };
}
