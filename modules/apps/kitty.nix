{pkgs, config, settings, ...}: {
  hjem.users.${settings.username} = {
    packages = with pkgs; [
      kitty
    ];
  };
}
