# stylix targets enabled by default
{
  flake.modules.nixos.stylix = {
    stylix.targets = {
      kitty.enable = true;
    };
  };
}
