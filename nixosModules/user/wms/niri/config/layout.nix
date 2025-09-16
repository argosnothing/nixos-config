{...}: {
  programs.niri.settings.layout = {
    border.enable = false;
    focus-ring.enable = false;
    background-color = "transparent";
    preset-column-widths = [
      {proportion = 0.33333;}
      {proportion = 0.5;}
      {proportion = 0.66667;}
    ];
  };
}
