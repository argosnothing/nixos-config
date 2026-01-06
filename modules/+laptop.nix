{config, ...}: {
  flake.modules.nixos.laptop = {
    hj.files = with config.flake.lib;
      (move ".config/zed/settings.json")
      // (move ".config/zed/keymap.json")
      // (move ".config/zed/tasks.json");
    hardware = {
      graphics.enable = true;
      bluetooth.enable = true;
    };
    imports = with config.flake.modules.nixos; [
      #xfce-bundle
      niri-bundle
      work
      gui-apps

      vscode
      zed
      krita
      memacs

      shell-apps
      battery
      touchpad

      # don't touch this
      uefi
      zfs
      impermanence
    ];
    my = {
      theme.polarity = "dark";
      cursor.speed = 0.30;
      is-vm = false;
      monitors = [
        {
          name = "Virtual-1";
          is-primary = true;
          dimensions = {
            width = 500;
            height = 500;
          };
          position = {
            x = 0;
            y = 0;
          };
          scale = 1.0;
          refresh = 60.0;
        }
      ];
    };
  };
}
