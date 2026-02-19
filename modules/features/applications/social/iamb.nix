{
  flake.modules.nixos.iamb = {
    pkgs,
    config,
    ...
  }: {
    my.persist.home.directories = [".config/iamb"];
    environment.systemPackages = with pkgs; [iamb];
    hj.files = {
      ".config/iamb/config.toml".source = config.impure-dir + "/iamb/config.toml";
    };
  };
}
