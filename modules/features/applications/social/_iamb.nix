{
  flake.modules.nixos.iamb = {
    pkgs,
    config,
    ...
  }: {
    environment.systemPackages = with pkgs; [iamb];
    hj.files = {
      ".config/iamb/config.toml".source = config.impure-dir + "/iamb/config.toml";
    };
  };
}
