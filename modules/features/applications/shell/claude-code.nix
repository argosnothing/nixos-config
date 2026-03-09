{
  flake.modules.nixos.claude-code = {pkgs, ...}: {
    environment.systemPackages = [pkgs.claude-code];
    my.persist.home.directories = [
      ".claude"
    ];
    my.persist.home.files = [
      ".claude.json"
    ];
  };
}
