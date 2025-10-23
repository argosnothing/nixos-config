# {
#   flake.modules.nixos = {
#     pkgs,
#     config,
#     ...
#   }: {
#     programs.fish.enable = true;
#     users = {
#       users.root.initialPassword = "password";
#       users.${config.flake.settings.username} = {
#         isNormalUser = true;
#         extraGroups = ["networkmanager" "wheel" "input" "plugdev" "dialout" "seat"];
#         hashedPasswordFile = config.sops.secrets."pc_password".path;
#       };
#       defaultUserShell = pkgs.fish;
#     };
#   };
# }
{
  flake.modules.nixos = {
    user = {
      config,
      lib,
      pkgs,
      ...
    }: let
      inherit (lib) types mkOption;
      inherit (types) str;
    in {
      options.user = {
        name = mkOption {
          type = str;
          default = "salivala";
        };
      };
      config = {
        programs.fish.enable = true;
        users = {
          users.root.initialPassword = "password";
          users.${config.user.name} = {
            isNormalUser = true;
            extraGroups = ["networkmanager" "wheel" "input" "plugdev" "dialout" "seat"];
            hashedPasswordFile = config.sops.secrets."pc_password".path;
          };
          defaultUserShell = pkgs.fish;
        };
      };
    };
  };
}
