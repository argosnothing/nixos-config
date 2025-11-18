{
  flake.modules.homeManager.disabled = {
    programs.niri.settings.layer-rules = [
      {
        matches = [
          {
            namespace = "^noctalia-wallpaper*";
          }
        ];
        place-within-backdrop = true;
      }
      {
        matches = [
          {
            namespace = "^quickshell$";
          }
        ];
        place-within-backdrop = true;
      }
      {
        matches = [
          {
            namespace = "^noctalia-overview$";
          }
        ];
        opacity = 0.0;
      }
    ];
  };
}
