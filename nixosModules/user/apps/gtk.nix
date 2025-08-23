{...}: {
  # Let Stylix handle all GTK theming including icons
  # Just enable basic Qt integration
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
