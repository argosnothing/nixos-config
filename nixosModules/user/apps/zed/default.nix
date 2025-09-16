{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    zed.enable = lib.mkEnableOption "User Zed editor.";
  };
  config = lib.mkIf config.zed.enable {
    programs.zed-editor = {
      enable = true;
      extensions = ["nix" "toml" "elixir" "make" "rust"];
      userSettings = {
        vim_mode = true;
      };
    };
    custom.home.persist.directories = [".config/zed"];
  };
}
