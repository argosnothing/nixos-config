{lib, pkgs, config, inputs, ...}:
{
  programs.vesktop = {
    enable = true;
    vencord = {
      settings = {
        enabledThemes = [ "Stylix" ];
      };
    };
  };

  stylix.targets.vesktop = {
    enable = true;
  };
  stylix.targets.vencord = {
    extraCss = ''
       .container-2cd8Mz { background: transparent !important; }
    '';
    enable = true;
  };
  # Reuse Stylix’s store CSS for both apps
  xdg.configFile."vesktop/themes/stylix.theme.css".source =
  config.xdg.configFile."Vencord/themes/stylix.theme.css".source;

  # Point Vesktop to that exact store path (not a home path)
  xdg.configFile."vesktop/settings/settings.json".text = builtins.toJSON {
    themeLinks = [
      "${config.xdg.configFile."vesktop/themes/stylix.theme.css".source}"
    ];
    # keep other keys you need…
  };
}
