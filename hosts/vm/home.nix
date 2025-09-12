{pkgs, settings, ...}: {
  imports = [ ../../nixosModules/user/apps/nvf];
  home.packages = with pkgs; [
    inputs.self.packages.${pkgs.system}.ns
  ];
  home.username = settings.username;
  home.homeDirectory = "/home/" + settings.username;
  programs.bash = {
    enable = true;
  };
  programs.home-manager.enable = true;
}
