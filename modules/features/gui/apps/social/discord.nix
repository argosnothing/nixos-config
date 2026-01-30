{
  flake.modules.nixos.discord = {
    pkgs,
    lib,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      vesktop
      (discord.override {
        withEquicord = true;
      })
      dissent
      vencord
    ];
    # Fuck you, whatever is making my cursor not work and making me have to use this hack.
    # Please, PLEASE, step on the biggest lego
    hj.files.".local/share/applications/vesktop.desktop" = {
      generator = lib.generators.toINI {};
      value = {
        "Desktop Entry" = {
          "Categories" = "Network;InstantMessaging;Chat";
          "Exec" = "vesktop --enable-features=UseOzonePlatform --ozone-platform=wayland %U";
          "GenericName" = "Internet Messenger";
          "Icon" = "vesktop";
          "Keywords" = "discord;vencord;electron;chat";
          "Name" = "Vesktop";
          "StartupWMClass" = "Vesktop";
          "Type" = "Application";
          "Version" = "1.5";
        };
      };
    };
    my.persist.home.directories = [
      ".config/discord"
      ".config/vencord"
      ".config/vesktop"
      ".config/dissent"
    ];
  };
}
