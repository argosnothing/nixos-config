{
  flake.modules.nixos.chromium = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [chromium];
    programs.chromium = {
      enable = true;
    };
  };
}
