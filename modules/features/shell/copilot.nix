{
  flake.modules.nixos.copilot-cli = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [copilot-cli];
  };
}
