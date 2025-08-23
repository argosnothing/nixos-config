{config, ...}: let
  styles = config.lib.stylix.colors.withHashtag;
  font = config.stylix.fonts.monospace.name or "monospace";
in ''
  window#waybar {
    padding-top: 0;
    padding-bottom: 0;
    font-size: 13px; /* text size controls height */
    background: ${styles.base00};
  }

  window#waybar,
  window#waybar * {
    min-height: 0;
  }

  .modules-left,
  .modules-center,
  .modules-right {
    margin-top: 0;
    margin-bottom: 0;
  }

  #window,
  #workspaces,
  #tray,
  #clock,
  #battery,
  #cpu,
  #memory,
  #temperature,
  #network,
  #pulseaudio,
  #backlight,
  #bluetooth,
  #idle_inhibitor,
  #privacy,
  #custom-start,
  #custom-end,
  #custom-divider,
  #custom-separator,
  #custom-leftend,
  #custom-rightend {
    padding-top: 0;
    padding-bottom: 0;
    margin-top: 0;
    margin-bottom: 0;
    color: ${styles.base0D};
  }

  #workspaces button {
    padding-top: 0;
    padding-bottom: 0;
    margin: 0 2px;
    border-radius: 6px;
    background: ${styles.base00};
    color: ${styles.base05};
    border: 1px solid ${styles.base02};
  }
  #workspaces button.active {
    background: ${styles.base0B};             /* keep same bg */
    color: ${styles.base00};
    border-color: ${styles.base0B};           /* vivid outline */
    font-weight: 600;                         /* optional emphasis */
  }

  #workspaces button.urgent {
    background: ${styles.base08};
    color: ${styles.base00};
    border-color: ${styles.base08};
  }

''
