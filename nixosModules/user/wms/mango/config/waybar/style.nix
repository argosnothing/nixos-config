{config, ...}: let
  c = config.lib.stylix.colors.withHashtag;
in ''
  #waybar { min-height: 0; padding: 0; margin: 0; }
  * { font-size: 12px; }

  #workspaces {
    margin-left: 4px;
    padding-left: 10px;
    padding-right: 6px;
    background-color: ${c.base00};
  }

  #workspaces button {
    border: none;
    background: none;
    box-shadow: none;
    text-shadow: inherit;
    color: ${c.base0E};
    padding: 0 1px;
    margin: 0 2px;
  }

  #workspaces button.hidden { color: ${c.base03}; background-color: transparent; }
  #workspaces button.visible { color: ${c.base0E}; }
  #workspaces button:hover { color: ${c.base09}; }

  #workspaces button.active {
    background-color: ${c.base0E};
    color: ${c.base00};
    margin-top: 5px;
    margin-bottom: 5px;
    box-shadow: none;
    border-bottom: 0px;
    padding-top: 1px;
    padding-bottom: 0;
    border-radius: 3px;
    background-image:none;
  }

  #workspaces button.urgent {
    background-color: ${c.base08};
    color: ${c.base00};
    box-shadow: none;
    margin-top: 5px;
    margin-bottom: 5px;
    padding-top: 1px;
    padding-bottom: 0;
    border-radius: 3px;
  }

  #tags { background-color: transparent; }

  #tags button { background-color: ${c.base07}; color: ${c.base0E}; }

  #tags button:not(.occupied):not(.focused) {
    font-size: 0;
    min-width: 0;
    min-height: 0;
    margin: -17px;
    padding: 0;
    color: transparent;
    background-color: transparent;
  }

  #tags button.occupied { background-color: ${c.base07}; color: ${c.base0B}; }
  #tags button.focused { background-color: ${c.base0E}; color: ${c.base00}; }
  #tags button.urgent { background: ${c.base08}; color: ${c.base00}; }

  #window {
    background-color: transparent;
    color: ${c.base05};
    font-size: 14px;
    font-weight: bold;
    padding: 0;
    margin: 0;
  }

  #window label {
    padding: 0;
    margin: 0;
    font-size: 14px;
    font-weight: bold;
  }

  #layout {
    margin-left: 12px;
  }
''
