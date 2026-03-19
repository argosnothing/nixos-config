{
  flake.modules.nixos.starship = {config, ...}: {
    programs.starship.enable = true;
    hj.files.".config/starship.toml".source = config.impure-dir + "/starship/starship.toml";
  };
}
