{
  flake.modules.nixos.claude-code = {
    # pkgs,
    pkgs-stable,
    ...
  }: {
    environment.systemPackages = [pkgs-stable.claude-code];
    my.persist.home.directories = [
      ".claude"
    ];
    my.persist.home.files = [
      ".claude.json"
    ];
  };
}
