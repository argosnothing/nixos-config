{config, ...}: let
  styles = config.lib.stylix.colors.withHashtag;
  font = config.stylix.fonts.monospace.name or "monospace";
  topMargin = "5px";
in ''
  window#waybar {
    margin-top: 10px;
    padding-top: 0;
    padding-bottom: 0;
    font-size: 13px; /* text size controls height */
    background: transparent;
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
  #custom-leftend,
  #custom-rightend {
    padding: 4px 8px;
    margin: ${topMargin} 2px 0 2px;
    background: ${styles.base00};
    color: ${styles.base0D};
    border-radius: 6px;
  }

  #workspaces {
    padding: 4px 8px;
    margin: ${topMargin} 2px 0 2px;
    background: ${styles.base00};
    color: ${styles.base0D};
    border-radius: 6px;
  }

  #custom-divider,
  #custom-separator {
    padding-top: 0;
    padding-bottom: 0;
    margin-top: 0;
    margin-bottom: 0;
    background: transparent;
    color: ${styles.base0D};
  }

  #workspaces button {
    padding-top: 0;
    padding-bottom: 0;
    margin: 0 2px;
    border-radius: 0;
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
