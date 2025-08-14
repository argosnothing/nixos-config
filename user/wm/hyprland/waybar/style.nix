{ config, ... }:
  let styles = config.lib.stylix.colors.withHashtag; in
  ''
      window#waybar {
        background: ${styles.base00};
        color: #AAB2BF;
      }
  ''
