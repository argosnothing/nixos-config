{
  flake.modules.homeManager.niri = {
      programs.niri.settings.layer-rules = [
        {
          matches = [
            {
              namespace = "^quickshell-wallpaper$";
            }
          ];
          place-within-backdrop = true;
        }
        {
          matches = [
            {
              namespace = "^quickshell-overview$";
            }
          ];
          opacity = 0.0;
        }
      ];
  };
}
