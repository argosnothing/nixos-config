{
  flake.modules.nixos.discord = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      vesktop
      discord
      dissent
    ];
    my.persist.home.directories = [
      ".config/discord"
      ".config/vencord"
      ".config/vesktop"
      ".config/dissent"
    ];
  };
}
