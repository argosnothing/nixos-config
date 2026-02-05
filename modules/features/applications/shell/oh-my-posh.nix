{
  flake.modules.nixos.oh-my-posh = {
    pkgs,
    lib,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      oh-my-posh
    ];
    hj.files = {
      ".config/oh-my-posh/theme.omp.json" = {
        generator = lib.generators.toJSON {};
        value = {
        };
      };
      ".config/fish/conf.d/oh-my-posh.fish".text = ''
        ${pkgs.oh-my-posh}/bin/oh-my-posh init fish \
          --config ~/.config/oh-my-posh/theme.omp.json | source
      '';
    };
  };
}
