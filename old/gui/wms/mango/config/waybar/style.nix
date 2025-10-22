{config, ...}: let
  c = config.lib.stylix.colors.withHashtag;
in ''
  #waybar {  padding: 0; margin: 0; background-color: ${c.base00}; color: ${c.base05}; }
  * { font-size: 20px; font-family: "FiraCode Nerd Font Propo";}

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
    color: ${c.base05};
    padding: 0 1px;
    margin: 0 2px;
  }

  #workspaces button.hidden { color: ${c.base03}; background-color: transparent; }
  #workspaces button.visible { color: ${c.base05}; }
  #workspaces button:hover { color: ${c.base09}; }

  #workspaces button > label,
  #workspaces button.active {
    background-color: ${c.base05};
    color: ${c.base00};
    border-radius: 0px;
  }

  #workspaces button.urgent {
    background-color: ${c.base08};
    color: ${c.base00};
    box-shadow: none;
    margin-top: 5px;
    margin-bottom: 5px;
    padding-top: 1px;
    padding-bottom: 0;
    border-radius: 0px;
  }


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
    margin-left: 4px;
  }
''
