{
  flake.modules.nixos.discord = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      vesktop
      (discord.override {
        # withVencord = true;
        withEquicord = true;
      })
      dissent
      vencord
    ];
    my.persist.home.directories = [
      ".config/discord"
      ".config/vencord"
      ".config/vesktop"
      ".config/dissent"
    ];
  };
}
