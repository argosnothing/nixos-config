{...}: {
  programs.niri.settings.outputs = {
    "DP-1" = {
      mode = {
        width = 3840;
        height = 2160;
      };
      scale = 1.2;
      position = {
        x = 0;
        y = 0;
      };
    };
    "DP-2" = {
      mode = {
        width = 1920;
        height = 1080;
      };
      scale = 1.0;
      #position = {y = 288;};
    };
  };
}
