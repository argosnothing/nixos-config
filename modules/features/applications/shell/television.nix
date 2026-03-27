{
  flake.modules.nixos.television = {
    pkgs,
    config,
    ...
  }: {
    environment.systemPackages = with pkgs; [nix-search-tv];
    programs.television = {
      enable = true;
      enableFishIntegration = true;
    };
    hj.files = {
      ".config/television/cable/nix.toml" = config.impure-dir + "/television/cable/nix.toml";
    };
  };
}
