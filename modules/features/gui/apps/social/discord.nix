{
  flake.modules.nixos.discord = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [vesktop];
    my.persist.home.directories = [
      ".config/discord"
      ".config/vencord"
      ".config/vesktop"
    ];
  };
}
